Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998A63AD79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiK1QQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiK1QQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:16:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3EBC1A;
        Mon, 28 Nov 2022 08:15:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 628973200942;
        Mon, 28 Nov 2022 11:15:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Nov 2022 11:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669652134; x=1669738534; bh=wg7FaKo805
        eO+vNPgQ7ztZjMcWXQHDAz6Wy4cpdl6SA=; b=LS5uLeJVdBZuZTtUjOOHkxZRYW
        Zxzxid+7EuBWTBo86rf+TL/N2F5x6eoDGBDASrMR/VYCSE+XtimVIPI82vmjBCI3
        5g3Q7P2nXT+NmLRYfdtSwKyblGaQse+ZIRQ7GHYLYO3do1Fv7Iv2TBSvkfEGCfIW
        ilCT7xeHvJtg0b62aMsit5Qloni3E130q1VA9l+62hmEdvMhhfKVY0eCrc+jk7Hg
        OwrX+g9ZaqUlh2ERcVSyvWBWUcnStVqSvPX2Zu36H5lR4YHcfJyoO+F0aGlNd2CP
        ddwZ8SIxgVUlYPT8SNqZ2Cw1m3ACKn+iC3P4tzkkmusHVMqwARwx5CyH1wuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669652134; x=1669738534; bh=wg7FaKo805eO+vNPgQ7ztZjMcWXQHDAz6Wy
        4cpdl6SA=; b=b65YMzkTrWpIYtQmR9odiHJDJ7BfHUZN/uWL+F8Aw10cJWGMCxU
        xBAqjmgl8mAcWdiFba2sRkJGSmdUMkcKdVWRF5kWpOckwD6qFDH5rlA3jbBaYYFO
        FiKGUCaCm3ofJkuhi2YYtjiNvN4MB4AQDk2vwJOlrdGfxbQG+JjaIuXA0WNhZ/Yq
        HktPQNh9FVkKdVbh5SQ8EPmPRfIRCy8LUGVBYBu18HHX41Cbomplu81ST0RUKwPl
        rQLcwwlfpTUJvPh1w/WW09Aw4YJZXzq17QdZayczeFrGhw/LrzqYGR70BW+l67ZF
        JCuQvyLKbXgRMxfIDtcAFGhSxWr26phVRTg==
X-ME-Sender: <xms:pt6EYxW7yUkjCUvoLNYZZiR9SHvzbKYGrAd4UC5VAKAGTpVFXSbfUg>
    <xme:pt6EYxmiS56cx2Epe9GZhtUvBSi9gONyR5A4fHB2BXGwla4ISjpXhmNnAdOASYzQ1
    5_iJtCPNca0Dm_xjEU>
X-ME-Received: <xmr:pt6EY9bSQm59bwu0jpCLZ5VDta7NuH8-AGbJAA_TCkIzwqzi9MYS0HJmxCUADvGE0K32tpZ8ZrvBOvPFo8swzNBSZpyV51Ebz7oa7sIWTXZso_kksHsWvg8WQZHLtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:pt6EY0V1CzL83rp1lD1q4jkxlyvN4xsk4rUO4UN_gJgJ2b11jLIReA>
    <xmx:pt6EY7mwHMh8h64OC4Dz_Vc-P2FaX3r0-qtrtyccWVfn_tthUN68jw>
    <xmx:pt6EYxcRcNRmEpEZq_XjqPh1VxRDxSLuh4CC4yA8gxadmvdvVL27kA>
    <xmx:pt6EY5YPoKCElaKrgbqTYrS5NmvURkk1nttm-AfXTWVsCCZAJlqo8g>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 11:15:32 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Janne Grunau <j@jannau.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: [PATCH] usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
Date:   Mon, 28 Nov 2022 17:15:26 +0100
Message-Id: <20221128161526.79730-1-sven@svenpeter.dev>
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

dwc->desired_dr_role is changed by dwc3_set_mode inside a spinlock but
then read by __dwc3_set_mode outside of that lock. This can lead to a
race condition when very quick successive role switch events happen:

CPU A
	dwc3_set_mode(DWC3_GCTL_PRTCAP_HOST) // first role switch event
		spin_lock_irqsave(&dwc->lock, flags);
		dwc->desired_dr_role = mode; // DWC3_GCTL_PRTCAP_HOST
		spin_unlock_irqrestore(&dwc->lock, flags);
		queue_work(system_freezable_wq, &dwc->drd_work);

CPU B
	__dwc3_set_mode
		// ....
		spin_lock_irqsave(&dwc->lock, flags);
		// desired_dr_role is DWC3_GCTL_PRTCAP_HOST
		dwc3_set_prtcap(dwc, dwc->desired_dr_role);
		spin_unlock_irqrestore(&dwc->lock, flags);

CPU A
	dwc3_set_mode(DWC3_GCTL_PRTCAP_DEVICE) // second event
		spin_lock_irqsave(&dwc->lock, flags);
		dwc->desired_dr_role = mode; // DWC3_GCTL_PRTCAP_DEVICE
		spin_unlock_irqrestore(&dwc->lock, flags);

CPU B (continues running __dwc3_set_mode)
	switch (dwc->desired_dr_role) { // DWC3_GCTL_PRTCAP_DEVICE
	// ....
	case DWC3_GCTL_PRTCAP_DEVICE:
		// ....
		ret = dwc3_gadget_init(dwc);

We then have DWC3_GCTL.DWC3_GCTL_PRTCAPDIR = DWC3_GCTL_PRTCAP_HOST and
dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST but initialized the
controller in device mode. It's also possible to get into a state
where both host and device are intialized at the same time.
Fix this race by creating a local copy of desired_dr_role inside
__dwc3_set_mode while holding dwc->lock.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/dwc3/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1f348bc867c2..fc38a8b13efa 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -122,21 +122,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 	u32 reg;
+	u32 desired_dr_role;
 
 	mutex_lock(&dwc->mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	desired_dr_role = dwc->desired_dr_role;
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!dwc->desired_dr_role)
+	if (!desired_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
+	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
 		goto out;
 
 	switch (dwc->current_dr_role) {
@@ -164,7 +168,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	 */
 	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
 			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
+			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 		reg |= DWC3_GCTL_CORESOFTRESET;
 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -184,11 +188,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	switch (dwc->desired_dr_role) {
+	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-- 
2.25.1

