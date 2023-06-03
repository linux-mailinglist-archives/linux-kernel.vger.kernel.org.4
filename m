Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95E7210AB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjFCOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFCOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53D18D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 07:53:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 436B55C00C8;
        Sat,  3 Jun 2023 10:53:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 03 Jun 2023 10:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685804002; x=1685890402; bh=F4OXbKEhX/
        cWHBaWnFmGY6QP2wMBPb2edHzYfPJhig4=; b=k/jGMYcXSWRlwp1iXFmb5LZL1K
        0nFerI/3Q2ubLUn6uAeTeRYk7BPE+wzpO8j+CExQick59ZwFRozc97HYVtVNeL5l
        0DvB3xxb9SRWv2vjGWxqwpaaPUztPhcFc2evqVlpQcjTg7Jb5+aBFpymHefPqS00
        fi4e1E9x93FmbljW/WxsHXWeMR+ZBZNaMoAh8eR5lgEaEWdMmuoSmC4mgFcI+Arb
        fJcuDRTbbbTy8e+zxKu3cpRou26/ndZr8c0pYwFTUGVL9klW9kIQyidHQIa0wGcb
        5H5qgRD/mh9KI80PTV1fNjkIXHsBWzEMEelfdNQxv/4Nhl7Y8lv+feQblzAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685804002; x=
        1685890402; bh=F4OXbKEhX/cWHBaWnFmGY6QP2wMBPb2edHzYfPJhig4=; b=n
        Wg+9EevZJ8ZOemDgL2dehUME+px4D3TcJV/KwLHq3qS0hxhV0ujPqqxhJ2LlkVfE
        3Cm2F+QuHQPtNEDR8NLR3zKfICS8FaDhYJeqaD/spboiIk+98pTQaNYnvlF2EjLd
        r+Hpy4ZGmdm9ghF/elvqh+oMgjHs6iNBDAOzzOo7TGsbteNUk39gPAxYTKrDUakf
        /lVRIvUwkj2TWUyIY80HHF6yMAxkZXWjjtmIKdQdxDYDmRtKt2KPKh8dyN00BDCe
        p9WO6H5uTJU7Ob5eNVLU4XfDM/i5syGd2Y43vSdwQucOnd/N+STfIaR+zFAB1mOP
        TDiYuEf02bYa2wEyfg0Zw==
X-ME-Sender: <xms:4lN7ZPHY0yFhIpsRVPY8s28Due-xxWibVX8YM05bKYkSdAANsqRoBA>
    <xme:4lN7ZMUAPgAFSjHnLlGLOpX7s2qy2sOR5QH2d9hrEd4rWrUp0f4sPz2_Dg33q6nJi
    VI2grbitUr_MCw>
X-ME-Received: <xmr:4lN7ZBKqE1LPt961fOBOHa0BMTkjOvPJ9nzV8ddVoQ9wTuI2ilK-_8pfFI-acpgDFOFLR3DnbG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:4lN7ZNEBp0bXTbr4PEE5EFUOG2vz80M3F4DdsToLEbrHNMlK1lzkwQ>
    <xmx:4lN7ZFVQrUeRDWBUlIjLHsOQoyJBkirXsRTuHhLA6UzEzRRVPZNU9Q>
    <xmx:4lN7ZIMuOoBA7-L-x5CuwWrXbjr2v7B8_5FnYZaMQTtf8gbo8u0oJw>
    <xmx:4lN7ZCgzUAbv5MBu-65OEHwyeuWcKqp6mqF--cH43ey4Nzn9_YIcWQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:21 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] device-mapper: "." and ".." are not valid symlink names
Date:   Sat,  3 Jun 2023 10:52:44 -0400
Message-Id: <20230603145244.1538-7-demi@invisiblethingslab.com>
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

Using either of these is going to greatly confuse userspace, as they are
not valid symlink names and so creating the usual /dev/mapper/NAME
symlink will not be possible.  As creating a device with either of these
names is almost certainly a userspace bug, just error out.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5b647ab044e44b0c9d0961b5a336b41f50408f88..12be95ee20778b9acd3ea0d98f160a7409028afc 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -771,8 +771,10 @@ static int check_name(const char *name)
 		return -EINVAL;
 	}
 
-	if (strcmp(name, DM_CONTROL_NODE) == 0) {
-		DMERR("device name cannot be \"%s\"", DM_CONTROL_NODE);
+	if (strcmp(name, DM_CONTROL_NODE) == 0 ||
+	    strcmp(name, ".") == 0 ||
+	    strcmp(name, "..") == 0) {
+		DMERR("device name cannot be \"%s\", \".\", or \"..\"", DM_CONTROL_NODE);
 		return -EINVAL;
 	}
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

