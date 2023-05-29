Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD64714E09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjE2QSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2QSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:18:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F8A3;
        Mon, 29 May 2023 09:18:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso22695545e9.2;
        Mon, 29 May 2023 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685377112; x=1687969112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OS7Cd231F040G33nTg/JdwMNbg9I56weKfa+JuzR9V0=;
        b=odFSh468vCEXSATMzrGBnyFPDEPBnu3/GVtTQzp2WbXOltmvSGkGEzlC+K8uKcxOUK
         BYYZO3kOcY8anhzgBOM6eu2JYSW1pbA8imDeBahG2zyaSZEaB0IcQh5Ze1XwlYq4jIDY
         KelS15P78jje2Xt/QEEsGMzhwwlpa5oUQBJ1dAWnUgDFDo8WAy3DvrQgmAHMZ+JDff+L
         C+HUaai8+J2dlLY0DigOEZjxf2blWamfHgxRO/kjSklzV24Si3sLDtOa8183sh/g7NiP
         OMgXLYoeAhgFdMZIEnib1pOtsX2fU4TsK6pA2bkKNPWSkiM2WC4x7RsOvk4Zoblle2YU
         fETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685377112; x=1687969112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OS7Cd231F040G33nTg/JdwMNbg9I56weKfa+JuzR9V0=;
        b=lyltKF5Tp7SP+N0v778Z1rL69SW48XDQlYseZEq0fJDw2DRtbZz6PXZ7a5uuqbIgZv
         1TQlL4wArHvhJmadlZjTmWsOs1Wp6MnCJV1HJXkzbCP45u+Y00IxSHdW+5eiYdASGkBo
         DMhN3FUywXBLrZzlK5Y88OsTz3gKA51xEUL2LKj6UW9iUl0nomdmqK+3xV/pFGd3agvA
         DcfpUrse5xCxn9YevfsUUJPZYe2MlmzfibKvMUK4lak0UmJX35PbpRwKe4xfKa9mGZ0J
         i++OTsS6NUZ1sxX4J/qCl6WZ0f41GVr/ASg5hFInBGDCih8apGZmNXvVNKrDcwoPhUfH
         PeWw==
X-Gm-Message-State: AC+VfDwuJzdEm7FNBlfQuLJrsnqRGM928bjyEvO2Zlw1H++Eg3kh7RqZ
        fXLkM46BYvQD2hFgfEECHUQ=
X-Google-Smtp-Source: ACHHUZ5yb7656A5Pt8QU+Hxu5DFAGjmIz71TZJhb5cmkFGg3fCgQ27dRj5NsY4DDPtehbz40yOKrMQ==
X-Received: by 2002:a7b:c84c:0:b0:3f6:cfc7:8bcf with SMTP id c12-20020a7bc84c000000b003f6cfc78bcfmr9832893wml.34.1685377111877;
        Mon, 29 May 2023 09:18:31 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x11-20020a1c7c0b000000b003f50876905dsm14723899wmc.6.2023.05.29.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:18:30 -0700 (PDT)
Message-ID: <eb9d9814-2dd4-ee87-b1ca-4660b59abec4@gmail.com>
Date:   Mon, 29 May 2023 18:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mt7986: use size of reserved partition for
 bl2
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20230528113343.7649-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230528113343.7649-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/05/2023 13:33, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> To store uncompressed bl2 more space is required than partition is
> actually defined.
> 
> There is currently no known usage of this reserved partition.
> Openwrt uses same partition layout.
> 
> We added same change to u-boot with commit d7bb1099 [1].
> 
> [1] https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e01fb15b815 ("arm64: dts: mt7986: add Bananapi R3")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thanks!

> ---
> If the bl2 does not fit into the bl2-partition (cut off), board does
> not boot, thats why i want to increase it now. My current bl2 is 197K
> for nor and i ran into this problem.
> 
> Openwrt uses also the first reserved partition to give bl2 more
> space:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7986a-bananapi-bpi-r3-nor.dts;h=f597b869abc80d1a73f44ebb85ad4da17376bb52;hb=HEAD#l22
> 
> so imho it should be same in mainline to not require complex bl2
> compression.
> 
> have now sent the board-specific dts to uboot too:
> https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e
> ---
>   .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso     | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
> index 84aa229e80f3..e48881be4ed6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
> @@ -27,15 +27,10 @@ partitions {
>   
>   					partition@0 {
>   						label = "bl2";
> -						reg = <0x0 0x20000>;
> +						reg = <0x0 0x40000>;
>   						read-only;
>   					};
>   
> -					partition@20000 {
> -						label = "reserved";
> -						reg = <0x20000 0x20000>;
> -					};
> -
>   					partition@40000 {
>   						label = "u-boot-env";
>   						reg = <0x40000 0x40000>;
