Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC1643EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiLFIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLFIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:41:36 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628863A8;
        Tue,  6 Dec 2022 00:41:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CA2E95C00B2;
        Tue,  6 Dec 2022 03:41:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Dec 2022 03:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670316091; x=1670402491; bh=aJo3J1Ury8
        ++OjEv6DzcQ9jc03bCyjWjmRPfTKm3uP0=; b=cIXLZfBwkLxJvUGYhKhDoQYgg3
        oVLwPWXuDT/Op0sWB9H0oa1jbST02sOOmrlqXck1x3pmwWp+Ci0/5vQU983BWieK
        LsHJ7gfJQHoUoj6JFIK57gq2hg1P894i+Tz3XNgDEXKbKufDqD8LruNMqM7DWLrP
        R64gbjNNZdJhGes3sBaJK4ZWetNyjDK22OZvuogfPQtCtGXTAYAF6lWJ4YxEnSRg
        zuAFrgCl+OOJ0n5F9e33XnkN6E9pJ4bYrx3MLzRalO7Gm9SvMKR8O1ZRB6BLVUSV
        hheItXaZZZIMDNct6/9dt5W93TySzSvGjzX+V+MktfpF2h94tpKYSeKuhzlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670316091; x=1670402491; bh=aJo3J1Ury8++OjEv6DzcQ9jc03bC
        yjWjmRPfTKm3uP0=; b=VSRbJf5zDphz/MaojcgPtnB5M93ipX5duRgXyeju69hz
        uwac1CtJ8HLaGSXgbetF/1gMnLFaY9yNzCTud2eU93HHc/Dh7hTmbvFrOvgGkgHw
        XfdGs4PkyRJkoXjtw85F/iVLfgE5JnCE3F01UXkipLNC7ZQEqU2+cb7wzIg/k0kO
        i4RSUdlDj0JK7b+a+Er+LebZ7NmkRoj/tmrt0ZQn1SrbWhSCyjaFqKlWFfG8+tQK
        Ckg53CVInEO6/dU5NoenHuet0T9mP2EeOVoedKRS9FZBNOD7tl9NYAyNv+QyxqIh
        +K8r+XcKhp+obbDKGqYeM7sw0k3MLJ44ANtrjNCMhA==
X-ME-Sender: <xms:OwCPY3eLQy-IcoRbJAD_JOVDcCGRNHO3Sd89JuFFgtJfOqv2M6P8Vw>
    <xme:OwCPY9Nnudqdi6_d2QGVlwGSag_Zeb4WKHnDo2j1pu2jPSUKBjeQ3u145VwpJZC2O
    fpO05pS35huVIiP_AM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OwCPYwgfHVwEAlvGexqKDEUUEwKpg-tLjX1fwreIpiPtS2xY2R1CWg>
    <xmx:OwCPY4_SijKSlgmczYi3cJcUy6pfrjF57dht8NYc5huq58uu2xJteQ>
    <xmx:OwCPYzvlX5h_xvCk7vf11qm2L01v7SpDpW4ZwNl4kJ9l1chMDxQpUg>
    <xmx:OwCPY9Lfi6zLdiidBl7GMSvefovfMsTLTG5wQnNln-KKR1t44jIU3A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 60E0AB60086; Tue,  6 Dec 2022 03:41:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
In-Reply-To: <20221206073916.1606125-3-jk@codeconstruct.com.au>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
 <20221206073916.1606125-3-jk@codeconstruct.com.au>
Date:   Tue, 06 Dec 2022 09:41:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jeremy Kerr" <jk@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022, at 08:39, Jeremy Kerr wrote:
> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. Rather than requiring a custom driver to
> implement this, we can use the generic "resets" specifiers to link a
> reset line to the syscon.
>
> This change adds an optional reset line to the syscon device
> description, and code to perform the deassertion/assertion on
> probe/remove.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

I see that this will only work after the device has been registered,
but not for early users of the syscon framework that bypass the
device logic and just call device_node_to_regmap() or 
syscon_regmap_lookup*() during early boot.

It should be possible to solve this by adding the reset logic
into the of_syscon_register() function and using the
of_reset_control_get*() helpers instead of the devm_* ones,
but I'm not sure if that causes other problems with probe
order, or if that helps at all, if reset drivers already
require the device subsystem to be running.

Philipp, what is the earliest point at which
reset_controller_register() can be called? Is that
possible before postcore_initcall() or driver_register()?

     Arnd
