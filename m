Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755806268DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiKLKZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:25:22 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB22FC12;
        Sat, 12 Nov 2022 02:25:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 922435C00EE;
        Sat, 12 Nov 2022 05:25:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 05:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668248716; x=1668335116; bh=qJfGBhZiTW
        ulvBK64Qdm+CqQnbSC354FNmkmvzVs8Q8=; b=P4bRPkGFH8dx3o+518cE2uqVKj
        GP0y7JWPhLiaF6TkrxidvwSXZXwljCNaDzsn/jQ02gnyvmM31F2riZoObuzHJ0cf
        Bvg2O1nW2oHvU9n/rzkPNtolYUoFDqVanDOtZ9XZsNKsuJ2d5d8Gb6joVHKu/JYk
        dX7Cw07yUp/2qBWwrJaLYuWZ4d3Sun+tRULVEi6JJp6x/S4y0NTly6HN1RGRddHZ
        m0ZwPzodW6FbGegU15axtHC912ujxvZbNCVVpsRLlwrVDXbyYsyhuFIUPmSt2Et/
        p8/zhw2mt5Q108rjXCCWJ3jN/QZw1xGLl9nxaix5gPTaIFNNBZkk7c5FbdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668248716; x=1668335116; bh=qJfGBhZiTWulvBK64Qdm+CqQnbSC354FNmk
        mvzVs8Q8=; b=SojtWf0siDBsuZmgt8IC+2ZQY+72PRBIRZVDkCoGYx5gcBpqHN0
        cAoRrMZDdEi5nuRem71ptZp6lvxY64czborDZejTcFjv+uUuR+FgzRYZ2YAVjTRv
        09rUekkVIdRMfdLWBoOa49wCy7c+hRKWdkyeJqaSMTZ55RcrwMyvqg5GrK/UUbDD
        0GN+pg8SdG+X1Dxywu3dzpS/pq/6LYF4PFJJHgjhgLOmXWDn7+DIGOFiXpr5Nl68
        vdliMXeg+EGr+xNWVlS8LuvAO112v4CTDDytGv2ORPav9Au2Bo3vUjJT17oE75rE
        GZLUC3UsQkg7bwa9pV/VI578EDCZc2A+3cQ==
X-ME-Sender: <xms:i3RvY-S93xrXhrw6sTqeWJ78rtoXwjMbywMSrMXsJWTvZbeyH2Gyhg>
    <xme:i3RvYzzOBIS8tSaDMltAh2Xw5q8dMW9O6mvP4az4WxaCpsmztxfS5M1a5BvxtRcgK
    90zobE9V0o27Trf3qc>
X-ME-Received: <xmr:i3RvY70PBqa_vqhRCqPpIfOauRnYgx3hhZArb26PbH35fUEEyjxgnc4E9p6n_69VGJ9ZaPe4kRr_EeRFTu1vgNPCPOR9nlSTEY50i9l3QMgEgPb3dh51S6aTZucj9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeekgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:i3RvY6Dt18-ddLR4gyLnKN_BKdvVLE7fu8cPv95EKgSZB1alxa-L0Q>
    <xmx:i3RvY3ixMYqN0irLUMIrHLRTx3AUmYe1r4xA3XAEcgucv5aRrJ6fyA>
    <xmx:i3RvY2r8IKiC4OWVsj9ybMfMtsky9ENL2mj6voIs5j6O95GuAfdsnQ>
    <xmx:jHRvY3cCTVWoiB_yqsRXSMq9oE8n3gKALIA_4rlLvfHN8Bk0l6Hj0Q>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Nov 2022 05:25:14 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: core: configure PHY before initializing host in dwc3_set_mode
Date:   Sat, 12 Nov 2022 11:25:06 +0100
Message-Id: <20221112102506.34990-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, first the PHY is set to the correct mode and then the host or
device side of the controller is initialized afterwards. Otherwise a PHY
that's already used has to be reconfigured.
dwc3_core_init_mode() does this correctly for both host and device and
__dwc3_set_mode() does it correctly when switching to device mode.
When setting up host mode however it first initializes xhci and only
then changes the PHY's mode. Let's also do the operations in the correct
order here.

Fixes: 958d1a4c40dd ("usb: dwc3: core: program PHY for proper DRD modes")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/dwc3/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ad4d644e21a4..759d23d908fa 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -212,14 +212,15 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	switch (dwc->desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, true);
+		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
-- 
2.25.1

