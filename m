Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64267316E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjFOLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjFOLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17872716;
        Thu, 15 Jun 2023 04:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5675E6390B;
        Thu, 15 Jun 2023 11:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF49DC433C8;
        Thu, 15 Jun 2023 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829059;
        bh=xFBDtI0eJXV50Of5xfPsY4FxA5omc/+439vJ3gAfG+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5tRanJtu78l4xMoalOzVLSoNFQPo6sEYl1Dr956lzi1eEApCPpKphZlGxrAf5tlN
         eVBrwR+SDROMDL0BDZMSaRUkk7sedpBNPBV7qHeQzVTO+GNMILq2D+/QpxaD7puRBS
         DJJhlgr5ssGAFLmHBAe1N4pd2+AxwR/89GKiEX4Ku9TIEfKuQ/n/7e/2RMNBBupJZb
         1ePp+k63wVJSJfS3aUlZgWwUbZ6jhZwBPCnlnL6oQfukichmPT0rTLggiMBZn3VqQJ
         2nakAkTEE8zx5FMtgQOp8xTABZX92cmCQLrXoaTFVeM3WZGDFD0R/ksPAq7S0wvbw0
         azvm8pddLbpgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 04/19] scsi: target: iscsi: Remove unused transport_timer
Date:   Thu, 15 Jun 2023 07:37:04 -0400
Message-Id: <20230615113719.648862-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113719.648862-1-sashal@kernel.org>
References: <20230615113719.648862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 98a8c2bf938a5973716f280da618077a3d255976 ]

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/20230508162219.1731964-3-mlombard@redhat.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/target/iscsi/iscsi_target_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 42f4a4c0c1003..4c15420e8965d 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -568,7 +568,6 @@ struct iscsit_conn {
 	struct iscsi_login	*login;
 	struct timer_list	nopin_timer;
 	struct timer_list	nopin_response_timer;
-	struct timer_list	transport_timer;
 	struct timer_list	login_timer;
 	struct task_struct	*login_kworker;
 	/* Spinlock used for add/deleting cmd's from conn_cmd_list */
-- 
2.39.2

