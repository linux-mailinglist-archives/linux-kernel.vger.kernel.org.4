Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4025C0561
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiIURgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIURgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578FA2ABE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA89B63190
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C563BC433D6;
        Wed, 21 Sep 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663781773;
        bh=QaPwob4cmJzkIfhU85aufFwc39FZ/FKzJ0qPTKysOI4=;
        h=From:To:Cc:Subject:Date:From;
        b=WlQAH2wHBfka+mlfQFZ3NASlgKzLaeIK3pvLZyC3UQ/C+ic0h/GdEK+DpNmhbrrLY
         hN10PFEviF/hd/2rrnWv9AZsaROR5E4gqLCwrXet02Ydh+XLQoK/EOEIuS/LLOfY5H
         zOvUqYtHyEI4UyzOBZd9cmSv4XlpFOBmcyxL92QIgcAnAtJz9NZdD/5O8zHni0CxPr
         TjUI3Sjcb03KYXEmGAwMT3ucAnkqG94yIuTlCrjkVLOvv3j9lQEuACAwpBCJSuOqiR
         mOlR1sK+qQHXKgUSqFE/8vNRQkTycnvudrm0uCAG4xqdPR5IoiKri4N9QuWUn9Wuid
         0OkBYaN8k3ttA==
From:   SeongJae Park <sj@kernel.org>
To:     damon@lists.linux.dev
Cc:     sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC] Listing all DAMON user-space tools in the Doc
Date:   Wed, 21 Sep 2022 17:36:04 +0000
Message-Id: <20220921173604.51794-1-sj@kernel.org>
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

Hello,


DAMON admin-guide doc[1] is currently listing only DAMO[2] as its user-space
tool.  However, I know there are user-space tools internally using DAMON other
than DAMO.  For example, as I also mentioned in the last week Kernel Summit
talk[3], I know Alibaba has made their own great DAMON user-sapce tool[4].  I,
hence, just thought it might make more sense to give users more selection of
the tools by listing all available DAMON user-space tools on the doc.  Any
thoughts or concerns?

If you don't have a concern but have your own, or know someone's user-space
tools internally using DAMON, and want to list it up on the doc, please let me
know.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html
[2] https://github.com/awslabs/damo
[3] https://lpc.events/event/16/contributions/1224/
[4] https://github.com/aliyun/data-profile-tools


Thanks,
SJ
