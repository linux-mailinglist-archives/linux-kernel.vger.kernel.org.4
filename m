Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32275EC9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiI0Qsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiI0QsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38FEEB42
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0AF56126D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E1C433D6;
        Tue, 27 Sep 2022 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664297215;
        bh=eytrRagVaWjBKmjz1wxgiF5QIrdp0pjGvQlDcuAKjdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQL7R4ZLmncYv3pMXg8Faf1wR6E9yY/gW2VMpsdvJB6qE4IoJAzKeUm7VeP7iihpf
         DzKPPSVjm5X5TPoLno+JtSb0D3tkQIx9XbnzmL35QhUKJdATlDpfGkM0JjOCU/3H7H
         fK/JcqaL4wQQ0ZOwMENK0uuZ12LLLcHZCVy+wJPKQY96vJdePgV14R1pb7a+gVkgNh
         ojZEsgljpY5TY+ATdN7NnlcHnzqPBlsJbE61Pm1aR0mPYjC4TOg1EOqxmdwLt6lFds
         K3N1CsVZHCm2uCt+Wmm4xgvTr2QLpNd7UlD/K43/sWXp3XDMs1XtM8TUnNqbG6YS35
         uVbVpwaZIzYyA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: move sz_damon_region to damon_sz_region
Date:   Tue, 27 Sep 2022 16:46:53 +0000
Message-Id: <20220927164653.88919-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927001946.85375-1-xhao@linux.alibaba.com>
References: 
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

On Tue, 27 Sep 2022 08:19:45 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Here, i rename sz_damon_region() to damon_sz_region(), and move it to
> "include/linux/damon.h", because in many places, we can to use this func.

Thank you for your works, Xin!

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

For the series,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
