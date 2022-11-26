Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79086392D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKZAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKZAlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:41:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E665B5B5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E4561178
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 00:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00175C433D6;
        Sat, 26 Nov 2022 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669423262;
        bh=muHms36hNkcFQa5KtDSV7M8jiWWpKmv+9Hs0+sEF4SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpRkUaEQtYk8bh8XTgPwE4Xv5ixf1iGOVC0HFbs6QWKFTVTV+FAMwPAAYWXV/AkLD
         fJhFu/Ryak3ggY5GQjvF3Vkc5Rs0WeRtZZ4xVixe2+CoH5q80PrFBSReZoyCnhjkn1
         gvtNFWrq9LXuelIV9LScCfwgkkKEl0PPQa1XCZfw=
Date:   Fri, 25 Nov 2022 16:41:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmem: use TestClearPageHWPoison() directly
Message-Id: <20221125164101.7fad45f3906c9cfa6cb614aa@linux-foundation.org>
In-Reply-To: <20221125115308.104059-1-wangkefeng.wang@huawei.com>
References: <20221125115308.104059-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 19:53:08 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Add TESTSCFLAG_FALSE(HWPoison, hwpoison) for HWPoison in
> page flags, then drop privite test_and_clear_pmem_poison().

Why?
