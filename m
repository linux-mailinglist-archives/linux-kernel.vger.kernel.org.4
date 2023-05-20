Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCC70A47C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjETB5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjETB5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39AA128;
        Fri, 19 May 2023 18:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50DC865B69;
        Sat, 20 May 2023 01:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BDBC433D2;
        Sat, 20 May 2023 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684547859;
        bh=XE2XquSRrobqoUiBQ27a0nRJ6lUpUGlxp62Xz5cyNZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwRFjBBJN6Fe31W2ivuqaF7UuCfJ6PHsmPw19Y9wstHxNkV7g1FB7h384lHu21gQm
         9pqUdUvaHR8ZLckLVLZBi/nhMCJMjlNHbuj1fyDtSncCaiddxwm1+tp5cfHOVwuoTs
         IHNhXRDK+PYWBf1t7+ZEwnjPUgwISJZ6O862l25/repv2gut7XgU4kgYY/496Y7bKN
         sQB3Lr6H2VcTc5F2mU3YRoxegRG2JlZg/XayteQgEF7BdP4HQCUmX8/3R4qt87cmK/
         iUpXzFiFG2enqnVpsjzcOu780rdB5Bna22tsR0SNDUq5ZHZkMqbp7VzOeUKTl+ATcU
         6tLg7pa8fv8GA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: mark the UFS controller as dma-coherent
Date:   Fri, 19 May 2023 19:01:22 -0700
Message-Id: <168454808160.2842337.5917662434231772548.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515121908.303432-1-brgl@bgdev.pl>
References: <20230515121908.303432-1-brgl@bgdev.pl>
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

On Mon, 15 May 2023 14:19:08 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The UFS is cache coherent, so mark it as such in the dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: mark the UFS controller as dma-coherent
      commit: 2b967894f80aac2c7421eb545c32ed995f8d9877

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
