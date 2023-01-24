Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928FD678DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjAXCJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAXCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:09:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC306301B6;
        Mon, 23 Jan 2023 18:09:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso8298779pjp.3;
        Mon, 23 Jan 2023 18:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDOI66t0q/oP7E/pKikemgOCe2s0l8GcG5GBgKQtNXE=;
        b=fLS/Ec7hGZGwOF2csyyx7asmruxOhiKoolimG+J143sZaS3Dd9SI4B9Y+jRI/smyYM
         7FTlvkrIihPwyL7KIhzRT5OmgwHmi0Ol2iPA72h6Ac6DsOK1n/8kUnfY/qv8dbaNArwt
         K1LO71u0KJukhXLFhDqCcDJwxbkCfiCGzz1tJMsxGcxkZuw3dzWO97kbGLpt6gaPPWZY
         IRrhV3aMPdfIa8kKQ4ii62OGb3odO2SvVHrnM5xrTO2zdYFb2LZ3H1FsdkinNkyqZesb
         lDxkTRPtaLQidsvcONDyXXRDLab+zGkI36MC73q5SudTjGFm8sOUj90aitBwQfeeZR/q
         F7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDOI66t0q/oP7E/pKikemgOCe2s0l8GcG5GBgKQtNXE=;
        b=FZ7XNzT61TIPkr3duHalZfDLBc1Kk+DK6bF6+ZEFmTsqb+Ebj/GzFrQh91n1jLxf+d
         CqtrAdjDlYSjachc7FfdDYtwYijSnSIcAMkexuVm+UUFJsCcpW244XxgXkn5V65pkzSC
         yDjWs8S4LutQ9f8KFVuuXs6FZbcEl/Cmuslzye6HQUpqglWUYEx7gVcDroFbCqu28UoE
         lxcv2mZmK+M6SLFsCATxeimhFxEzyEr/+MriwWfoFnMna2w+iSCbhvLitY3wdmg21/e0
         j3xbhuWXwyowikN2jpONemyJd0qZ96WbSPNC+semWhfnqO90/+L4L63uULDL4rP3XIZS
         anfQ==
X-Gm-Message-State: AFqh2ko5qUW6TsBv1mh/tED2uU5gU2F92TGtTnOskOLu/WmdGPcD8lKk
        2Qmg9EIJkIwZlVuWeMSjJT0=
X-Google-Smtp-Source: AMrXdXvg/EPy6kakIOxMYkNEGMjnT9H8lLzdCwftb8iaw8taUrONL/r/vPS4ux4xrk13uYltzaEQhA==
X-Received: by 2002:a17:902:7881:b0:192:bb38:c412 with SMTP id q1-20020a170902788100b00192bb38c412mr26040498pll.44.1674526141197;
        Mon, 23 Jan 2023 18:09:01 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902d64700b001929568afe9sm346624plh.306.2023.01.23.18.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 18:09:00 -0800 (PST)
Message-ID: <679a3bed-e3fc-832e-8e5a-e6bca638ad26@gmail.com>
Date:   Tue, 24 Jan 2023 09:08:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 00/15] Ambarella S6LM SoC bring-up
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Li Chen <lchen@ambarella.com>
Cc:     =?UTF-8?Q?Andreas_B=c3=b6hler?= <dev@aboehler.at>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Daniel Palmer <daniel@0x0f.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Li Chen <lchen@ambarella.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY DEVICES (MTD)" 
        <linux-mtd@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rickard x Andersson <rickaran@axis.com>,
        Rob Herring <robh@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <a69a5ffc-0820-4adc-9ac4-f827ebf66cf0@app.fastmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a69a5ffc-0820-4adc-9ac4-f827ebf66cf0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 15:39, Arnd Bergmann wrote:
> I seem to only have part of the series, please add both me and
> the linux-arm-kernel mailing list to each part of the initial
> submission.
> 
> It's possible that some patches were already Cc'd to
> linux-arm-kernel but did not make it through because the Cc list
> was too long (it has to fit within 1024 characters for many lists).
> I think you too the Cc list from get_maintainers.pl, but when
> sending new drivers this does not work well because it picks
> up everyone that recently touched the Makefile/Kconfig.

Hi Arnd,

It is possible (and common) that people who recently touched these
files, when given new drivers patches, aren't interested in reviewing
them for many reasons.

In that case, you may want to see Alison's trick posted on kernel
outreachy list [1]. In summary, pass `--no-gitfallback` (don't give
addresses of recent commit authors) and `--norolestats` (only name and
email are printed; MLs don't get open list:-generated names). Also,
another trick that I use is to condense the list by passing
`--separator , ` so that it can be easily copy-pasted to
git-send-email(1).

Thanks.

[1]: https://lore.kernel.org/outreachy/20211015171331.GA431883@alison-desk/

-- 
An old man doll... just what I always wanted! - Clara

