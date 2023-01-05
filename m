Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736465E910
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjAEKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjAEKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:34:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1D2014;
        Thu,  5 Jan 2023 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672914679; bh=HdTaM69YzlM7AWTFyHXLA1zjDBcCzf/dJ1df7pUtA/k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RXTvGhBnhOsZEJOiek0QbgAawv2ugUNvjAp/Y1+lP9ebOptf9YrENXHWSZQRoWiuN
         DBgX/+oWDob8rhh1P7qLN16NE9s6xXS/sC7Rnd7QGk8qS5vKbY36ClWTiOwqvGIDUe
         38PJGWl5xFCU4mDQVzHFuu07/GnG11zhF6fcg5LtB3qf6m8C0RisBPjIEpOSAtm36g
         LlQ6nXOQRBeirG3OqBZoUDxAKm5cE/FZ5mx1o374j16yKl8OpH2tWEgQdiQTrp76eb
         7mRwS4JR8io0jLdvDvSOMHwiOxAxu4bNqN3VMOacwcNCdY6LHWS5vxiAUBBaGbwZ88
         mB6QnrOFQ82OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.173.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1p8igv3HSV-005KA5; Thu, 05
 Jan 2023 11:31:18 +0100
Message-ID: <ed7a65bb-f521-e5a5-85eb-0f24b023421b@gmx.de>
Date:   Thu, 5 Jan 2023 11:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] fbdev fixes for v6.2-rc3
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <Y7aGw/irynC61O85@ls3530>
 <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAKMK7uEnFBo_YfU8OTvMS8+YkoGS=vmpGQPMa9PKxGOB3pd7nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vP4qg4Ik2xnHi9jKgGd7IyG0tMSl/rKMrdlhpkkF4WKn94KVpl7
 AidKo+tAbMC5shZXoITBMNCJ3aEWzPY0DEVApA6mj1lhpaDWgkeGdbz7PQ8R6z+jHK788qP
 PUP5FpjrAFOksi6//oVXlUJUz7Pki4XBF7A4UjEk3O4yLmw1cf/4aUOI/iVZO+UNU3IfBj1
 C/92kRV1UM+wW2+OtwGCg==
UI-OutboundReport: notjunk:1;M01:P0:JKWTuPJdwUo=;76xy/qSTu3Q8WMlQ9AIUR0ckxBy
 1JvLVdlUcX2Tzq2k5NOvR6fKfIlbBlfTJ1vzpHAhpD6G2pC4MkBJfZw5HQj6jFLO8Wz60ctT3
 0E+SpPCC65G65hWl/k2roZ03uk7h+tfM8s0db8ynyrQ1F6vFR+SkQ0cK7wVgpSbMgsrDY5YpG
 yz4xiEH6s51mq7jpJw743aQNk2LBMShrYSk8LhyzOTNJFoattXtVV6DkiapnoS6hI/sCBf/VD
 0Q1Nz2MqoKvmZ6OeEkkPH1WUL2SsmsojHevh3F0tbfjQcgvNSF+i6QyAC98AYmf62of1fwvrd
 so8XE/tX6Ae6mm0xEoNvBW4UhbyF7vWloBEgzASFWA1ZzmaXNxfZSbxXw3nDoQd+Env+R9GdF
 nZHsuTmJjcWPkMqBXgfDAG2AZsl4hgn6h+wBEGQwXpnwN1pkKWlEFCHWuP6CkQ3pGtwQQbZDU
 /UMXw1ixmzkTxtpezMd3wfsBHXu3abfuVuKWPEUZnQ5VfCGQ4vEXDm5C2NPl4QWYJChOMCQaM
 2qcWTiSt5b0deo6MIVJ6M/l3gOjmh8DE7+4T/FmsqP0NKNK+CjkOxPY5NJb3I6xGKrUmhmnpL
 vjCS2erU0RoYmF+xvQqzWOaC3ELnDdB/FBqHQUE8WKBSda1HPZSWaT+RZ7DPCfRVJFEWqsKTz
 rcM7PTNgSv5jt+DidbgUF2KOOXDSzkQg0u419GMVR3VHXHM2qpNDHsHoTL19x2n+SbU5wxI9L
 fppl2XVAD3+sNTdF9bW51RyUmHdI6Y+ERh6kpIWg+etNEk5IZssvje0nVYFAE9jFhIJrnJXeA
 rxx0JxPLYyYBAwEt772EyMd6KTos7EfhgKjwTL2D+IbR+ZiIaAjKyPbgrbu2/U5TFZN1+uom9
 7M3TYZDyPXD2mkneLj+X0fl80uCERzaInhFfwcLuyv4QZs+FWGAHuxJUvArlaYFhgX0SVS2iu
 i3oLFPcBYE4vunUEjepTHhmOC/s=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 11:22, Daniel Vetter wrote:
> On Thu, 5 Jan 2023 at 09:14, Helge Deller <deller@gmx.de> wrote:
>>
>> Hi Linus,
>>
>> please pull the fbdev driver updates for 6.2-rc3, to receive
>> fixes for matroxfb, offb, omapfb and fbmem.
>>
>> Thanks,
>> Helge
>>
>> ----
>>
>> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e=
71c2:
>>
>>    Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>>
>> are available in the Git repository at:
>>
>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.gi=
t tags/fbdev-for-6.2-rc3
>>
>> for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854be=
:
>>
>>    fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +01=
00)
>>
>> ----------------------------------------------------------------
>> fbdev updates for kernel 6.2-rc3:
>>
>> - Fix Matrox G200eW initialization failure
>> - Fix build failure of offb driver when built as module
>> - Optimize stack usage in omapfb
>> - Prevent use-after-free in fbmem
>>
>> ----------------------------------------------------------------
>> Arnd Bergmann (1):
>>        fbdev: omapfb: avoid stack overflow warning
>>
>> Hang Zhang (1):
>>        fbdev: fbmem: prevent potential use-after-free issues with conso=
le_lock()
>
> I looked at this, and even by fbdev locking standards this makes
> absolutely no sense to me. I think this should be dropped before we've
> reached some sort of conclusion on what is going on, or whether this
> is just pure static checker conjecture without fully understanding how
> this is supposed to work really.
> -Daniel

Sure.

I'll send a new pull request where this patch is dropped.

Thanks!
Helge


>
>> Paul Menzel (1):
>>        fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB
>>
>> Randy Dunlap (1):
>>        fbdev: make offb driver tristate
>>
>> Xu Panda (2):
>>        fbdev: omapfb: use strscpy() to instead of strncpy()
>>        fbdev: atyfb: use strscpy() to instead of strncpy()
>>
>>   drivers/video/fbdev/Kconfig                |  4 ++--
>>   drivers/video/fbdev/aty/atyfb_base.c       |  3 +--
>>   drivers/video/fbdev/core/fbmem.c           |  2 ++
>>   drivers/video/fbdev/matrox/matroxfb_base.c |  4 ++--
>>   drivers/video/fbdev/omap/omapfb_main.c     |  5 ++---
>>   drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++++++---=
-------
>>   6 files changed, 27 insertions(+), 19 deletions(-)
>
>
>

