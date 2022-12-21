Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E5653789
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiLUUV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLUUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:21:54 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287126569
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:21:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C57D75C00E4;
        Wed, 21 Dec 2022 15:21:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Dec 2022 15:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671654110; x=1671740510; bh=OBjG4NwLQl
        FX4VKbAZD6WZvZtFoUBV+Fpen91dytqj8=; b=EVaEKA7c+Irz4sEx1eWBGekLVS
        boOBWx6ReDDosvnwqTpwSirRQ+x3PWRdJGMeX+VoUyoPFBryWxOlXdROiH0CKhAe
        I8Cu9ejs72lHX2vQYSIGIkNh8nzzuNj5SQo0qDgsMulAUXdw7+V4PO3bXFpcARxD
        dsLufKLFpxj695qbQWWw3Paf2wwK8MeoEerM3SwPn/flRZsS83qzily4hsrW1tq8
        a7KM+xbgGpP2stDQPU2EdYuYZKsnePJj2LCguo+oq5qvzZsosKvbZwc5y6Zmeg+U
        paKyefQbUIFOIlIS3lXuZnXsR766ba7VWtkM4RZzp4UhIA8rKxDMgl4gJEng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671654110; x=1671740510; bh=OBjG4NwLQlFX4VKbAZD6WZvZtFoU
        BV+Fpen91dytqj8=; b=p5CSpyv3UEIIOE2HEO9+r09wf3LN31KRDi5ZGsT2hSFY
        5Ymp96qLMn7fy7ksLF/9trgfbEsJw5QcXYKkpp5g/WudyyA/w1Hol91RKFTNd4HN
        N2DJHjG03a2Vh+xteFhk9dFqbcxrY/SPUZ1/1Ir+XmGU38o9YQ/+Pi4YKojJ8UAN
        BAwD6R69NLQdS9iq+gU6oTyXYheaw4Ztq+yB+0m5r9sBi0wJ9ylu400rAZ6DOhVD
        vkCLOzuaeb4f2wNU8sfmdkGucDlWUHCUn8zEFpC51JTKuOjy5hdGt0uaUfUMokC2
        0WJtp3S8alwbrl0zUwSLjIx4mWeprGJfkiapz5c8wA==
X-ME-Sender: <xms:3mqjYxTnUd10IptozB5EZcTuV-vKPTk6VQ795pGe1zRidNzFwPzSyQ>
    <xme:3mqjY6x34XcJBXy-yGFtLkJsAH1D8Kj2plvchTzYWqfMakzdQ8fmoagCH4B2dXSHX
    8OfqWKyFZzhfWzTHBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3mqjY23UdA7SQv1VdNs_KNtYaHGFy_oQTu9W2c9OjAFTyva4HOW4NQ>
    <xmx:3mqjY5DM973X8imaV5wSek1S3dVV-b_AxygFcpz-MitmrhW7TFFzHg>
    <xmx:3mqjY6g9TzWYCtUUJ5ZW6sWpcM0DT1sm8bna5K2iifODTzBn3n0ZDg>
    <xmx:3mqjYxTJ0x4GU1RAgnzteO-d-EbtSleGT23fip934Ev4KuOzzOb5bw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC8D8B60086; Wed, 21 Dec 2022 15:21:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <50c4ad07-e18f-46ef-a0e4-1bc6a5c2d632@app.fastmail.com>
In-Reply-To: <Y6NpUyLRR0f9sQ9C@kernel.org>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s> <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
 <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
 <Y6NpUyLRR0f9sQ9C@kernel.org>
Date:   Wed, 21 Dec 2022 21:21:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc:     "Leo Yan" <leo.yan@linaro.org>,
        "Vincent Whitchurch" <vincent.whitchurch@axis.com>,
        "Hans-Peter Nilsson" <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "John Garry" <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Kim Phillips" <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to sort -nu
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

On Wed, Dec 21, 2022, at 21:15, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 25, 2022 at 02:56:31PM +0100, Arnd Bergmann escreveu:
>> On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
>> > I think it's the right thing to merge
>> > this patch, @Arnaldo, could you pick up this patch?
>
> So I'm adding the provided:
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
>
> 
>> That sounds fine to me.
>
> And taking this as an:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> ok?

Yes, sounds good. 

      Arnd
