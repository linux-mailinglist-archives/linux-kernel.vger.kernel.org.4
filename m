Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1E662496
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjAILs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjAILsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:48:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9B13CE6;
        Mon,  9 Jan 2023 03:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673264884; bh=KMpl6S7lSlaZ+5yiGcgsKsmplZZc72cQt2PocMHQQ+4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ov7smU7fXXKmFQoWUwHLOAWagAYM5bIaeNpOmiTlHt6/mVfHHZUWSpGW2dWgJuTm1
         2e9fncUjJgCKiFctLNlNTrffN14v+9eaGtdH/X1idaawabbkj5LKuLgCyHa5Tqy/yy
         hPJHN8uR3PEZfKB2obxabQWnuP+RaZRwlKPr6jRaHhFyXM+PRLgXZ/lRnBz51fpza5
         +71eoygdGDXp1XbA0K8WjeL5mNGke9MVb4VLxQ4t5Bo5A/izIDIE2c88p6eW7M4HqD
         rMeGQj83JoWzXMt5lEExViIN0cfEybOck4TFy30QjluwLbarKr01MA4esMu78GKDDW
         RSEOOXe5b2N6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.168.5]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1oxaMc1YU2-00scLO; Mon, 09
 Jan 2023 12:48:04 +0100
Message-ID: <70764773-ee94-869c-4a08-1810789db2e9@gmx.de>
Date:   Mon, 9 Jan 2023 12:48:03 +0100
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
 <CAKMK7uFijjF+px9=xDXnyfhMbkxRqinEmV_N5VX6eAuJkc1J+g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAKMK7uFijjF+px9=xDXnyfhMbkxRqinEmV_N5VX6eAuJkc1J+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7aq0ObGspn1cqOYLuC2y4ZriMmnTdLAEMWFlnaY/QM58ZVYQ6M
 A+aUfYHOCxB7lFAySs07SCH8Hr5NJWFT7zI6wf0j69XuWHF53+1+SBw3X1D0R53sTATNBTn
 KxXaPaADOP+wm516nefSSazg8X/cMGsNeK7JNoRHdXYrgRN/TAOvrdS7fqB1F4/lHhY6wJp
 gGqkmZsTyQUuX5nhZR2vw==
UI-OutboundReport: notjunk:1;M01:P0:FjDXyeR7/1w=;Rlzm8dWnWnIv3YtmsaxjocevHWg
 fCWo6dlP/N48kxqGGgj9hR3OYxO2H/9DXDo7FuYfOp/ZCUP9VrgUvBbFJq0eZICVlJO01IXE+
 4/7edylkI65qOWI+YFjoc0Okq+YOs2UzMW3IaRvST+MriyM8tAOmFHpgGwhy3FdiAhXXOK+sX
 kO6oyy92vxxREwhC2Kn9CiVMBoDRfbvvD4bTNOgNVxEF6Vt+ILEfQdQHLDowtoI4BPv9fHR4M
 gmlHAY7Q0WVlmjsWZXBLP1t0eDu07JZ6CBbKJWIaoE5Xq54DOSesNI0Pvl6UVJpdiR1qfz3I6
 VE3OKMY8efXD2W/j26LTUztGm+Z/7FXDdNW4HFXaUMUt37yvIHVMpoixby6LywH6KvcYwSVXQ
 ShIedViIod5HjPvakiBF91+aiNCBtGDlmFC+uPv2/haY8G/YvOwcFBn9KyMx0rA+Sv044njcp
 yE3a/XFA0SV75NmysttRRsDkC+k7hZFM667iX0hBPbETtBFutAbJAjo9kKp7HmzC+ihK2WjiR
 yOThRYxAgXiWgJgzP9vAPa4iPKVGpAuMDeTSThxC4N9TNHTqyfs7GWcyiFhSyCs3eKOOEu+AN
 QeZ/lQFlBIjKLtpkq2+saosJY/4rg/3L+AWEUI4pQjTKQxulpvkwBpMigHs7n3UVs25uJIqIF
 oJNrw83cQgOu3pQXK9nXVEokfNaZ4CG4igf3ldtO1iYMXIp7bGRWGEdsTFMfmAMaJObZ5E7WN
 tpU6SxYQLvmTrtxi5ebwS3g06rh+sV3xKC4gtlCz5PWGEaYWC2K6bNj1+a3PJff3YfFup+ftp
 bXsx+Zfn0A0dinS1frGJHZVXFGuUY+rfmbg8yRAqyFTLyEIvFZtWP6qrucR3LsMtR7cwAxlfn
 Snh0A8c5p+68CQI8aAdvvXw1VyjpjHaLcLi4CV63CXlAPTAqfoz98BSbH1meCF5E9yAMJAkYw
 CArOz3wZYlmLbUIs0jCcPiTnxk4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 11:26, Daniel Vetter wrote:
> On Thu, 5 Jan 2023 at 11:22, Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> On Thu, 5 Jan 2023 at 09:14, Helge Deller <deller@gmx.de> wrote:
>>>
>>> Hi Linus,
>>>
>>> please pull the fbdev driver updates for 6.2-rc3, to receive
>>> fixes for matroxfb, offb, omapfb and fbmem.
>>>
>>> Thanks,
>>> Helge
>>>
>>> ----
>>>
>>> The following changes since commit 1b929c02afd37871d5afb9d498426f83432=
e71c2:
>>>
>>>    Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.g=
it tags/fbdev-for-6.2-rc3
>>>
>>> for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854b=
e:
>>>
>>>    fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +0=
100)
>>>
>>> ----------------------------------------------------------------
>>> fbdev updates for kernel 6.2-rc3:
>>>
>>> - Fix Matrox G200eW initialization failure
>>> - Fix build failure of offb driver when built as module
>>> - Optimize stack usage in omapfb
>>> - Prevent use-after-free in fbmem
>>>
>>> ----------------------------------------------------------------
>>> Arnd Bergmann (1):
>>>        fbdev: omapfb: avoid stack overflow warning
>>>
>>> Hang Zhang (1):
>>>        fbdev: fbmem: prevent potential use-after-free issues with cons=
ole_lock()
>>
>> I looked at this, and even by fbdev locking standards this makes
>> absolutely no sense to me. I think this should be dropped before we've
>> reached some sort of conclusion on what is going on, or whether this
>> is just pure static checker conjecture without fully understanding how
>> this is supposed to work really.
>
> Just to close this: Turned out to be some kind of static checker dud
> (and unfortunately the commit message didn't even explain that it was
> found through some undisclosed static checker, I asked the submitter
> to rectify this going forward since they'll likely submit more stuff
> like this).
> -Daniel

Thank you, Daniel!

Helge
