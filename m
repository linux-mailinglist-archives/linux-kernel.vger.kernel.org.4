Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC64687E72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBBNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjBBNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:19:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60447F306;
        Thu,  2 Feb 2023 05:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B6B0B82662;
        Thu,  2 Feb 2023 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEEBC4339C;
        Thu,  2 Feb 2023 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675343988;
        bh=cgyO6oENOnGLZEDMSFb7vIWhYFOJKLrgcd5FRlRWzRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeMK7BAps8cxAwwxSB6OMyScSi0s1hP4yKWA+9+p9cJPxDw0Ie85bGL6YrGWPDHPe
         DKBDJWIqrcJ4aRMdeV2EXMtbpePjQhJVfjscB/8Dmr4tM7qPufCGBUDqROHxDskze7
         KGz4uOCdRlO3SKSyFqKSNeFupbwHmpuDyqksSwANnEEsrkdE6S6Pup0718AFuAXEeA
         ne/Cgev/ikzvXh6Ho8g4Z5A+eDt9RjXJ9tHjKSozdMq9oxl/wAQ+wqEWv3/vtcwa2e
         QRicWhqSpib0UFZpAdSowTzPIRZ8oPpKByhxPAbWgTs7J6eH1ZQ+zW9oczULwYn9np
         mXMtfOHI9y7Og==
Date:   Thu, 2 Feb 2023 18:49:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/3] Add USB/DP combo PHY config for SM6350
Message-ID: <Y9u4cAK+uKXuu+uL@matsya>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23, 14:29, Luca Weiss wrote:
> While this patchset started out as just adding a dedicated init sequence
> for SM6350 since USB PHY init didn't work in some cases, now it's also
> migrating the phy config and dts over to a new format.
> 
> Also note, that the DP portions are pratically untested since TCPM
> (type-C port manager) and possibly other components aren't brought up
> yet.

Applied 1-2, thanks

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

cover doesnt need sob :)

> ---
> Changes in v4:
> - Fix dp_serdes offsets in driver, add dp_txa & dp_txb fields (as in v2)
> - Fix order of resets in dtsi
> - Link to v3: https://lore.kernel.org/r/20221130081430.67831-1-luca.weiss@fairphone.com
> 
> ---
> Luca Weiss (3):
>       dt-bindings: phy: qcom,qmp-usb3-dp: Add sm6350 compatible
>       phy: qcom-qmp-combo: Add config for SM6350
>       arm64: dts: qcom: sm6350: Use specific qmpphy compatible
> 
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi               |  54 +++-----
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 139 ++++++++++++++++++++-
>  3 files changed, 154 insertions(+), 40 deletions(-)
> ---
> base-commit: d514392f17fd4d386cfadde7f849d97db4ca1fb0
> change-id: 20230120-sm6350-usbphy-87c5e3f0218e
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>

-- 
~Vinod
