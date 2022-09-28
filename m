Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A165EE334
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiI1RdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiI1Rc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4EF3725;
        Wed, 28 Sep 2022 10:32:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E6561F5D;
        Wed, 28 Sep 2022 17:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9958C433C1;
        Wed, 28 Sep 2022 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386372;
        bh=MESF/SAXKnOYRRXeWy0BA+NQHtLoq1hqzis71tdV/bg=;
        h=From:To:Cc:Subject:Date:From;
        b=NQ8lHRM4EI7m6vcK4N+wXV44/T7gKFQe9h85VmI0RpYs18IIEBnSQVfGnTNmoF35+
         2nt0smmScKpVmRbpzXi/w3NcwZgfs9rdrKQlq5wRGzXg12Xh7Bu0e8ellH6wY5xzRu
         nrA6RLIYupyfewoxt+5FFLnadBZGdjM9lro7UfJ5Mwqnn35ftBN+ZZM1bfpBRbeyw+
         p7H/IfanWQXJdR6tXrDf7DMvXBbwEGdAG6h+BO011s4jJEfhJnaoL+PWydbnr8ylFS
         eJCUGVp/cT/I0TVHgJAOzGshBNo4+3YePtylyu8uxPtWQ4npzlGvcBrzqmbXEe2vRD
         lWYG+G64lgOrA==
From:   broonie@kernel.org
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: linux-next: manual merge of the counter-next tree with the counter-current tree
Date:   Wed, 28 Sep 2022 18:32:48 +0100
Message-Id: <20220928173248.236720-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the counter-next tree got a conflict in:

  include/linux/counter.h

between commit:

  8294b04153c33 ("counter: Realign counter_comp comment block to 80 characters")

from the counter-current tree and commits:

  88f48f81d496f ("counter: Realign counter_comp comment block to 80 characters")
  b6e53438badcb ("counter: Introduce the Signal polarity component")
  3cebaa0b807a2 ("counter: Introduce the Count capture component")
  a51fd608704bd ("counter: Introduce the COUNTER_COMP_ARRAY component type")

from the counter-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/counter.h
index a81234bc8ea8e,c41fa602ed283..0000000000000
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
