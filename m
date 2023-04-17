Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD626E53BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDQVPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:14:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6224232
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:14:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1DF8A3200913;
        Mon, 17 Apr 2023 17:14:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 17:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681766096; x=1681852496; bh=mC
        5DuaozRZOtAfkgxPWm4eLWSyE/qIa2ZY/soYhKUHU=; b=l+GQ8d078hCM1xjfO/
        gUbbAG4xtPuBG6RprgWz1nukoce59e9tsiv02GCC90zlWdVpUnq/KcTQTAhcw2H/
        omRwKI7vA1wqMPsmlVU20t4AQzf+drS5gJi2Jqzgj3Zys/XvCz+bnPlgCEobchNE
        /qAddAhDRflIQsg2sbSD+XBchNnsLajLkoBbOdJAfB3YQ4FvzlsOUzDzEhxZpr75
        NRI0gbkGtZJVXJOAn6x2Rm6SL5Cjlua3zmbVuvumDHDJms9BJDGDQUN7fWlYiTfm
        BkbuPF5bkYbqZkR+usRJK4dCjdlX/grLQi7Xi6XFLG8bWXZhVl+B7CohWqHCEC3i
        BPBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681766096; x=1681852496; bh=mC5DuaozRZOtA
        fkgxPWm4eLWSyE/qIa2ZY/soYhKUHU=; b=iX870AtNY8yMO5uSFmk2eyLjvSphX
        O98KD4jOhavoZtkuBESGQGjnVIsetJ2M7wnBysWX2R/sAu887WTHrXrJihAkTE7w
        E8ojF5Vz4f/r0nocwXWeuAxzzUr4/xNGb+cw80qbJO1tFr0V9dzKIzLALbMlLK8b
        dbNH15rPbOrde94+af1x2bTZ28rJOPPM9rwAp6u3yrjOkwrMhmNughxzDIaGNCWw
        z6uruCXO3s9QFAJBFMBhNExWY5v+3sQ95mbIdbkYBGd5aq//kqdiKQXKe5o3RAKi
        eWnyBKwO6kFiquox6WIyr30yRuE0dKIcfyC9QN0YgzvgrI4a1othrWkxw==
X-ME-Sender: <xms:0LY9ZPPwUGeHFceJLxve8skHlv420bTnpb55962VFUUN8fFGKgrJdw>
    <xme:0LY9ZJ8F69cBQHiUziVY6qQCV22tNk2EsuAsrklVWludm7SHlyTY3KrhG574lI2hc
    rxwT-NvKywBbhdd0hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0LY9ZOSWEh6URb5WYiwyjEwIE01z5_F6O9fj3Tr9kptf6K-cQLcmzw>
    <xmx:0LY9ZDuDjpgimztpRmoawAD0y2EYy126dxSnFmyosJ5RosMEwY0SmA>
    <xmx:0LY9ZHemPF9TgHKzX7VNfrSxXC1NL17MdPVJyK-9ID4Y6nmpMIUVVg>
    <xmx:0LY9ZCBe-jmlGGha8tZp-eNdhpZTAzecgkGoJuP1ywrJHUTYby9EMg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 296A1B60086; Mon, 17 Apr 2023 17:14:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <0d966637-6074-4d54-a299-41d063e05310@app.fastmail.com>
In-Reply-To: <de29b7ac-910c-8d4b-50ff-47ba4134d16a@amd.com>
References: <20230417210602.2614198-1-arnd@kernel.org>
 <de29b7ac-910c-8d4b-50ff-47ba4134d16a@amd.com>
Date:   Mon, 17 Apr 2023 23:14:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hamza Mahfooz" <hamza.mahfooz@amd.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
Cc:     "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Taimur Hassan" <Syed.Hassan@amd.com>,
        "Jasdeep Dhillon" <jdhillon@amd.com>,
        "Alex Hung" <alex.hung@amd.com>,
        "Michael Strauss" <michael.strauss@amd.com>,
        "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
        "Qingqing Zhuo" <qingqing.zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: mark dccg314_init() static
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023, at 23:12, Hamza Mahfooz wrote:
> On 4/17/23 17:05, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The newly introduced global function is not declared in a header or
>> called from another file, causing a harmless warning with sparse
>> or W=1 builds:
>> 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:277:6: error: no previous prototype for 'dccg314_init' [-Werror=missing-prototypes]
>> 
>> Mark it static instead.
>> 
>> Fixes: 6f6869dcf415 ("drm/amd/display: prep work for root clock optimization enablement for DCN314")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This has already been fixed as of commit 669f4ac40947 ("drm/amd/display:
> set variable dccg314_init storage-class-specifier to static") in
> amd-staging-drm-next.

Ok, thanks. I waited for a rebase on today's linux-next before posting
mine to make sure it's not already fixed, it must have just missed the
cut-off.

      Arnd
