Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A6708BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjERWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjERWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F8E66;
        Thu, 18 May 2023 15:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1ED652B3;
        Thu, 18 May 2023 22:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47BEC433D2;
        Thu, 18 May 2023 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449618;
        bh=/rU/K82aVhns/camL0+0a5v6k6bmJGI8LsunNV9htII=;
        h=From:To:Cc:Subject:Date:From;
        b=PJr0qQwseqFAFobh/+Hvw+Ywz8VJYG0H1HgKOSWQGUCKfxFhAzwlKnOZfM1J47odA
         f3KGE1WAb8sfsTH0GSEaREXfHvfyY8kOT0Jf/wlgBl3Lbq6ZT3uWrFYaYvfeG14QTa
         9Zyerqz1W1BfZ7bXEennAKrvhJrk2K/sDlcxeMIIZOZh0Iimv4rziwixyMpzA2sLlJ
         MAB1/Kn+tDMKOqoTQBW+kyqBpAj3MGbgdCUIUpYGOh7bz8k+BUwbLdPm4CwJsGJyyO
         STIDzz7rFoHzocvxqIJ5CTKqlfueyLZkub6S/IrzyliDG70gHqs7kcC9Lb3mWYkGyj
         +FlbfClYlvuvQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Docs/RCU/rculist_nulls: Minor fixups
Date:   Thu, 18 May 2023 22:40:04 +0000
Message-Id: <20230518224008.2468-1-sj@kernel.org>
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

This patchset fixes minor problems in example code snippets of
rculist_nulls.rst file.

SeongJae Park (4):
  Docs/RCU/rculist_nulls: Fix trivial coding style
  Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples
  Docs/RCU/rculist_nulls: Fix hlist_head field name of 'obj'
  Docs/RCU/rculist_nulls: Drop unnecessary '_release' in insert function

 Documentation/RCU/rculist_nulls.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

