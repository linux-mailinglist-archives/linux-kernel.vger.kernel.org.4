Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719235F2201
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJBIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:23:22 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743327DF5;
        Sun,  2 Oct 2022 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664698989;
        bh=cXRHQMxLlVnjyQtGs46/1bRAmc90kvKW48qPbo+fsFE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TA8k8xJYM6VStplkxWKVy9zSYuFKxxiW+0Met2B6dz4/5clJb7hDu9gWMDLgqKl8C
         6WwV5TuMi8ufH+GtNcnU+/Xcoc4YxYt20Z3OOzwvZo25W67XCnWxmU7gksajPrxX59
         ILMaJtp5XqJ+zYWqtUkK421xYtGWskgo51xEwzGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.40.110.21] ([143.244.36.77]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTABT-1omqB80Dsd-00UcRo; Sun, 02
 Oct 2022 10:23:09 +0200
Message-ID: <56a04cae-7240-9005-4931-5b3e9f598ffb@gmx.com>
Date:   Sun, 2 Oct 2022 08:23:07 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <87pmfavfpt.wl-tiwai@suse.de>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <87pmfavfpt.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T/8NZqDEJHe9wvX25MB+Pqrj+U7LnOWjye/iBtFkbDrmg4+F3Vm
 TBdY+os/AL6HnH1G1I590dJ0Hv66WyWkGmmaOsm9/jaX1XvtPeK56TWwLWTv95jjCIbuB7J
 99WyhudgaYk2esipn13tC5bxXgXn4tayg6xP6K+p8d7mhfuRwet+oaMCDknudf0BcmLaW+v
 IoW5bCrwtxlbzR/ZtqGpg==
X-UI-Out-Filterresults: junk:10;V03:K0:M1pBkA9VViY=:9P3D0CDxOoOb7dJdR1qWBR4M
 RxGCHAfhcIeQpnKsSz5vI/nMQldRvoSzRXJz5nRzzxSmTL3ix48G+k+n/HgZHhC3YpfIACfOT
 cdrvSzR0VFVeGe8Rm8+WZEHS4SaipEFLcM96kdn2yLA6Eu6rYdaypkwXV80Alv8YwvDA4Jv7b
 4lQk3PT9vr6WrvMI2NPvAsQwJ54tBwILAeO2ckAs6Dm7FvcggXZcufoJWyqVRCxdA7j/xmsDc
 hKCWvuNW0a9xyQCtumJFBhieqCacoIYoy0PMtwX3DZLIKT47t0gQC6FfEku0XWzQkNE34Roo4
 ufCn9A7E23LDhc7MmsjCw3J6/9HlWiuhcpq8W1jRG46c4HM2xSWaBdrV4ZaKa0B5ElrhIuKnh
 a1k7X8z/bAK4fldmtRNeQYwb932Mc7Z3Rd17/V+CDEcgeKhlrTUo1/uME7J01XHLheWhNOE6g
 HtlbktamChRC6mezi8pzbV37ADKeXmEacrRIjsgt7OcoM9AnftGSlhKyELrnuotI1vSgNNUYP
 3HsUIlw9ptiKRjdxBHSpXahwtlAfIYaDn7H2eCsVlXnVdNg+UEIzHocRiccEmKmoamyNr5EFw
 0iwLI850BkvX3BGs2R+FykFl3djzrLNczcfQnSqWchxTloNKn8ZbViktc6Wyf1bDJHP5NvI++
 S/Yg6f5tUHE94yT9g1L5QixFacmOOUBQyNNA/C7P8GFjtGf+f5tTybNwBtRJjEdq+GorFcSjc
 85KM7R5kC15FCgs0JUJYG+8LvyvD9GU4ggL68g20PYL7ieFquR95eG595Joc3SCOPTGOEfmmm
 iGGYLoHJap64oRxfCvRV+y3/fkDmhj6bkbdDM5PM5k61cF5oNSapmbbNrafjM0y1coeZYNMq8
 IluNvdSgYNV4Hi9olfVzV8RAzCeumRD9yVTqa5X3TJ1z5BKOpLoJISkob+kjTc6NZvCATn05T
 dvXOWZ6QMccOQz9Oy48ccRiuleGm7IHls3qbchfBwD2pM4iPuKwdqxjD+IhXDRbEL76FccBcg
 q/gmylNtMXqOk5ANGrxDgLCPtLz/ZjMaCuG/KRCOFSB5R+N8zjrw5grKjYb4B7Pz+aMiw/TBs
 /9r7WfFjpHuOzybbjbrjPgw+xwtH4g1JFK7s6tt6BZo6qxubAwyNvbqBFrmf2ShttwNu2Tvnl
 kzQZjYrJqKcEd8oQq/HX3hg2My7cf4kqp7MBBOCyjnvkbw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 07:37, Takashi Iwai wrote:
> On Sat, 01 Oct 2022 12:30:22 +0200,
> Artem S. Tashkinov wrote:
>> - 2 -
>>
>> Here's another one which is outright puzzling:
>>
>> You run: dmesg -t --level=3Demerg,crit,err
>>
>> And you see some non-descript errors of some kernel subsystems seemingl=
y
>> failing or being unhappy about your hardware. Errors are as cryptic as
>> humanly possible, you don't even know what part of kernel has produced =
them.
>>
>> OK, as a "power" user I download the kernel source, run `grep -R messag=
e
>> /tmp/linux-5.19` and there are _multiple_ different modules and places
>> which contain this message.
>>
>> I'm lost. Send this to LKML? Did that in the long past, no one cared, I
>> stopped.
>>
>> Here's what I'm getting with Linux 5.19.12:
>>
>> platform wdat_wdt: failed to claim resource 5: [mem
>> 0x00000000-0xffffffff7fffffff]
>> ACPI: watchdog: Device creation failed: -16
>> ACPI BIOS Error (bug): Could not resolve symbol
>> [\_SB.PCI0.XHC.RHUB.TPLD], AE_NOT_FOUND (20220331/psargs-330)
>> ACPI Error: Aborting method \_SB.UBTC.CR01._PLD due to previous error
>> (AE_NOT_FOUND) (20220331/psparse-529)
>> platform MSFT0101:00: failed to claim resource 1: [mem
>> 0xfed40000-0xfed40fff]
>> acpi MSFT0101:00: platform device creation failed: -16
>> lis3lv02d: unknown sensor type 0x0
>>
>> Are they serious? Should they be reported or not? Is my laptop properly
>> working? I have no clue at all.
>
> That's a dilemma.  The kernel can't know whether it's "properly"
> working, either -- that is, whether the lack of some functions matters
> for you or not.  In your case above, it's about a watchdog, something
> related with USB, TPM, and acceleration sensor, all of which likely
> come from a buggy BIOS.  Would you mind if those features are missing?
> Or even whether your device has a correct hardware implementation?
> Kernel doesn't know, hence it complains as an error.
>
> In many drivers, there are mechanisms to shut off superfluous error
> messages for known devices.  So it's case-by-case solutions.
>
> Or you can completely hide those errors at boot by a boot option
> (e.g. loglevel=3D2).

The problem is some of such messages are indeed indicative of certain
real issues which result in HW not working properly, including:

1) missing/incorrect firmware
2) most importantly: not enabled power saving modes
3) not enabled high performance modes
4) not enabled devices
5) not enabled devices' functions
6) drivers conflicts (i.e. the wrong module gets loaded for the device)
7) physically failing hardware

I'm quite sure you don't really know what half of those messages
actually mean.

Speaking of 7. Various kernel subsystems/drivers deal with e.g. mass
storage which is known to fail quite often. There's not a single driver
in the kernel which is actually brave enough to spew something like this:

"/dev/xxxx might be failing, please RMA or seek help online"

instead you get a dmesg choke full of "unable to read sector XXX" or
something like that.

To return to the previous errors: it's impossible for the user to assess
their severity and that sucks. What is "platform device creation
failed"? What is "unknown sensor type"? What am I missing? Who's
responsible? The kernel? My HW vendor? Are those errors actionable? In
my understanding a properly working computer must not produce
"emerg,crit,err" errors. I'm not even talking about "warn,info" and such.

Best regards,
Artem
