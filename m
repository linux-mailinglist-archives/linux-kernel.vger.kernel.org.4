Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94165C589
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbjACR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbjACR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7610B6C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DD7B8107D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBA2C433D2;
        Tue,  3 Jan 2023 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768745;
        bh=NKKiVB1i2BfdlcIEk4DPuD8/R+WjII2LWaQr2JIaGxo=;
        h=From:To:Cc:Subject:Date:From;
        b=kRrAp4zvFZ+IvMmX8QXX1nwz53lUWGjnvrOFrlt32WyIplWPTvno3pZgkby0fhfmX
         UVHZBn8E0i8qXQFDwftLOIMuMJHe+hUcpv9hhVl7bNJNis00u59kA8Wug8Tbx6kxVn
         ZgS5rQ33d5Acq62M86/dHWxeikYbVw3zu3dPro++W8FGVpVxdEmUbWPddra8TXVCTQ
         IZWvOhcyR8VKN0Ai0vS7mJtVq6PvChYXdnvEmmCC6HyLy5OUPACy8+4M6wHJVEySou
         VZZr19upSR+jbnXUGNJpZBkg+nOiriFJEKQTl5OjgGb9DKM/jlg8mZMcfQPkd8z3Ku
         N7W4aWwnXpsqA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     colin.i.king@gmail.com, dfustini@baylibre.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] scripts/spelling: add a few more typos
Date:   Tue,  3 Jan 2023 17:59:01 +0000
Message-Id: <20230103175901.128262-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few more typos that found from real patches[1,2] to 'spelling'
file.

[1] https://lore.kernel.org/linux-mm/4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com/
[2] https://lore.kernel.org/damon/20221228174621.34868-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 scripts/spelling.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ded8bcfc0247..64bddbf7425b 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -411,6 +411,7 @@ contruction||construction
 contry||country
 conuntry||country
 convertion||conversion
+covert||convert
 convertor||converter
 convienient||convenient
 convinient||convenient
@@ -664,11 +665,13 @@ feauture||feature
 feautures||features
 fetaure||feature
 fetaures||features
+fetcing||fetching
 fileystem||filesystem
 fimrware||firmware
 fimware||firmware
 firmare||firmware
 firmaware||firmware
+firtly||firstly
 firware||firmware
 firwmare||firmware
 finanize||finalize
@@ -1558,6 +1561,7 @@ tunning||tuning
 ture||true
 tyep||type
 udpate||update
+updtes||updates
 uesd||used
 unknwon||unknown
 uknown||unknown
-- 
2.25.1

