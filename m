Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8756205EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiKHB2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiKHB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5112B63A;
        Mon,  7 Nov 2022 17:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFBA61380;
        Tue,  8 Nov 2022 01:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87311C4347C;
        Tue,  8 Nov 2022 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870880;
        bh=Yn9vD7aPdJpm7zviw8cUVowJExvvVCQS6pH0coJ+GSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efsA6hVOlreEekr5yuz0fGPpeSN+FDE7COGoRC9+IzO4vkyvnYFuDLj9oUoNmVKEV
         fTKD/YmrzKYDxRfTZusrwnh0s2yiaLs7OeOfdGpMM1i11FWsrrDI3xAx0nQjhSj79V
         EqSj0LI/x/jhVsNBN9mQGKQsAEdRlxco6HL9e1y7I6348zZteWIjqDmVrAOWaybSBH
         aFacVk1c2dPkjzymnUBdImbTJVkyaFezHVXiao1dNvbgayKvu4XWsNXpL5ITyxlMBQ
         qe4K6r7VUC1pW2kcaoVDQ3wleolYiM6ks2Hx+J0TnTzbyTpKJHGy0TJ3H1/xHuL8ow
         sLKQ4jZbX0oPg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, afd@ti.com, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: support more types
Date:   Mon,  7 Nov 2022 19:27:31 -0600
Message-Id: <166787084683.599230.9192518212041906530.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 18:39:31 +0100, Luca Weiss wrote:
> * 'adc@' is either spmi-iadc or spmi-vadc
> * 'charger@' is either pm8941-charger or pm8941-coincell
> * 'usb-vbus-regulator@' is usb-vbus-regulator
> * 'vibrator@' is now in yaml format, so add it
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: pm8150b: change vbus-regulator node name
      commit: 0c9a86fb9ebc576e66a2ce6a667684431a14d2f1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
