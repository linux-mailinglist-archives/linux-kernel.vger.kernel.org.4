Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167965BCEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiISO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiISO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:28:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1A2715C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DA55B80B12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C740EC433C1;
        Mon, 19 Sep 2022 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663597700;
        bh=7XIAvh2Ds3fMnv0YV7QedORdsVRDqow4lZ+84hUl+EY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RtW6jEo3fVe/peUJx6mAvu/uV95qgB1fGPBYXJTLQVqL3rbt7824JJnQQdWkoYVmq
         PFM+JvqPT9McpPKpvolD9Gn9kiI8B24/UbIbUskzXEnBxfYy7AdXV/4Qwb0TK0XGNq
         EQ27hUhQDW32dwVCqcRpLeO844wOVviMgeVINHujWUAMSVe4vYWLzssFq/F0We6NN0
         6sG6XdAAmjnLuXqeQGyanHirTU2zWWyfU8wRHvOnfuCuArUegLgvE1ilnRvFpzolzY
         zYwMk5OGCMBanz0cKCSTW54DZrzTtSscgmt5JASHwjbf3Y/aSJwsXHRMgxN+O2IjLC
         ADqPqNJ/d02lw==
Date:   Mon, 19 Sep 2022 07:28:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Subject: Re: Linux 6.0-rc6
Message-ID: <20220919072818.6037f014@kernel.org>
In-Reply-To: <20220919040653.GA1840059@roeck-us.net>
References: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
        <20220919040653.GA1840059@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022 21:06:53 -0700 Guenter Roeck wrote:
> On Sun, Sep 18, 2022 at 01:56:17PM -0700, Linus Torvalds wrote:
> > So this is an artificially small -rc release, because this past week
> > we had the Maintainers' Summit in Dublin (along with OSS EU and LPC
> > 2022), so we've had a lot of maintainers traveling.
> > 
> > Or - putting my ridiculously optimistic hat on - maybe things are just
> > so nice and stable that there just weren't all that many fixes?
> > 
> > Yeah, I know which scenario I'm betting on, but hope springs eternal.
> > 
> > Regardless, things look fine. I am expecting rc7 to be larger than
> > usual due to pull requests having shifted one week later, and in the
> > worst case that might mean that I might feel like we need an extra
> > rc8, but for now I'm going to assume it's not going to be _that_
> > noticeable and hope we'll just keep to the regular schedule.
> > 
> > But it would be lovely if everybody gave this some extra tender loving
> > care in the form of extra testing...
> 
> Build results:
> 	total: 149 pass: 149 fail: 0
> Qemu test results:
> 	total: 490 pass: 489 fail: 1
> Failed tests:
> 	mcf5208evb:m5208:m5208evb_defconfig:initrd

Is this also us? I can't find the report.

> TL;DR: Patches / reverts needed to fix known regressions
> 
> Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"
> Revert "fec: Restart PPS after link state change"

Will be fixed by Thu.
