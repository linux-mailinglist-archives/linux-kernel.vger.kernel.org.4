Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE58717CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjEaKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjEaKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:13:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A110B;
        Wed, 31 May 2023 03:12:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B76AA32009A1;
        Wed, 31 May 2023 06:12:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 31 May 2023 06:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685527971; x=1685614371; bh=gL
        q2gHiJM+KP1+NdSFVehsgQGj4GYd9hBZy1RUFLs0Y=; b=DEcPru7BTgdHj70sAp
        LGx4H6mvsBm+vApV8FhA2+5LYsNWA7mVHokhzH/l0mhX0NjpJKnxEXQuelTZqzs5
        57qLlYMpiHW2gp7E7l7iekXWtCjz6RyWJo+9k7Av/va/c+3OQETPxekb+UDZTHaW
        S226KvUwFti06hkzjW5rHLzxYwJVj1WGE08Zy6L3QA3BvhiP6/CV5kjUreQJisf8
        HrXkrcrcmgsCfrRd2bYg6X3XCQMVuaOieWbNV9FgRlYUKfyVrKGDtLCN5oMixvmu
        PD1qcCfFH5bopnUWA7yIc+0YBNocxDf2W9iU4VQXz3NCFQqw+zLZOZRjSONM/1de
        KKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685527971; x=1685614371; bh=gLq2gHiJM+KP1
        +NdSFVehsgQGj4GYd9hBZy1RUFLs0Y=; b=XpHnguzyG8jh82OblR0wPOi0HW7yq
        guz08WJU38YmvDPHVurY+G2eCezGVN+im9dV4n3bFqWWQfDbhPASvEIj6aMCiwCN
        GSWvS4XVdwCJsehHG/5rfhjtNApBS/n2LQQKc4EqvhwboYsFOiFpKy0iEgbcUyv0
        jSTG2oETo6GQoez4hG5QXfeMxk65T1IXZSUh2miiUJYijI5aQSWmU8V4XtwJiaHE
        LjAMdpx3jjPfjsu8tI7CXuplA+YzZ9mv0dqjZddEwuUlEqxNXneXk0q0qb0PQ8yv
        ljMgUQKdSTdFy16029xzDC6wLHGFIUR+ck4vpDTCXKhAhp9TAQXQX6DNQ==
X-ME-Sender: <xms:oh13ZLte04EM-c0kF10tTrSyzw54xFGD46A1Oi-hIC--KbC6RPcFNw>
    <xme:oh13ZMdzdfSWFa4u-FxthIT5t-v_WhHbpiBYkp3Q8t1VqQrzKELic7MQQApv-JrVU
    1iEP7ZQnrekEKBDY18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:oh13ZOxt2-ByGSiubGPgnUaXf8hx57qalEDB2nWzqWdVrauzDGyjSw>
    <xmx:oh13ZKNBoyT6NknJNcfoLX4_24o-Jyu9ylpvPzgzKoVA9PGoIre9mw>
    <xmx:oh13ZL8oA1_gswiqmbZKOBZ5eJ9bprlL9iKBdflJNHPZuZREnvTpBA>
    <xmx:ox13ZGlx06UPoFHl0ZHzIJx3KLKPK0bWnoV8CUNPfHXjbcWtXWbfnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA3DBB60086; Wed, 31 May 2023 06:12:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <33173e7b-0ec0-4a1e-9533-0d3b6eb4c8ce@app.fastmail.com>
In-Reply-To: <41c61895-59f4-449c-9e2e-d127d7f95be5@app.fastmail.com>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
 <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
 <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
 <2fce7746-6d63-4853-9b20-8fa0b24d6f32@app.fastmail.com>
 <41c61895-59f4-449c-9e2e-d127d7f95be5@app.fastmail.com>
Date:   Wed, 31 May 2023 12:12:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>
Cc:     stable@vger.kernel.org,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Nick Desaulniers" <ndesaulniers@google.com>
Subject: Re: randconfig fixes for 5.10.y
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, at 21:20, Arnd Bergmann wrote:
> On Tue, May 30, 2023, at 21:02, Arnd Bergmann wrote:
>>
>> CONFIG_COMPILE_TEST=y forces a number of options to be
>> hidden from build tests, which is generally super useful.
>> The one that ended up hiding the stack growth above is
>> CONFIG_GCOV_PROFILE_ALL. I'll try enabling it for a few
>> builds to see what else shows up with it.
>
> Update: you already pointed to UBSAN_SANITIZE_ALL causing
> this, I can confirm that this is also the case. With your
> config, the combination of CONFIG_GCOV_PROFILE_ALL and
> CONFIG_UBSAN_SANITIZE_ALL causes the compiler to completely
> mess up register allocation in this code, disabling either
> of the two gets it below the boundary.

After a night of randconfig builds with both UBSAN_SANITIZE_ALL
and GCOV_PROFILE_ALL force-enabled, these are the ones I found,
listing only the worst size for each function (using gcc-13.1).
None of these show up without GCOV though:

crypto/twofish_common.c:683:1: error: the frame size of 2040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
crypto/twofish_common.c:683:1: error: the frame size of 2336 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1589:1: error: the frame size of 1696 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c:754:1: error: the frame size of 1260 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/staging/media/ipu3/ipu3-css-params.c:1206:1: error: the frame size of 1080 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/staging/media/rkvdec/rkvdec-vp9.c:1042:1: error: the frame size of 1660 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/staging/media/rkvdec/rkvdec-vp9.c:1042:1: error: the frame size of 2176 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/staging/media/rkvdec/rkvdec-vp9.c:995:1: error: the frame size of 1656 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

      Arnd
