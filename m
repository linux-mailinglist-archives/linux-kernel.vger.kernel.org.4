Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9F61A381
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKDVkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:40:40 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50FBA6;
        Fri,  4 Nov 2022 14:40:39 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id b124so6510565oia.4;
        Fri, 04 Nov 2022 14:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh4TZpx/fUejHGdSgYJPb2bOIrkhGmJ4yxw/EXpmSSk=;
        b=iPRBMAce09l0t8FPGESxNDo0BR59BiqGIsHpT/KMpqnsrQ3RZa8G1fqDcTcgVmzfGT
         GKyOMw/oZXvdie/JussKcE28KwbK1URxxWOQZWnb8d5/v/WT/GFl7qDLGD26D7f/MKgW
         W5Mzwtxa1Tpl9dHKYpiTzZNeexiAjYNrqspYcCM0OZSIXkxOGUsnkgYV3hi50JHNWpks
         CSgJw0w9YadOmJvXyvnr+zLtYOL+CZ675uYaiXw6IjGUInUsNBmIHWGupLL5Qv0GMvaW
         0jPyKU+TjVJ8An7ssQOsM2XjLA2gpH+G8hRtbVtiip9DVAvXaZywgszlLUvg1eRcHwt6
         6wqw==
X-Gm-Message-State: ACrzQf1/MLB0Rk0MQNWu0n+cblRVmtPxL0VQeYYKx8bqvppedq7r1OGG
        j7vouubrmqvRIqfDYwLb5Q==
X-Google-Smtp-Source: AMsMyM4AIauGU9ELLG9wadYHkA3jCPpaknwCvdEYTBT+HNyDIyo9igsDWHLRAB0W7CXeL0RgIYFYcg==
X-Received: by 2002:a05:6808:1288:b0:35a:5a4b:812a with SMTP id a8-20020a056808128800b0035a5a4b812amr2989133oiw.117.1667598038238;
        Fri, 04 Nov 2022 14:40:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a4acb07000000b0047ed75e4d61sm135059ooq.7.2022.11.04.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:40:37 -0700 (PDT)
Received: (nullmailer pid 2878196 invoked by uid 1000);
        Fri, 04 Nov 2022 21:40:39 -0000
Date:   Fri, 4 Nov 2022 16:40:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 11/13] dt-bindings: phy: qcom,qmp-usb: fix
 sc8280xp binding
Message-ID: <166759803901.2878139.5371601797957864706.robh@kernel.org>
References: <20221028160435.26948-1-johan+linaro@kernel.org>
 <20221028160435.26948-12-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028160435.26948-12-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Oct 2022 18:04:33 +0200, Johan Hovold wrote:
> The current QMP USB PHY bindings are based on the original MSM8996 PCIe
> PHY binding which provided multiple PHYs per IP block and these in turn
> were described by child nodes.
> 
> The QMP USB PHY block only provide a single PHY and the remnant child
> node does not really reflect the hardware.
> 
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
> 
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the per lane PCS
> registers).
> 
> Note that PCS_USB region is also not described by the current bindings
> despite being used by the driver and this has led to people increasing
> the size of the PCS region in the devicetree so that it includes PCS_USB
> registers even though other regions like TX and RX may lie in between.
> 
> Add a new binding for the QMP USB PHYs found on SC8280XP which further
> bindings can be based on.
> 
> Note that this also fixes the SC8280XP "phy_phy" reset name.
> 
> Also note that the current binding is simply removed instead of being
> deprecated as it was only recently merged and support for SC8280XP is
> still under development. And, specifically, there is no support in
> mainline for the multiport controller that uses these PHYs.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,msm8996-qmp-usb3-phy.yaml        |  13 ---
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 105 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
