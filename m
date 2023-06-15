Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DFD731FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjFOSKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbjFOSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8EE295B;
        Thu, 15 Jun 2023 11:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFFA6106D;
        Thu, 15 Jun 2023 18:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB04C433C0;
        Thu, 15 Jun 2023 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852610;
        bh=vv4meO1knN0gNYFpBkBU7VnOP3JPLKf+tWByQNe1cyg=;
        h=From:To:Cc:Subject:Date:From;
        b=As0HhD51H/x7PIE1X7eVgPnRRbhxiMsT9wGidylJBBPAf1MDJi7+z62Ej/E34fOFX
         Sbav8GO/82gscjXoODCAyMJje2b09uKeM8OcJnjtMBT0YXSBiprSGDVxaS0RM7tFGE
         ZLrmE4saX+pjfJFHlCFbiSKiViBIpUtAEny+B2HlYWZkyfS+cHitwfEn8VQZ1xj6AV
         +YPRniQIWVSJ3dQdiP+VUPDcQlkKexDuuOJZl5J5Wn6mrM4vealArGrMYbuoq58lX6
         bGAgvmIZkHGjFIQkINTTyu8BMN3Dfyutg6pyluOfADzGX4R/iNc7ibRvOGFNxDhCq/
         ZnXa3HFUueASg==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Docs/RCU/rculist_nulls: Minor fixup
Date:   Thu, 15 Jun 2023 18:10:01 +0000
Message-Id: <20230615181004.86850-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Changes from v2
(https://lore.kernel.org/rcu/20230613182434.88317-1-sj@kernel.org/)
- Drop first two patches that merged to Paul's tree
- Add definition of 'obj' (Paul E. McKenney)
- Fix more wrong hlist_[nulls]_head field name mentions

Changes from v1
(https://lore.kernel.org/rcu/20230518224008.2468-1-sj@kernel.org/)
- Add Reviewed-by tags from Joel Fernandes for first three patches
- Fix the text for wrong extra _release()

---

Fix minor problems in example code snippets and the text of
rculist_nulls.rst file.


SeongJae Park (3):
  Docs/RCU/rculist_nulls: Specify type of the object in examples
  Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
  Docs/RCU/rculist_nulls: Fix text about atomic_set_release()

 Documentation/RCU/rculist_nulls.rst | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.25.1

