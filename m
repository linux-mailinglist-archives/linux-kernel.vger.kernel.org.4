Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0A722782
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjFENec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFENe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:34:27 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D8DB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:34:25 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685972064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kf6zgkDUnecNfzu3j5XSu5/huKGd/SdarF/Qmk9HXkg=;
        b=e3vzuYc+FQS4U26zWHOa1Nuw6wzI+Q4pu2QiWAwmFJXBtt41NvtzYC1g475fXEc3IgpvJw
        8aUqcvLqwYSmAynnaUt/sHuvpppFiaCQzZj0lRYQTsVRz0jSFIYiCLVMsnZsquD3tbVbnd
        AKBla+3BywAN+pzMNKc+XyRR7WKQ85MGhQLX+aJKceuDSC0MlKHcfAQrG9LMLEI5HeHcWj
        bcB+XNWPssl6VnooV+EqkYBphWXFuj0Xz0nTp24ClEa6dN0bHzuTaQ/nBCwkbufGB6iWmX
        JRj0kBUsmLHWdPTDc6DzKYfhKMYyzNZXYhy1PsmJZgUNhgVLzE7pPjq95qi7Yw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A553DFF80D;
        Mon,  5 Jun 2023 13:34:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/4] sysfs: Improve readability by following the kernel coding style
Date:   Mon,  5 Jun 2023 15:34:19 +0200
Message-Id: <20230605133422.45840-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605133422.45840-1-miquel.raynal@bootlin.com>
References: <20230605133422.45840-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the if/else block is to select the right sysfs directory
entry to be used for the files creation. At a first look when you have
the file in front of you, it really seems like the "create_files()"
lines right after the block are badly indented and the "else" does not
guard. In practice the code is correct but lacks curly brackets to show
where the big if/else block actually ends. Add these brackets to comply
with the current kernel coding style and to ease the understanding of
the whole logic.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 fs/sysfs/group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index eeb0e3099421..990309132c93 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -142,8 +142,10 @@ static int internal_create_group(struct kobject *kobj, int update,
 				return PTR_ERR(kn);
 			}
 		}
-	} else
+	} else {
 		kn = kobj->sd;
+	}
+
 	kernfs_get(kn);
 	error = create_files(kn, kobj, uid, gid, grp, update);
 	if (error) {
-- 
2.34.1

