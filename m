Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EF25B42B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIIXAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIIXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:00:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E48F94B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A241CB82657
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264DC433D6;
        Fri,  9 Sep 2022 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662764424;
        bh=f/7dJ5txgGxEVcbNQbggz7c0bBv4vFnX6giz7/h7ftA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/vk82qK4O+vymiABD4L2SfJe9CfTJlUDAy5G7oIRlyj3Prygy5S27vbNAXVFhKJA
         oAbjjcTp5S0fatq2klxDqoBs0OX0vB0pY/nYc/KJx/i3WBcKSCeaNhnxPDgJDQngbU
         NzOM5kWmqpls5cHBHrOZMdANEfK8qittiqo28ob1UGYQyTbdY3hEe6DHPpAqkZbeeo
         HL0WJplG7wBxIah4XUlpMZO8Ru/uKeDFogzsZLnGCdNrbaDXYfai4nEM41p6IfpKhE
         E9mEi6PUNZbDedqcATGtGQNbo0LgeV/VmT9yWrde/T1JGZW9Vt85YQ2cRaXfPRc7Nm
         rhEbzYWiyZAjw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Xin Hao <xhao@linux.alibaba.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Date:   Fri,  9 Sep 2022 23:00:22 +0000
Message-Id: <20220909230022.51436-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909154434.5870e33657a11d53320861e7@linux-foundation.org>
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

On Fri, 9 Sep 2022 15:44:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu,  8 Sep 2022 22:16:53 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Cool.  I rewrote the changelog significantly:
> 
> From: Xin Hao <xhao@linux.alibaba.com>
> Subject: mm/damon/sysfs: change few functions execute order
> Date: Thu, 8 Sep 2022 16:19:32 +0800
> 
> There's no need to run container_of() as early as we do.
> 
> The compiler figures this out, but the resulting code is more readable.

Looks very nice to me.  Thank you, Andrew!


Thanks,
SJ

[...]
