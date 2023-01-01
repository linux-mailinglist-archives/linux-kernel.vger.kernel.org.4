Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F413B65AB2A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjAATZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjAATZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:25:11 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643052706;
        Sun,  1 Jan 2023 11:25:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CE7A65C00BB;
        Sun,  1 Jan 2023 14:25:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Jan 2023 14:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672601107; x=
        1672687507; bh=VpktkYQ2pX/lu78EKe1ReoxXZHT7qf8KAco8uky/13U=; b=B
        Rs/Y9AbvltE9KgZGZbW7mbfPr7BJVRShdbhDFQTqeUuac9nir9LC9zA9ryGx97wq
        zpJ3eQKLBxMKjTvKDEU7EDAFPyWmHt8H0NnwcjuGdSuPYoEwp3pCP9qj4BLRtmvC
        /Ee27QCvOBzmTTQqu3maRzWp5/GVvwfhMSkrbhEhmKUAwuJR5UlJmzgNcTURtTq2
        GavaDkG1SYCCwfZlzBlWwkxntNidyJ66iRz+6XnHf6WavLDn70FABiuZUv2SPI4L
        RU21lDD3Hp/jeBOUq9Kq5CBXVAZx14prxrIAlIgQAm7y0eh492VZ1qMujHMghGXp
        QIENirTySm9yFgIvRb/tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672601107; x=
        1672687507; bh=VpktkYQ2pX/lu78EKe1ReoxXZHT7qf8KAco8uky/13U=; b=d
        IsatgG3kLOfNy6cUS6o4wLTGqIZnt1/cQqV3UsQ0ISWcxOFbjjHn6l7aR2CWzkgi
        HgZGugHsIPY+wRYzEzP7lhAwf9urrDhaQK/Vzwfb8RuWQqtYg231dvoukSYJGIBf
        KMiZ3hj6+3/rPeGifKd/7mpI1f4Gi6tPE42imo/l7W0Aevqk8DHnuKSyNImYXCHV
        Erns9KxADd+1nfUgVUYtHY9eHZKrWXY43sowVLXvhFmpwKB6YSJUVLS/j5WA6xv7
        Lz/nFgWn1wmfYkPKxym8nyGj5OyadJRH6DvZdqSsIkBQHGLUpDBtrQgCCMurxxNr
        rTZ2qeqCXccII9Mk4yjFg==
X-ME-Sender: <xms:E96xY-kTYB-9oRazmIN5TOi6DCeVSt7INpYto6VhoDqvU-v5QodSKQ>
    <xme:E96xY13sjV5iRWgUdwOvIrkmsV8y9E5hMGvJQBOSUTuBB6uBpaG0zcZN3lTP3Nj6D
    51rw28eQJjZPG5XwA>
X-ME-Received: <xmr:E96xY8qJ5UeCwPMGjiMgiQnNPHlLOofoCYpUjppKbu7fzyY4T5WjftIhywykEX7SKj7nyF5fJeJjQ64mSCNvugZjgSK85DwtKHOdt6PAFqxpril9WT18bRSWMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:E96xYymTok3k6kFNuknX0gnE2fYf6-seD-DwIgVIeLN1ke3catKs2w>
    <xmx:E96xY81Cf5KNnJwmzB62M3uB_gucVa-x-41kbbLsjwdtvrMzRvgDnw>
    <xmx:E96xY5s7FpITiLHT66NpEjg_LkTosKwa3ltFCgt1legAsY-rF5e8Pg>
    <xmx:E96xY9J4knNs_eCIinK9_u3Bg6PfYYgF0IsGHRg8tDjhAJ6QXHfpzA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 14:25:06 -0500 (EST)
Message-ID: <5a6a65c6-6df3-0d24-b28a-324b28fd4756@sholland.org>
Date:   Sun, 1 Jan 2023 13:25:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220810022509.43743-1-samuel@sholland.org>
 <CAPDyKFqg0BUbpQwKvZxuMrqoiwBKzZxbgP-e=50yLpKRhQ+zPw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix clock refcount imbalance during
 unbind
In-Reply-To: <CAPDyKFqg0BUbpQwKvZxuMrqoiwBKzZxbgP-e=50yLpKRhQ+zPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 05:11, Ulf Hansson wrote:
> On Wed, 10 Aug 2022 at 04:25, Samuel Holland <samuel@sholland.org> wrote:
>>
>> If the controller is suspended by runtime PM, the clock is already
>> disabled, so do not try to disable it again during removal. Use
>> pm_runtime_disable() to flush any pending runtime PM transitions.
>>
>> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mmc/host/sunxi-mmc.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index b16e12e62e72..3db9f32d6a7b 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -1492,9 +1492,11 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>>
>>         mmc_remove_host(mmc);
>> -       pm_runtime_force_suspend(&pdev->dev);
>> -       disable_irq(host->irq);
>> -       sunxi_mmc_disable(host);
> 
> Perhaps a better option than the below, would just be to drop the
> above calls to disable_irq() and sunxi_mmc_disable(), as that is
> already managed through the call to pm_runtime_force_suspend().

I like the idea, but it will not work for !CONFIG_PM builds, which this
driver currently supports.

Regards,
Samuel

>> +       pm_runtime_disable(&pdev->dev);
>> +       if (!pm_runtime_status_suspended(&pdev->dev)) {
>> +               disable_irq(host->irq);
>> +               sunxi_mmc_disable(host);
>> +       }
>>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>>         mmc_free_host(mmc);
>>
> 
> Kind regards
> Uffe

