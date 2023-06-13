Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6075072EADD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjFMSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbjFMSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543610E6;
        Tue, 13 Jun 2023 11:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072A563365;
        Tue, 13 Jun 2023 18:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D5C433F0;
        Tue, 13 Jun 2023 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680678;
        bh=fYUb6CftCUHgEez7cEVw6sHLN8i6kk/u1hx6ktGX5K8=;
        h=From:To:Cc:Subject:Date:From;
        b=nzdSedolsXMieERD+LypnKsZ33hvftu/SbevjYWLWRnL+WLIzpMNQmyQcNM2VisZc
         nuWwjzhZoHJrc8k4ZkJhaANEJtVGAQXIlwT+Rx/IdPTgEWVNx9dfKYnEbUTnUH3Oz4
         1/ttkfIMAtR+Lmf+NBCDtZiOKbvP3VsFwwlcxWWGLlVxaYabb/qSN5knh88z80o+ju
         wlFTxkMPVrnz8wyXgyAvTUU75ShXnt4fjLn37kry+pbkojd4Ouy5oAXPbVdqR668iH
         IWlQwF2hYx/4azbNaBjfEDIUy2llQOkJbo7yF+T5zY3nW8VquoXRs+Roig832/hbgs
         w7ozZwE0XrPBw==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Docs/RCU/rculist_nulls: Minor fixups
Date:   Tue, 13 Jun 2023 18:24:30 +0000
Message-Id: <20230613182434.88317-1-sj@kernel.org>
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

Changes from v1
(https://lore.kernel.org/rcu/20230518224008.2468-1-sj@kernel.org/)
- Add Reviewed-by tags from Joel Fernandes for first three patches
- Fix the text for wrong extra _release()

---

Fix minor problems in example code snippets and the text of
rculist_nulls.rst file.

SeongJae Park (4):
  Docs/RCU/rculist_nulls: Fix trivial coding style
  Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples
  Docs/RCU/rculist_nulls: Fix hlist_head field name of 'obj'
  Docs/RCU/rculist_nulls: Fix wrong text about atomic_set_release()

 Documentation/RCU/rculist_nulls.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

