Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0B5B82A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiINIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiINIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396222BC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E92BB81633
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DA2C433C1;
        Wed, 14 Sep 2022 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663142783;
        bh=tz2wl0ODbAbHBp+5FRVVBI6erZjKNxf6vRG2VcY5R3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lg5tnyTFNbTp0GbDkGpDVmhjFxfbC4HMDOu+m3OMhY87RAzNHtU46/l1V7nrRSPrJ
         Wv4Sf0bj1s3HDCf/zPNRaPZO4GP8dHWeNQpKdGesWveX1tf32vOMxYj4BAzkMucYO5
         gwLaCS/FqMGN92S2Uzim4bbS7OJ3uDVEOxw/fzJe/804UXxNZ2rZ72I5O3LYHWs0Z/
         hHed1xzltTlM0ALgiH0ZVIZP7w+GsUzhplqgCXgz46ABmNE4+jD1PUUX5tGqFT1zhy
         4PEZ+xU4VDAgiPd5LgRpZCAQdy8H2zRURx9jsRBtEFGOvfp/bBlWZ2VsWNwSGlmlsG
         SKhOT/HbJ/Isg==
From:   SeongJae Park <sj@kernel.org>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: simplify scheme create in lru_sort.c
Date:   Wed, 14 Sep 2022 08:06:20 +0000
Message-Id: <20220914080620.58974-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <936d9ace-45b5-6579-b1c6-872055cce979@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 14 Sep 2022 08:35:01 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> 
> 在 2022/9/13 下午11:43, SeongJae Park 写道:
> > I'd like to apply your patch and then rebase my cleanups on it, but it might be
> > not a one second work.  Could I ask you to wait until my cleanups are done?  I
> > will post the patches within this week.
> Ok,  thanks.


Thank you for kind understanding!  I posted my cleanups yesterday and those are
now merged in the mm-unstable.

Appreciate again.


Thanks,
SJ
