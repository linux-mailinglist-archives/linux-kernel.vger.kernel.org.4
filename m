Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2054627876
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiKNJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiKNJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:02:59 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C063AB;
        Mon, 14 Nov 2022 01:02:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B87F85C0170;
        Mon, 14 Nov 2022 04:02:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 04:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668416577; x=1668502977; bh=rhjNGR+gix
        yY/w7y0uEYH+moGTK6wkTGkRYxgwtnNh4=; b=gVoD5gubdrw254rJTDOQ+Lnknr
        I23cXqSnr1qXdHYrO7uztpdPFz+TubKBMHsvNhtQtinPDJFVMtglBszRn4sgTfLu
        hclKxP28EhQ5zLceA5VLsvCFP7D8nmT2DuESCvd82+jPi3tpvlk1jbYwSwPuqUPy
        lXO86Fl3oD6XkhanADl7P8wMEtrUXtQBaxHiZFZXCpNQxCmxhXQqSWdBZBNj4kA5
        ZhA/crCyc4NU25Xz9cZDelmJxQ4xjYiOfKyyAMdcMnQIzPDu69PJg0BPczg21J4u
        SU4A492nE6LqoG8DlRBFebsdSjKi/jLXcmnrvoVAz6wjtlDxnzmLQeJ9+rmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668416577; x=1668502977; bh=rhjNGR+gixyY/w7y0uEYH+moGTK6
        wkTGkRYxgwtnNh4=; b=Fltgp6PhT7hv16Oq9ZUrkAD6hfOVoNvmudHPmtRYh+xn
        ge5UNsIcPvqUj/Mw2goJHWPYNGOIj/B9P1c17dXoXbzdL5bszXmMy4+NPpTZ5+Q/
        F2ATjxNz4ZMSAoqQVRFAAMREGEFZQWCDWKA8O1vihUgWjlqWO4kiaXgZ+wsJqFql
        x9d0W0Rxl4Xl+LKfiXcxSpVwUKv0f7r2g60088oIV7nP6xmXVOivuJ3vg8M1dWdJ
        m+i+wI+bIjXfcebrQMH+37EFsY3Jcf08e3XB8ZFN2gDsX/JsgnC+VvpKM0hu6LYK
        vjm5PMgFxPchxH5sAtnsDXjCwmplikzLo0bMwrirIg==
X-ME-Sender: <xms:QQRyY1prgWhZf215ajWPbwqNVfXQTLR4vdOpqh0RtXS71mtbQmtWkg>
    <xme:QQRyY3qtexDhLS1YVrWDz06eYdkMrnoLD_0btRjM3RU5D1uRzic9ObWr7sPpuxeB0
    O1rGt8Szdcvwg>
X-ME-Received: <xmr:QQRyYyPRXNIWtac8y06kmGlp3XsO5qE3OyjGGS9ZXhpXWlb2JGYOf_3mqx8eZCOOKsQL_AFjqjlPl3NWSpitF7YizJEeK8Cn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:QQRyYw7qkWB0beE8LDU4lYQyeAbWxf3s-ox4emCX3a3fxaTPfBmdfg>
    <xmx:QQRyY04AlVujqjFABHe1CyoSAWz_gf_9RypXLMMWOjBf5jcFkBxNZQ>
    <xmx:QQRyY4jRhUlgP1x-0u9z3YzEck28ardZiFMi0-BXaYFY8SGLw-vsyg>
    <xmx:QQRyY2tIvj7tuuFBy6f8dNpPgRIIBkWfuz_PehPCDREej0Qbs7s9Aw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 04:02:56 -0500 (EST)
Date:   Mon, 14 Nov 2022 10:02:54 +0100
From:   Greg KH <greg@kroah.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liu Ying <victor.liu@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the char-misc tree
Message-ID: <Y3IEPt3L+al0vM63@kroah.com>
References: <20221114181752.08a850f0@canb.auug.org.au>
 <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:33:41AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 14, 2022, at 08:17, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the char-misc tree, today's linux-next build (powerpc
> > allnoconfig) produced these warnings:
> >
> > drivers/bus/simple-pm-bus.c:96:12: warning: 
> > 'simple_pm_bus_runtime_resume' defined but not used [-Wunused-function]
> >    96 | static int simple_pm_bus_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/bus/simple-pm-bus.c:87:12: warning: 
> > 'simple_pm_bus_runtime_suspend' defined but not used [-Wunused-function]
> >    87 | static int simple_pm_bus_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Introduced by commit
> >
> >   882cf4c913d7 ("drivers: bus: simple-pm-bus: Use clocks")
> 
> I see that this is caused by the patch using the old-style
> SET_RUNTIME_PM_OPS/SET_NOIRQ_SYSTEM_SLEEP_PM_OPS macros
> instead of the correct SYSTEM_SLEEP_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS
> versions.

Ok, will go revert the offending commit for now, thanks!

greg k-h
