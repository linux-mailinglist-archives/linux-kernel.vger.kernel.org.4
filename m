Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646766FDA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjEJJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:14:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772D30CF;
        Wed, 10 May 2023 02:13:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 88CB45C02DD;
        Wed, 10 May 2023 05:13:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 May 2023 05:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683710036; x=1683796436; bh=ii
        ADo2HcVVP7FI0vsjXgBbOVG3uyaHWjU7aM/iZfF6g=; b=fQ0pc45lup697IbFq5
        7VfBPUM54DU4ba+Je2Aw+5Rl872ZxULr52/WGOoXdFFpAl8AZXFGoH38GIf7UnN1
        BxUKsq+wYdfRRLiNjpkpcPnWiMXgP4+F52tztVHZalAlnnWLQq61doK+VRkDZ58a
        q+k8ePiWGuKJz59iCuZm6VOz10qggDNyYwM5r86dsRfMgsHoB76MdyiedlCX3ePm
        HET49vPIajwacbIxAd8puh6GNMimHkCoMavggq02i8PhM1pNtHMFYa18JpXwMP3K
        PO/GlhCRyfWQ6a5gU8TjzqafJH2tp0/Yt2Awc83wL9auOBgpvy3ixvCVdFbdIAwQ
        JJfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683710036; x=1683796436; bh=iiADo2HcVVP7F
        I0vsjXgBbOVG3uyaHWjU7aM/iZfF6g=; b=P7rchaHWU3Ofd9cQJ+ipo5Su4l+CW
        l2GrrIG3tC11y4REJsbZEDvHafr6jSH/OpUW6rcB3TpKbRORc4Wcvg7WkSVFRJIr
        ctq4UH4neT2ulzTHFIomba4ThhMVVjjpZ1Ah5QhR72YfIixWffPWWmU0M6gVlBtS
        qItRsQFQctqMuNdeIvkGnlzJkf8C36JtwlDzUFG694bBMWB+kJ7AX/hoJo5lRvxX
        eSJpnrpLcP4s8hgqETMAvMEmzquITy+cJ1WCjC83dBgKv8IBWK65HsYuctgDujtc
        R+2CTMi9gwSwEIGCWWAMkbOleBNRYq56KGVWl51esed5I6CGFenUaOQbQ==
X-ME-Sender: <xms:VGBbZOeeGHuqwg4M43TOeGtpFogjbBb8sZzKUoR41L19cOSn8MRQYA>
    <xme:VGBbZINOKZ8bRXL3mha9OfYn7k8zTobuXbjBu4i7HSOOpHnFlJ2uxIgp3QVdoIPLc
    hfffBWP5VEsSw>
X-ME-Received: <xmr:VGBbZPh3RNOUf2wT-uWzowDiMuxBECwWEEhdJpIG8rgOICewMaGyZkq0D_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeghedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:VGBbZL9Qc2UYbJrMatkR8vQJq6yx3cgLD5XnycSnDh0_gbPEAPyBqA>
    <xmx:VGBbZKu__Brm1JfvmxyKQkFtwoDaHS0meLCSDWeIzU_mNoH1qt0X2Q>
    <xmx:VGBbZCHaWw7OWpAogx0n74wfVa0LFO6ar8_tdUBxb4UozwqWD7IX_w>
    <xmx:VGBbZB-2XtfxDMh4O77ZCGL36Rv32ruLiqOfeX6nG1pSKdUCNgFugw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 05:13:55 -0400 (EDT)
Date:   Wed, 10 May 2023 11:13:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Message-ID: <2023051027-wages-feminine-cb5d@gregkh>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417FE67ABF9A2B1EE4DEBA088779@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417FE67ABF9A2B1EE4DEBA088779@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On Wed, May 10, 2023 at 07:49:20AM +0000, Peng Fan wrote:
> 
> > Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
> > parameter
> > 
> > On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > With the clk names specified in clk_bypassed module parameter, give
> > > user an option to bypass the clk from managing them by Linux kernel.
> > 
> > As I said on another email, no, please do not add new module parameters
> > for drivers, this is not the 1990s
> 
> After a search of the list,
> https://lore.kernel.org/all/?q=module_param
> 
> I still see many drivers are adding module_param.

And they should not be doing so as it is almost always not a good idea
(note, some subsystems, like sound, do require it, as that's the api
they use, so this is not a blanket statement.)

> Is this is strict ban that new platform driver should not add
> module_param?

You need to really really really justify, and document in the changelog
text, why all of the other methods of configuring a platform driver will
not work in order to have it considered.

thanks,

greg k-h
