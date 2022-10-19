Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D43A604687
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiJSNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJSNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:13:13 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939A53003
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:58:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 4F08B204D9;
        Wed, 19 Oct 2022 14:50:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mGVPu9q_G-D8; Wed, 19 Oct 2022 14:50:42 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id AFEBD20184;
        Wed, 19 Oct 2022 14:50:42 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout1.secunet.com (Postfix) with ESMTP id A9B3980004A;
        Wed, 19 Oct 2022 14:50:42 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 14:50:42 +0200
Received: from [10.36.110.53] (10.36.110.53) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 14:50:42 +0200
To:     Petr Vorel <pvorel@suse.cz>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kroah-Hartman <gregkh@linuxfoundation.org>
References: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
 <Y0/DlHMIPbRDG+fF@pevik> <Y0/uFkggIJMjxcpi@pevik>
From:   Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: Re: v6.1-rc1: Regression in notification of sethostname changes
Message-ID: <ec9e00b9-8b47-7918-c39b-8b0069003169@secunet.com>
Date:   Wed, 19 Oct 2022 14:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Y0/uFkggIJMjxcpi@pevik>
Content-Type: multipart/mixed;
        boundary="------------8E72B37259581E8BD9D09621"
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------8E72B37259581E8BD9D09621
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 19.10.22 14:31, Petr Vorel wrote:
>> Hi Torsten,
> 
>>> Hello Petr,
> 
>>> your commit
> 
>>> commit bfca3dd3d0680fc2fc7f659a152234afbac26e4d
>>> Author: Petr Vorel <pvorel@suse.cz>
>>> Date:   Thu Sep 1 21:44:03 2022 +0200
> 
>>>     kernel/utsname_sysctl.c: print kernel arch
> 
>>>     Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
>>>     This helps people who debug kernel with initramfs with minimal environment
>>>     (i.e.  without coreutils or even busybox) or allow to open sysfs file
>>>     instead of run 'uname -m' in high level languages.
> 
>>> broke the notification mechanism between the sethostname syscall and the pollers of /proc/sys/kernel/hostname.
> 
>>> The table uts_kern_table is addressed within uts_proc_notify by the enum value, however no new enum value was added in "enum uts_proc".
> 
>>> I noticed the problem when journald-systemd failed to detect hostname changes made with the sethostname syscall (as used by the hostname tool).
>>> When setting the hostname through /proc/sys/kernel/hostname the poll notification was working.
> 
>> Thanks a lot for your report, working on a fix!
>> Andrew, Greg, sorry for a regression.
> 
> Hi Torsten,
> 
> could you please post exact steps to reproduce the problem.
> Although the required fix to add new enum into enum uts_proc is trivial,
> I was not able to reproduce the problem with 6.1.0-rc1 (actually
> 6.1.0-rc1-4.g1d716d8-default which contains few extra patches).
> 
> # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> opensuse-tumbleweed.20221001
> opensuse-tumbleweed.20221001
> opensuse-tumbleweed.20221001
> 
> # hostnamectl set-hostname foo; echo $?
> 0
> # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> foo
> foo
> foo
> 
> # hostname bar; echo $?
> 0
> # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> bar
> bar
> bar
> 
> # echo "baz" > /proc/sys/kernel/hostname
> # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> baz
> baz
> baz
> 
> 
> # hostnamectl set-hostname foo; reboot
> After reboot it's 'foo'.
> What am I missing?
> 
> BTW I originally tested the feature only on dracut initramfs (with rapido [1]),
> which obviously bypass systemd. For a fix I'm creating rpm package (binrpm-pkg).

The problem is happening in the systemd-journald poll notification. I was checking for the problem by attaching gdb to the running systemd-journald and setting a breakpoint to the server_cache_hostname function. This function is triggered via dispatch_hostname_change whenever the hostname changes. This is done via sd_event API in systemd.

Here is an example program for this functionality without any further dependency:

#include <poll.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>

int main()
{
	struct pollfd info;

	info.fd = open("/proc/sys/kernel/hostname", O_RDONLY);
	info.events = 0;
	info.revents = 0;

	while (true) {
		int res = poll(&info, 1, -1);
		if (res > 0) {
			if (info.revents != 0) {
				char buffer[64];
				gethostname(buffer, sizeof(buffer));
				printf("Hostname has changed to: %s\n", buffer);
			}
		}
	}
}

I have also attached this program.

If you call this program and issue calls of the hostname utility to change the hostname some message should be printed.

	Torsten


--------------8E72B37259581E8BD9D09621
Content-Type: text/x-csrc; charset="UTF-8"; name="hostname-poll-test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hostname-poll-test.c"

#include <poll.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>

int main()
{
	struct pollfd info;

	info.fd =3D open("/proc/sys/kernel/hostname", O_RDONLY);
	info.events =3D 0;
	info.revents =3D 0;

	while (true) {
		int res =3D poll(&info, 1, -1);
		if (res > 0) {
			if (info.revents !=3D 0) {
				char buffer[64];
				gethostname(buffer, sizeof(buffer));
				printf("Hostname has changed to: %s\n", buffer);
			}
		}
	}
}

--------------8E72B37259581E8BD9D09621--
