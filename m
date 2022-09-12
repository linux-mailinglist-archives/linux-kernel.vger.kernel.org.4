Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B685B6172
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiILTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:05:46 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20B3402D7;
        Mon, 12 Sep 2022 12:05:45 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11e9a7135easo25939229fac.6;
        Mon, 12 Sep 2022 12:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uI4DbGbAM0PwjRpMrOblwrt+romR1rmxVbvdKQ75a3g=;
        b=iBN/UKu4z7gotgnRJsgczB5GMQmRya6ar8tSAcayeQWulBRM0y5IMJ8jCkWQrHaDrf
         RzFJ8zkXogcgG6IH3uZMHhr/PG+DKPksJ5woKfr5H1WCTn/gY+j3I9HJUrnq8oB6+c4c
         Lr6qZ7TfWS6USrkd9rcyLyF0X4kMxy9WHu4IM1bhOxKa4k3JTHgWVFjke0lkRZthjqhr
         byRUpkBRhkwel76NhrYN7frUB3FuFB2HDK5/kBTKVSm86IiE+xv9w+3a1Xxyf4eyPBM6
         6/KXdiIKBmQyBuC2dq91xilI7JikABFNDco556P2c/9a+2GngPq8kQro6//vOKwP2pMZ
         qKDg==
X-Gm-Message-State: ACgBeo3XlkFVetJb+hWOQEDaJ4Er2qCcDYYfavafVC4R5GXJ6KK1m/ON
        B7s7DK8k0M8/8ciGaA47NA==
X-Google-Smtp-Source: AA6agR6wKZLkyzDqxAkDrRQa7TDbXFNIvobcMLRTkCNkT+mXdN79cG0z+B7nutrnVbtasLONO+iHAg==
X-Received: by 2002:a05:6808:1248:b0:34d:f86d:4ac9 with SMTP id o8-20020a056808124800b0034df86d4ac9mr7147955oiv.203.1663009544939;
        Mon, 12 Sep 2022 12:05:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o10-20020a54478a000000b00344eb5a9416sm4330740oic.55.2022.09.12.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:05:44 -0700 (PDT)
Received: (nullmailer pid 1658600 invoked by uid 1000);
        Mon, 12 Sep 2022 19:05:43 -0000
Date:   Mon, 12 Sep 2022 14:05:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220912190543.GA1658366-robh@kernel.org>
References: <20220823145649.3118479-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-10-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 09:56:41 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml      | 1 +
>  .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml      | 1 +
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml     | 1 +
>  3 files changed, 3 insertions(+)
> 

Applied, thanks!
