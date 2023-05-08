Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66076FB5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEHRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEHRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:19:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1659C6;
        Mon,  8 May 2023 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683566322; i=rwarsow@gmx.de;
        bh=3GwddkUaT4egiNG9XI3JLy/NEDDtzwWlfimW2nnXp4Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DFX3eJ1rpUiWgu2TrazWs/88qv9qRVy3dyScvUxdlzSQ87L4y+VSH4ClKHnqir09R
         rZ3Gf6q/LHyC6Y4ZhbdosLl059WXb5/O30JUGkDvm439UVUGja8ouz0VHz8lA2fJnJ
         iM7ZAcDFJwlkvjMfz4LrUYSQ1cbZeYlEOUTX10efDKX3ytUfWVylcz+8/R0LnuZfzz
         n+sGOVP/ymfF36li90agtkRrwbojhHUSs+6yyheYZCN6ztbQvRWsneLGC9qDWXZ1ut
         t4LpSx5PgH5qIdXSxf2hrSBUlac0mePtC1JM6/z4UsyempZaUAHXpWsUE986s6V+NC
         VLRLflPYtLgZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1pyWGw3hqF-00GFL3; Mon, 08
 May 2023 19:18:41 +0200
Message-ID: <62ab5732-4748-d326-231f-a5c86c4e5352@gmx.de>
Date:   Mon, 8 May 2023 19:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: no sha256sum for 6.3.1 (was Re: Linux 6.3.1)
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
 <2023050617-stardom-granola-32e3@gregkh>
 <20230508-length-distress-784870@meerkat>
Content-Language: de-DE, en-US
From:   Ronald Warsow <rwarsow@gmx.de>
In-Reply-To: <20230508-length-distress-784870@meerkat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C7qJcLe54/x1Blu/2f8fgnKaeeKVS8I0PYDo5ryKRsja4RS92dv
 /Mnu2wIJALRUhKfSjBVlE/x8wVnNhsGlDRhAW801wPoDzV8AfEJ3MMcgXyGAfkDsnS9t0A2
 QO/2buSefD9kFOM6zWedk3FIPiAxc7pHiS4L6m3c0+gOwn9Ja5SEoQ8zhT6w0jw7pNBFBe8
 q84SzVIY4n3lgNhRC5jbg==
UI-OutboundReport: notjunk:1;M01:P0:OG/KU/ozn4k=;h1ibpqppYdmMEqO+MCWJ2m5YMei
 8hwDWBLriz+7QGPlnRRzLNHRR/NJxuPLjAr2saNiPOBNvdFJt9OEAx3F2qBK3p0+PRDqQiOnv
 NtkX+1+Sb9JEulEwuwgT6BiDZhjDbFfKnr4zzGlZVgJl7f/KhQqz8/meBuzLUZhZcLN13HHBJ
 XBFVQ5OEQCZO6BXadGsMUOHmTY2ZOcqScPIpiyNVSRMAWj9bXlhNUK4u2seQx+WxQD9HJKsM9
 3RrRq7pbsPC1tS56aGBxNaFK/AHrJ2LH6NsDMW9KRXpGuodR/++Q7l4AWITZvBRQaROmeGuhN
 ZQ2CLMBIBA0NVmjsvL6O3vNQOYGDDxFtPLD5KX3yX2s2IZgHS2515Jz6XnMtzYVal0xA7UoMK
 20MaW/3TiSjM48Gbp17uHm0auBF163cZzOHQqWOV3Q5GeHrpGtKvvtVyg5D0FEaWrvPAytBeX
 hVRtmhPjk2Myb6yLOXnXGVvrmhZQe/eul4DAAQ3L4tVDLvANGNB/0stXuHNP+hDAwDr8eTHlz
 7D0uMXVZbq6dxpWlQEsFZmEm+F+K0YJTQoReZqVai8LQBUP+/S45i2ffPXIpCx1+0CTf5M9SO
 UFagCBS7/vW6CZpw5psrt+R/Y/AXe6whUXVAuNARBOiunoQUWFKZPtAnUziaLgoyFCkU0Cit3
 DonrNWGIZb8Brz0mx1C7jx43uxqDrHuxs9YE3/1AHAmuqnhi26pWuuonwXLOSU1bUR1ehdTaL
 ErWX5Qs6X+XSzNHzJhhzmk4b6/nB5kuKYGQ2lFeqzbLvdM82k2dt1NBjGA8WHhssfupP115Qx
 n2E+8mfnlzjSKVBrT2jL0yqq4tKU+TWDyRAp/v+MGulDXneq8h9p8RX9BX8HSqi5P5LnnwAud
 ddyR6kaPFEwe0ChBS5qwvESeGZPAfvQ5A1eb5c9gZNlEHz3gzuTtKjAkdFNP+8rIHAjdz8Bc0
 aukLqowqohcnwebS6EQzAnGQhcc=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.23 19:01, Konstantin Ryabitsev wrote:
> On Sat, May 06, 2023 at 09:38:35AM +0900, Greg KH wrote:
>>> fetching new kernels via script:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.gi=
t/tree/get-verified-tarball
>>>
>>> it seems
>>> https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc
>>>
>>> doesn't contain a hash for 6.3.1
>>
>> Yeah, that does look odd.
>>
>> Konstantin, I think you said you updated some things on the servers
>> right after I did the 6.3.1 release, would this have caused the
>> signature to not be recorded in this file?
>
> Sorry, this got fixed last week. I forgot to mount the key storage after=
 the
> final reboot. It should be all good now.
>
> -K

Thanks
=2D-
Ronald

