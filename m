Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE186D2F19
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjDAIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 04:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 04:35:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361AAD25
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 01:35:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id r16so18337580oij.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VwVQomXd5Zv0oc2cOzA2dNy1IDIN7zen19ti9Y4+h0=;
        b=GKwwshigjYzgT5A6DHoE7vuuJiHt2dyOgEASzCH2cCRjnfunba4bjWRQA+VMGSgikA
         V6gn7B3+Ko4JgRsa2wJV9iNh3BcB4kNxOzQKuLPjM8Zm0QmwqSywpVu8gKIeY8QoQgpi
         VCNd8S8Sht01KQNuneIFxw14tUN8JdNZeHQQOES9KED0nY8dp0vby3FQe/FlQHSC7KB3
         +WIOj213RflIqrOAniBrzHxU8A45XW9s0zsYj1eCZ2MtvoX3m+eTnAX1TR8Zf9h+EJlV
         3J/wG/M6heQOjQ4YLW85RVpHRAJFIfPd8huyBMoFhS3InV5cAswsWygJOLAF9SY2zPZ8
         sgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VwVQomXd5Zv0oc2cOzA2dNy1IDIN7zen19ti9Y4+h0=;
        b=OJjaDWgu3nXl2ZGhkDTnp4lOEv0MwQxTBtrunh5irAMPjgNocT09gmASvyTrHb0Mop
         aRmBnRzKtdkAfD+4cQqh9qwEZGJWZoqD80fNkLrbSwadPV1fe+phCv2XLI8LVhFIZpiQ
         qYIV0pWsCzgnxx14zCUfEAUhAGtfLFH8441y1CmgZHwKk8Ni5V5yjtfmTV831yGj3HzL
         jRt+WeiEkJap7y42Vl9nzwewd9SDxyI75sm9c8jZ9CYCMZUz/whkkF4O2JDWA0hhHMEz
         pFS4VxiyHZsETPw1Lt2W0667xVnc1yGkIY5cDU3QLwupQmZh/Eusl7gPVPF1ys8TZQPb
         eeNg==
X-Gm-Message-State: AO0yUKVaJiq2DlxAK7b3qTjnHae9ks98EtrZLEu8MZKwnAiSj9jRoXGe
        alv396dHLeaPskN5OBolJuqPT3rBdDNwVK7ard4=
X-Google-Smtp-Source: AK7set8KjM/fud01LYEdEw4o75u38YsCKt6Kspqxm62B4+H55PxMjW5idzgSivTrzffGLyoXQLXC/bnUz/eIf6NwUu4=
X-Received: by 2002:a05:6808:8c:b0:386:b6a7:c093 with SMTP id
 s12-20020a056808008c00b00386b6a7c093mr8861476oic.6.1680338142207; Sat, 01 Apr
 2023 01:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200424222740.16259-1-afd@ti.com> <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
 <f46c097a-b2a6-6368-a8a4-e30995a54d17@ti.com>
In-Reply-To: <f46c097a-b2a6-6368-a8a4-e30995a54d17@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sat, 1 Apr 2023 10:35:30 +0200
Message-ID: <CAH9NwWeZnDEkundm98=KL6xB9bVO3nOkk48xMF-eQnztP4DD4g@mail.gmail.com>
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

>
>
> Okay, will split for v2.
>
>

Was there a follow-up v2 of this patchset? AFAICT this series did not
make it into the mainline kernel.
Do you have any plans to work on it? If not I would like to help out
as we have a use case where we want to
use a dma-buf sram exporter.


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
