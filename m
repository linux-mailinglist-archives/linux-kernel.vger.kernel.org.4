Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DC5BAD18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIPMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:12:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777815F102;
        Fri, 16 Sep 2022 05:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BA72B82681;
        Fri, 16 Sep 2022 12:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F4C433C1;
        Fri, 16 Sep 2022 12:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330336;
        bh=avDYvG2aCI5qbbRVHFWoG6998vd8DKq7JCfEt0kpfYY=;
        h=From:To:Cc:Subject:Date:From;
        b=UGMqFk01x7rdBerClFtSJZB/0BKcR+m3pecxM7j8LZWxYttSh9T406YWX49/iFC9o
         y8ikGUzYeR2olfa4jAoIG/nqklGEGWW76XGgBJH5CvhiSBU2FTPdOKxanEQaT6+2lG
         qobsmiCWvdijlkdqEDqnP6NN3tyNFQte+Sn5NbXRS8KgS2wyn0ffo+2YF9sRYZSzxV
         v4O3n1+t3akZVgEsc5Eqh6oO1NstqSx8bhz81CLhbcJZNYS46jrDfM7AINOpubQAGT
         4rfmh6J8snObPkEJN+ufwrrKiutAPf0El8I5Izi4FwMMnxPxDJJtMxQwniFaQQSgz4
         CZRvJ5Ygvldaw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/6] Introduce the SC8180x devices
Date:   Fri, 16 Sep 2022 17:41:58 +0530
Message-Id: <20220916121204.3880182-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
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

This add Qualcomm SC8180x SoC which features in Lenovo Flex 5G laptop. This
also adds support for Primus platform as well as Lenovo Flex 5G laptop.

I would be great if Martin and Greg can ack the binding patch so that
everything can go thru qcom tree

Bjorn Andersson (3):
  arm64: dts: qcom: Introduce the SC8180x platform
  arm64: dts: qcom: sc8180x: Introduce Primus
  arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G

Vinod Koul (3):
  dt-bindings: firmware: document Qualcomm SC8180x SCM
  scsi: ufs: dt-bindings: Add SC8180x binding
  dt-bindings: usb: qcom,dwc3: Add SC8180x binding

 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |    1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  |  590 +++
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |  326 ++
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts   |  706 +++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         | 3939 +++++++++++++++++
 8 files changed, 5566 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-primus.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x.dtsi

-- 
2.37.3

