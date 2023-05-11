Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D16FE852
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjEKAIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEKAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:08:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84532698
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 17:08:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CC5305C071D;
        Wed, 10 May 2023 20:08:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 May 2023 20:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683763715; x=
        1683850115; bh=ECxtaniZ3VlG/FHLa8XkwazhoVMQeBUbJpGETX7ZGzE=; b=n
        1deAYbal4hf5VLxoP2VrSFr8Wgm01A2y9We7D5Fa+ayuD2Z8coFat1A7jG0ka9lO
        vKLujrobnuq7AohpdD+2Z9aDS+KdVkQUBCluP4hnnC2JucilISRiDhqSMpvw779v
        iVtpRuSnGCHF2kuM2GjTwRwMV0moXEQgG3pgCDEpDIldG90M9twc4GcfnNrk/kwa
        0hoRF0TbDhf9Nd/bBDY9FvffgYR6l9NsKPKSK41S9alf3IKryBy6JxRhN0mjRNGU
        7GpXC3fZBP5G8QvO9j9J+PI/8E3uC+ZGlzPw2vrI6sXFv+3sKS1A9qybFaONmOtm
        Q9WsPa2ugFrGp44IwSXlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683763715; x=1683850115; bh=ECxtaniZ3VlG/
        FHLa8XkwazhoVMQeBUbJpGETX7ZGzE=; b=jygWQe4f1lWpnuBVJWlzAKHcPowY6
        zUays1eecmB3mbRDTS7bLgISdByLkWUEzdXsFIEhcp4Fl9VtJt1Xdkljs5M5C4s4
        2ZXNZV65ShEcHqyPLfZT9hyG0bE6wizfc9me37HCUOwPoXaNfkLkSpB6w9qbrNP4
        soSeInBSHyWcYxjWbrn7B63aL5kuIG/+Lsq6wzdI8e6FjsSqV6BAc0IHxLTxfx17
        VWKfOo7uuwEaY5k2f8CnG3TcTy6ZkrzMFLHErUFvq2TLvY2Ie55IR7ioyPrfhVmY
        9djIzIxRO6jGCgVnYd/k4AHtaQvT5HPFOKFQJS+NOswauaMG5mTrLgx7Q==
X-ME-Sender: <xms:AzJcZOZIzDbxhSTBGmrZ2RRXJqV8FswFRWG8ufDkrQsnlsPWD6gFyQ>
    <xme:AzJcZBbKd87kFCttzCFPmjoW71RziW3V8lDlM4kb0WPOcqV0n_B9T_m-b6W-3Qgc-
    W_dt6WDrUWlfsGfTzE>
X-ME-Received: <xmr:AzJcZI8nOeBA8QH_n48HaEFCh8TszMtjrhjdPZXPsnnFbHh2jR_KLyP3t-QtmeTT75VTalHXQBBMbMLmirRRzhQILQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:AzJcZAq-l5AZLgAlvbk4KbrIx4BdEsTgZnjgpOYjPrf6DO0wyi2Dyw>
    <xmx:AzJcZJqq1P4qT1fUPrL115fX7dt_urNHUjeQKLY-q3r2PC0pydKXAA>
    <xmx:AzJcZOSbseRILxeTRzBhEMavZPYyzjPpYWOmDP4ep_l_7drI69nXZw>
    <xmx:AzJcZKDAYKtVtlpE0FdH42ip_xzC7rWo1TVRUEDriA-M4rYMclvYow>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 20:08:34 -0400 (EDT)
Date:   Thu, 11 May 2023 09:08:30 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] firewire: net: fix unexpected release of object for
 asynchronous request packet
Message-ID: <20230511000830.GA796953@workstation>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20230510031205.782032-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510031205.782032-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:12:05PM +0900, Takashi Sakamoto wrote:
> The lifetime of object for asynchronous request packet is now maintained
> by reference counting, while current implementation of firewire-net
> releases the passed object in the handler.
> 
> This commit fixes the bug.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/lkml/Y%2Fymx6WZIAlrtjLc@workstation/
> Fixes: 13a55d6bb15f ("firewire: core: use kref structure to maintain lifetime of data for fw_request structure")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/net.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

The patch is applied to for-linus branch and will be sent to mainline
within a few days.


Regards

Takashi Sakamoto
