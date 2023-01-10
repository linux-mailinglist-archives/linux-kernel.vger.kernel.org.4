Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093BD664074
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjAJM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjAJM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:28:01 -0500
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58E5F98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:28:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 4495C16C0004;
        Tue, 10 Jan 2023 14:27:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lj3SrLoA6jRB; Tue, 10 Jan 2023 14:27:57 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1673353677; bh=zwxBsdOxXbT/o7p0/efrqT/Nkwrd77eV/+pSV4XqXNc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GXfR+1I7gu3qzNDklinm7snHOlgQA4uHRyNRiZsLPalOWYpcS83pNHtyV464bxRHB
         PkFCcfqxFLEcHJsjpEK7nmqKqfMUh/EoBwCv5SYwdu5Fvz+8HeLnz9RaQSUBMyvSt3
         EPaPycjIEJj00BgUXiQcOUwaK+5W3COTEDrU3gP8=
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Reddy, V sujith kumar" <vsujithkumar.reddy@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>
Subject: Re: [RFC] Sound support for Huawei line of AMD laptops using ACP
 and ES8336 codec
In-Reply-To: <8349cf5f-1e26-f605-4404-978dbef9cee3@amd.com>
References: <871qo7fqjp.fsf@mutex.one>
 <598ca0a8-8aef-a030-7060-f76ba4700bbf@amd.com>
 <8349cf5f-1e26-f605-4404-978dbef9cee3@amd.com>
Date:   Tue, 10 Jan 2023 14:27:54 +0200
Message-ID: <871qo2bmlx.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello V sujith kumar, Mario,

Thanks for the replies to my email.

"Limonciello, Mario" <mario.limonciello@amd.com> writes:

> On 1/7/2023 00:58, Reddy, V sujith kumar wrote:
>>=20
>> Could you please send=C2=A0 the error, we will check and let you know wh=
at is=20
>> missing.
>
> Just a guess here without seeing the error.  Is this perhaps because the=
=20
> SOF F/W binary that was loaded was not signed with signature trusted by=20
> the platform and the platform required validation?
>
> SOF on AMD was first introduced for Chromebooks which don't use the same=
=20
> authority for firmware binary verification that general purpose UEFI=20
> notebooks would use.


So I compiled the latest sof firmware from main branch commit
90c14e56cb, and now it seems I get additional errors that I didn't get a
few months ago when I last tried:
[   38.251393] snd_sof_amd_renoir 0000:03:00.5: enabling device (0000 -> 00=
02)
[   38.252944] snd_sof_amd_renoir 0000:03:00.5: unknown sof_ext_man header =
type 3 size 0x30
[   38.252955] snd_sof_amd_renoir 0000:03:00.5: Firmware info: version 2:0:=
0-90c14
[   38.252957] snd_sof_amd_renoir 0000:03:00.5: Firmware: ABI 3:26:0 Kernel=
 ABI 3:23:0
[   41.345068] snd_sof_amd_renoir 0000:03:00.5: ------------[ DSP dump star=
t ]------------
[   41.345080] snd_sof_amd_renoir 0000:03:00.5: Firmware boot failure due t=
o timeout
[   41.345085] snd_sof_amd_renoir 0000:03:00.5: fw_state: SOF_FW_BOOT_IN_PR=
OGRESS (2)
[   41.345137] snd_sof_amd_renoir 0000:03:00.5: invalid header size 0x7f841=
000. FW oops is bogus
[   41.345142] snd_sof_amd_renoir 0000:03:00.5: unexpected fault 0x7f840000=
 trace 0x7f840000
[   41.345146] snd_sof_amd_renoir 0000:03:00.5: ------------[ DSP dump end =
]------------
[   41.345150] snd_sof_amd_renoir 0000:03:00.5: error: failed to boot DSP f=
irmware -5
[   41.345266] snd_sof_amd_renoir 0000:03:00.5: error: sof_probe_work faile=
d err: -5

The kernel I'm running on is based on the asoc tree from Mark Brown:
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

commit f8778e910cab179f5835386a0a70847921a8fbec (sound/for-next)
Merge: cdfa92eb90f5 b11845893678
Author: Mark Brown <broonie@kernel.org>
Date:   Fri Jan 6 17:04:36 2023 +0000

    Merge remote-tracking branch 'asoc/for-6.3' into asoc-next

Let me know what other information you need in order to debug this.


