Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E564EAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiLPLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiLPLxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:53:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228C3054C;
        Fri, 16 Dec 2022 03:53:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so1555915wml.4;
        Fri, 16 Dec 2022 03:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13Vm0Lo332lPPEsaCgPFzelDF94GXJZ/U5/noq/R55w=;
        b=m+6cs8UgDkgrBh11MngOAu6i4Zg6gyR10RxWXvHqf9GwlYCVctTfJHXDFmc2AKCLNX
         wWoU6Xixz7e/eZTf5rKFD8YlcDnjwg9BPwUPfV5g57+6MGXL+91OhowWpKSYMXHetrTy
         AVu6hA0h4jIwWetkwP1bCGUup6ZIwBeq93USUDy9jz2S/yM+lrAcEpEOmHMCBCuCfxFi
         npWQbhxSvU/MVCPYbpuUoFAeMLeYjIr7y7nIl7T/hfZTGTPNguok1+BX2EWlexJoXhnh
         154FLq2azM0avyQ5HBQ+Qylkx1yybgYNgjMsf0KTCt+oJR0WQtSg+bj9pr4u7/UyLVKB
         jjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13Vm0Lo332lPPEsaCgPFzelDF94GXJZ/U5/noq/R55w=;
        b=Cl8gTjOz84foRecWZDE7T4/0Qm4GSxUoKAOwJqbfxzLjiS+tGOqh3YWDwVmrEA2yM9
         2KM3NDuPOxmmpClNwZp9TnQOgOym1m9GsvJaWHBTEfuSVDQDfm0Ps9ua2fWQWbsEuW/S
         kHmNxGjd7ANqIF0o0KOadOk+pci9pjWDYF5aWPiRrlOoPEdAXHa/lFrOqW1hIbiwF2Ci
         A0q509NK1b8esqCIuYXFN43m5fevBfWyy3GMPdKy3dvddhcU374rbFrYQUU82d1s2a4j
         o6SoCz48SLmRAo/ReFAqqXmpC7KBWLuRkZiFoho3H93H08I+s8uhZ7Tf8cm+51DZOd9x
         Sw9A==
X-Gm-Message-State: ANoB5pkLoKbYEp5VVLUHVoFhecvgLSAqcrmmPWo6cOcjrmQ9VT4YDHUh
        klL1OHJk9qvgOWlRgN0AwCA=
X-Google-Smtp-Source: AA0mqf5bZXdv96QOcJhiW7IsKGleAkHdIQijkx4qy+QU0fcKKDKeNqxRLGjMQy21S+2Q0rZzIzjBfw==
X-Received: by 2002:a05:600c:3d8f:b0:3cf:d70d:d5a8 with SMTP id bi15-20020a05600c3d8f00b003cfd70dd5a8mr24051092wmb.6.1671191595799;
        Fri, 16 Dec 2022 03:53:15 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b002425504ae7dsm2071582wrb.80.2022.12.16.03.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:53:14 -0800 (PST)
Message-ID: <06e969b5-3be2-4b23-de5a-93aa9ae6d95c@gmail.com>
Date:   Fri, 16 Dec 2022 12:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/5] Add CPU caches information for some MediaTek SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 06/12/2022 12:23, AngeloGioacchino Del Regno wrote:
> In devicetrees for MediaTek SoCs the CPU caches information, if
> present, is incomplete as it misses cache size, cache line size
> and number of cache sets which, in turn, will also prevent any
> cache associativity calculation.
> 
> For all of the SoCs that I know and/or I have information for,
> I've added the right information for I/D, L2 and L3 where present.
> This will also make the cacheinfo driver to correctly export the
> CPU cache information to sysfs.
> 

Whole series applied, thanks!

> AngeloGioacchino Del Regno (5):
>    arm64: dts: mt8195: Add complete CPU caches information
>    arm64: dts: mt8192: Add complete CPU caches information
>    arm64: dts: mt8186: Add complete CPU caches information
>    arm64: dts: mt8183: Add complete CPU caches information
>    arm64: dts: mt6795: Add complete CPU caches information
> 
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 50 ++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 74 ++++++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 58 +++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 +++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 58 +++++++++++++++++++
>   5 files changed, 298 insertions(+)
> 
