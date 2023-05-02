Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6A6F3D23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjEBFxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:53:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFA2702
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:53:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BB6865C01EC;
        Tue,  2 May 2023 01:53:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 May 2023 01:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683006814; x=1683093214; bh=L2yccSjdHtS3v
        murCVuzHV7VToYRo/5t3+9/yGqQm7c=; b=GqVNG5J8PdJPsNqifSZuzBoQAg5dv
        8JbQpHCnAbqZs6SERjZ/y4Yux9bUdOsNC53dqd4oHN/odG271Z4rgLBsAj+8MjIB
        L+ICrkD8P4LqZ0XeanU+N18/Mi6FC4iKCNfwcrlJ1ZlP1hfkbWwP1C9xC+EA9h0K
        fbm2vlAS/vgEbewbgiyMjkfync+ZCOoa8pXh2M2URvAzf3DD2hcM9oJlpEaXbIhq
        xHhHpHEDsVcSeR7TIjdhYA4TzzgK0fW8tL1icDbEqbxKsvobWFAyMozR/dCdJY6u
        83G04ZFQlXGGnevGp6x9rJW6RVsbt4dt+32kJs48IBB7Hz/ZOxYYbOOGA==
X-ME-Sender: <xms:XqVQZLU4h4N5pKcqoMqHbyCJjoX2FsSqAb9WM0-i1OWdiJtGmR1mOw>
    <xme:XqVQZDnfVwJxZjIemDX8fIMqOQVnQYdOg5BqvIntzwAM701WRb8rVqP_FoUGbto0j
    4-3NSLfkNXmCEo>
X-ME-Received: <xmr:XqVQZHaZ4x-7c8bZxT3thG5hRxCqDnPGOxm0mSFl2t0U2JuZDhf3HQBu3THU3Ew-VZ3RaSMjsTldyGDGwoFlV4cMuA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:XqVQZGXHcyHk_4cF-2-DXZTU1c_UrpF0ktbdG__TwPmEPSDxVdPVMQ>
    <xmx:XqVQZFlo0OYzp2qIDVd13f7YGmnTBlFpN6mYVqw2L-Dm9O2Y3MO_kg>
    <xmx:XqVQZDcAb2XyGq2Jswi-jEnhA5Suefnuvlmo2tih3ubaDZsZ5dEAoA>
    <xmx:XqVQZLWpS8Bdc7c7_na5ZInB2u-ASaD16uIiy16K-jT6J6sGGNfwCw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 01:53:33 -0400 (EDT)
Date:   Tue, 2 May 2023 08:53:29 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Schspa Shi <schspa@gmail.com>, longman@redhat.com,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com,
        danieller@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH] debugobject: Prevent init race with static objects
Message-ID: <ZFClWdkHOA0Eoybu@shredder>
References: <20230303161906.831686-1-schspa@gmail.com>
 <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com>
 <87sfdw8yru.ffs@tglx>
 <87pm908xvu.ffs@tglx>
 <87zg7dzgao.ffs@tglx>
 <ZE/BQ5yUQZUwhlTu@shredder>
 <871qk05a9d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qk05a9d.ffs@tglx>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 05:42:06PM +0200, Thomas Gleixner wrote:
> The change in that patch is neither debug_objects_activate() nor
> debug_objecs_assert_init() no longer invoke debug_object_init() which is
> now the only place doing pool refills. So depending on the number of
> statically allocated objects this might deplete the pool quick enough.
> 
> Does the patch below restore the old behaviour?

Yes. Couldn't reproduce the issue with the proposed fix. Feel free to
add:

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the quick fix!
