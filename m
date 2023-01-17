Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1966E8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjAQVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjAQVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:52:17 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933AE38B5C;
        Tue, 17 Jan 2023 12:18:41 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1433ef3b61fso33214313fac.10;
        Tue, 17 Jan 2023 12:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR8YbcfMepY76OiaErdLAV2Hc3g5AfoqFq4DC8Gzbb4=;
        b=XAb63qvqOQrkLNH7dLz+Mx7O4rcVXc++jFIIgyPTh/Nh5siiQV+/36IzpRks9bfj12
         TozVqlTXM+X1G9ztqqRjAq2tuEfk54IAZIzXLkutoVx7nZpHvkX4Zb9M20qpumGDK8C1
         EXQFv+IEd1WXf1Uq1nHfgHztR8JGR7ArH8h0CfqlBl09zw/2UG2jiksL+TSu6irL8lbh
         zHKz9zjrgggEcs2jOgL86By2Dv+rE0K+2uLs3aP8/0lxYeCaX2T1WdbTDmZ4uE0pJN4u
         W6QhT1QNymu6dzXLKW8n/Dr7MG8eKoVRu07lkhZXP4L+jxCrz6c3YDaPd4EEwBgGvBgx
         x58g==
X-Gm-Message-State: AFqh2kpqzEPGUzdKJ+80xCJRrBF9XuucCHTwn8pBzsL6mzkX0JLWomSF
        zUXtxOYslj04afxkTUSeQw==
X-Google-Smtp-Source: AMrXdXv089TBvVd1Nm1c4yDRuJAsd/heqs9Z0JWT0biGb6hOr+GpAjpZXTc84rnYeIbCce/TeFamqg==
X-Received: by 2002:a05:6870:7b8a:b0:15f:18cb:9816 with SMTP id jf10-20020a0568707b8a00b0015f18cb9816mr2724591oab.4.1673986720766;
        Tue, 17 Jan 2023 12:18:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k18-20020a056870959200b0011d02a3fa63sm16805671oao.14.2023.01.17.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:18:40 -0800 (PST)
Received: (nullmailer pid 3639226 invoked by uid 1000);
        Tue, 17 Jan 2023 20:18:39 -0000
Date:   Tue, 17 Jan 2023 14:18:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     quic_abhinavk@quicinc.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
        agross@kernel.org, sean@poorly.run,
        freedreno@lists.freedesktop.org, robh+dt@kernel.org, david@ixit.cz,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, dianders@chromium.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        airlied@gmail.com, devicetree@vger.kernel.org, swboyd@chromium.org,
        robdclark@gmail.com
Subject: Re: [PATCH v7 4/4] dt-bindings: display/msm: Add list of
 mdss-dsi-ctrl compats
Message-ID: <167398671860.3639169.11899100042089144320.robh@kernel.org>
References: <20230116152128.909646-1-bryan.odonoghue@linaro.org>
 <20230116152128.909646-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116152128.909646-5-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 15:21:28 +0000, Bryan O'Donoghue wrote:
> Add the list of current compats absent the deprecated qcm2290 to the list
> of dsi compats listed here.
> 
> Several MDSS yaml files exist which document the dsi sub-node.
> For each existing SoC MDSS yaml, provide the right dsi compat string.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,mdss.yaml        | 3 ++-
>  .../bindings/display/msm/qcom,msm8998-mdss.yaml           | 8 +++++---
>  .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml | 6 ++++--
>  .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml | 6 ++++--
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml | 8 +++++---
>  .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml | 8 +++++---
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml | 8 +++++---
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 6 ++++--
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml | 4 +++-
>  9 files changed, 37 insertions(+), 20 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
