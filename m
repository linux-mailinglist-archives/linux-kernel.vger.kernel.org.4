Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4059064E9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLPKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiLPKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:41:39 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F145ECC;
        Fri, 16 Dec 2022 02:41:34 -0800 (PST)
Received: from compute6.internal (unknown [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 98F253202612;
        Fri, 16 Dec 2022 05:18:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 05:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671185926; x=1671272326; bh=GtRlZqOItr
        U1QlWIXO4vq2lcVVqz0Xra01x2nnM+5SQ=; b=G7igdATSsnZODT8XLz5ncALZqO
        k10fQ237UsThCWdue+lltqUJGzUPDMF28fMx97M4AkorJqqSe9ZQxSYaQZx56AeC
        EHEguJlyXunsocNiu/RjZLUUMkHEMqxDLoH4YXPyvHEDXXJux7NFSF9mn9Y8TgvW
        6AxviGNh4UK1BY5vBQmQCWog9vI/qBw8ps8PeLoNTszeIwQSa+IQIH9YAYtD33Xn
        7OGI7uTr2b787gd9qofN7L1CpDS7ZwJyfqWa502zzrXr6MiDxvN9x4nvH1yh5ti0
        I978fG/62KBjzAh4YSzW3k9m2CoTL7IZZFdsJ7evDejrSy8eHPA0+BOvIFag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671185926; x=1671272326; bh=GtRlZqOItrU1QlWIXO4vq2lcVVqz
        0Xra01x2nnM+5SQ=; b=L1By0LA9/8qY7X6bsIAaH5MIjUmuI/9h6xWB+o5BkDS8
        TXObzHFRQ20lKmpIXNUk6B0d2x4/49/QXq3+xLGmTXAY8SrNlH1T1uBSJ3fSDQAG
        Vz19SLJqF1VYOWJPL1SiFAO67EtVDowfqSO56VNa/E8K9z8cKw8wlEv1nO6VGbHR
        jyvL7gT3jn2i7htTK1wUiuLTi8NBTcQhlgUXhA+/jF7QNBrbX2pkjBgi3oXKkp96
        Lq+HjXbhYN0rsqie9sgiDEp439pmJgUtfVu1UdfcoSQpsFZtVWHTHuTgkH6DlC0u
        vBE0Poon/VxmL73MTWbfa/HburlDqsdPtHQGz88UBg==
X-ME-Sender: <xms:BUacY_-PhfvlXsey-UuiVE0ZvvN90m5buhvbpbSbHyvDQ0r9lSZMmw>
    <xme:BUacY7uFR0D8sxe4HOWpX4LUZSwaRGK6kZF2SWEbQqrT1guXZCDQ16cqMrAhVsm4F
    e85JoNt1RY3bmtbAa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BUacY9BKXgoEbxLPkM6sCJcFgXIxtV69mZ60oiFXVUyrSmJ6ChZL8A>
    <xmx:BUacY7cmAL6rDakAhEmVptzn7zkezpzOFEKlIb2kvJVKxGE8ylKSZQ>
    <xmx:BUacY0Oq0KeJ_uUj7n15o18IznObE4MnGf4_-Q7PlywN4-2m6jYgcA>
    <xmx:BkacY7f0WYx1-vltgzIe39PWgEdva10sh-1EeWjQieqCagtoh1OVUA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F2F9B60086; Fri, 16 Dec 2022 05:18:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <67efe55d-e5cd-46c1-97e4-c9f3a5884a07@app.fastmail.com>
In-Reply-To: <Y5tPyOqSNud7LumS@sirena.org.uk>
References: <20221215164140.821796-1-arnd@kernel.org>
 <Y5tPyOqSNud7LumS@sirena.org.uk>
Date:   Fri, 16 Dec 2022 11:18:24 +0100
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: tps65219: fix Wextra warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022, at 17:48, Mark Brown wrote:
> On Thu, Dec 15, 2022 at 05:41:28PM +0100, Arnd Bergmann wrote:
>
>> -		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
>> -		if (rdev < 0) {
>> +		error = tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
>> +		if (error) {
>>  			dev_err(tps->dev, "Failed to get rdev for %s\n",
>>  				irq_type->regulator_name);
>> -			return -EINVAL;
>> +			return error;
>
> This will shut up the warning but is leaving the use of the
> uninitialised rdev (which I'm kind of disappointed the static checkers
> didn't pick up on).  rdev needs to be passed by reference into the
> function, or set from the return value.

Right, I didn't look far enough to see what the function is
actually trying to do here, and that it completely fails to
do that.

I see that the bug was introduced between the first [1] and
second []2] version of the driver, but don't see why. I'll
leave it up to Jerome to address the problem, he's still
in the middle of posting the rest of the series that has
not yet been merged, so it makes sense for him to test it
all together.

    Arnd

[1] https://lore.kernel.org/lkml/20220719091742.3221-9-jneanne@baylibre.com/
[2] https://lore.kernel.org/lkml/20220726103355.17684-10-jneanne@baylibre.com/
