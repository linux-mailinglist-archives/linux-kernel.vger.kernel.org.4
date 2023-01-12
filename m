Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D18666ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjALJ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjALJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:56:54 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111BCE2;
        Thu, 12 Jan 2023 01:53:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D39F25C0151;
        Thu, 12 Jan 2023 04:53:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 04:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673517231; x=1673603631; bh=p2SYc1lBE9
        mVbk87ASBnhBU0dygdpDeQU1sczP0Q77g=; b=qbSoBZv6O3JXCieEgYA/dSNtQi
        vA2d2UQ5xvrUNWIpuahsX4gRaGm90QNXRnL1SiH6ofLvShcF1fdVPwaWBYL8Fp9K
        mZlEIuvI+ahIs4b/q2RfRvK8tmFRhS/rPoJM1vVAdna98KmcYfbEKAzVAqmVvj9y
        JjKkb0LZvttLrIbpgyIUJ1lr5e0MLEaXqyB5gzRlo3yUl8qB8k6ZeQMcseIKzoiu
        X66jwBO/TA2L7a1vMaIA/rdDHsOTbw6LChLUGbnFIJokZuetngB4ZEUoIQkSX6CE
        5THUZ/h2j25YP5ZnMMEtKE9Se3cV09OiHRh9COCuu1eUxasejJ3A75/UjjXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673517231; x=1673603631; bh=p2SYc1lBE9mVbk87ASBnhBU0dygd
        pDeQU1sczP0Q77g=; b=BHGcCl2cznImYavnq2kUO1R04hSPBZ/dlPCz19RViD17
        uBptds9dlo4PEvMWpY/E3UuhA7QFW8azaZa8zTKYrlIXQFB8XCX2BlFxNEGmQbCI
        MfMBN7+ZpF/jyjDJ+yfvhmfzoaoxhUQJCKk7HrRER/soLmOccug4qtPx4uE4ARt/
        UM0K0Hhyj9mNky1fE54WEkFnRetVzGPkRQLNalBq6uezWdOyDVRiBE9VbzJZBH+x
        m5qZWn7xugYukfvaMs9/15rYS7h+XRQgxpzaABni/Ljf35hIu4Ci7Vw/YBXKD+Gx
        WBEK3f9bRsj1BdlxQuxIJi4HqeKWW6g3JKfJ0Qg0OA==
X-ME-Sender: <xms:r9i_Y4-6DoKLoZ4J1vw6UkYn0SMp4SpytknuZnZQ_b6Cq_UuXGZelw>
    <xme:r9i_YwsFrOEMGeUdAYZ3YJUefnRTKqL6qXvPgjBj3aklFH5Qmsf3yNFD7z65FgV__
    hp-Xqgh442mlzbhpJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:r9i_Y-BfSspw833oXxsO_WyqI5xB-IiKIw2lvQYtWgEaWJ0x52RP0A>
    <xmx:r9i_Y4d-Mdvwm5dNhlyEXqsGmZmIYJzbGTRnGKjJnQEwLZiz9m6XZw>
    <xmx:r9i_Y9Ptd75lNeHAMeDqhrjbtg3Gk7sD_WMSEAM1NAgsonFkugrhQw>
    <xmx:r9i_Y2gA0ZpdrQ4z-rytYj0ZOeK2F-zpqC_WmoTXJQNHWgmKE-wgwA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7D94B60086; Thu, 12 Jan 2023 04:53:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <c89c1079-3d3e-48b0-9331-a2f052e9f215@app.fastmail.com>
In-Reply-To: <CAKXUXMyRBhtHBu=9TdaumwuHPzKv48YCWnAoCx=Vr8p_fTJVqg@mail.gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
 <CAKXUXMyRBhtHBu=9TdaumwuHPzKv48YCWnAoCx=Vr8p_fTJVqg@mail.gmail.com>
Date:   Thu, 12 Jan 2023 10:53:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI support for
 OMAP1/2 chips
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

On Thu, Jan 12, 2023, at 10:19, Lukas Bulwahn wrote:
> On Thu, Jan 12, 2023 at 10:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I see. Yes, probably, !(MACH_OMAP_H2 || MACH_OMAP_H3) is really in the
> current state of the repository "always true", and hence this
> dependency "depends on ISP1301_OMAP || !(MACH_OMAP_H2 ||
> MACH_OMAP_H3)" is always independent of  ISP1301_OMAP.
>
> Are you going to fix up your commit "ARM: omap1: remove unused board
> files" with this change?
>
> Please ignore this patch then; patch 1 and 4 still seem good to pick, though.

Done, I've applied those two and fixed up the other patch.

Thanks a lot for your series!

    Arnd
