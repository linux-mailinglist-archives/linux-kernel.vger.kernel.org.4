Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C46E5D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDRJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:21:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4A6E8E;
        Tue, 18 Apr 2023 02:21:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B07875C00DB;
        Tue, 18 Apr 2023 05:21:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 05:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681809670; x=1681896070; bh=dk
        fbnRlz6tHyrEXwUKIVhiEjDrEgVLGMSIvOajuR2jE=; b=kUkHypCrrJUQXUo7MV
        fbA6kcT8i3X36RfcdKjkiVYZW2J0aBQy+dGMFdx3t/dL7bMoIC0UHX90h6327Jy8
        FAIvACVdVm/TkgLNM6CXdwXr0eWQKYVeKwbUGqBqW3w7XkCE/9Bmguu3sipk7bCB
        vU+N7WRTnPcoKBdknL9FVmXdnY2dub7klb9FtpJiUYY8ED2a85TNl3OzzwYJaERt
        LUAC4sb6AXR/gRfmGw1U5hvuTCdosuGYzFb7lGj4u+FZT3f2osnJIUaA95tLzarZ
        Zxe5UERlSZYM0Y2FHtevNCl9BZ5fs0Tn2RnngqK46WWI7DS3W5du4ph/O+QwtnIX
        ditQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681809670; x=1681896070; bh=dkfbnRlz6tHyr
        EXwUKIVhiEjDrEgVLGMSIvOajuR2jE=; b=hL4R580YWYNlLSAhmR7FTXZH5BvaX
        dvphYafeYU4EdCCj6/f8eghc8DtmCpvctoFPfTXxLwTMG5zwkkubrHTQVdgQiERx
        TB2W1y7m/NjTSWUdNppjAwuIW44RX4xQKLT9b5Ou2xoaOQfyMucwPfVjUHxO0DOL
        li508orjXIX3nw2sbhBzvrpLCwrptWr5K+1ZTk0lc/+FhMLflwC4SnvESReFvp+c
        dPq6Ui7sBFP6MLud1zr6OcgwP57dXejkvocBFfl2D8wait0vVRcC1m85l0a46KsL
        M2j9Z8y0egCGQbjkI+NuYU0W22VKlDtbHPMrfx1GbNiK0B3mvDzJpRj3g==
X-ME-Sender: <xms:BmE-ZNxrmQo4xknP98dRRam-GuAnqQlW4NyFdl8PbCARL3xGKc_v3g>
    <xme:BmE-ZNSwANlfnpoDbFe_oclpwPLojVPTqkZC_0OYNxsY3LKdh4ornMmWn-dGIZgPX
    BLdMXjg5azsO6Yi23M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BmE-ZHUa-tZlV-Q9OiPAiX4N_hgCCxmqI-acqAzM6CFmvRgqWQAU5Q>
    <xmx:BmE-ZPjNAVugZwF1fmVQkwC03ILmZqYRrNFNfyV5dGlnop00bnwhkw>
    <xmx:BmE-ZPBGtYvxhclqfJi9C4yoQhOSsR8odHtOhsym5EgCv2c0fCUUaw>
    <xmx:BmE-ZHZuz4eOsXj9ZIsGJYzb5XIo9c8sfeO2dFO01RjJFIU01XTi5w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 469B3B60086; Tue, 18 Apr 2023 05:21:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <52721c32-1cb7-4c00-accf-314ffbc32a76@app.fastmail.com>
In-Reply-To: <20230418081959.GB30837@pendragon.ideasonboard.com>
References: <20230418071605.2971866-1-arnd@kernel.org>
 <695e9f88-5a79-7ca4-645f-047b78495a80@xs4all.nl>
 <20230418081959.GB30837@pendragon.ideasonboard.com>
Date:   Tue, 18 Apr 2023 11:20:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Dong Aisheng" <aisheng.dong@nxp.com>,
        "Guoniu Zhou" <guoniu.zhou@nxp.com>,
        "Stefan Riedmueller" <s.riedmueller@phytec.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Christian Hemp" <c.hemp@phytec.de>,
        "Jacopo Mondi" <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: nxp: ignore unused suspend operations
Content-Type: text/plain
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

On Tue, Apr 18, 2023, at 10:19, Laurent Pinchart wrote:
> On Tue, Apr 18, 2023 at 10:04:13AM +0200, Hans Verkuil wrote:
>> Hi Arnd,
>> 
>> On 18/04/2023 09:15, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > gcc warns about some functions being unused when CONFIG_PM is
>> > disabled:
>> 
>> ???
>> 
>> The Kconfig has a:
>> 
>>         depends on HAS_DMA && PM
>> 
>> So how can this be compiled with CONFIG_PM not set?
>> 
>> Am I missing something?
>
> The warning appears when CONFIG_PM_SLEEP is disabled. The pm_ptr()
> change is thus not useful, but the switch to SYSTEM_SLEEP_PM_OPS() and
> RUNTIME_PM_OPS() make a difference.

I sent a v3 now. I ended up leaving the pm_ptr() in here, based on
the recommended usage of the new macros.

    Arnd
