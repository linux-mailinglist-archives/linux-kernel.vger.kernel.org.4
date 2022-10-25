Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00660CCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiJYNCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiJYNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:01:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47696DAFB;
        Tue, 25 Oct 2022 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666702811;
        bh=wsDhwFYF2ypw9VCnpe60sIBdnr/nisSCe9ukcSaSRJc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HeBGreJuEr0HxgZjQSTleJuyFSwNYqu58sCfGzb0FtLR/c6HqBEXAqs9qHeNp4ur/
         lftOHiS0chQj7YchcW10fjb6r5f5Zk1pzZriv/gV2GY6Zhv4mcXaNDy00v21c1qoJF
         mHAP0MEO3dO8w/2F25tUY1tBkJWJGVUWV5xMGXhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.173.118]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1omUSO0PND-000wT2; Tue, 25
 Oct 2022 15:00:11 +0200
Message-ID: <d8ece597-33a1-fa9e-919c-e366baf429a8@gmx.de>
Date:   Tue, 25 Oct 2022 15:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] video: fbdev: sis: use explicitly signed char
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20221024162901.535972-1-Jason@zx2c4.com>
 <ec8edb92-a21b-6291-4275-d7cba97d7ad7@gmx.de>
 <CAHmME9r=E=sUEU0_thtrj6agd_8YbTVUm2fEsErGKM-ff6y03w@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHmME9r=E=sUEU0_thtrj6agd_8YbTVUm2fEsErGKM-ff6y03w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3jd4/zuW7A1CY/7wnyvEZTEZ75iH/CycOOhyBADdI+VYatFG8BU
 r8yAOfCMJXTYpe8IB05uMf0a5Pg/TfTvUipZsO1vqgDPGvkmVVIJrJT89JdX3H8NDL7u/Ol
 OFDiAy0ITEF1G+3zCOAUCK3rRcG9kuCi4h0Gl/yW6IdavWS9LJhHVgsOlUUz0BtpkqStzeF
 SZVVS2Vp1qxaKVl4DX8eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p9RwJudlmmI=:P8aM+/cDAX+TuByCTv6svH
 rGu5tv79wQt9hOXjkhmD7vBtcHcWwPR+InAILrrdho5rXzIqdk80MBXWSJUJ8etARgqHPIWHG
 3AbvJsXolUzL2qUb9NqrlXM5AdIsr4ggGtABPN2nwA7ZZ7hbcKDtlV+rZGhl4QB11/+5cMl4C
 i3YUnEnVcNYag23c/lozSIiQPyKVIBwv6IoF0H49JGtN6jDgs2wwgyhl8Y2r15PLvo3tQUJiQ
 9Pt1zgIpfQlcjjfgt4aycCpe66uYMCXQeos8LJSZYGTYaA8IW4bM7fRLp3BUuqV3finMlLV75
 xVgsCs7uwq/Ev5Z/ECDkJFpU1gCwwYSk1g+Md7Kzz2Ow0Q9i+aBLnN5WEP2vqPJ+YkRr041pe
 DQTCLKwNkkUG4sgStm583HtxhCB2hk3RTeDUBPlXCAKXHjrz9JPzGQ6snn1Ck3MpK6VaHJ2VP
 lOMHlpHtL3ZHANwmTHa4GcBNySu5UAhGGKmqZP2/rTXL3QoQveXaoayEotjaO4uv5TtB9BZmH
 cdXOceDmwXggpM8UR6RbfhhVHfg7p3XtERF1oj5SJnxy9xaQBLK+n+GoldiIt34RA5SH42/Gq
 eN/UxC0dXMuFOkVa05Bk1XFfxWG40LVJI8TcqXSsH25yF3jfBZTIOWwrkfzzO4nOGdLlsDg3B
 JdfaxEyv8bX+mHTSZJp3qKI8NLGQdN9hUbirr0+eNbx735C6w58smWNoCZ8DcGpkiZmDQ2XJ9
 lqewWxcnwGYKJ2NK1r86oGr1l7rKr5eeNhrM6FZltFKKCkAwRd941SVGjLqcuNG2oZinqM1jv
 HU2EJjyz/tkRqiWLQWZ5kHQ7mWD5e0uvVCZhgfqid6eYp0jo49lAJgD3/GEoXroRD44ZfGJ0k
 558ZJnCPNpLPi3IEZsLEGWJaYs8vsSXGQr5zMnlqQ5rjw9P5bpxgVyZhhnWiGYLlQgwxaiSYQ
 o6ewWdullqeQN4FrYSannHJqek/cMU6cUjA28ragWGpyWvc+Eua0PnN2MkSg0hO+Tbv5UemJT
 Jbc/6DY++byRPGnoRhxIHCsKCnilI9kpcCD7n1EkqP1DfXOsm2zwZqBir+/z9kXo24abFjfm0
 v758+kY2PE0m8Ot0S7aSsrQSENaCKoLTsO+83cyzDZZROCqdiuUezkphn3sc/VWSX+4J2Smpm
 M7rJbnhPyfXz+uZslPfQ2pLwljUoCS02T8AHn8RaIHMFD0zc5GEJbBf9hh0svO4z9TFUqGwbn
 H9sn6sTeHAMjAlRvye9WBFjpEERlmltbvkFGAJ2r5KIEEsZ56+4zXjpdIxB1ABkJPh3ulBcnQ
 RiDdVgeKDItVxDvhaBQSlbZ69ZHvpXEqcHnZ4h+cQEXdm3kSzGK8HBA6dKneskrEQFw7NzSLi
 9ySJ8pbcn+ZNLxwNOmC6KhM884NAzFTituKMbXaEhCHdGy8u3/iX2vF9Cz9I9l8cuuhrfylIz
 CeJESdJgEA5qkhLI4O4Kk/Kh6lxyw6cWynkuBhXYRF55FbCTaTbsqpB95RqZMrWc8lSg71jSe
 44/Ta6HzDDmep0aznGk+xnkihgK+f4wdDYl3yf3uIsHG6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 14:55, Jason A. Donenfeld wrote:
> On Mon, Oct 24, 2022 at 8:29 PM Helge Deller <deller@gmx.de> wrote:
>>
>> On 10/24/22 18:29, Jason A. Donenfeld wrote:
>>> With char becoming unsigned by default, and with `char` alone being
>>> ambiguous and based on architecture, signed chars need to be marked
>>> explicitly as such. This fixes warnings like:
>>>
>>> drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS=
_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
>>>
>>> Cc: Thomas Winischhofer <thomas@winischhofer.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Helge Deller <deller@gmx.de>
>>> Cc: linux-usb@vger.kernel.org
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>
>> Applied to linux-fbdev git tree.
>
> For 6.1 as a fix, right? Since this is already broken on, e.g., ARM.

Yes.

Helge

