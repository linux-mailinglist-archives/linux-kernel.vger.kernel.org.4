Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3062866C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiKNRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiKNRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:00:13 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F8317CF;
        Mon, 14 Nov 2022 08:59:35 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 17FDC5C0197;
        Mon, 14 Nov 2022 11:59:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Nov 2022 11:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668445172; x=1668531572; bh=yKRgGvprbc
        oIqEkAWWNc2PNyMEcpae3Af/heeqEz8UQ=; b=iOsUoNfHwTvT0XulboXuoSXg/k
        2G1WgarGXIWbdDvh/mz+3P4qmXmoXgVrmXE3irKW3Ev8dr+6TX2DCyCkT1Uw4Pn5
        pnyhGdLUQ+PBbVonXW/d9u6F2Hi0XaQP0FwV0k2s+70ADMhhChA6w/qBqWUnlb0l
        nhXTy1V1K/99LvkwzsddgtCZGCswmA+uLopbmfqt2bfGtggfwrDUDE6UUL0ck2aQ
        juUX49UKP7//5Rxa+caLYLuku+taXmO7iUohrrHdfckmsakiRPSs7NJrnE1CULoG
        IgBZ251kA9cA38NKqVTQWRd1N7iXuy4Z34AtDWkToVyjljVpCGln5i1ykArw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668445172; x=1668531572; bh=yKRgGvprbcoIqEkAWWNc2PNyMEcpae3Af/h
        eeqEz8UQ=; b=T32XE8s2ywBn+GqAV1ujFSrQIje1n1zhqOEAD/4bABuM9CfpPF8
        EQBEkT0yoEJ6KsaSfTTrJHW4Wz9j+JvQu1r/IVBiyKT/RGVh4F/zB4Tq46sJ8kRG
        PsJtvoOQTdyJwwEPtNFGXZJzMuGOd00i6D4lKKcgUE1u9KU6lVE1xRliyNE9/VSR
        SuNRjynMHSsCNHg6bIL6mR07Tal97PVXmhR2Ucj60e+n/D+nBIPIlsvd/Px/GqNn
        TvzxZqEe2aZBHcdGiB5eyVofd5fqJQSzZhNqkLCLN7dhztizfeH1Fja1cHX6YuhE
        jPbUlpx2WGqigMS0SiB5uOzKr0xBcB0LzyQ==
X-ME-Sender: <xms:83NyY6vfb1bUjeof0I70mLX2b6zF9tXYGkrmOcQb5wIaxWQi3YLJWw>
    <xme:83NyY_f5LxREFsWGIbm6Hx249Xl-GHX3JqU4Dk0Vucw60cNRQ0O-z9RONt_BR--Ya
    jqa1rPkHWCNhHOEfhg>
X-ME-Received: <xmr:83NyY1ywFUw4MfCiAn4_Lvnjpyhjw5_exALQbaYEoeswwXWIY-J4fu5xetikz0EtQWxFgyoE7XhooxFPRhnncG12gS8VPqahr7szK1w5moOdzGM6GMk-6bzIpXJ9pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:83NyY1MrYoPAtbm6nDzuAzXqcV-8qqrPQvfteyDmhD7U6yyKskYnZg>
    <xmx:83NyY6_IgEoU_VwHvctKI148NJRHRtqvfdXOxZLTnqv-vKCr3MTeYQ>
    <xmx:83NyY9VIXbGpiPlycWcQwd5NOhw_LkxjN3emDmuM3UWdGxFBcl9x6g>
    <xmx:9HNyYxYUtIQJLJ_bSSdSbXrX37p6CVuSvCMCq0U5KeqpteBckaH63Q>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 11:59:31 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: Check for ops->exit instead of ops->enter in altmode_exit
Date:   Mon, 14 Nov 2022 17:59:24 +0100
Message-Id: <20221114165924.33487-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_altmode_exit checks if ops->enter is not NULL but then calls
ops->exit a few lines below. Fix that and check for the function
pointer it's about to call instead.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 26ea2fdec17d..31c2a3130cad 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -134,7 +134,7 @@ int typec_altmode_exit(struct typec_altmode *adev)
 	if (!adev || !adev->active)
 		return 0;
 
-	if (!pdev->ops || !pdev->ops->enter)
+	if (!pdev->ops || !pdev->ops->exit)
 		return -EOPNOTSUPP;
 
 	/* Moving to USB Safe State */
-- 
2.25.1

