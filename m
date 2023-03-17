Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0196BED01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCQPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:32:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F95D9663C;
        Fri, 17 Mar 2023 08:32:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EA6565C00C1;
        Fri, 17 Mar 2023 11:32:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Mar 2023 11:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679067123; x=1679153523; bh=jB
        gCssmgOfG5MkjfkiPqcV9O/3gEfCK3M40fWK1PAh4=; b=PV+mFUPDDJAka+xToN
        j3JVVOoFBD8x7hBKnKegHMbLEo9F8F3yk1yj2+mZCKYxuFYv0/QpHo/lw/jw8xO+
        ouTmskQ8qhnWBSx96OcrEbqm1XGxJn0R1UDe93YIZ7bTCMIHWfh6oPNEUs3cavSX
        TwcXphRIT7ZFQMKa+d4pZtl49rsXyKONEnbOJWkJBS6qiIozWt5vUe0klIjlNKwO
        dL+A0UCi6BEdRRzz9nALHTCGkWsg4VROh1CNveFE3XPWqkIdngqaBgQ9TlU9L0Ov
        2Ujc2cBlJFYI7N0cU1ndGaYIOWRoLCZ3AxN3ZFEmkqWmaX6WDDKHVOiIz+nQ1tSP
        Hl4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679067123; x=1679153523; bh=jBgCssmgOfG5M
        kjfkiPqcV9O/3gEfCK3M40fWK1PAh4=; b=fwm63yHcv00u2sjVH5H+Z3Us/ft5x
        Gg2cDMeZ5XtaUzf0juBe+mUWSVZtAIoNauSny1sviPjfSeD9iERvlC5cn1Y1yase
        sQw16d7FHZUqFYijPMOFa2wft3qK9fHognZo7HavCvYlIk5pZku6+mRIUJCm3qnG
        dQJEeaCtLT5rj0B3Uwu+WCra6NqndCIRtLu2h9f4QljkjSvpy+QxF4H+YhkK9ojd
        Cp0XPydWoFQiqAR6J1LDor8pIGOSs9khwXeFUof0Vo/+4xzrqdZZQCISaud0cBi0
        JOD+AG82gixH7TwF8eBNxbOcMuxM9mUy/gldbAiNPppW+1O7H02Z7voFg==
X-ME-Sender: <xms:84cUZHvqS7VrITUPyYBIN0ilJD0KTapRE3Qth09cTTeuROH_cjtZfw>
    <xme:84cUZId0V4GRS0oqi6qXC8bGCZtEN5k9xypkQXoEXRNwC_WSGRp9vXx_wy5M8_U59
    p6IYGIBiSRn24UVZCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:84cUZKw_whoVRzsocaKakyKmGE3tmgnq4rMrfkTac0bNWP0MWRxKIw>
    <xmx:84cUZGMQXQmKYG-Kwdr3CA5BZZFWEAlc4dqdBw5MxGX5z_J1PUEGHw>
    <xmx:84cUZH-w4MrehzkZo6Aah9au3WJZPV8ymrFNmIkYktCKACvfgjSPQA>
    <xmx:84cUZKaJV8x7rApGvpESsp7EVY353DbBBvextLPRveA1rAUBMEu33g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4F1C6B60086; Fri, 17 Mar 2023 11:32:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <b030a920-d9c0-4f2a-b1a8-f6d89bcbdfe1@app.fastmail.com>
In-Reply-To: <20230317081156.32337-1-lukas.bulwahn@gmail.com>
References: <20230317081156.32337-1-lukas.bulwahn@gmail.com>
Date:   Fri, 17 Mar 2023 16:31:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Lubomir Rintel" <lkundrak@v3.sk>,
        "Russell King" <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mmp: remove obsolete config USB_EHCI_MV_U2O
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023, at 09:11, Lukas Bulwahn wrote:
> Commit 77acc85ce797 ("ARM: mmp: remove device definitions") and commit
> 06f11dfb5b75 ("ARM: mmp: remove all board files") remove mach-mmp's device
> definitions and the board file for the Marvell PXA910-based TTC_DKB
> Development Platform. With that removal, all references to the config
> USB_EHCI_MV_U2O are gone. The config has no remaining effect and can be
> deleted.
>
> Remove the obsolete config USB_EHCI_MV_U2O.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please pick this minor clean-up patch as follow-up to your patches
> mentioned above. Thanks.

Ok, added for 6.4 now. Note: for platforms that don't normally have
pull requests, you can add soc@kernel.org to Cc. That way it will show
up in patchwork to make sure I don't miss it. Don't use it for the
more active platforms though.

    Arnd
