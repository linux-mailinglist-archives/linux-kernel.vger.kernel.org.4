Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358BF6E229E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDNLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjDNLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:50:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC230FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:50:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 47EE93200A57;
        Fri, 14 Apr 2023 07:50:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 07:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681473000; x=1681559400; bh=xC
        u/zFB54tKHUMDmD1o4m9ObckbKooBvOQBEMUHyFIw=; b=Y3Jlyx8anMeOtLJslJ
        D1bIVIM1lShQZOP0owlMobghz9Dh1vkk8+IQhpwHMnXTBpZ+/bANjT3knA65A924
        amNHnggzez2cG6NPMsmKdeQ4qUmgSqR5LxTUBsjFSwhF2XApecxQdp02DsXCI4kp
        GjlTCgKbMdEeDWn0BU2dj5Z1zfaj6bsYiwW/YIWy1O1FMFMVeDGEZ/LXe1mqRGvM
        EETeTajO7HIju7g7PcxabuUWMDuc2M6ACRb4gmI9HlcBlFuiCyBJLaLiyewHa0mR
        gZtoZ5u5HZV9cGPL3Sb64u4V3xvFHRKvRA+lLsUu96lZ+D3MosPWaq4h05XTtuAp
        SohA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681473000; x=1681559400; bh=xCu/zFB54tKHU
        MDmD1o4m9ObckbKooBvOQBEMUHyFIw=; b=EeEqBrrulgokx9XUTBCcKVckPZrRn
        S39F8GMpBtbRKJ2w7fsBIVnF5HlgUrl8evDx098QULQ9v4KsjxE/yyLoi/2upbLZ
        amk0y+WF2gjgkDdzdRHt5yWTWNoxR4NQyOLlCTvF4AMUFojz/G3zKe6u0S7J49uV
        CPvs+5QJr7jdOBM3D75B/rjqUHSqHf0ub9oDLs1Y8TMqeUzKOrUi9FkbW67myeoc
        JyKFIOI8Rkbewax5ppyPjdw49zvJEu82LDBleX131LOFJ6YWuJQoJETss07iwtJZ
        5inN9raOJYERdSzs83yS5eDuMEnz+pzAYRpgsw2pVWuI9x98NsjlaN7Mw==
X-ME-Sender: <xms:6D05ZAOhrXzAwpgikff4ZMIwPKprO3ZzlCSLjLOuZwHEa_fxr1muvg>
    <xme:6D05ZG9cUGVQwZHeyB8pdlbTjp587fOLPh0VUPk4d9ADP4QVhQDE8nrKCX2vakOnh
    txAn1mNWJKgb_E9sJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6D05ZHRt98VyESeetuFWsqu-emMhk4Ke6oODaeJQGwO2fKvw8dx-Hg>
    <xmx:6D05ZIs-g1oWbxtoHj2H_DBwQlPnydICnBsDf1qGBSkg3AynZSDX4Q>
    <xmx:6D05ZIdHeuLT0qrzskk2orFRborwgo7uriukcwpmcvwP6esaKgTGWw>
    <xmx:6D05ZARNIcRBex361unPHfy0QmGwzPrhGd5B1_g9ldCp8KfuXe0azw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F300B60086; Fri, 14 Apr 2023 07:50:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <9213a846-9fa0-4a71-97e6-29da5be54103@app.fastmail.com>
In-Reply-To: <ZDkyc0cVcgmbnrDt@FVFF77S0Q05N>
References: <20230414084619.31524-1-johan+linaro@kernel.org>
 <ZDkyc0cVcgmbnrDt@FVFF77S0Q05N>
Date:   Fri, 14 Apr 2023 13:49:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Rutland" <mark.rutland@arm.com>,
        "Johan Hovold" <johan+linaro@kernel.org>
Cc:     "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] firmware/psci: demote suspend-mode warning to info level
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023, at 13:01, Mark Rutland wrote:
> On Fri, Apr 14, 2023 at 10:46:19AM +0200, Johan Hovold wrote:
>> On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
>> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
>> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
>> is now logged at warning level:
>> 
>> 	psci: failed to set PC mode: -3
>> 
>> As there is nothing users can do about the firmware behaving this way,
>> demote the warning to info level and clearly mark it as a firmware bug:
>> 
>> 	psci: [Firmware Bug]: failed to set PC mode: -3
>> 
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>> 
>> This one fell between the cracks so resending with tags added.
>> 
>> Mark or Lorenzo, is this something you can pick up?
>> 
>> Johan
>
> Sorry about this.
>
> I don't think we have anything else in this area, so Arnd, are you happy to
> pick this via the soc tree?

Sure, applied to the fixes branch for 6.3 now.

     Arnd
