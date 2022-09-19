Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C55BC5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiISJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiISJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3857BB866;
        Mon, 19 Sep 2022 02:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2350F61828;
        Mon, 19 Sep 2022 09:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75329C43470;
        Mon, 19 Sep 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580707;
        bh=FJUuPlF9EQ5WBKIVHxojSXsG1ogqBLlxRRFzoNXf0FA=;
        h=From:To:Cc:Subject:Date:From;
        b=ixM1OIPtNcHW8xkCO6pGoAz53Acik3j5Yz2badHd5+Gw/nmg0swjfBVteiT0D6jNQ
         c+dw2+iIBmv3MZV+5BMVLRbczpGypSLGcDQMQv9DREAWvhTTSNSmrRIBTYMac/rRLa
         QXoEjmOruIOoU5ywOjlcA5nJMzt036OljKNvxXlpH3GRu6BnuBwmY13Wi2jKDuvVrw
         gl4wTsb2jYnbTYLXOXoirnlIqstnPUCj9x2LVL5V6Sq8QFfey+KHv7jjpdJkhW0csq
         BnI1AgpI6dQGLUzicxiEVeTk2ujlb8XhHG2WDrCJfrzkxFuayG966YJz+BSGaNzmGx
         MAaJ9ZYIQDEpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDKx-0000Pm-QU; Mon, 19 Sep 2022 11:45:11 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] arm64: dts: qcom: sc8280xp: fix USB/DP PHYs
Date:   Mon, 19 Sep 2022 11:44:50 +0200
Message-Id: <20220919094454.1574-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

When adding a check for overlapping register regions to the QMP PHY
drivers I noticed that the USB4/USB3/DP PHY nodes are currently broken
in multiple ways.

This series fixes the SS PHY nodes and drops the DP PHY nodes which can
be added back after the binding and driver has been updated.

These should ideally go into 6.0.

Johan


Johan Hovold (4):
  arm64: dts: qcom: sc8280xp: fix USB0 PHY PCS_MISC registers
  arm64: dts: qcom: sc8280xp: fix USB1 PHY RX1 registers
  arm64: dts: qcom: sc8280xp: fix USB PHY PCS registers
  arm64: dts: qcom: sc8280xp: drop broken DP PHY nodes

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 28 ++++----------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

-- 
2.35.1

