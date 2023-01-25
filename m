Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1467B676
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjAYP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjAYP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:58:43 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFA14B740
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674662276; bh=mRXvKeUevITL+UqWkL1V2wkHSLY/pnkSwu5McPidAVo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=oI/3KWajJVIEgTTP31C+9M5Mktt2BoM3Ni7pMf6OOGSTBdiSTObHXQta4y108Fsoc
         BKCzWixvGF1mT5YgRO9o4sgIhV8QJJYQwn7xRmFc4zHsR8jytBX7ngsnQ+Q6s7J3ei
         HEb5T35MV0ec0F0nD44DK0IfFO6aC7IdZVHzz7ug=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 25 Jan 2023 16:57:56 +0100 (CET)
X-EA-Auth: qWMBEQIm45L/nOTD0T8o6eDJmD/P/T0xgkI8HlaqTnpIpcB5NPRFLM9PQBTCCILC1IYQ3j//BJ81ROQKCK3UyQRtXp4S+1sc
Date:   Wed, 25 Jan 2023 21:27:48 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Natalia Petrova <n.petrova@fintech.ru>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] i40e: Add checking for null for nlmsg_find_attr()
Message-ID: <Y9FRfCOyvsAbHdJy@ubun2204.myguest.virtualbox.org>
References: <20230125141328.8479-1-n.petrova@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125141328.8479-1-n.petrova@fintech.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 05:13:28PM +0300, Natalia Petrova wrote:
> The result of nlmsg_find_attr() 'br_spec' is dereferenced in
> nla_for_each_nested, but it can take null value in 'nla_find' finction,

s/finction/function

Regards,
./drv


