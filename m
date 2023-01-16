Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633166BB38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAPKHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjAPKGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:06:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F718A9E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC88B80D70
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF975C433D2;
        Mon, 16 Jan 2023 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673863577;
        bh=3aMyUKpwYYfFXYrxkDcWdbRFEBJQFTH+rGxlccfrU2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs93CvYTVIPwKtWIUOwwoLvDpsQU61sJJmgSzUytCiBJujM7BnFpZMZQDHy7kpRW7
         AinPNzl5tt0EfVsKcTLdRwZIPKY4IWOj+MNrLAH3li9dVoKclLVS3n/9qkIvlvNHyC
         MWLUwi2gpYwkFh6HZb52yc8VCs8PHqK0DRSNcjVb6h4YgU41pA2yTsdRUGKm+OOZV8
         X5ppIdoh8RYOYFZ+4IK0l5x7ksEhC7KWq3oajojLClsaYeCEZSxN7hMsmAw07/G8VO
         CIFeuqz3S+rFecNRw9Q1cK+gwHGM/OaK+faVO+0nTAUou6VYyxBQ+L21vHTb5FVHkf
         SF8vcWqCs5rwQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     airlied@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] BRANCH_MARKER: work
Date:   Mon, 16 Jan 2023 11:06:11 +0100
Message-Id: <20230116100611.12712-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116100611.12712-1-jirislaby@kernel.org>
References: <20230116100611.12712-1-jirislaby@kernel.org>
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

From: Jiri Slaby <jslaby@suse.cz>

---
 branch/work | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 branch/work

diff --git a/branch/work b/branch/work
new file mode 100644
index 000000000000..587be6b4c3f9
--- /dev/null
+++ b/branch/work
@@ -0,0 +1 @@
+x
-- 
2.39.0

