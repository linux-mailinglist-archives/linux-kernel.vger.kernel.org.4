Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32292611AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJ1Tj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1Tjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:39:52 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943214D39;
        Fri, 28 Oct 2022 12:39:45 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13ae8117023so7395068fac.9;
        Fri, 28 Oct 2022 12:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO2vxqm78QhPt3F83EEw+gwkQklZjajmJIRAkN8DiHo=;
        b=VoPcL13olOURLgREPIKUrmc3MLzRfSAY16wHqYnB/7WdVFJQKJ7Stma4sT5WSGn5ht
         i51snYDV1+jkMSSQ4fqtdutPumYFOVYElrAXRQ5nMNd7uWzJ+8R/aPsE8md7VoahHCoE
         85SriZr3S3p8LRmcAvM1Leskfh5CiM1ijrYPK9vTV/AU0sYRWd8N5s0gYFQElcJWPCQw
         AlRFXgetVY6zQXHAa3FYjELM7DLYG4cry131Wyg9rWnEFwBh0u2oeb/nNC/68sj5ACPu
         0LRMO28WAyh5yXS2kbTJLIE3BYTDVpXFfLDbZV5+RHGPk0eCe1ZxTBNV616caJzGdybE
         nEjg==
X-Gm-Message-State: ACrzQf2fzFKAM4/2/J+a07SDghokdlTwaPkZWh3l0igdHXGYm/3jDWRm
        TmAeIUhc/uQM3qcBasKmR5QFcE4vbw==
X-Google-Smtp-Source: AMsMyM6Xj1iu4oGXFzZGjKiVrQBh8AQZKNOax1t8inO/Roy6hBuh8rXVQ0FHFrTLlEPlJecGS865Ug==
X-Received: by 2002:a05:6870:c155:b0:136:3bfd:4df with SMTP id g21-20020a056870c15500b001363bfd04dfmr452806oad.221.1666985984477;
        Fri, 28 Oct 2022 12:39:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g13-20020a544f8d000000b0035437f4deefsm1833001oiy.26.2022.10.28.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:39:43 -0700 (PDT)
Received: (nullmailer pid 2192832 invoked by uid 1000);
        Fri, 28 Oct 2022 19:39:45 -0000
Date:   Fri, 28 Oct 2022 14:39:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ASoC: dt-bindings: wcd938x: fix codec reset line
 polarity in example
Message-ID: <20221028193945.GA2192436-robh@kernel.org>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
 <20221027074652.1044235-6-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027074652.1044235-6-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 12:46:52AM -0700, Dmitry Torokhov wrote:
> The driver for the codec, when resetting the chip, first drives the line
> low, and then high. This means that the line is active low. Change the
> annotation in the example DTS accordingly.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> index 51547190f709..2f5e0df93872 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> @@ -112,7 +112,7 @@ examples:
>    - |
>      codec {
>          compatible = "qcom,wcd9380-codec";
> -        reset-gpios = <&tlmm 32 0>;
> +        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;

Missing a header for this.

>          #sound-dai-cells = <1>;
>          qcom,tx-device = <&wcd938x_tx>;
>          qcom,rx-device = <&wcd938x_rx>;
> -- 
> 2.38.0.135.g90850a2211-goog
> 
> 
