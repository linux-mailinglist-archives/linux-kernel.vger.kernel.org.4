Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D96066BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJTRIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJTRIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:08:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBED1A0471
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:08:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q9so1193061ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brQMIRceaTVvRhjMDwEog122afcHskOShD8yzAFIE2Y=;
        b=FQSfOyhjtOsFj5iQ5ZyvmklzwffTcJBx2xDNixBd8SqoxYcvPpMzNpkLfs4Qt/zoXh
         +bsVoPClhOlaIp166/JQb4BCD3BVuvNA+3zWzfp5SVH9osX2BTTouVhGBu/hKOSKts00
         OZQwQyAoakJss3u0exSOfHIY/+z+o5XsWU5Q1jwF/WhsBDlwwg72yur3GJWNkObKAXK+
         GCSwX4WIB+Bbd5JQTF8GvnfSm16QpuUe+BKmgYR2xlsDNTYrHN/dRWM9qG+PeTGHfdkL
         g+Kpb3miBPCadUrfqJqjjhO6fEx1Y9MP1kV8rNFryYy12bVd2XT7sktNk2lv4f3vodZZ
         sTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brQMIRceaTVvRhjMDwEog122afcHskOShD8yzAFIE2Y=;
        b=4YG/RrptTPfA4bm67itKAsIqnbQDUIJaY0fzFMs3k0fhrOWVToEmp6hUX26/bUIy7q
         rEfQMvoUcsERKULOsdrl7UND+BG1+AvcCgB3TuG+5EjnIjpCIuO2G0vL3dBQ6ocNv5v/
         R9vtdH0+j2czEGt851ZdHXKxFFWhkVQ2I+0YpI964RKvg/UB2mrAsoEMyocE54d+cQvG
         xjn4jdL/n4WEpKIAwAd+96bdtjxq96S6mLdX90GbwJJRIZB/87eVontsjwZjdIcisJh7
         RoHqLh/rmGJdgK6fVZN5d3cZL+QeIVjjtvFCRz7tsz67lYy4CZvKpFuBvU2BTMdWhRVz
         XYXA==
X-Gm-Message-State: ACrzQf2iTw/fJA5h/K1lNc1SnClON8BGHsOpJ6ZG0V19FsySFLXwdpo3
        XWGw+Q3ZFDW+bSeRUGzxivE=
X-Google-Smtp-Source: AMsMyM52oCmtAEujXlp4+mCUCpgc1VFq2XIhqa0rqlHzjABZPCieMXu7UrOULwfspjwTCgCt5c+7Gw==
X-Received: by 2002:a17:907:1c10:b0:791:a716:5089 with SMTP id nc16-20020a1709071c1000b00791a7165089mr8121458ejc.672.1666285694675;
        Thu, 20 Oct 2022 10:08:14 -0700 (PDT)
Received: from ?IPV6:2a02:1210:866e:6400:218:deff:fe4b:3db8? ([2a02:1210:866e:6400:218:deff:fe4b:3db8])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709067c9300b00770880dfc4fsm10582077ejo.29.2022.10.20.10.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:08:13 -0700 (PDT)
Message-ID: <5d44ffd2-df31-d771-6395-819b47fe2181@gmail.com>
Date:   Thu, 20 Oct 2022 19:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 04/17] ARM: ep93xx: remove old board files
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Hubert Feurstein <hubert.feurstein@contec.at>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-4-arnd@kernel.org>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20221019150410.3851944-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On 19/10/2022 17:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These five board files were marked as unused a while ago, and
> nobody wanted to keep them around for longer, so remove them
> now.
> 
> We still have the edb93xx, visision_ep9307 and ts72xx files,
> which can hopefully be converted to device tree in the future.
> 
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  MAINTAINERS                            |  10 --
>  arch/arm/boot/compressed/misc-ep93xx.h |  13 +-
>  arch/arm/mach-ep93xx/Kconfig           |  63 ----------
>  arch/arm/mach-ep93xx/Makefile          |   5 -
>  arch/arm/mach-ep93xx/adssphere.c       |  41 -------
>  arch/arm/mach-ep93xx/gesbc9312.c       |  41 -------
>  arch/arm/mach-ep93xx/micro9.c          | 125 -------------------
>  arch/arm/mach-ep93xx/simone.c          | 128 -------------------
>  arch/arm/mach-ep93xx/snappercl15.c     | 162 -------------------------
>  9 files changed, 1 insertion(+), 587 deletions(-)
>  delete mode 100644 arch/arm/mach-ep93xx/adssphere.c
>  delete mode 100644 arch/arm/mach-ep93xx/gesbc9312.c
>  delete mode 100644 arch/arm/mach-ep93xx/micro9.c
>  delete mode 100644 arch/arm/mach-ep93xx/simone.c
>  delete mode 100644 arch/arm/mach-ep93xx/snappercl15.c

[...]
