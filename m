Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC067210AC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjFCOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjFCOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A602CE;
        Sat,  3 Jun 2023 07:53:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C76425C00C8;
        Sat,  3 Jun 2023 10:53:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Jun 2023 10:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685803992; x=1685890392; bh=YCzACzClxG
        a/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=pXYzXv05o9CAdFMXpOMdKmLWi2
        Q5Vuiijm/ua1tXFFnVVd1Mmlyx0n3sJG7LkVHlrx2skKiWiQsHJ5s+xH+jgC0xsU
        qnJCUnbr2+RZTznR9n9hba8/it5Hsqve8eNGpy0QG3q8nhb0B1fZMwII5oAYzLwz
        7Ltro9/nIYFdvObT9L7XkEt3SEUT1fRvXKLzRUcRu0DWmp6C+ElO/93OT/zM8Aot
        qc/ZHGerpZ5NcMYIvFiQjfF3K6k3pdwGiI/q5Yhhb1BqGoXcKRrTEpbGWzp8Uf33
        8phGyAwsIKivy40tWpDXpekYtqYOqbnwMX//S+yA+45b5TOkqsaxN67UJOtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685803992; x=
        1685890392; bh=YCzACzClxGa/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=v
        CBsWyth29tlIlptRZtIJNH+muWrQmiT0Lbs0SbsNteRgKmQXQX+J7Vt5gror77e1
        Ta3vwUGl8KlKj4yUjlg7SEmhjxAyAHA/3/GEaOcpKHbkZjqfeFUPzqGPayw4ppWt
        SY1iURtwhnQk12abr1qwqjnpnn2UOFpHOvFzRcNgap4XiFbgm/vJ8QcL2+l9m6nc
        yRf9hwoR8sxcEZqlk3scrn+CmX8utRGnawc1t1vP3GSe+0k5uAIC6suw46l5mpJr
        TYSOPN8JdKHQwvpvEoqy2l0jGPvAv+Wmyju1pHSFcnfe6O/TuNQJHDcwQFJvn/ez
        wcDzQsQBeOHQnAI6qxI+g==
X-ME-Sender: <xms:2FN7ZE2h5QeLfbrohaX27qRqTPUK48kyBgm3-afbOaLUJukdgBM0-w>
    <xme:2FN7ZPH3omy1JSPsoxKOshmcJiJW3thxamhbYkN0FNFZAHg9LcV-H52-S7u4Ng0Nb
    n6Lg1u8Kx4mK7I>
X-ME-Received: <xmr:2FN7ZM5vsjOKkKbG5RSuNkEV7oUWyz5n7GZ-mv36HQIUpYTZPZzD2_PiclAIGT-dSZBzc91_hsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:2FN7ZN0aOE4E4YhBrqF_xSyYQvn7SEcA-3yA5oHdNLWbpQSybaNF5Q>
    <xmx:2FN7ZHHCBVyVBX_loHW3pTFfQ6nennJbkyE4OHWJQicqH5itNUuEHw>
    <xmx:2FN7ZG_sNxo5GyxjtyLo1SVHeVmznrWI33qrIRRElaWXj51-P9LM5Q>
    <xmx:2FN7ZPDQwR-wycjhdOYZuCyv0fuuk_LPMaDvLTD8z-1uvyfBRl2U7g>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:12 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/6] device-mapper: Check that target specs are sufficiently aligned
Date:   Sat,  3 Jun 2023 10:52:39 -0400
Message-Id: <20230603145244.1538-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603145244.1538-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise subsequent code will dereference a misaligned
`struct dm_target_spec *`, which is undefined behavior.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
+	static_assert(_Alignof(struct dm_target_spec) <= 8,
+		      "struct dm_target_spec has excessive alignment requirements");
+	if (next % 8) {
+		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
+		return -EINVAL;
+	}
+
 	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
 	*target_params = (char *) (*spec + 1);
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

