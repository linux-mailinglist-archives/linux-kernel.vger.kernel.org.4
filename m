Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A47131F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjE0CfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE0CfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CEC9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20ABF65062
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEACC433D2;
        Sat, 27 May 2023 02:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685154915;
        bh=OARHjl7VtSdPoG7u5ehRQS9jDdQ7zVa4zuVU0zJzJLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=vOJFzCGpW1ATUZ2z1oyj//r7R4XFpU8o1SPSilDqjJ7VozGVRyp4R3WcFd6SsTbkB
         xBpXx4R39XzOQb+k4e6Jl+2Uz3RlG7k3h/+Ia6A5x8RNO08cHQJYnTglse+KnFLQK+
         QFQ04FZueDQG1csGHgzR3YgzUZe1QGLLSRdNsMXwcbcvPkgLxCBjFCsP/gCWzcqVrL
         +XHEQSmxSY4HVr6SlEZ/sZGqRkTA5IB+J6nIpm5pimHl+UWGJL+ifkiRloYXw/S1NC
         mD/m8jLetJO5gTcbNfA/j4K5iTlpho7c6rofQlMOWEgW4jRcanWYWoo8QX3N3ab7F2
         SuQjymaWreArg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date:   Fri, 26 May 2023 19:34:59 -0700
Message-Id: <20230527023459.8567-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230527023149.8441-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 19:31:49 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> Could you please resolve those by wrapping the commit messages and adding
> 'Closes:' tag?  'Closes:' tag might be able to replace the 'Link:' tag I
> supposed above.  I have no strong opinions there but having both may harm

s/supposed/suggested/


Thanks,
SJ

[...]
