Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120F688E04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBCDcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjBCDcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:32:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CB6813F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:31:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so3834640pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 19:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ELdr8kr8cfAFHro3oo2nX8Zeaf+T1iI5OEPVbajWl4=;
        b=jCJnuaG7D0JNqsasbCOptl2FERdbLdwSDouVdFGzdlhZ4c0vC6kncai50bmmbcG/DW
         Sb7Q7TTuIW399D57jto6QS7jK7rNGJfTigkW4VVmK8ixDAHFWk+AjRyf/EIoK4SW+kaf
         4oqgE3ORR+Kae4q0iDp42Aaevi8KRRznIjekikScXpDDIySq4G+W3WG5YRVSvm90lcLs
         i6r167TOVqnrFS1cchC+nMQa+SdsnBqvWgEziNgvGavPegJwuoxvGFv5fZH+5rwlJWHS
         uRjz49UFgst62dCFszB9MGisu5ceibyxM/Q2gNIrFfVIWNN41LF4scop8rJgL2j92Zaw
         Yzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ELdr8kr8cfAFHro3oo2nX8Zeaf+T1iI5OEPVbajWl4=;
        b=6QLx3eYZU7RCaPIOh+AoT4MEBMZYHXfuZTLvSYLQMKRyTkU5xJxMMrgtbMr6FaEdPe
         aO11OY51kuTT8vSPDW4uEu/2hjK+KovNPoaXYXav2H4VB2obrsKpqkXmMGXAsDdi4XRk
         kRGuXimdhaAmScwYsDkn+KBldOJ9qhUVvMPtmKmkIg/8R0QTR3fQVWGpOXGOJaZ/nElq
         lOVcR6i1lfAKsHw69GQ8IBcSiT1kmhRlNfLM5zZh5JeQlqnDylGTUIdsxy0D3yA20AFq
         5MKkOJlnX0tNe3kMLujptjcM25quI9GAI3yx2jltzXpIqm501Eg+WjTQPvSpSAeDAXuz
         bZuw==
X-Gm-Message-State: AO0yUKUAYbz0EYW90y9ni1m49UasSKkZ/tZi63JPXOdBtmaqgtPaUykM
        3fv2Lt7+eCu1sIuqJVl7XNRT7w==
X-Google-Smtp-Source: AK7set+57aLnObSHcH5qlDN6Mf7iQBt+c9eQWgNCT+CmyqH0+99UE+sJruvk7QuheXFpwkAyk9dl8g==
X-Received: by 2002:a17:903:41ca:b0:198:d8a4:1ece with SMTP id u10-20020a17090341ca00b00198d8a41ecemr1658070ple.8.1675395117606;
        Thu, 02 Feb 2023 19:31:57 -0800 (PST)
Received: from localhost ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b001966308ca0dsm420998plk.167.2023.02.02.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 19:31:56 -0800 (PST)
Date:   Thu, 02 Feb 2023 19:31:56 -0800 (PST)
X-Google-Original-Date: Thu, 02 Feb 2023 19:31:51 PST (-0800)
Subject:     Re: [PATCH 0/5] mm: Stop alaising VM_FAULT_HINDEX_MASK in arch code
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
CC:     linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <mhng-15cb5600-7883-4454-aabe-6e695a81a45c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022 19:03:51 PST (-0800), Palmer Dabbelt wrote:
> When reviewing
> <https://lore.kernel.org/r/20221029084715.3669204-1-tongtiangen@huawei.com>
> I noticed that the arch-specific VM_FAULT flags used by arm and s390
> alias with VM_FAULT_HINDEX_MASK.  I'm not sure if it's possible to
> manifest this as a bug, but it certainly seems fragile.
>
> The RISC-V patch is on top of the linked patch above, which isn't in any
> proper tree yet.  Everything else should apply to 6.1-rc1, but I'm in no
> particular rush to get that cleanup in so rush on my end for 6.2.  That
> said I figured it would be easier to send along this now, just in case
> someone who knows the MM code better thinks it can manifest as a bug.

Just pinging this one, I'm not sure if it was just bad timing on the 
last one.  That RISC-V patch is still sitting around outside my tree.
