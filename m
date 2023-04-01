Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7844E6D3339
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDASoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDASoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:44:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612076A2;
        Sat,  1 Apr 2023 11:44:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 701673200929;
        Sat,  1 Apr 2023 14:44:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 01 Apr 2023 14:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1680374641; x=
        1680461041; bh=EgK3/TiL28np4Zgt5b+Y1BW3uvD4i1QZBW4nZflddTo=; b=k
        QlG/2aT3s3N+UkoOxW1j7vt1fNMnAgu7Pt8zM/HOM4cWHcmGsL6SNtZKo7wQBgEU
        birN6Gb9kDI0bgLK31lolyhU1UZVtKouLdV6rncBByUIydGJ28EEhrWEyQTTjWz0
        glxH89hQ/Cwl4/sUWScMNhoZN3CaWI8uEj8GdzwSIDIgTvQMprpmA1E2iqy82bu+
        nyUNng6kcB8RjTddFOgfpgSPF8DYJkcyMXEflUHkPnsmUl+kz+dMeyalNj1xwXme
        q/3dW2sCNpApPzDV6BCai9PBClIsubvLiL6L/rKxq/KVhUD4LWr5ECaMU4c31xKn
        ybPL1YS1CYySaTlRqcR8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680374641; x=
        1680461041; bh=EgK3/TiL28np4Zgt5b+Y1BW3uvD4i1QZBW4nZflddTo=; b=M
        AmzMeNOTkPgjPgbXr1AbBhOg1cHpu4AsuWlsUx58XwYKNoT8ktHqrBSfY4lRLlkp
        K23w3XAJ2m8xBgkNxMF8/xlPPDrhTZbHe2W9JGQD7CCVD33xwnzVNslWrskX2EpB
        vmWM7QQqaliZhy95aVAnAejPqO+f7z2ZOO+daF5ey+MK7/y48b82o/qUG2HvIGtx
        OYIlcrkf7wuqCH827NsYRjxzT93Myt/0Jb1UrrOYa2JiQ7PmcR0cVXsFf+gePM0w
        zVD2bAKNPf9Bw5Eh2lL4BxorFxOAIrhHHGaxxbFPDqY+myFUogjPkrCaKIP6Cm89
        hnpkhegBGii2sjQut5Dhg==
X-ME-Sender: <xms:cHsoZBySCpFY6DgHlcq_YcpqZ2nJaTvuZXQwhF68uaQf-USBpnkX7Q>
    <xme:cHsoZBR6i4K4CIf7KBuTQRwptioKDRZJvSlXU7obpTQPF81az5xEM_vS_1rUkDiOI
    eu1PyRRxx5fTkRda8s>
X-ME-Received: <xmr:cHsoZLVK4b7EMeT1FJWPl-naQ1HiHM2tOKjxlQ4bI5Iho_rsoWmW29kCNx-kvcgYtlCsB65-ylLDhPeXvDAi5B8RashInj-4fQ-YxQdpY2BlTVrDpOM73T1w_tx_OO4zN__fil04uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeekfeduueetuddtgeehjefhvdeiheejhfelfefgvedtiedvhfelheei
    udefgeffkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:cHsoZDjZyshdUtpGwxl3cXk0uPAHuIcdilaUVfyjuu6Onn9VYxKV5w>
    <xmx:cHsoZDCRasm3jIvMV3rLbs46Ca0dtsdL_pNe34vNU50632dcxhLCfg>
    <xmx:cHsoZMKN93kBmhE8De7TCXmFbLmZuAkefrdc9W5q4-sLjse96SVqmw>
    <xmx:cXsoZFCx1_-pg5YzduTU9HSFAsYEWwe6cYy_jYNMnx1KzhT3itsyAQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 14:44:00 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        Mario.Limonciello@amd.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: think-lmi: Clean up display of current_value on Thinkstation
Date:   Sat,  1 Apr 2023 14:43:45 -0400
Message-Id: <20230401184345.208960-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ThinkStations on retrieving the attribute value the BIOS appends the
possible values to the string.
Clean up the display in the current_value_show function so the options
part is not displayed.

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Reported by Mario Limoncello <Mario.Limonciello@amd.com>
Link: https://github.com/fwupd/fwupd/issues/5077#issuecomment-1488730526
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/think-lmi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index ad952b49617b..29e94db03238 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -920,7 +920,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
-	char *item, *value;
+	char *item, *value, *p;
 	int ret;
 
 	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
@@ -931,11 +931,13 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 	value = strpbrk(item, ",");
 	if (!value || value == item || !strlen(value + 1))
 		ret = -EINVAL;
-	else
-		ret = sysfs_emit(buf, "%s\n", value + 1);		
-
+	else {
+		/* On Workstations remove the Options part after the value */
+		p = strchrnul(value, ';');
+		*p = '\0';
+		ret = sysfs_emit(buf, "%s\n", value + 1);
+	}
 	kfree(item);
-
 	return ret;
 }
 
-- 
2.39.2

