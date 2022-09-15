Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0BD5B9347
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIODh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiIODho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D89321D;
        Wed, 14 Sep 2022 20:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D9162088;
        Thu, 15 Sep 2022 03:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11BFC43159;
        Thu, 15 Sep 2022 03:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213038;
        bh=Ux6LCWuF0upV4LmswakubF+kyYhCwKXEDUfb/sVTqiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZUDXkdzEdGUgGulMRPff5y0u7p7xG2zqzGHsGj9QjoHauomQeDPuEiWn4v8jluhO
         w/CAAiJCWNpJI6gUdZJibhrMBzv7QhXKNBddmcHpBF6NQKWlehqWsysjvC6A0fQtBd
         uLNqRvvQK5A1b/vF2mb3dSqa9l9+ZeLLoHhcBOd00npyOT7MzkBcLG+iqCWpfSiFNl
         /LM0i6pa/u9SF8TYERxJhbuxLEJo9MXTwHb/M8TAohjDG5aejKeH85gnfP4TLfGBdL
         HpA06MEmT8QIP7M6xdVLi3xYVoiHf+G+ayn5AGd6r9dePS2KAoIoFzwJtgoLePRb5a
         tNoxSBAtfyQuA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp-x13s: Update firmware location
Date:   Wed, 14 Sep 2022 22:37:00 -0500
Message-Id: <166321302063.788007.13188921370780972793.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220914073922.7145-1-manivannan.sadhasivam@linaro.org>
References: <20220914073922.7145-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 13:09:22 +0530, Manivannan Sadhasivam wrote:
> The firmware location in linux-firmware has been changed to include the
> SoC name. So use the updated location in Thinkpad devicetree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: Update firmware location
      commit: 29f894eca862f55e570d578571aa62b38d9ac9f4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
