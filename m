Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417665BE2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjACKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbjACKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E513888;
        Tue,  3 Jan 2023 02:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57923B80E8F;
        Tue,  3 Jan 2023 10:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C26C433D2;
        Tue,  3 Jan 2023 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741896;
        bh=68oUZCvOyh2DfT3yErbuubEfNI1BBBZOuFmzO/RIRm8=;
        h=From:To:Cc:Subject:Date:From;
        b=LrIrMo5UYJZdI+xvp036Wp86hwYGd+b2P5kPWASjTmFPEL1KcFSxg+U+uG8BvydZp
         dlfe7tQfPibkwpIeV2y6JCiN5rhy5idlNPsV/L5N66S7sOLy8PajxMa7j4CaFTCUTb
         Jq+u7PMXtSn6BtwFaPBZd6AZ58wOzxXkrOzAf4IjVPHcK4QyeabmoZ+M9OTJO6G1Y7
         uBR4KgWpYE4LxvW4ejpzj8Vlzh/zEGbX3p9vRia5jBoWam+zwnUYwge7jMitf27NSm
         0lH7UgECfeWWL/7Dt5UfUDgHJjCYHWNTl9ykaG0Sql/qcLfAb3lT6Y1d/CnCpkV0mK
         aWTG5U+5fzzKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCeaJ-00047M-HU; Tue, 03 Jan 2023 11:31:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/6] arm64: dts: qcom: sound cleanups
Date:   Tue,  3 Jan 2023 11:31:35 +0100
Message-Id: <20230103103141.15807-1-johan+linaro@kernel.org>
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

This series clean up the sc8280xp sound nodes somewhat, for example, by
making sure the nodes are disabled by default in the SoC dtsi.

Included are also two related cleanups for sm8450-hdk and sm8250.

Note that sound on the X13s is currently broken and depends on
out-of-tree hacks to even probe:

[   10.719830] qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode
[   10.762206] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 19
[   10.857910] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
[   10.858386] rx_macro: probe of 3200000.rxmacro failed with error -22
[   10.975745] qcom-soundwire 3250000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
[   10.981406] wsa883x-codec sdw:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
[   10.986440] wsa883x-codec sdw:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2
[   11.086238] qcom-soundwire 3330000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
[   11.087322] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
[   14.342332] qcom-soundwire 3330000.soundwire-controller: swrm_wait_for_rd_fifo_avail err read underflow
[   14.342464] soundwire sdw-master-1: trf on Slave 1 failed:-5 read addr 41 count 1
[   14.342503] wcd9380-codec sdw:0:0217:010d:00:3: SDW_SCP_INTMASK1 write failed:-5
[   14.342536] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 initialization failed: -5
[   14.346734] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
[   17.727488] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 state check1: UNATTACHED, status was 1
[   17.839483] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
[   17.896325] qcom-soundwire 3330000.soundwire-controller: swrm_wait_for_frame_gen_enabled: link status not disconnected
[   17.896374] qcom-soundwire 3330000.soundwire-controller: link failed to connect
[   20.962617] platform 3210000.soundwire-controller: deferred probe pending

The out-of-tree patches I had seen that looked related to speaker
protection had been merged for 6.2-rc1 so hopefully the above log spew
is the only downside of keeping these nodes enabled for now.

Johan


Changes in v2
 - keep the sound nodes on x13s enabled despite the missing driver
   support -- hopefully Srini and Krzysztof can get this sorted before
   6.3 is released (Krzysztof)
 - moves the x13 vamacro node (new patch)
 - clean up the sm8450-hdk wcd938x node somewhat when moving it (Konrad)
 - rebase on sm8250 patch which had already moved the wcd938x node
   (Krzysztof)

Johan Hovold (6):
  arm64: dts: qcom: sc8280xp: disable sound nodes
  arm64: dts: qcom: sc8280xp-x13s: move vamacro node
  arm64: dts: qcom: sc8280xp: clean up tx-macro node
  arm64: dts: qcom: sc8280xp-x13s: move wcd938x codec node
  arm64: dts: qcom: sm8450-hdk: move wcd938x codec node
  arm64: dts: qcom: sm8250: clean up wcd938x codec node

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 78 ++++++++++++-------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 18 ++++-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 16 ++--
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       | 53 +++++++------
 4 files changed, 103 insertions(+), 62 deletions(-)

-- 
2.37.4

