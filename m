Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE35F74A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJGHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJGHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:23:45 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2B0C0687
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665127420; bh=cy8Ct/zdox6eTUJMOHbh6Xzw2LPW+jh13NnxIrEHTvg=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Date;
        b=RlUSM52lItw06NOqdpKooSfspkpm/6yFMNDHV4hSpVW6NBMR4AaXnIlLy08sysUJ4
         y+m+qCGHWRC/XnR06yPZG2ZXa15ImEWgT7LCr1McUBf6i3Q54TnL0K2xRcAPkYbV1P
         AeSPCDt3OBL8sN8znwsWs7AMef8NtHIVXU8ZSyox2idLQmiiH7f6HjOMwtYwChFq7l
         gieHHvjnvaYIoob44Csr+/KahQffaM4GFLCYJWplIG4pRZ/ILXTircApZ4B/zN5Etk
         yGEKUBQ5x7NXpfuu6CBoBxIugMbX+mMZOSjEitZ4rO7jqWBm1Bz0Yw1lDbIMK+PTiL
         YyKCap3s6o2rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14pE-1pLmj825rG-012hb6 for
 <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:23:40 +0200
Message-ID: <5c0092d617625a2acaf72c1f623b7349a1d666a8.camel@web.de>
Subject: Re: [git pull] drm for 6.1-rc1
From:   Bert Karwatzki <spasswolf@web.de>
Reply-To: torvalds@linux-foundation.org
To:     linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 09:23:40 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:PpN28fbZWf1Hr5iyq6MizhiVGmEQnylCyJtNM9iOQlhWkcA2ZNn
 WXi6qAzjMRXFUX40nyXcDiye4x3qrjg22pKNvjtP/won5iMYvgcTh1zfLIo2Ay//TjGmM73
 8ajBfC8Fw5ZqL1CfQn0fOst4fEYLWKef094irYIIuFN0LS9Z1CTwhTdWE3hLbkdVBRu03hj
 PgVXb2CUUFMdHHmf7Aucg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJvDvEFDw50=:zEzE/5zpgyBUB2cgGOp/xw
 HdcufCieJGdv+Icvn+TsJZeNP0NaDOCxAhrrt+PctJjrPrezcF5Q0QOynbHGgJ8PWAN3hqCUF
 q6gWLkXTTcoJnlT7DeS9KW9gas6v3uGOpzisqiQ3jssHzlHAIVv/UeTZ/mqQ2uu2UTeSUZUyv
 clLoMhfFyLWkXGqTN9AbsoK0U9TBT/8CzYUuUspM/daVrVkw8XedeDjBhkg04tWPHs+qh2x4I
 GPHh7ac7GWkcNpVAFfHcWxahgUj/aGhIchK9fy0Nd7Nt6U3jmpgH+ALL+WDqZSFsbMqeIqTkF
 bz9diCKKZBhnlTZfPo4N4Untm2xKPoIiYZpg3G68eW79sn9EIva/A+D9MTg9heqKRyrNa0HYp
 HXFD7eAWoGjYBF/QRKXzWCOWV7udL5Fx2+dAG5kgjWt0sEbIG9CM50+zXb56kE52b3yrDEMo4
 zpkSlBLFc+crAmb1OCyRQZjt6I/bPXAMgKs4QHWsG5jOaiQKwZJfiHbvicwVPIn44ia3xtSNW
 lZXCqZ4/7GceEx2yW72Z8CHD+IKiHUK5l7dcgJiGXrl3ya0dQmYWSQLvCn/yrhl18qLKIxgAo
 H6qlD0RpcvVIdLjuFIuCAbs2FX1IazzgpMpyGrxNIbw02e2EkZbCrw752siMFJFHKNGk0Fwp8
 9lK2e2U+t/ADTdT4y/GJ+84RPNDr/FqLIcC9I0NyrvByOWRpQAHtu+S2JY/GDeKqqv25Gjp6J
 Z4jaD6DYAV42/cqG7CtwXh6CAwdA0XjKSjdIvvY09aBEeO6+nCRkK6O8rrKxQOrOc4E9LhRER
 Ms6jVyyazXPwfkmWSWYfZQDrwvQANl4hkqPy0tj8aTsYz6Dt1tCchg2VCMTGJhq6FmcxT8OBx
 LZuvBqngkWNXlbfjTJPMz+Fai2Bu7MZ+FCYE4w0bBHxe4CVO63yUMmIzqrg4ogMgwnTxAD35i
 VL+WO1yrjfAS90NCXgX9mMz75BpZs/+Cm/WkdBYlZY2oO9zT1iCwzAzRSZmE6xRt0A6igS9ha
 d+bEwV1Md20wm44jJ5MP9eqsWYF0Fvg9kqaskSH2Guaq4vI6iYhJKtnkJ6EWM7qWrYyh5QhoI
 N/ZbVZh+EhWiW+DGJUBmZL5LYkPTEa2VxzZ/3ULRThXvcVzkFNbt6ewduB5exeBnn+AvXoUtT
 zmsjXXwb4z67CIQ7W0mPXAFtA4CQmqSn1xIOHT+5BFVXxkIkG8MFTltDp41Yi/ms/Ku+jCVNi
 X8m5JEnjJDRM7Y+tIT5kfQiF6YIKD8tmj9lyMzi4F/nRiIwwsb2vBPNNNdHnhgKF1sWxcFt4i
 mhPsR+ELC9MJXNMc2f930kI1thS9Uja6c0E/1aksyzzJoi+Nvqa/V8xwr/jDFoYmcWshoXRTe
 oSAMpsd9L2awBPXs3Cgzm2SYybkgTmbRY2Zma1HCEzs4nSHEFkS/lu1qJwB/tCg3zn7xrr3kh
 jafbKpGHAiI4WDnHvGTzx4SvuH2ePbOETzPdqWKqpYpkqeyR7+uvNdbGYP0kLkAuLp0ikvuAB
 f5G5p4Z/rhcz0S5upHbJRC9FcLcwy6G7LxbGAmsvmv8Tj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 3:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>=20
> On Thu, Oct 6, 2022 at 12:28 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >=20
> > Maybe you are seeing this which is an issue with GPU TLB flushe
> > which
> > is kind of sporadic:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/2113
>=20
> Well, that seems to be 5.19, and while timing changes (or whatever
> other software updates) could have made it start trigger, this
>
> machine
> has been pretty solid otgerwise.
>=20
> > Are you seeing any GPU page faults in your kernel log?
>=20
> Nothing even remotely like that "no-retry page fault" in that issue
> report. Of course, if it happens just before the whole thing locks
> up...

There's also this issue with the drm scheduler which causes a lockup
without messages (but with a flashing capslock LED). Going back to
checking the finished fence solves this for me on this device:
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
https://gitlab.freedesktop.org/drm/amd/-/issues/2179



