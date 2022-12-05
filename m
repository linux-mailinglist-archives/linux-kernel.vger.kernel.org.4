Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86CE642670
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiLEKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLEKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:10:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77800183B4;
        Mon,  5 Dec 2022 02:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A90B60695;
        Mon,  5 Dec 2022 10:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B68C433D7;
        Mon,  5 Dec 2022 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670235029;
        bh=UKiRJZiLjJcqQYbuhGuTxSbl5IYHsAs7+XtrUEGo+TA=;
        h=From:To:Cc:Subject:Date:From;
        b=PuivGRnqMZC7MP8tajdweXR+6j1gw7Aypy8W1f02XdoBU5LpivlE3rLfpXRQK4Gvv
         DO4UBtdkUF/y+TUCTACOhR3YtVYhh/OZ1mTsSnSYQ+6IEaUK5MlWdh/Fw52oghFlqm
         n6jKXjHsIIt7ZMo4z7gpq2it8rkaLkdGBxICl4H55WxBsCFpqlyxNWkv8y7QRdQ8mL
         PxVAaJCWFC3h4Z0OyFR+IU9bCYRJxXGXGeah8Y9CsCyM2YBHdyjzXSZFGOe13IJQ1y
         zzba4l+zNTc+nYOUPNLnIyL3k0a70NhoiBGYVDdDTjqvpMEsBBnjvhsULgh5rH/Mn8
         Z7RcXH4TF8d2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p28Qj-0007c6-GC; Mon, 05 Dec 2022 11:10:34 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sc8280xp: fix UFS DMA coherency
Date:   Mon,  5 Dec 2022 11:08:35 +0100
Message-Id: <20221205100837.29212-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP UFS controllers are cache coherent and must be marked as
such in the devicetree to avoid potential data corruption.

Johan


Johan Hovold (2):
  dt-bindings: ufs: qcom: allow 'dma-coherent' property
  arm64: dts: qcom: sc8280xp: fix UFS DMA coherency

 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi              | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.37.4

