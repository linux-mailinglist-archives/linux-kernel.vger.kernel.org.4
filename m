Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14866E7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAQUqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjAQUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:37:25 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2134C30;
        Tue, 17 Jan 2023 11:22:21 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so8705278otf.8;
        Tue, 17 Jan 2023 11:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rG3R2V1qqSN44Ku2yfSe1P+2hvGoj34mROM9Vs7AX8=;
        b=ASwErkTLs9xzvG8HW3HYcMhklaJYgR5TZK6X782L5hoJZ3k2mEeRtZQMRNa6VOGO/8
         QubZ6ptNtn1XaU+jdnFimgC9uicHX/V2DF2gRHsK3U1QHAk8fiPuWulXsLeu3SjFdfNu
         5O9ESppGbe4CxeClCSnbkk1dLd5FYCl3JncAaYTu5ueUqWbD3YNOCdzQ1gXiAcVU+A9L
         xsi6pd9cnbwoKhqU0EOXeljKIhM83AZ88mMlqU9Dh9TB8hTCO8b4yussYFAoDysOVFY9
         sWuq0IKgctGnFmlwtHxPUMEYdcou/Y/+TkfSYqAqRZMAcCti6ppAA6KbG7Twrzpt1/n+
         wcQA==
X-Gm-Message-State: AFqh2kqIORDqmrnWHfs2ul42tjsIRWSPuymR37GiF8xTTPdbIdQ2hXFZ
        SPUcRHU+ZgUHZ0ViStmTvQ==
X-Google-Smtp-Source: AMrXdXvKqegazsLgf2v9G1uLKuVnBCQgYZfnuujKkNC+iUoo7aQUeewPrn0DJQx+IyQAjvv5Q53F/g==
X-Received: by 2002:a9d:2c06:0:b0:684:c8ff:8844 with SMTP id f6-20020a9d2c06000000b00684c8ff8844mr1992677otb.12.1673983340756;
        Tue, 17 Jan 2023 11:22:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w25-20020a056830061900b006863c59f685sm3601880oti.28.2023.01.17.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:22:20 -0800 (PST)
Received: (nullmailer pid 3489286 invoked by uid 1000);
        Tue, 17 Jan 2023 19:22:19 -0000
Date:   Tue, 17 Jan 2023 13:22:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: qcom,wsa881x: Allow
 sound-name-prefix
Message-ID: <167398333901.3489228.15719942715865032325.robh@kernel.org>
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 13 Jan 2023 17:22:12 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to fix:
> 
>   sdm845-db845c.dtb: speaker@0,1: 'sound-name-prefix' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
