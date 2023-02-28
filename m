Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B46A5AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB1ObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1ObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:31:05 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A042D171;
        Tue, 28 Feb 2023 06:31:04 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5702468otv.0;
        Tue, 28 Feb 2023 06:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XtdomdrpB2aqEtkSgb8XMiwOG9PDyVF2pWLS4s97V0=;
        b=YjnyLoVZWOUqvBmuqIe8OC39E1W7+mmqRxsARzYcY4Gvu7wFS2a597+eN+RbFFjkGm
         OW+NkvyKDmG3+HFYV7zSsPkNW6NpZWGbkTxOtqlNp+hpuUBZSXo/Z+SQSS56NMBZla3Y
         RtHvS8tlPWq0T8zo/Zy4l6IBBHMQ9ydiTKFm06NiNmBeUhFqxFzzhSgEyrGknqvGJ3IB
         y7Os8TaecQ4xw0BDIY6PXxflszo14ijHIm2LQzgKfmNlibnsoANrseEE5VjNvFVEFbND
         ZEuoge21iWiTAvlb7GRaSGr5ldW7zh1ogKTVEHMl93CdQ+aWq8kTueRcBHtFppEoE/F3
         Jr+w==
X-Gm-Message-State: AO0yUKX8r0divmYSKEyqGnSDdRsS6obRiyvkxHNE3rHDgSlkxDi99HeD
        ROqMjw41AQILnwYxP5R9Oy0WV5R+cw==
X-Google-Smtp-Source: AK7set+IYSCG82EmbLpvs8GpRkNamd+enUeLvFLiXGBjn60AQUO0OYNOR8+MxZCZ9INfN281fi93+w==
X-Received: by 2002:a05:6830:3107:b0:693:d5c2:9a9a with SMTP id b7-20020a056830310700b00693d5c29a9amr1692776ots.36.1677594663333;
        Tue, 28 Feb 2023 06:31:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l96-20020a9d1b69000000b0068bcadcad5bsm3726856otl.57.2023.02.28.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:31:02 -0800 (PST)
Received: (nullmailer pid 3198314 invoked by uid 1000);
        Tue, 28 Feb 2023 14:31:01 -0000
Date:   Tue, 28 Feb 2023 08:31:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     broonie@kernel.org, quic_sjaganat@quicinc.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ipkumar@quicinc.com,
        devicetree@vger.kernel.org, quic_gokulsri@quicinc.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        quic_anusha@quicinc.com, quic_srichara@quicinc.com,
        quic_kathirav@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        quic_arajkuma@quicinc.com, lgirdwood@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH V2 2/6] regulator: qcom_smd: Add s1 sub-node to mp5496
 regulator
Message-ID: <167759466099.3198254.6194582057962133441.robh@kernel.org>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-3-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217142030.16012-3-quic_devipriy@quicinc.com>
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


On Fri, 17 Feb 2023 19:50:26 +0530, Devi Priya wrote:
> Adding s1 sub-node entry to mp5496 regulator node
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Dropped ipq9574 compatible as the existing MP5496 support is
> 	  extended for S1 regulator
> 
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

