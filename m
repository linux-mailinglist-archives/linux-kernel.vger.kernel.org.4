Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC26348F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiKVVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiKVVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:10:55 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2E7CB97
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6dPZRBVDncbKAsAtZalrSR3psk0nbnHpzr/Zu2o2Hjk=; b=qTSmc/SW3xqZ589OMJfYmo5pJ2
        xArLSRGgxN5wsCIwQy4C1WqaM6Vn4I2woblv063J2ZBcP8gMHO2k8q6sREtBFOQR6fc8NlgmElRNp
        FntXusr9FdKXS5AfbxqJd5tihS0xWzbRWfnBDzahzUSQC1FbMswKwrsIbPnGk06+00ziSUvTZhjaD
        Xt+cho0dYgxAulC3lhsAzKo+1Cx3RUYlKPCLGjd1pixKT33T98F1QKFSG4G/s4n0LaXv5hsswJF6/
        UvO5jb6eVTFwygXgREOe/ir9e2A0ODyPQNwItq0194r1+HrpneYy9INB92cFcr2OR36n2kFgRO+N7
        xLKjSRsw==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=62028)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oxaXa-0006jg-5j; Tue, 22 Nov 2022 22:10:50 +0100
Message-ID: <182643db-e5f4-2277-a971-0f159849dadf@tronnes.org>
Date:   Tue, 22 Nov 2022 22:10:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git send-email friendly smtp provider anyone?
To:     dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <20221121151922.jaal6ym7z2ejju4q@houat>
 <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
 <20221122155122.edxtmsqpjxgj4dsj@meerkat.local>
 <3b06dfd5-0eb4-dbfc-6ba8-077b1a92865b@tronnes.org>
 <20221122185001.q6hmeblp64jqdzvz@meerkat.local>
 <02bc2442-e3b3-d720-9d13-ffcdfd760fb8@tronnes.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <02bc2442-e3b3-d720-9d13-ffcdfd760fb8@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 22.11.2022 20.22, skrev Noralf Trønnes:
> 
> 
> Den 22.11.2022 19.50, skrev Konstantin Ryabitsev:
>> On Tue, Nov 22, 2022 at 06:42:19PM +0100, Noralf Trønnes wrote:
>>> The first thing that strikes me is that everyone mentioned in one of the
>>> patches get the entire patchset, even stable@vger.kernel.org (cc'ed in a
>>> fixes patch). The first patch touches a core file and as a result a few
>>> drivers, so I've cc'ed the driver maintainers in that patch, but now
>>> they get the entire patchset where 5 of 6 patches is about a driver that
>>> I maintain. So from their point of view, they see a patchset about a
>>> driver they don't care about and a patch touching a core file, but from
>>> the subject it's not apparent that it touches their driver. I'm afraid
>>> that this might result in none of them looking at that patch. In this
>>> particular case it's not that important, but in another case it might be.
>>
>> I did some (unscientific) polling among kernel maintainers and, by a vast
>> margin, they always prefer to receive the entire series instead of
>> cherry-picked patches -- having the entire series helps provide important
>> context for the change they are looking at.
>>
>> So, this is deliberate and, for now at least, not configurable. Unless you're
>> sending 100+ patch series, I doubt anyone will have any problem with receiving
>> the whole series instead of individual patches.
>>
>>> As for the setting up the web endpoint, should I just follow the b4 docs
>>> on that?
>>>
>>> I use b4 version 0.10.1, is that recent enough?
>>
>> Yes. There will be a 0.10.2 in the near future, but the incoming fixes
>> shouldn't make much difference for the b4 send code.
>>
> 
> This is what I got:
> 
> $ b4 send --web-auth-verify <challenge string from email>
> Signing challenge
> Submitting verification to https://lkml.kernel.org/_b4_submit
> Traceback (most recent call last):
>   File "/home/pi/.local/bin/b4", line 8, in <module>
>     sys.exit(cmd())
>   File "/home/pi/.local/lib/python3.10/site-packages/b4/command.py",
> line 341, in cmd
>     cmdargs.func(cmdargs)
>   File "/home/pi/.local/lib/python3.10/site-packages/b4/command.py",
> line 86, in cmd_send
>     b4.ez.cmd_send(cmdargs)
>   File "/home/pi/.local/lib/python3.10/site-packages/b4/ez.py", line
> 1102, in cmd_send
>     auth_verify(cmdargs)
>   File "/home/pi/.local/lib/python3.10/site-packages/b4/ez.py", line
> 188, in auth_verify
>     res = ses.post(endpoint, json=req)
>   File "/usr/lib/python3/dist-packages/requests/sessions.py", line 590,
> in post
>     return self.request('POST', url, data=data, json=json, **kwargs)
>   File "/usr/lib/python3/dist-packages/requests/sessions.py", line 528,
> in request
>     prep = self.prepare_request(req)
>   File "/usr/lib/python3/dist-packages/requests/sessions.py", line 456,
> in prepare_request
>     p.prepare(
>   File "/usr/lib/python3/dist-packages/requests/models.py", line 319, in
> prepare
>     self.prepare_body(data, files, json)
>   File "/usr/lib/python3/dist-packages/requests/models.py", line 469, in
> prepare_body
>     body = complexjson.dumps(json)
>   File "/usr/lib/python3.10/json/__init__.py", line 231, in dumps
>     return _default_encoder.encode(obj)
>   File "/usr/lib/python3.10/json/encoder.py", line 199, in encode
>     chunks = self.iterencode(o, _one_shot=True)
>   File "/usr/lib/python3.10/json/encoder.py", line 257, in iterencode
>     return _iterencode(o, 0)
>   File "/usr/lib/python3.10/json/encoder.py", line 179, in default
>     raise TypeError(f'Object of type {o.__class__.__name__} '
> TypeError: Object of type bytes is not JSON serializable
> 

Konstantin found a workaround, so I was able to push the patches.

Here's the result if anyone is interested in seeing the result of using
b4 and the web endpoint:
https://lore.kernel.org/dri-devel/20221122-gud-shadow-plane-v1-0-9de3afa3383e@tronnes.org/

Patchwork gave me a new submitter ID:
https://patchwork.freedesktop.org/series/111222/

Noralf.
