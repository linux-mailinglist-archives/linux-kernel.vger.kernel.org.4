Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F31677E83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjAWO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAWO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:57:43 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9039745;
        Mon, 23 Jan 2023 06:57:42 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A15994E5;
        Mon, 23 Jan 2023 14:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A15994E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674485861; bh=TY29G+ev4y9tcF73dUPFSmkzhA0XuNgyUeAQxw1JoY4=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Nt+tAeWTW1qZEuwXjwFIoAZFkbR3fCm8VtNQqLoG6nX9D+JzYGh7ZhRZxXfjF6aVT
         IEYpuTbKkmHtfvFvMspY6OIv0htyn+73ES4ZDTTzsXamEccFYCmhSp+w0zzZPSmogr
         xBG1CRjxbm1f/DwJLZBHHlCF9JMQL6HTWEHBHSt/vryPOzj58Iwmjg0bjDDwGP81hZ
         3qCKjYZfEeu8kWXKed7nhLitjDgC3R0OHQJHAdWeLEMrdi0Gegu59z9DYioQFeiqp4
         NLovDDXBCuS6GlH4YIEERD8HLtC98bneVyOOvzGQYVjSPoBPAKF/0sxSD2jrpOmBLR
         CKVId8FOUEvOQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: rv: Fix full name of the GPL
In-Reply-To: <2983169.1Ym2AYXvDY@prancing-pony>
References: <20230122181224.53996-1-didi.debian@cknow.org>
 <111677351.cJcasWOL3y@prancing-pony>
 <c9d6291f-8b50-bd37-f48c-d96834d990dd@gmail.com>
 <2983169.1Ym2AYXvDY@prancing-pony>
Date:   Mon, 23 Jan 2023 07:57:40 -0700
Message-ID: <878rhtl2mz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diederik de Haas <didi.debian@cknow.org> writes:

> On Monday, 23 January 2023 14:51:57 CET Bagas Sanjaya wrote:
>> > Please disregard this patch.
>> > I'm now sending a similar response as I'm sending to my other patch
>> > submissions, which is the following:
>> > 
>> > I now consider my initial view of the issue as a spelling error,
>> > incorrect. I would be changing the license and IANAL. I'm also not the
>> > copyright holder which I believe is needed to change the license.
>> > 
>> > Apologies for the noise.
>> 
>> Glad to reply, but I see your reply above as if it is written by
>> a bot. Care to vary your sentences?
>
> I already got a bounce as I am now considered a spammer :-/

No, I don't think anybody sees you as that.  Please do not worry about
Bagas; he is fond of unnecessarily picking holes in the work of others.

> So now I got to figure out how to fix this clusterfsck, without being seen as
> a spammer/bot, while also trying to minimize the burden on others.

You tried a fix which, as was pointed out, was not the right direction.
Just drop it and move onto your next contribution, and all will be well.

Thanks,

jon
