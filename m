Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330C673356
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjASIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:08:01 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD84EF2;
        Thu, 19 Jan 2023 00:08:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C418E5C0129;
        Thu, 19 Jan 2023 03:07:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 03:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674115679; x=1674202079; bh=W8zQgh8vqQ
        Cm8jzCK6Tq+eiSYVU4ajK1uvhhd4aKcwc=; b=YEjxi/aE7MK6oWjRntedsnZRh4
        aden0Qq1GEVlrED84KL2Wg+7foHOuUkIZFkyV9dV7OM6ghUNz7DyLTWIQAy3tWke
        SqbZsVu62JlF1lOfI9NFWh21jujGmmr5S3dtvUh/lVgFEXCABG+gRF7d6rBx2jeg
        FeCTkfgrnAS2nqWjyVEmtJkAep4evx4i6dqwARDR/rvsUEC5IWLnxOrhgl2qM8nH
        BICj+81Wzh4PfufWy2E9V4Kd5Gd3MJTAu35bwo5wdY3knbFgda/Cg+ZklwFVBkHc
        N+5EqcfgZq5CFs7skYnUcxR0GRQ9PqKtGaOvCz4uH/cMjFtRFj3UWfqhlf/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674115679; x=1674202079; bh=W8zQgh8vqQCm8jzCK6Tq+eiSYVU4
        ajK1uvhhd4aKcwc=; b=K6p3IVUBM9nHO31Boe5yg2Kp/fyXTrPJIfud75t9YMEP
        73y4MeeoVSdxO5ITLaCHKpg8DqkLRfTBYLoSasJaujqQZpP6h62YnQa87gi+TQK8
        Tl93JDAeCPycOiv2muwrpc/6udm5YpEwN+nzQlgy3VB/kwU9eV6/yhBiTlQ7oHDA
        ySlqylizlDB3XZg4/PkkUWB1B/7o52HztJNvv97QgWHQOAxv/A4LgSat9kNJLs8j
        DH2rpD3YOR8DId7C4bTB5/0cO9+Nkghd5tp74IX4zHFECy3w4ysoXl4KGs6e/VoT
        4OHAvQfBaqOvWooEQhW3ar7l3xnaq9G1RkB0BM5qKw==
X-ME-Sender: <xms:XvrIY87FMpnFcNAhDFXCeMSQcKEifGdpY3oYoCzMgFohg3M4vElYwQ>
    <xme:XvrIY95oMx77XCjXysiFFcYIp_eqYrlhGPHRFuhDnKftfwnYAf5L1ADstlK6HM_kV
    _YC4mCO8-njU2R6QVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XvrIY7dyIzRI8NQhwu8wwcHanniRadq2n3YTYffOGI_W-Un5YvnTcA>
    <xmx:XvrIYxKuv8OWelHXfo549ohYuvNKAhDfF6dKY7TA04rKfvXDUgJgPw>
    <xmx:XvrIYwIO3d_-kZMfvBXZ6VeoGc_NgwmLn-mU6o152J1yKn31McaGMg>
    <xmx:X_rIY_92gFa8UrMbHZwbtCnDCzSaDzmSLdMdurdygIW6H0NgOOvSvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CA8EB60086; Thu, 19 Jan 2023 03:07:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <b1f98c2a-3087-464e-b9fb-97e7c78cfdab@app.fastmail.com>
In-Reply-To: <67efe55d-e5cd-46c1-97e4-c9f3a5884a07@app.fastmail.com>
References: <20221215164140.821796-1-arnd@kernel.org>
 <Y5tPyOqSNud7LumS@sirena.org.uk>
 <67efe55d-e5cd-46c1-97e4-c9f3a5884a07@app.fastmail.com>
Date:   Thu, 19 Jan 2023 09:07:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Brown" <broonie@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Tony Lindgren" <tony@atomide.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jerome Neanne" <jneanne@baylibre.com>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Yang Li" <yang.lee@linux.alibaba.com>,
        "Yang Yingliang" <yangyingliang@huawei.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH] regulator: tps65219: fix Wextra warning
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

On Fri, Dec 16, 2022, at 11:18, Arnd Bergmann wrote:
> On Thu, Dec 15, 2022, at 17:48, Mark Brown wrote:
>> On Thu, Dec 15, 2022 at 05:41:28PM +0100, Arnd Bergmann wrote:
>>
>>> -		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
>>> -		if (rdev < 0) {
>>> +		error = tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
>>> +		if (error) {
>>>  			dev_err(tps->dev, "Failed to get rdev for %s\n",
>>>  				irq_type->regulator_name);
>>> -			return -EINVAL;
>>> +			return error;
>>
>> This will shut up the warning but is leaving the use of the
>> uninitialised rdev (which I'm kind of disappointed the static checkers
>> didn't pick up on).  rdev needs to be passed by reference into the
>> function, or set from the return value.
>
> Right, I didn't look far enough to see what the function is
> actually trying to do here, and that it completely fails to
> do that.
>
> I see that the bug was introduced between the first [1] and
> second []2] version of the driver, but don't see why. I'll
> leave it up to Jerome to address the problem, he's still
> in the middle of posting the rest of the series that has
> not yet been merged, so it makes sense for him to test it
> all together.
>
>     Arnd
>
> [1] https://lore.kernel.org/lkml/20220719091742.3221-9-jneanne@baylibre.com/
> [2] https://lore.kernel.org/lkml/20220726103355.17684-10-jneanne@baylibre.com/

It looks like you merged another workaround from Randy Dunlap now as
commit 2bbba115c3c9 ("regulator: tps65219: use IS_ERR() to detect an error
pointer"), but I think that one is just as wrong as the one I submitted:
the 'rdev' variable still remains uninitialized, and checking its value
after it has already been used is not helpful.

      Arnd
