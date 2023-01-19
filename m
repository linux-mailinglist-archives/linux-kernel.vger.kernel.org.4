Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930A673EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjASQca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjASQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:32:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32764E533;
        Thu, 19 Jan 2023 08:32:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so1981500wms.3;
        Thu, 19 Jan 2023 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kISsw3ka351W71cdTlHfeqvj1tDvB34A5YrxX8eaPhY=;
        b=NSkj7iMOP2CnoZNIaPDjSKL+KKbshuGz1XlGid8CesKFWQes8jnfg7LV5VtSmrraMS
         4tR3Ms9c3Ea8vM5JnC4FPTfui6ag0x7JhjwkdG+EhvtZlddPLFr1VYagyWzDyxLJX/NV
         OgWCLU8qqBpnGmAvPLyEXPJbtgPiSsXtFDwcggKhzVYAYHGbYubjEkp12f0WK1NNymvv
         /jvkTZr+i5oi9sYME7TkSchyaT/pOjy5TG0ciQRQwiLiHXeeMY7268YO+ZosuXuq1tGA
         mpUg42XC2S12FRBRwFo81tmmkDCFCLzwniZxI/NU4Y2gDmmrWvefRcxBFnqkWDRFiNR9
         q60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kISsw3ka351W71cdTlHfeqvj1tDvB34A5YrxX8eaPhY=;
        b=anbFSr6YxETuW9Io/bUT0R7kkGGDdHP6/2BhU1Qm6Vu5o6SQwyi4oSOM5ipIY/sa7u
         AcW5HeN8QdsSZNhYOiB15mRMHGJjsBhXQJ9GrHaQFup67+fWef9XUpxVCzsrDz8ZjvFQ
         ycCcOfqPuoAaPQdY4yS3xdBd8pilH1S4P1VjTYesYKOBJafnpVPEAPA9PCduoyUFLQaj
         Hg2Bqp3sYmpTp2iw0SeDetiDkfOKg9R4uuyKwZbo4OoIHVWfRtZ/grPSSHTzNNXtDFq9
         OpNryIOBLdqqZV33cs9qOi9/F9eWkDCHuSui/U5VBwl62VKsMkXbkKcyiSqa9ErH2dGG
         Wnnw==
X-Gm-Message-State: AFqh2kqt1xRawlrByTbJK5Cu6s9M7NXKT93omVXeznYHPlbXlqdi/ErY
        B8hhBpLXp/8S3+H9Tb6JuOA=
X-Google-Smtp-Source: AMrXdXv9EBtbXnsYULYPFoJNloy6O/ErN/hAcWIoch5i2nj40w/DPTMPhwgaX6fLP3mKWsam8/XI7A==
X-Received: by 2002:a05:600c:c16:b0:3da:26e5:10b6 with SMTP id fm22-20020a05600c0c1600b003da26e510b6mr11197814wmb.30.1674145935484;
        Thu, 19 Jan 2023 08:32:15 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id fk6-20020a05600c0cc600b003a84375d0d1sm5193380wmb.44.2023.01.19.08.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:32:15 -0800 (PST)
Message-ID: <c0026ce0-caca-1ca2-dc4c-72d14078de6f@gmail.com>
Date:   Thu, 19 Jan 2023 17:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 8/9] dt-bindings: display: mediatek: Fix the fallback
 for mediatek,mt8186-disp-ccorr
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-9-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118091829.755-9-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:18, Allen-KH Cheng wrote:
> The mt8186-disp-ccorr is not fully compatible with the mt8183-disp-ccorr
> implementation. It causes a crash when system resumes if it binds to the
> device.
> 
> We should use mt8192-disp-ccorr as fallback of mt8186-disp-ccorr.
> 
> Fixes: 8a26ea19d4dc ("dt-bindings: display: mediatek: add MT8186 SoC binding")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index 63fb02014a56..117e3db43f84 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -32,7 +32,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-ccorr
> -          - const: mediatek,mt8183-disp-ccorr
> +          - const: mediatek,mt8192-disp-ccorr
>   
>     reg:
>       maxItems: 1
