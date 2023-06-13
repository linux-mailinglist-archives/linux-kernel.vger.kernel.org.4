Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9372F0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbjFMXsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbjFMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A783C2D50;
        Tue, 13 Jun 2023 16:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A11B63C8B;
        Tue, 13 Jun 2023 23:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C112C433D9;
        Tue, 13 Jun 2023 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699948;
        bh=p2R+/mHF91wIebjpSsBTFu4SEbaQgfELL3DvhNmbKdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrY9G0vKO0SclZJ/92dsXCMoMzdICPVzDUOH4MrNuxyniJx67fYfKGIwLVTzeP5Jv
         dBRfp2bJTtIHlJRTwmAchq6ICuWmTNz+rX/vMr1uxn2kQ+kucipF+Wn9C2MgdL8ZjY
         OLQuxsFswWdaykzo2WsfONd3Lu+UypJobHlR6RYwk6TxU3WXi1l8eJ565dXZbJ3PJ/
         athgw/0mP7v/QMXGwQvl1+gbc5psesaAmV13qpto4cNL5+HZFU/eVdtJBw7vpRAjUs
         XYCAfnrrNbHTsQlE7SZssMOXLyZfN1f5fiJJc7WXypP4cdPylPX+ANsmprGNr2fYLh
         ZFI+OrtT4bJ8w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 0/3] Thermal zones for pm8226, pm8841 and pm8941
Date:   Tue, 13 Jun 2023 16:48:51 -0700
Message-Id: <168670013503.1400697.7077988789865184986.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
References: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 01:14:58 +0300, Matti Lehtimäki wrote:
> Add thermal sensor for pm8226, which is using on chip VADC channel to
> report PMIC die temperature. Add thermal zone configurations for
> PMIC thermal sensors found in pm8226, pm8841 and pm8941.
> 
> Matti Lehtimäki (3):
>   ARM: dts: qcom: pm8226: Add thermal sensor and thermal zone config
>   ARM: dts: qcom: pm8841: Add thermal zone config
>   ARM: dts: qcom: pm8941: Add thermal zone config
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: qcom: pm8226: Add thermal sensor and thermal zone config
      commit: 1b118df488f2be09b846994a4135d57f634e564b
[2/3] ARM: dts: qcom: pm8841: Add thermal zone config
      commit: 84e72ea467db83043858b48fcd97de4c9e68881a
[3/3] ARM: dts: qcom: pm8941: Add thermal zone config
      commit: 637cc974046abe5718bf045a1bc66a238778a145

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
