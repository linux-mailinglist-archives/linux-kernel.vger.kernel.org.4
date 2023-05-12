Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC947006F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjELLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbjELLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:38:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E20213F;
        Fri, 12 May 2023 04:38:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 054B95C041E;
        Fri, 12 May 2023 07:38:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 12 May 2023 07:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1683891498; x=1683977898; bh=9q
        AOuPR81wdPIMJq/ul1Z1ZgLOrwDPtn2FpzZci5EkY=; b=MT5xz0YxP3UruUyKZy
        7TCEGigykY1e8mQK0VTM7nl0hxMJQpMHFzCEQB4/G//ujbBUpAI5gOuY92oASXKI
        8/DkHoH9s1k4VmNkc+Dh3Pp2ypodlCV380TnG+4DuUTwoAdm3tEoyTwWIMNC9hjD
        fonnzyJs56rdFtH3xrURdb46ZRn0eW7Ul/XIHI6y8obdGo/+sms/RR9fSGjHdIxO
        CvT+5QTwtawEx+X8Qa5uiIS/djx9xPTMJ4tSdCakrzppUrbpYXuzOQAjim4xq+p4
        EPQ6CiOBl2qIJCuLkhVHCadFEWBaDxCDUTps94MIoV0tXD/nB3YRHDgfKAMoHqua
        cEEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683891498; x=1683977898; bh=9qAOuPR81wdPI
        MJq/ul1Z1ZgLOrwDPtn2FpzZci5EkY=; b=ScXFSHvxKD4mTOvqnXuUeVuMco5J/
        Fm5JXG6BzheiBC4zlr4BU5uWzz1O22v06Xn/zZCWxU8WzLJLCoksnrFjjthkfn1g
        dbQ5rPE6zFV/4inncX+ewq86p6az0uR+5LOSJCig/bIyXKpuExKNt8zgTF/UHaYV
        yDU+sZKr+xjVf37hD4/V7DgG4RuGXWd/TCrWF4dvYDnk+2rz3nPU9G5rkPab8wA9
        WAhRaQ6Kd/Ke1c/4Fgyrwh/uDoZFi9HWlnxMSwTestHI5G5CLpriDvTMRAjuZxOU
        +sav+fiifhtdA+BmlVQoD85rWhZH/JOjyST/qpsbF/Aj2moBDgedWFGbA==
X-ME-Sender: <xms:KiVeZEGjFkK5WzttluNkyIDvVATUeeKeZ1qKcOyL4tVwjmIf-3sPmA>
    <xme:KiVeZNUEMqCPX210aEPW2vIuP73O5YTPfDHtX2g8fLcrTl4DNKFLM0CGwY7u6qXEY
    4h9rBv-dBBVfw>
X-ME-Received: <xmr:KiVeZOLEX0dF7MUAovzGDPwhPO7Bhb4wcaexgxtcAncTJNULxAAuOkeH_9cOuwCPlyNuqxB6uSIPgZo2fQXsY7b6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:KiVeZGFM5S-CembPJInGX85HTXRRmj7vm5a5jSzhkQCRFdPB-qOXSw>
    <xmx:KiVeZKVv8CpYTf1SLUayNkAiWEI80RI8IrP850Q6GF_Awpk6mPBWhA>
    <xmx:KiVeZJNjsM9qCFytn2KOJE7ivIXiQi-0blqU7vkYCCwg-rmwAwdm2w>
    <xmx:KiVeZAnAxFPB9NRaNjbyn8O9yj_zXaaVEy8EM-PgrcBvetGVwt2qzA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 07:38:17 -0400 (EDT)
Date:   Fri, 12 May 2023 20:38:11 +0900
From:   Greg KH <greg@kroah.com>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
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
Message-ID: <2023051224-freezing-dweeb-25b3@gregkh>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417FE67ABF9A2B1EE4DEBA088779@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <2023051027-wages-feminine-cb5d@gregkh>
 <28629bcd-d01a-92ab-b27c-0b8ae8bfdaf3@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28629bcd-d01a-92ab-b27c-0b8ae8bfdaf3@oss.nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:54:23PM +0800, Peng Fan wrote:
> 
> 
> On 5/10/2023 5:13 PM, Greg KH wrote:
> > Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> > 
> > 
> > On Wed, May 10, 2023 at 07:49:20AM +0000, Peng Fan wrote:
> > > 
> > > > Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
> > > > parameter
> > > > 
> > > > On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > 
> > > > > With the clk names specified in clk_bypassed module parameter, give
> > > > > user an option to bypass the clk from managing them by Linux kernel.
> > > > 
> > > > As I said on another email, no, please do not add new module parameters
> > > > for drivers, this is not the 1990s
> > > 
> > > After a search of the list,
> > > https://lore.kernel.org/all/?q=module_param
> > > 
> > > I still see many drivers are adding module_param.
> > 
> > And they should not be doing so as it is almost always not a good idea
> > (note, some subsystems, like sound, do require it, as that's the api
> > they use, so this is not a blanket statement.)
> > 
> > > Is this is strict ban that new platform driver should not add
> > > module_param?
> > 
> > You need to really really really justify, and document in the changelog
> > text, why all of the other methods of configuring a platform driver will
> > not work in order to have it considered.
> 
> I just wanna use the module parateter to give user a choice to choose
> to bypass some clocks.

That is not what a module paramter is for, a "user" does not use them,
that would be required to be set at boot time.

> There are 100+ clocks in the driver. Different user
> may wanna different configuration. With device tree, it is
> not flexible.Such as user A may wanna bypass clock X, Y; user B may
> wanna bypass clock Z.

Device tree is supposed to be flexible to handle this.  If not, please
rework the way your driver handles the device tree information about the
clocks.

Again, module parameters is not the way to handle this issue, sorry.
Think about what would happen if all drivers were to attempt to have a
module parameter like this.  That would be unmaintainable.

> With module parameter, I could easily set it in bootargs.

Users do not set bootargs :)

> But anyway if this is not preferred, I need to find other way.

Use device tree please, that is what it is there for.

thanks,

greg k-h
