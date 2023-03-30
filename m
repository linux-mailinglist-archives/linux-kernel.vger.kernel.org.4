Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5416D0525
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjC3Mps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC3Mpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:45:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBBA6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:45:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1D6053200906;
        Thu, 30 Mar 2023 08:45:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 08:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680180340; x=1680266740; bh=f1
        AZRuf8N3jc9HZXV85iMY7xgnUCPPnLIMmRPwfIxEY=; b=iyIls0tkzFxjaQwDl1
        S9EOcOH7vj6pZu3LAtbUrXTKTWAmhVUe1rkkaVxMbLQ9FEJ5gBqWDlphBSBbt1WR
        6pJcX3ABcr2DTflnC+67sUbLgxkXCjSP96qLwiVKIli8Ez69ys3bePhKQ8GXKG2s
        1eE4CcCGgyCm2JnTH/tc5TZ3emZmGIpcQ3RG7zNGJ+++/W0en/TLE0jzAzjj8hFX
        tOvlqv6crMTJnspkImKPr9e62BBPKGSc7R9N6+s3S2MOeNVbmN2KwFcBXk3HE7Fu
        OVpIfWwCYFDbbwq19TYSPOCi3M/zE0YtDUR2Bbyw67eMNZggJzcqxYwc4+Kzq3KJ
        tM/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680180340; x=1680266740; bh=f1AZRuf8N3jc9
        HZXV85iMY7xgnUCPPnLIMmRPwfIxEY=; b=RpdtIdOmrgfuQritf0SNB+tpUyJbx
        vcRWGGcujwF1fLhNpDJpouBl5ur6udTI3eKAMylxvHoR2liiBM9/E7sqlCCT4v5h
        WTMqCEmqM4CUKb5UYyAc0ASpNw1jg2Iu+qBDjMjXiENSEdS4Cjip6by46UODddEV
        Nh7xFbAp/nqT2t9Xse6eBNqiDQc9E59Vr3nla2J0qBMEph/oI9XXMDYCUZISwJOA
        hPqRzFLmEGhpMfuog++3TLwwE332tfCxXqO6nFk4BQC4bUKzP6AIH+CxwFPmVFzN
        6SAzoBRIDnMXMgmqByAAVbVwEaSDx9rbAzYvjDdEtbFvsdxO4Y66goJlQ==
X-ME-Sender: <xms:dIQlZFshQKFqBiKJ59mbe3jiTsAdlkTYmD1Y8-c00JJliTwBYXg7Uw>
    <xme:dIQlZOcRIDjDJRdjZ08m1YxCpmjmDx_Yp8tNkwALdEkFBywW51mAv2yofrMrTMcoq
    -cK1yFJPfrvdfY-V9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dIQlZIyBEYBWpSoZe9nHEDPatO-Exb6ya6_aMJpiLBIo-Cy79Xd2eg>
    <xmx:dIQlZMNcy1vHJY4SFztss3_kgJuvXcLJFlAQRji3CYLyBywtVQpPow>
    <xmx:dIQlZF919aSWK0B1wpdYR554vnpmpaEyYGTJWdz5YHz4Z_tGxI0E_g>
    <xmx:dIQlZCHEQDfPb0drdQrBGKV1QusalwqW_657FjVqMdRQqJPbiF7A1g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6CC68B60089; Thu, 30 Mar 2023 08:45:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <242a5400-b5e6-4707-af88-1d695e114f78@app.fastmail.com>
In-Reply-To: <20230330114242.GC434339@google.com>
References: <20230320152319.665592-1-loic.poulain@linaro.org>
 <20230330114242.GC434339@google.com>
Date:   Thu, 30 Mar 2023 14:45:18 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Loic Poulain" <loic.poulain@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 13:42, Lee Jones wrote:
> On Mon, 20 Mar 2023, Loic Poulain wrote:
>
>> Use of_io_request_and_map() instead of of_iomap() so that the
>> region is reserved and protected, i.e reported in /proc/iomem
>> and not accessible from user side (CONFIG_IO_STRICT_DEVMEM).
>>
>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>> ---
>>  drivers/mfd/syscon.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
>> index bdb2ce7ff03b..7e6d4edda118 100644
>> --- a/drivers/mfd/syscon.c
>> +++ b/drivers/mfd/syscon.c
>> @@ -60,7 +60,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>>  		goto err_map;
>>  	}
>>
>> -	base = of_iomap(np, 0);
>> +	base = of_io_request_and_map(np, 0, NULL);
>>  	if (!base) {
>>  		ret = -ENOMEM;
>>  		goto err_map;
>
> Looks sane though.
>
> Arnd, do you have an opinion?

Thanks for pinging me. I would indeed expect this to cause
problems, as syscon mappings are likely to be used in a way
that is not entirely clean, with other devices defining
overlapping ranges.

For any other driver, the change makes a lot of sense after
checking the DT file, but for syscon in particular I don't
think it's even realistic to check all users.

     Arnd
