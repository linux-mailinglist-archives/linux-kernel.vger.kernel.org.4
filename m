Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F866E725
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAQTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjAQTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:34:58 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5E5829F;
        Tue, 17 Jan 2023 10:38:37 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id h12-20020a4a940c000000b004fa81915b1cso261867ooi.4;
        Tue, 17 Jan 2023 10:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usmLcJsIrTN0HzsLj6S4gEel07Cxr+uLTfIujYF6bko=;
        b=rApqE/H8lQKYkkSCKtB3ra8+NVcQ1wMweNOOGMW6rsD8cno6V9zZhDwK5nQGTtnOy5
         TLO8pgANRowp1ugb2CMd4uditf9DpwmlhQXzK1Z5MIQVsGu4vfJJQ4Ink/L8lM8bgCvW
         vlXfjNSQzLXzdoQ3+bp0FxlFrEtIbQx5jqfm3pgIf6rKUOLJ0SkponU96V4iWnjI6knq
         5TpKnVrUpuqY1FL22zSrWxrM+8IWKrZGgMqQHQdRCeA4/jxCtTD7MEW3jjLmQdBFikTY
         sThUuz+QGP+wKLfbmJZ4uO/v9kZ4DQ4OO4D31JMRcu2QpKnmkv5kWoR17Eh7+Y9IpTal
         0sUA==
X-Gm-Message-State: AFqh2koHxL/rRn0PU9OPqkryX9Tb6Pdqjqhesm8f38rcUz1+K0MrvllK
        1Y3qhe0BJfT1yIqMVwO7tg==
X-Google-Smtp-Source: AMrXdXvLVI5CuwaiE3H8rQprNcWFD5EueDgPFGCLXvTjlgOMhu3/99mSh2ykniwjUqwZDe68lJAbKQ==
X-Received: by 2002:a4a:d6d8:0:b0:4f2:2e05:4fe0 with SMTP id j24-20020a4ad6d8000000b004f22e054fe0mr2302535oot.4.1673980716888;
        Tue, 17 Jan 2023 10:38:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z23-20020a4ad597000000b004b0037cebc4sm15453364oos.9.2023.01.17.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:38:36 -0800 (PST)
Received: (nullmailer pid 3431272 invoked by uid 1000);
        Tue, 17 Jan 2023 18:38:35 -0000
Date:   Tue, 17 Jan 2023 12:38:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     devi priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH 4/6] regulator: qcom_smd: Add PMIC compatible for IPQ9574
Message-ID: <20230117183835.GA3427325-robh@kernel.org>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-5-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113150310.29709-5-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:33:08PM +0530, devi priya wrote:
> Add mp5496 PMIC compatible string for IPQ9574 SoC
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> index 8c45f53212b1..7907d9385583 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> @@ -22,7 +22,7 @@ description:
>    Each sub-node is identified using the node's name, with valid values listed
>    for each of the pmics below.
>  
> -  For mp5496, s2
> +  For mp5496, s1, s2
>  
>    For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>    l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
> @@ -84,6 +84,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,rpm-mp5496-regulators
> +      - qcom,rpm-ipq9574-mp5496-regulators

Is this a different part than just mp5496? Or used in a different, 
incompatible way?

>        - qcom,rpm-pm2250-regulators
>        - qcom,rpm-pm6125-regulators
>        - qcom,rpm-pm660-regulators
> -- 
> 2.17.1
> 
