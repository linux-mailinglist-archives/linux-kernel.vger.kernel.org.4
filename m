Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A9693D70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBME2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBME2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:28:18 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2176596;
        Sun, 12 Feb 2023 20:28:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1A5C432004CE;
        Sun, 12 Feb 2023 23:28:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 12 Feb 2023 23:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676262493; x=
        1676348893; bh=0i5TurBb3X4wdi823xN8BxjMRfYoHg+NNXP0jPnU5RY=; b=e
        FGdztbJWaVqSFr0mK4refTYRRpk4q1isnVhU+a10fSwuznf9R7HpMkKA3V42MBWx
        OVr4pK3HwUKA/91K8bJUIb9pTD2dgyCRISJoCJ8s7fuPK50oL2iYsrvuuS6mXDP6
        3hNfpO/sAKTGDn8hocvT86NSo4q4Ni4Zjaeo0rCJfxpSUOOF9kViStbCiIbBDhVa
        5AvFnq8+XA2K4xVMuf3UWrjZBj/cmLa5L4H/gA+DQhCPiabA9hjwJM6NCjs/wMzl
        xRmo9RGGfFHfOAUTmk/UA4vgSgMw0g8j8gyx6rGEbZSlJB6ksYEkL6N7eGa0RpvO
        7iFKEA6W0VOcCIAizuJ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676262493; x=
        1676348893; bh=0i5TurBb3X4wdi823xN8BxjMRfYoHg+NNXP0jPnU5RY=; b=q
        mjrCA4TVAt3+EyqMOC3MDxZuXOGpbS3CCjhD+kpugy90P4BHABs1FD8VRZYThcPv
        Obp5KsVSLyGfQvGl31t199TYXsX7apvnVTuekn1etjzKk+51ZoiHfQ0E634jebgX
        XjHGHKhD2dRIpbOrT/jF1VKFoz98BEh2LXn3y7yQPaJ2HhqTXyzeXOomnVBBchtX
        XD1G8kyzbdK1WDscgIn3RHrDvuSquAA30kYB9QVRYfAl0D1TVtvt9Jrz9a2/gyQF
        jbuEjlsMFG1x/uejZk3eD3FhR9/R7BLWpV+ibNpxU/lYJIOMP08anhvtrrL3qIkk
        w6cOgVxN8ybRZGe2WgnMw==
X-ME-Sender: <xms:U7zpYwhQN45phes7FVqBS-nWhYl4-g9wQ9V4jxpy-XEzovxzEjfk8A>
    <xme:U7zpY5Bfyj7lDtfcRpmDK-WeQ5DTF8OMJW6OIKVT64sWkQ65vCm0yllgM0ZlSDvnB
    jbAqwSq1wmS>
X-ME-Received: <xmr:U7zpY4FoJn7XpRRzUWpYltcEfljaiDCYBvJQ3VnxHZYyLB3HXZpbMpsXTGYyEMLBaVTrW58GTGtkMJjxdp3JMJkKBta1iOUNW6-Y7zFhN1VFOsM_A32g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:U7zpYxTRDbLdoH43TG8NzCF5UKkRICy4QRnoWBQgTfiq9aiO7_KPeg>
    <xmx:U7zpY9zBbYyH8IPNfHSOMiy9lHfKn6feai-Y8MnVqnja83ZlDbvwgA>
    <xmx:U7zpY_7OnWaZ9BYIhtnjLSPXAx4jh1RM7yk8zJVlPOpq9zItt0TxLA>
    <xmx:XbzpYwq2fGSDlOSOZ3vGbTJrZrz2SZgpyn-9fznzHrvi-WJGp2krRQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Feb 2023 23:28:00 -0500 (EST)
Message-ID: <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
Date:   Mon, 13 Feb 2023 12:27:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
References: <20230211195950.452364-1-pchelkin@ispras.ru>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230211195950.452364-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 03:59, Fedor Pchelkin wrote:
> Syzkaller reports the leak [1]. It is reproducible.
>
> The following patch fixes the leak. It was proposed by Takeshi Misawa and
> tested by Syzbot.
>
> In other places of the code the waitqueue is freed when its wait_ctr
> becomes zero (see autofs_wait_release). So I think it is not actually
> supposed that inside autofs_catatonic_mode wait_ctr cannot be decreased to
> zero. Please correct me if I'm wrong.

This is a bit had to read but I think your saying there's an assumption

that wait_ctr can't become zero in autofs_catatonic_mode().


That's correct, the case of a waiting process getting sent a signal is

not accounted for and this can (as you observed) lead to the wait not

being freed and also not being freed at umount.


I think the change here should be sufficient to resolve the leak and

I can't think of any cases where this could cause a further problem.


>
> Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
> instead of wake_up_interruptible', shouldn't wake_up_interruptible()
> inside autofs_catatonic_mode() be replaced with wake_up()?

This does imply that [2] should have been applied to autofs_catatonic_mode()

as well, I'm still trying to grok if that change would cause side effects

for the change here but I think not.


Ian

