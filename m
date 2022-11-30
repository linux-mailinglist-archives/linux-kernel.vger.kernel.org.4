Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71C63DCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiK3SSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiK3SSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:18:25 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74ED9897B;
        Wed, 30 Nov 2022 10:15:42 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so11758302otl.3;
        Wed, 30 Nov 2022 10:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQgMv+4kwESBu57U9sIa1Qhs40zZZUjyRdV30we0JoU=;
        b=2w5+3hzeNhvnPmhc8BE9pnXTYLELFXlf8pMYGsrwtxap9p+1aeG/nvqr7TiwzXgpdc
         DHh/eOPfOsX+vdA2Wo4RGZvgdxlafEINJdWWi3aBEr5SYeWYo3VEQYYWZWiDhaX7cPmP
         VuoBbh6u9OCZ6f0khh4IlNa6iYk59U7W768A02W3nX1wmWEiahKAUM+s33bNv1XPqAwj
         7TMAncgofOofNdICX/f3mrcq4f/r34mPd48YtvdsXn0tPj9c3XFbKybhjKxm4/eV5zW1
         CUdk6wMQ+XANgKNKJr0cQEllX1LUdhFCydh6L44fEW6xvXCu8ccNpa/D4sMV75tlYHIN
         noOw==
X-Gm-Message-State: ANoB5pndIpmMxFmlyq9NIsDMeAzF5FdUF/uJQ2Khq2TCKTEMvo5HZ4e1
        tQGGgURsiUmtbdX83F16I328zTvJMg==
X-Google-Smtp-Source: AA0mqf7Gyq/9uTW6zQxKhmsY5gzkvXymZgl+qZcZo2UBY55Qqq62o+YalOdkJKa3fE9puNdFsdefAA==
X-Received: by 2002:a9d:2c42:0:b0:66c:754e:869b with SMTP id f60-20020a9d2c42000000b0066c754e869bmr30820357otb.198.1669832137870;
        Wed, 30 Nov 2022 10:15:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v12-20020acaac0c000000b00342ded07a75sm902245oie.18.2022.11.30.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:15:37 -0800 (PST)
Received: (nullmailer pid 2555328 invoked by uid 1000);
        Wed, 30 Nov 2022 18:15:36 -0000
Date:   Wed, 30 Nov 2022 12:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v1 1/9] dt-bindings: arm: Add support for DSB element
Message-ID: <20221130181536.GA2553507-robh@kernel.org>
References: <1669018873-4718-1-git-send-email-quic_taozha@quicinc.com>
 <1669018873-4718-2-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669018873-4718-2-git-send-email-quic_taozha@quicinc.com>
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

On Mon, Nov 21, 2022 at 04:21:05PM +0800, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDA. Specifies the DSB element size supported
> by each monitor connected to the aggregator on each port. Should
> be specified in pairs (port, dsb element size).
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index c46ddea..e3b58b5 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -58,6 +58,13 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,dsb-elem-size:
> +    description: |
> +      Specifies the DSB element size supported by each monitor
> +      connected to the aggregator on each port. Should be specified
> +      in pairs (port, dsb element size).

Please define DSB somewhere here and not just the commit msg.

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
>    clocks:
>      maxItems: 1
>  
> @@ -100,6 +107,8 @@ examples:
>         compatible = "qcom,coresight-tpda", "arm,primecell";
>         reg = <0x6004000 0x1000>;
>  
> +       qcom,dsb-elem-size = <0 32>;
> +
>         clocks = <&aoss_qmp>;
>         clock-names = "apb_pclk";
>  
> -- 
> 2.7.4
> 
> 
