Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C373061DDAB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKETUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKETT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:19:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BCFB844
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:19:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 161B23200392;
        Sat,  5 Nov 2022 15:19:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 15:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667675997; x=1667762397; bh=63
        c2H+dRQD1BzJZi0cy8b0iFyafq5iwHTt7UuUibAIE=; b=H+JQcl35za7+ROjxck
        sQmB6zB+1wboxkVRTI9TantFMWG1GBuOOIz5mL4qSF5LVfY8xnlKORAwAlQFulf3
        d1lSIAMox3vNRn2aqLlmdCMDfQWAO5NFhNyXJWPc6DH/UIOfddSejzRcKvXCKQpr
        u3ojWPFYFOQvHaWcbQ2/XUdawhecgirWsx6dN2+KRlRmwh2HKXZqmeo7c1LcYXjI
        fPIvF7WdCveT7j0UvL5YNTQNT2AnfyYHaetBzM0vLzREA5RhVGKSfVFCxD1RVp7D
        ZRnDESQM7HS2h4AQlo/IBxePUP1DeTgcKfq7fRMwgKlMjC3ex5X6CV22wfScEM3Y
        j1IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667675997; x=1667762397; bh=63c2H+dRQD1Bz
        JZi0cy8b0iFyafq5iwHTt7UuUibAIE=; b=co9pExtOgnJxK9hFOBL56VSD7zb2V
        1Hcb72pT0OGFQF0at4s8S7ENA+phcrwviGDlY58UMepUNnGK3RngaOxVc+Duz6X2
        /ycph15zLNDtj+AC4wxGRzkoKz+vQozdef1g5qJgj1kHSbNfudRU/6cEsiu7nZbn
        dtUG33fWywr6XfrLs1C0yrhtzYpl2fW1SHxhXja7RgeVNgwES5dTefGFRGuMrW3z
        7+QrxTkz43Xvu4K6Viba1XPdOtWhQG+PTt7ux5551ZNhKgJa9KWE4emkEEheRSwH
        Q6sdlLYqAGTxkKc7E1AK1d4zw/fOh1tgs9fOFPPJ/A+PR2iXAIVFvlqnQ==
X-ME-Sender: <xms:XbdmY5ZPjEYroYvrNFegeouF6lVjQFnY3z_-lam4q-GIzmp5waGkTQ>
    <xme:XbdmYwbDfNPSeDN04Snq88CrGzeUSRPPtnp8YHcP-hgUR2D-Sm3gLcf-Mira2uEgi
    Ld4v1Xb7Flf6hivow>
X-ME-Received: <xmr:XbdmY7_FPhhXQ3PJirdxz6wgy_9oDbz638y2wMgDflCpiWjPpN2z8B5HJPVuRC-YxzH4WDVVc42to7YmiuxjfmttC5BKrZ0g4RhQxuWWI9fRm1UGRTgqyNhVx_Bc0Xtjez7E4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:XbdmY3o4W-uZuGUdIoFaD9xi0pQ2Kk0CwhDrCfRXnj6jW8-v2b4LBw>
    <xmx:XbdmY0psUEP5G2XdSNvQN-RDLx_sf35OTv1VVViCE-qxFnIeLJYFgA>
    <xmx:XbdmY9Qzp2uAA4FxYbqXqFrWQZ29afZ3wO8CYpcjPaaZQKKMWT71kA>
    <xmx:XbdmY5BgoC7EeI0TF4pGUfsvCH2iO3xCiNBaONMNDlPMJ1UV_yV5Qg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:19:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] bus: sunxi-rsb: Remove shutdown callback
Date:   Sat,  5 Nov 2022 14:19:52 -0500
Message-Id: <20221105191954.14360-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221105191954.14360-1-samuel@sholland.org>
References: <20221105191954.14360-1-samuel@sholland.org>
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

Shutting down the RSB controller prevents communicating with a PMIC
inside pm_power_off(), so it breaks system poweroff on some boards.

Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Fixes: 843107498f91 ("bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/bus/sunxi-rsb.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 4cd2e127946e..17343cd75338 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -812,14 +812,6 @@ static int sunxi_rsb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void sunxi_rsb_shutdown(struct platform_device *pdev)
-{
-	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
-
-	pm_runtime_disable(&pdev->dev);
-	sunxi_rsb_hw_exit(rsb);
-}
-
 static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(sunxi_rsb_runtime_suspend,
 			   sunxi_rsb_runtime_resume, NULL)
@@ -835,7 +827,6 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
 static struct platform_driver sunxi_rsb_driver = {
 	.probe = sunxi_rsb_probe,
 	.remove	= sunxi_rsb_remove,
-	.shutdown = sunxi_rsb_shutdown,
 	.driver	= {
 		.name = RSB_CTRL_NAME,
 		.of_match_table = sunxi_rsb_of_match_table,
-- 
2.37.3

