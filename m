Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4998A6BE7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCQLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:25:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF620D35;
        Fri, 17 Mar 2023 04:25:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so3075112wmb.3;
        Fri, 17 Mar 2023 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNO4YTYPu+vesxBB7tlPYGkKhGJaH/b9VuXd4UUCCuk=;
        b=i9Wj5Wz2CcBxCaIXIP8h3Bj0dRq3ztoYJf2yINByDJ38A2uO4OqKGsTcbXGQKpKZIq
         c4qDeBStYgUnByThXiiETA5g8D5tZpmTeFEWS9hxkkkpxN0mt9l8UYLBWabTR331kzCe
         lFWjaAmeEkwSY+8F6L3LwP5vjZcA3i7icV2F7U/feh1Xv6TAjf/Kwt6SB5gd+ojaVWDD
         EO+mKlFhyl5Op8DXtQS6/PqFrJBzrCBF1CM7mmv2YXDhI7SVoWzCYVsFA+Zs43BvFXrY
         RIyjpCgEtOZa8zp1GO0hUMW9pBwpnwnT0fiRHOkQqQvlBYiY9AwCBtXx0BP0m98pjEQl
         jUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNO4YTYPu+vesxBB7tlPYGkKhGJaH/b9VuXd4UUCCuk=;
        b=k6FXhyp7/+yBrZEldbyCd5oHGSCKR9TFicUDKuP5MHlCPIVjWBQ3bFyxeflQkFa9U6
         dn5bJIoXaZoj5L1AEc4RuIDSJntUVGadAuV91CiE3okVTgrOyys6FlOaQ/ItW32Dh6q8
         EmeZ37DD9KDskzDru1vQlJyF3YD1CpsqriTDvyPEo+M4iLglhuzIHVtBuu+j1rcp4gUt
         iqY7EG1N+itRUCaVZrNUOyyx+nznQqjCBDCLo0nlGLhKzUYSYHOomFWexuhpMwpw6ECG
         Q4TBgZfKCuVo+yM1732d2N9iodgrV7QJoqGbxvo3IO0qN3+QSFIH/eqrohPpcx1TO0la
         6JJw==
X-Gm-Message-State: AO0yUKWMZXvY+T6Kgtqu03fiiT34Muqvl0ZHX3z3HvdMRQWQ2rPpjHjA
        HtH3RDmN3PrsiAMtQ/vjeVg=
X-Google-Smtp-Source: AK7set9AZgBwQRetpG5pAKvdSStKHWZZDn5pX8FDFHrAZcHx7URK0Whqyt8RNBG4wx0hW18wu9zHkw==
X-Received: by 2002:a05:600c:540a:b0:3ea:e582:48dd with SMTP id he10-20020a05600c540a00b003eae58248ddmr24674303wmb.34.1679052348654;
        Fri, 17 Mar 2023 04:25:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bca59000000b003ed341d2d68sm1717773wml.16.2023.03.17.04.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 04:25:48 -0700 (PDT)
Message-ID: <008996c3-074c-b443-73f2-c14f0fdf8e4e@gmail.com>
Date:   Fri, 17 Mar 2023 12:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dt-bindings: display: mediatek: Fix the duplicated
 fallback
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230306-ccorr-binding-fix-v2-0-4822939a837d@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230306-ccorr-binding-fix-v2-0-4822939a837d@baylibre.com>
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



On 06/03/2023 17:15, Alexandre Mergnat wrote:
> The item which have the mediatek,mt8192-disp-ccorr const compatible already
> exist above. Remove duplicated fallback.
> 
> Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback for mediatek,mt8186-disp-ccorr")

We can argue if dt-binding patches should have a fixes tag at all. Given the 
fact that there are so many warnings still around, I don't see any value add to 
backport these to stable kernel.

That said, this is defenitely no fix, as it's only a code clean-up. No warning, 
no bug, no functional error fixed here :)

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Fix MTK color correction binding
> 
> The fallback compatible has been duplicated in the 137272ef1b0f commit.
> 
> To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> Changes in v2:
> - Fix commit title.
> - Link to v1: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com
> ---
>   Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index b04820c95b22..3aaf44719786 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -29,9 +29,6 @@ properties:
>             - enum:
>                 - mediatek,mt8188-disp-ccorr
>                 - mediatek,mt8195-disp-ccorr
> -          - const: mediatek,mt8192-disp-ccorr
> -      - items:
> -          - enum:
>                 - mediatek,mt8186-disp-ccorr

Please sort compatibles, that will allow for easier reading once we add more to 
the file.

Regards,
Matthias

>             - const: mediatek,mt8192-disp-ccorr
>   
> 
> ---
> base-commit: add072536971d7ce891fde3cdbf68c55e7cfa95a
> change-id: 20230306-ccorr-binding-fix-718c6d725088
> 
> Best regards,
