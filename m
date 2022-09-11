Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CB5B4E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIKL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIKL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595762C13F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CD9EB80B34
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F24C433D6;
        Sun, 11 Sep 2022 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662897443;
        bh=mGFSKvyr3J8oywtPSjgu8i64jOtXdSIc9VRry4m1+dQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Le+32p1D6J8gwxQyKiNSm6+En8DaCH38zHSsByO5Vfd+igNTUanZFqy+yuZLUwKc4
         j/G/oiovInlKYsI2Vr2mu/YbeBFssFt3/2cVDjwDCrN4hfbVvT5lw/7dE6SVZRV5O9
         iJ60Cfe7+NvBF3jlTez9Pw7NfCp2xzIqhmoaUcRq7vF5REFf2OQQ286Yx1SZpbpse1
         2AayTjKZJo2VofVXuvH4gmywi8ghq0uXH1C+YIWe0kLDvPjEsSjNnw0s16eCX0qTw7
         mn6r6Ydhyf5YzuVv3p4hIYSqzW4JQcH6U45PCpT7scxJgtVKGvzN2T4qmqHRSl/MPG
         MP24UuHLPcwEw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: simplify scheme create in damon_lru_sort_apply_parameters
Date:   Sun, 11 Sep 2022 11:57:18 +0000
Message-Id: <20220911115718.51465-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911005917.835-1-xhao@linux.alibaba.com>
References: 
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

Hi Xin,

On Sun, 11 Sep 2022 08:59:17 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_apply_parameters(), we can use damon_set_schemes() to
> replace the way of creating the first 'scheme' in original code, this
> makes the code look cleaner.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
