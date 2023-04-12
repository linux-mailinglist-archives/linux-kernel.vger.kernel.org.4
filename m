Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482816DF992
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDLPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjDLPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:17:08 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B3E5D;
        Wed, 12 Apr 2023 08:17:07 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w19so7907903oiv.13;
        Wed, 12 Apr 2023 08:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312627; x=1683904627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNprRlqDCMnfC83BhNWWEXQLaWwc7+dkeFZAuE/vPLQ=;
        b=YyvPsycdrLiUHblu0SezIbeMK9Xp8ZVoCXyp+MWqlmnZCMBgey04MlLah4o9wCmRmS
         xuC6naC+p4+b9QgYrVVeMJkh4uxYbRFAQxwo7oEVsRTevsYygaiHa4GicM9g3iCOb+JC
         1b3Q5J/f0dSi8+WClxEVezYCH3gIODOtf6y37LKMwvpiAbDfclMNlWwDQHDQo+6tKAS/
         twAKvU1BcZ+ItQxaVZi6ujaXnfo6+h5FNT83eQ+7cdvWmQnz2RHBxLrdz+V/LKd5mvSJ
         /c2/0v+flFEy8JieaQzKHRQI4SznS5FlW5/RJs1npm87lEtM9GTj52aD7SvBrbcqSERu
         Z9mg==
X-Gm-Message-State: AAQBX9fmN4UkiWnMu2twb5/NqkLdBVJf4Khc+LsIPXSz2F97Ua2F70td
        YMj/RRKhLLSxEjTiFAWLSA==
X-Google-Smtp-Source: AKy350abHrfHtLlbSppkCQJjD5SEZ0x+NFR09MPJHNdq566/4Fq1xdrWO4naJDHYkLIHQzPninrxgA==
X-Received: by 2002:a05:6808:1d2:b0:38b:6d43:9185 with SMTP id x18-20020a05680801d200b0038b6d439185mr2732410oic.42.1681312627015;
        Wed, 12 Apr 2023 08:17:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h16-20020a056808015000b0037b6f5d6309sm6778889oie.2.2023.04.12.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:17:06 -0700 (PDT)
Received: (nullmailer pid 2451233 invoked by uid 1000);
        Wed, 12 Apr 2023 15:17:06 -0000
Date:   Wed, 12 Apr 2023 10:17:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: clock: qcom,gcc-sc7280: document CX
 power domain
Message-ID: <168131262566.2451173.17788755819115497126.robh@kernel.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
 <20230408134820.76050-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408134820.76050-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 08 Apr 2023 15:48:20 +0200, Krzysztof Kozlowski wrote:
> The GCC clock controller needs CX power domain, at least according to
> DTS:
> 
>   sc7280-herobrine-crd-pro.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

