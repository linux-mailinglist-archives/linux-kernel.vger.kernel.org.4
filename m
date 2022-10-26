Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698860D8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiJZBri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJZBrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:47:36 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D6A1A8359;
        Tue, 25 Oct 2022 18:47:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 340BF1E80C9B;
        Wed, 26 Oct 2022 09:46:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uhCTPFNFdbLS; Wed, 26 Oct 2022 09:46:06 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 351C71E80C9A;
        Wed, 26 Oct 2022 09:46:06 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     neilb@suse.de
Cc:     bvanassche@acm.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, willy@infradead.org
Subject: Re: [PATCH] reiserfs: journal: Increase jl pointer check
Date:   Wed, 26 Oct 2022 09:47:26 +0800
Message-Id: <20221026014727.3020-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <166673341340.7585.173987927705263434@noble.neil.brown.name>
References: <166673341340.7585.173987927705263434@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sorry, I think __GFP_NOFAIL should be like this:

The __GFP_NOFAIL flag will cause memory to be allocated an infinite
 number of times until the allocation is successful, but it is best to
 use it only for very necessary code, and try not to use it.

I'm not sure alloc_journal_list function is a very important function
 here. If it is, this patch ignores it and does not consider it anymore
 __GFP_NOFAIL allocatiIon problem.

