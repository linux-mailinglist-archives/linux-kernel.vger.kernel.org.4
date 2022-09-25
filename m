Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C735E918E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIYHwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIYHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:52:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CE39BA1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 00:52:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so6418314lfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Nv/5RSkqJKkOQl85OwCTSN2eXEdey0R3YQsmEsMaY/o=;
        b=hU2MCTfvOqVLs63hQU18x6s6H8CTXmttD5HjqiKRCmqMfvHHHmqZUxliZ8w2KMvlxW
         HY6ZbU32LdWScTNc9OXWD838+l++dGSb2Fd9ZzYTTaZVi7cBcbSyoTfMoiF7vr6gFiqP
         cGxfMD2f+QvL9CfHSeDVJRwLcgL+sN01C9jJeLvXRcoixlSc/FLPiJlRhz+gNGITIlcy
         h29T7GtPtgwgrGMn8PjOk9SctvjwVP/Io7FyM9W7m4EWImDl5eEDbdHjzGaYS1YgS8uu
         9Ft9k4LleycrQ6/vSdz5qoqOrRXAQJxpJ6ifWgJvGzjwNBzhKiJ3YZlvQpZMy7SvRX0/
         XnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nv/5RSkqJKkOQl85OwCTSN2eXEdey0R3YQsmEsMaY/o=;
        b=7Twzx5WC21KoZf9lARbYwnZXeEHLej//RnOW0ETO54HxLf5KGvuDEpeXVuDeY6tZRl
         4j7S0jlTZID7yrCzb+M3WPEKK2Q5OcxzIYd9lZRehbfWWHcObwVrEVMsnitdJvXjaUH4
         xT+1078sN3q3RgeEbu9n8xnV+iHybnzni9Ko0Rs3mcOovn3tl2OVqzfMMtKnKcSa3hTA
         YUSaQJzbp5ydJciEjxTnJh1qYTM9MsceuCo50h9OC8AkO3x9o8JWx5KmBGiU2mSGy66b
         oRM7pltmAewqGup4pwhtIdKG1GQmAK4/Z5DQMbjSJFKrA28kLIeiJ3EUcSRVypN1iQKi
         pKCw==
X-Gm-Message-State: ACrzQf3iwh7Seiqwscv+t6/gPVsjAaOwD7VmZ6oMzaJj26I3wqfmuYHQ
        UzLwyKQr+1vG1QnxGrFSgDxx4w==
X-Google-Smtp-Source: AMsMyM5KqwOtk9nprf+87CHVg/qjuDRlMePxSxZCLocwuB38qh1j0wmVsjSub+fYSEf33xrdHHVGjw==
X-Received: by 2002:a05:6512:78e:b0:49a:d9ae:3051 with SMTP id x14-20020a056512078e00b0049ad9ae3051mr6285650lfr.203.1664092368716;
        Sun, 25 Sep 2022 00:52:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b004979ec19387sm2128219lfo.305.2022.09.25.00.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 00:52:48 -0700 (PDT)
Message-ID: <6bbe9527-ae48-30e0-fb45-519223a744d7@linaro.org>
Date:   Sun, 25 Sep 2022 09:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220924080058.20566-1-jason-jh.lin@mediatek.com>
 <20220924080058.20566-2-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924080058.20566-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 10:00, Jason-JH.Lin wrote:
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> and they makes VDOSYS0 supports PQ function while they are not
> including in VDOSYS1.
> 
> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> component). It makes VDOSYS1 supports the HDR function while it's not
> including in VDOSYS0.
> 
> To summarize0:
> Only VDOSYS0 can support PQ adjustment.
> Only VDOSYS1 can support HDR adjustment.
> 
> Therefore, we need to separate these two different mmsys hardwares to
> 2 different compatibles for MT8195.
> 
> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..4f90ea03c596 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,13 +31,16 @@ properties:
>                - mediatek,mt8183-mmsys
>                - mediatek,mt8186-mmsys
>                - mediatek,mt8192-mmsys
> -              - mediatek,mt8195-mmsys

We keep making circles...

I asked "and why mediatek,mt8195-mmsys is kept as non-deprecated?"

and your response is to remove it... Eh, okay, that's fine but now your
change causes now warnings in existing DTS. Either you keep old entry as
deprecated (just git grep for deprecated, you will find examples how to
do it) or fix the DTS.

Best regards,
Krzysztof

