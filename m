Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84AA701DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbjENOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:04:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DB1BF3;
        Sun, 14 May 2023 07:04:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f380cd1019so552603e87.1;
        Sun, 14 May 2023 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684073066; x=1686665066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuGklFcEx4ogqrncOrMBWjf7nZjLMpfhpMESX9sQcR4=;
        b=k7agaoeR57haBOVtUviP2mPIXwvl3yDhurydnAnCwIR7gIuo7/UQPSmEMyNTEmLhF1
         pC7LSIz2o/0l8p+Yuq1vGRO0WgQ5U90JxDy5R1hmvnO2Qz9QEc7vgDZ36P2Teb+4e+AS
         w5gB2Pc4mR6Qt0mRlV5uZHh6yim3wU5m5HnvRIqq7Akv/SkYOlUEfWgQHZckBP0cTBI2
         yQkrFhOCJRzQ/SBFa1kXXEBljM+rw/sAJhuHnFco/mxTX5NmAwRpq5ygUbS5w8E7SPnB
         Z503Toob9fVsM18xzKyGNyRUzLBWOHF47uXKTSOg6+hhU9qKp+scUcyquPZCoL4Qbf7M
         r3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684073066; x=1686665066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuGklFcEx4ogqrncOrMBWjf7nZjLMpfhpMESX9sQcR4=;
        b=glla06MgKV3Ki7VDxUuAS632Cyz5HOSC4Cvi5yMWUyXWYGKgHnbu4HnO6FEisK01/c
         CreWw0DQ6JwVNsRemUDIeoC8E3VGiZuDP+7K9yvxMSMHV+CWvNdRvSErV7/rIM0z3Hjh
         T6TbrNl1/1SDI/qvi73yFV9zMASYZHBkWsRrmEZmX6EPP0itLGNWUW9D4U1pqSP9dIw0
         Kdfyerz/GjjCV2qe15jgLQgENSB3s3Q1SFenarbjYXJAfGJDUt0hWjeOjXtGoYXWwTgn
         8WlnN+bW/dBIWXcgLb8KEBrI19u9Vfv3d2yySMTMD7w0He8cg7kdYPUtzp7ND5V5GzeD
         HC8A==
X-Gm-Message-State: AC+VfDyAsVpre9uWqyDMb3h6IJR3QTqQU6AkkgnwLhRgdQcQD9hm4fsE
        4DfRCvf54siCPFhi5G5S2p33DkGYw869kA==
X-Google-Smtp-Source: ACHHUZ73vIq12vZRHgJzDA2lPm9LeJRlziN8yf3RKEMSmOSkYiMhZfduQK9GoarN7Z2bi2UuX0HFHQ==
X-Received: by 2002:ac2:5deb:0:b0:4ed:d216:8217 with SMTP id z11-20020ac25deb000000b004edd2168217mr5603903lfq.11.1684073066149;
        Sun, 14 May 2023 07:04:26 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id q1-20020a19a401000000b004f24bc0cbf9sm2217231lfc.154.2023.05.14.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 07:04:25 -0700 (PDT)
Date:   Sun, 14 May 2023 17:04:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irqchip/mips-gic fixes
Message-ID: <20230514140423.vvuoctb7u5uc53c3@mobilestation>
References: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun

On Mon, Apr 24, 2023 at 11:31:54AM +0100, Jiaxun Yang wrote:
> Hi all,
> 
> This patchset fixes two issues in the MIPS GIC driver that may block
> booting on some systems.
> 
> Please review.

Thanks for the series. Please find some comments sent in the framework
of the corresponding patches which don't though prevent from having
the patchset tested. No problems were found on the Baikal-T1 SoC with
2x MIPS32 P5600 core on board. So feel free to add for the entire
series:

Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Thanks
> 
> Jiaxun Yang (2):
>   irqchip/mips-gic: Don't touch vl_map if a local interrupt is not
>     routable
>   irqchip/mips-gic: Use raw spinlock for gic_lock
> 
>  drivers/irqchip/irq-mips-gic.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> -- 
> 2.34.1
> 
