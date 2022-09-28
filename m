Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7FB5EE36D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiI1Rr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiI1RrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:47:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B59F6867
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:47:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g20so15152607ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=im9XgETRxegMUR78LTkoFFDmVSoYc1KHVKiHFv5Z2KY=;
        b=a0JNO+DzxwYmo8m4zvCjgit8yewjJ/rCYwUMgSkwxCPXyb8MliNAyp3skj1+3k01/F
         M56hDpGrQJCbaoHs9BdSfS6hcHio2xAckACPJRjtAQvTDIBD1DOrA7cC1mOzPy8GkefX
         N1RkhaulmRkZPF7HGBB9wpJ/o23HY9wDawXIo2WTG6B3iQIOSXt32J5K+b6mrynF7Hid
         BbFiBR0wFjTa3FLwSuODAYnbGWUv1u+FNJH3gLszI1MX7sVtsDf9zmu5i42QMCPbceEb
         oulGVSsqEBN73DUOcJ130okuum1nwAtStdUR8qXWWsCWTscNXqXo1dKqN/7+Poj0WZPO
         DfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=im9XgETRxegMUR78LTkoFFDmVSoYc1KHVKiHFv5Z2KY=;
        b=UOL3uSrX1cX0PAjqizIoUv3xG8VCAqvgwRP772RUdDdTIBwpuJWGQmpNidCrxStr8M
         W0aeQL/fd8S1v+hD2LI+DmdYwLqIOXWK8Ws4bey7KjbNwcOkP1UIqYgxsZfEC5rxgs/G
         cppyhdUrqyPvVPhMRQGQnBQy4nrP8IGpe49CTsPcwIo8wOtSvToWDs/Kv6daqdH7B23B
         55DJXgE0xcaWal3+Yr7OcDwOeyIyU+kHZti/9fC796UpOWUwYjBMorS/qWzUBvO417Bq
         a5MU7FIHWIhC+57aNbl7VHjUSjeCpeqF/vf0J791aBDsMh1aHUlY1+vo4DoMkJJfIDDV
         aJTA==
X-Gm-Message-State: ACrzQf0U+I0AjnWDhaaxeq9Ks8/KnRbXQvLc2Abx+vrA5hVajxW1pORV
        3gASy2/34EjJOhKX+eWUYz68XQ==
X-Google-Smtp-Source: AMsMyM5lItS8m+a3tjAri2PadLRMGws9Z/yEkLDSyn/WAlOVnniMT1nbYT5FjnGrixQi+wl7GkLLRw==
X-Received: by 2002:a2e:b016:0:b0:26b:f00b:a8cf with SMTP id y22-20020a2eb016000000b0026bf00ba8cfmr11755167ljk.24.1664387241691;
        Wed, 28 Sep 2022 10:47:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i8-20020a056512006800b00494935ddb88sm531221lfo.240.2022.09.28.10.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:47:21 -0700 (PDT)
Message-ID: <b748aebe-09b5-d4b2-a6e4-0f13e440bc05@linaro.org>
Date:   Wed, 28 Sep 2022 19:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 01/11] dt-bindings: remoteproc: mediatek: Give the
 subnode a persistent name
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-2-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927025606.26673-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 04:55, Tinghan Shen wrote:
> The node name doesn't matter to add the subnode as a cros-ec rpmsg device.
> Give it a clear persistent node name to simplify scp yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/remoteproc/mtk,scp.yaml          | 35 ++++++++++---------
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  2 +-
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 7e091eaffc18..786bed897916 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -58,6 +58,23 @@ properties:
>    memory-region:
>      maxItems: 1
>  
> +  cros-ec-rpmsg:
> +    type: object

additionalProperties: false on this level

> +    description:
> +      This subnode represents the rpmsg device. The names of the devices

What are the devices? You wrote that it is one device, not devices.

> +      are not important. The properties of this node are defined by the
> +      individual bindings for the rpmsg devices.

??? No, you need to define the properties of the node, e.g. by a ref.

> +
> +    properties:
> +      mediatek,rpmsg-name:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description:
> +          Contains the name for the rpmsg device. Used to match
> +          the subnode to rpmsg device announced by SCP.

maxItems... but is it really a string-array?

> +
> +    required:
> +      - mediatek,rpmsg-name
> +
>  required:
>    - compatible
>    - reg
> @@ -89,21 +106,7 @@ allOf:
>          reg-names:
>            maxItems: 2
>  

Best regards,
Krzysztof

