Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7ED7210A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjFCOxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFCOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F4197;
        Sat,  3 Jun 2023 07:53:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 05CCE5C00D5;
        Sat,  3 Jun 2023 10:53:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Jun 2023 10:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685803994; x=1685890394; bh=aSjkzE25S8
        BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=i7f0Q9d5TEM1LgMqJdRiHaENlq
        ynQteKNn8bi2ztKCkSRVp4PxCircChHJT/lYVyvSYX0Z7/qgUv30JIzrk7ZYzd9i
        AKpKIVDyu3UAbtIRA78mvGuQxHdfXgT4ZsQlTamYjEoYxKy3K3SrCDGg6x+TRcWC
        PRTR9cmPgtqtcQlhEfHPC0N+VDElYhcKIbVFQCNVDt5ii7Z+pgsCClY33l8He98V
        C+xZF3NFoGeKTHJGUNqkMQ2tt2DgND6dr1InWKfjK2UwmGmAMarSoXt0/8UgfsN/
        qIXYrRMLYKpDfyanOmEeliW/NbSDAg+adQX8UewvfqzWjY3IRWMEP6UMqISg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685803994; x=
        1685890394; bh=aSjkzE25S8BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=J
        iBQ1MuYjIHoAHRkeTOW9xDwi5DUzBk+/ahqcMcNfOXPc8+MBgWAtdbyAcZpxzIa1
        ne/CK8oMKk7G+IAqFPQTTQOxKru3sgIM+tatRjNxFPMPYFzthPJse+XnxjxmgWgu
        rG0zNv63FslYu0OuN//1Md2SXw1/m8ZlbTDkDseHCLVTTnGOigAGCEGDPsMh8/yM
        bKGgGhhl6euDITEJ9ZRAtzHnpAdOavk99iorbnhFA5HmX4/25rx8CJ6j4Tqgzrq2
        L98mPoTsXdOEhMrwBSQcz9IKGjbQiuXyUsBZy2E1JtKyInnFAm3MIL7PJnaNeY/f
        i/odYTx+R7YDYAb3QRjWQ==
X-ME-Sender: <xms:2VN7ZFOOnLLSMNyLKsjRpe64xNv4C7ld1fAh9C3BV--P5_bBM4otUQ>
    <xme:2VN7ZH9HASt9Rc9hMEGzW_kzKXepnp30YWZf1kO9WtKvPTqTjXv5NhSJkYGSRD7hg
    a0Yqm-hc5X4AVY>
X-ME-Received: <xmr:2VN7ZETjO3jSzOnsD7iG4cQuZP7Ywu6sDDveNM4Ikww850NU-fG25jr5MXeFW3KVywvz5u9EY7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:2VN7ZBtIQr8ab_QY7pzn9qmzRils_8B8d0AnTu7S1xcwjAVBYDLCBw>
    <xmx:2VN7ZNe5KBuMTfqM1xxpC7q-CKAEFwowwLos69plGuNf7DHCuY6Pqw>
    <xmx:2VN7ZN3maGw4XPSuYZKLMM_p98HZ5GDfJT9zMTF86Sj8fRdDy5ZF7A>
    <xmx:2lN7ZB5rgqfmsT9A-XpPh30iiaFF6T0YJSxpGK4rjSbnKd6OvQVOsw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:13 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/6] device-mapper: Avoid pointer arithmetic overflow
Date:   Sat,  3 Jun 2023 10:52:40 -0400
Message-Id: <20230603145244.1538-3-demi@invisiblethingslab.com>
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

Especially on 32-bit systems, it is possible for the pointer arithmetic
to overflow and cause a userspace pointer to be dereferenced in the
kernel.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc..64e8f16d344c47057de5e2d29e3d63202197dca0 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1396,6 +1396,25 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 {
 	static_assert(_Alignof(struct dm_target_spec) <= 8,
 		      "struct dm_target_spec has excessive alignment requirements");
+	static_assert(offsetof(struct dm_ioctl, data) >= sizeof(struct dm_target_spec),
+		      "struct dm_target_spec too big");
+
+	/*
+	 * Number of bytes remaining, starting with last. This is always
+	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
+	 * out of bounds already.
+	 */
+	size_t remaining = (char *)end - (char *)last;
+
+	/*
+	 * There must be room for both the next target spec and the
+	 * NUL-terminator of the target itself.
+	 */
+	if (remaining - sizeof(struct dm_target_spec) <= next) {
+		DMERR("Target spec extends beyond end of parameters");
+		return -EINVAL;
+	}
+
 	if (next % 8) {
 		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
 		return -EINVAL;
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

