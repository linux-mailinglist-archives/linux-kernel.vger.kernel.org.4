Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C9632E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKUUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKUUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:43:31 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2DED71
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:43:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 50B965C01DB;
        Mon, 21 Nov 2022 15:43:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 21 Nov 2022 15:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669063407; x=1669149807; bh=X99sl0XOU+
        RnPtDuCkgNa5OfxrgBoPhcnizaCfENa8M=; b=CpOXDUHZhUDIL6Gb9NLrBiW3aN
        Hj0NRLMhwBr+3XpmUKDWr0v9TkR+d4vy/xEUmJgX++MzPvm+d1l8h5K82DXoCV/t
        5+JXAgbWqs5FGtgKlF9mdu0v5vwJMXQTwG6Cyv20LG41EOVSP9Mp0i+Yb04k5oJh
        lDdXUqLoeqcchKGtt7FEFKiaXYYTmKepdenXi3/S51t12DVXPnj88XkkWVacULge
        6syJX2qrk04c/PGWaomgS7JzNnPfzLeJ7EYxmmkXe3Urnbn0oZ7o1TYI53CZKMcX
        igX8RJA3KyrnlquWeZ53rTYeekImlhzzXRylwV6r0W1PLJJEcqI9J0cVw0xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669063407; x=1669149807; bh=X99sl0XOU+RnPtDuCkgNa5OfxrgB
        oPhcnizaCfENa8M=; b=Ef2rWWBIFrWuJLua6mD+MZ3KB9Gk8+7T9kPsbmXzPq01
        gjDuIWeHWnYp0IunrOtUfJa6AaNLv4hryImNhTRzbLoq1B3kiAnxnuzINcnaol8R
        TWXSNVlrXlm1jZVxxoRc5DBX69ZPBbwdvbF1+TjRFHAjR6Ylj0Kni2IhgY2EO74M
        OJeQYXRdEkrQlKcHKz+GRW0cvd0QRbvfIvOxDgNPm5QwvSarCvkIBm2YQ7SFCYcA
        O6/34LU213bPpW2XweGjbaTPtYqvf6zUMxZOTeED2y7lwc7DZ/HC/LSrtejQp05T
        EtQAiOzPUD0Ug8fioBp/kG3+REro5h4xAw6fBPg+aA==
X-ME-Sender: <xms:7uJ7Y-DcbA-2W5S1RARkMMwQBtOJq1QrtmZ_mQoQ2is_VW21tqjZOw>
    <xme:7uJ7Y4hnQYawqhBIyAd1InMcxUam8bsHb24_xARKVPX7a_m9HHeEAVvAksFoTURga
    LgS0aXgEe3HkXloHp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7uJ7YxmdnUWyHAoqePuZDv2wTgSKEpeeB3dTHbKrsWEmGNqs5ggoRA>
    <xmx:7uJ7Y8zFLwXpWUQPanGKsTj73AnPtWKHwjzRhF3M4k6icBhvrTbMRQ>
    <xmx:7uJ7YzREYJ2rL-jZyJH46a7G4vGWrcWPTIGd7gmkyJp9yMfzXD3a1A>
    <xmx:7-J7Y-H9Qa_FujGGzG_njXuOSVrBK6wJ1I_y7ZuBiBQ4AcbhSqONqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96D10B60098; Mon, 21 Nov 2022 15:43:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <cf1c2f76-a724-4609-8263-a5cf997895be@app.fastmail.com>
In-Reply-To: <20221117105131.7059-1-cniedermaier@dh-electronics.com>
References: <20221117105131.7059-1-cniedermaier@dh-electronics.com>
Date:   Mon, 21 Nov 2022 21:43:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, "Marek Vasut" <marex@denx.de>,
        kernel@dh-electronics.com, linux-kernel@vger.kernel.org,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add DHCOR to the DH electronic i.MX6 board support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022, at 11:51, Christoph Niedermaier wrote:
> Add DHCOR to the DH electronic i.MX6 board support to cover the
> DHCOR i.MX6ULL SoM. It is a solderable SoM.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

The patch looks good to me, and while I could apply it directly to the
soc tree, the normal way is to send this to the i.MX maintainers
(added to Cc here).

Shawn, let me know if you want me to apply this directly,
otherwise I assume it will be part of you next pull request. 

     Arnd
