Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB776975A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjBOFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjBOFBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:01:33 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226C34009
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:01:31 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 534CC240308
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:01:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676437290; bh=FWiteDJexgPQ7XRRBus0P85wr8k1keyo2CAWC376RBg=;
        h=Date:From:To:Cc:Subject:From;
        b=LgoCIgmA4DG3U60cJpRJjIfKH2twgmEqeqoq6NeO4a5klvUy8lbvR28CSQQGmpLeB
         u/cuCqwPjajm87/BGARvdGKD7jbG7tuMZd5kvjp8XR7FGogGQjTtBILnhU4uOFLtaC
         NqEN/t1repkDdAO46q6Frc8WszoJ4xFjstGj4D+W8YNzJsuOjZKChNHGl4So8xi1rm
         dysZ4bqopyhPAep0kE1DpQm1+Oj9BVrxkLtcLGKvF3lFPY7+rgwOO1CH2LWK4dFQgu
         T+4yjxHc7VypDuYwKSU/8pgo2ZmZr/rj9Xy4vbsFKRf+HNwzFWqVJ7a7ITbQOdHk4s
         FsddejQMTLvWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PGmBZ5hGhz9rxF;
        Wed, 15 Feb 2023 06:01:26 +0100 (CET)
Date:   Wed, 15 Feb 2023 05:01:25 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Bastian Germann <bage@debian.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Enable hwlock on Allwinner A64
Message-ID: <20230215060125.0e06312e@posteo.net>
In-Reply-To: <d483ea28-feed-41d1-f9b6-4abfcfe42874@debian.org>
References: <20230213231931.6546-1-bage@debian.org>
        <20230214001805.6ead683d@slackpad.lan>
        <d483ea28-feed-41d1-f9b6-4abfcfe42874@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 22:55:45 +0100
Bastian Germann <bage@debian.org> wrote:

> Am 14.02.23 um 01:18 schrieb Andre Przywara:
> > So are there Linux/Crust patches out there that use this device?
> 
> I do not know of any. I was just investigating the chip and checked the parts that I could easily
> use in Linux.

Easily using it is, well, a bit questionable. The only reason to use this is
for syncing access to hardware between the ARM and the embedded OpenRISC core.
Like Andre wrote, it only makes sense if you want to etablish some form of
shared access between Linux and the Crust firmware. Using this in Linux only
instead of the common spinlocks won't be fun, that hwspinlock unit is slower.

greetings,
Will
