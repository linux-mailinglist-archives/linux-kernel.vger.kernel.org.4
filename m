Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23471F49D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFAVZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFAVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08CB195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:25:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1827B5C01D9;
        Thu,  1 Jun 2023 17:25:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 17:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654724; x=1685741124; bh=h/1KwQmVaB
        XUd1H3OHkX9KZBr+WvyoaYktC9lrYuvik=; b=kMK42/eP2QQw4iUjZwnuhTf7+N
        I8hnwQvpNyGrcpi701r+NYHbQNUNNtEkwodP+KKRX25LcWStIj6vg866vTVQ6t3c
        bldGK7ptPX1Gw6AspQW46YYt36yXWssA/PptTC7RvTMO784ZrR+uyt+kdQoXNxsM
        nDBewdaCVISlh5JZ19A4bDdvWKN6/L+L8QT8Q98+tgiKO79IwN6gJfzHNCiCx2cH
        I5expoAb73sL4DRIUBcdrcF8f0Ha7O7XlAuFfLn3yw2bbGqibn4yTc5gloWJKe7O
        ajCG3rM4H2NA+xa751J0cyC98iNe9YXFT6yluN7w2Kb8eyM6fdjL3QD7c+fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654724; x=
        1685741124; bh=h/1KwQmVaBXUd1H3OHkX9KZBr+WvyoaYktC9lrYuvik=; b=a
        TkAGIVwq2iFivqFUKv2DA1VXOJJnOlnFEzrgATMUTlhvLHCgMW/qBYE6xJHH68Rc
        59UUXKm7wT4hq98cjMhkY+KnWJLS8nH0Sym3gB82X2HAydwujG/4Uz67emSIKOPc
        dOofJ08BkOCrCY2L0FPK0B9Hi9FE+vNkkyTyGEHJ2cMdtMminLMqWqFVE2zXnChz
        Fk6WhTpiRuMyhjnDzLtsWQ1y5hgOdhpN+UBzMVauvtZ1jjGKLly1L9fMgzxt32tX
        mjD9kfCAacfZh4MBl3d8yaJtA5vPfScToCaSNEYieLfPPbbdHQqCBjYzZC3Fp9yw
        Pwfor2M+KQyJooGa4MvCA==
X-ME-Sender: <xms:wwx5ZN-1nVIOm-poAfwY9drGrP90YJr5LpDKtQC7y0V1wVqOEYF2nA>
    <xme:wwx5ZBvmFjIoi_nEYkSHx4SoUgCEPCj5JjzzcatwrTOK9fa3MSU7SUicVzOfNeewF
    waFfYuhoSjT7ZE>
X-ME-Received: <xmr:wwx5ZLCTwGhQvoIACKWGpOIxAADgTa98P88Cz2-F86hbwBliEpBaJSG_lXwozkbcuhGdXiGEa_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wwx5ZBdu0qnky4yPi8iZRFNjfK0r4M2LhhyDSGerNQOK36XFPeGGJA>
    <xmx:wwx5ZCNO-Qh9kG24AtB4r0wKEVfpVCo8avynWEOLTvq3v27efeUSKA>
    <xmx:wwx5ZDlThLHPAN4DdI1yz7fhhxtS3qwq8COBRROqtcR1yY02SWmdhw>
    <xmx:xAx5ZLbchMSSD7_LbgR_uT6c8M0LsdGIxZ-a370F4lDPGenGDUjQEA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:23 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] device-mapper: "." and ".." are not valid symlink names
Date:   Thu,  1 Jun 2023 17:24:55 -0400
Message-Id: <20230601212456.1533-7-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601212456.1533-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index b12592bcb4b2b8513f5da6208fb545203534d7ff..adf0c4becc743e4ad59e1d6b0ef108ddd56f207d 100644
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

