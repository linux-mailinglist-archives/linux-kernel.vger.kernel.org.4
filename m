Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064068036D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjA3BJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjA3BJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:09:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90914E9E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:09:39 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j9so8023236qvt.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yo94T67wvDVdPN5Q3se3RG9bVStWWcUDOPqRLP3XGs=;
        b=BVSbnjGLBTIOp1rcXpgipwmlvpl47G0mog2e28FV2C1XkA5TC8SQtQTICufoCzHkOQ
         QH/71L7B72lSDYrxhz8d3mV4aQMD0dggUKX3OpnO0mcP+yq+tUT6FiDaGCxaCjraT7j0
         oI9LQvgd26m4NQz/nnfCTeYA4dmb6F3aq22FXGCIDvhYcjm8FW0w7gUCynHQX6xQKjSL
         evz4ChE+JAP7pQM36LNdA/1siCOxpe6Prk+00QrZ/Vpx7tqlXuqd3xaHrPH0iViyfAoz
         66R4v7Nnpwzt+O1+QR19wMrG30l0QDLV3iXlwPBv4XHuYv9hT1DQFHvpb8lFKdLrsjGv
         /kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Yo94T67wvDVdPN5Q3se3RG9bVStWWcUDOPqRLP3XGs=;
        b=LsdBCVxROCEjA3assgrmLIWvi6TBP8Yc+6g/RUy9ynBK13VietJKqxumTu5C5hJ2RJ
         3DU7as8hMxqgM9yrOITzdCZaaRFno1cyazbcOCHncA3rBzxd16jiwa4hn5mwgxuo02Au
         P04OzI/+9meghMG4OKWhrugrw5ydjNNhvbdtNMqG/40Oqp3/1F7G4Pujm0OmG7lWOQck
         keOqOADbKHzNiO+FNGEmAQkn28Gavt95r+X6eu/Mk3TOE5R4ATHxmubVB93bOFJLIHsz
         z2xAoQg6WFZsIS3IsTkO51e/7avc3yMstLQY5Mt9ZN0fPc9HyhY1YNllpWesq/1+hL/g
         lt5w==
X-Gm-Message-State: AO0yUKXIKiY92MBMf/YCc7lscd77dQe1hTPAkC0fwP5rbga/VBppjFgx
        XDNGtCC1mmawWdoxeLztZCBt5yiLmLRmqSeKRww=
X-Google-Smtp-Source: AK7set9N7VSfztFNBi+QRCX3NiMmCiXgS3Wx0zOn6eV2gX5WEi0I6SiT5+dHkutBtsYQHIT7ZMTjCB/e21uqYRYV3kY=
X-Received: by 2002:a0c:f510:0:b0:53c:b367:9e51 with SMTP id
 j16-20020a0cf510000000b0053cb3679e51mr89766qvm.9.1675040978641; Sun, 29 Jan
 2023 17:09:38 -0800 (PST)
MIME-Version: 1.0
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <fcec3c78-b5d9-eb48-0fc0-d1f27de87f23@leemhuis.info> <b21fa1f6-a71d-5657-8596-ee0be73185ea@leemhuis.info>
 <3ab28896-70e9-6f90-5b97-e5397b06e715@googlemail.com> <a163dd7b-c5d1-a07b-a816-7a2dfd3edfd4@leemhuis.info>
 <ab1b0f73-6b4e-8602-2999-b7bec25d92db@googlemail.com>
In-Reply-To: <ab1b0f73-6b4e-8602-2999-b7bec25d92db@googlemail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 30 Jan 2023 11:09:27 +1000
Message-ID: <CACAvsv4sOtPjCVnEcKd2RCUqYWxSn5XKyksbS-Bds2qCqyusVw@mail.gmail.com>
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        bskeggs@redhat.com, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="00000000000084d57705f370dec9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000084d57705f370dec9
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Jan 2023 at 21:29, Chris Clayton <chris2553@googlemail.com> wrote:
>
>
>
> On 28/01/2023 05:42, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> > On 27.01.23 20:46, Chris Clayton wrote:
> >> [Resend because the mail client on my phone decided to turn HTML on behind my back, so my reply got bounced.]
> >>
> >> Thanks Thorsten.
> >>
> >> I did try to revert but it didnt revert cleanly and I don't have the knowledge to fix it up.
> >>
> >> The patch was part of a merge that included a number of related patches. Tomorrow, I'll try to revert the lot and report
> >> back.
> >
> > You are free to do so, but there is no need for that from my side. I
> > only wanted to know if a simple revert would do the trick; if it
> > doesn't, it in my experience often is best to leave things to the
> > developers of the code in question,
>
> Sound advice, Thorsten. Way to many conflicts for me to resolve.
Hey,

This is a complete shot-in-the-dark, as I don't see this behaviour on
*any* of my boards.  Could you try the attached patch please?

Thanks,
Ben.

>
> as they know it best and thus have a
> > better idea which hidden side effect a more complex revert might have.
> >
> > Ciao, Thorsten
> >
> >> On 27/01/2023 11:20, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> >>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> >>> to make this easily accessible to everyone.
> >>>
> >>> @nouveau-maintainers, did anyone take a look at this? The report is
> >>> already 8 days old and I don't see a single reply. Sure, we'll likely
> >>> get a -rc8, but still it would be good to not fix this on the finish line.
> >>>
> >>> Chris, btw, did you try if you can revert the commit on top of latest
> >>> mainline? And if so, does it fix the problem?
> >>>
> >>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >>> --
> >>> Everything you wanna know about Linux kernel regression tracking:
> >>> https://linux-regtracking.leemhuis.info/about/#tldr
> >>> If I did something stupid, please tell me, as explained on that page.
> >>>
> >>> #regzbot poke
> >>>
> >>> On 19.01.23 15:33, Linux kernel regression tracking (Thorsten Leemhuis)
> >>> wrote:
> >>>> [adding various lists and the two other nouveau maintainers to the list
> >>>> of recipients]
> >>>
> >>>> On 18.01.23 21:59, Chris Clayton wrote:
> >>>>> Hi.
> >>>>>
> >>>>> I build and installed the lastest development kernel earlier this week. I've found that when I try the laptop down (or
> >>>>> reboot it), it hangs right at the end of closing the current session. The last line I see on  the screen when rebooting is:
> >>>>>
> >>>>>   sd 4:0:0:0: [sda] Synchronising SCSI cache
> >>>>>
> >>>>> when closing down I see one additional line:
> >>>>>
> >>>>>   sd 4:0:0:0 [sda]Stopping disk
> >>>>>
> >>>>> In both cases the machine then hangs and I have to hold down the power button fot a few seconds to switch it off.
> >>>>>
> >>>>> Linux 6.1 is OK but 6.2-rc1 hangs, so I bisected between this two and landed on:
> >>>>>
> >>>>>   # first bad commit: [0e44c21708761977dcbea9b846b51a6fb684907a] drm/nouveau/flcn: new code to load+boot simple HS FWs
> >>>>> (VPR scrubber)
> >>>>>
> >>>>> I built and installed a kernel with f15cde64b66161bfa74fb58f4e5697d8265b802e (the parent of the bad commit) checked out
> >>>>> and that shuts down and reboots fine. It the did the same with the bad commit checked out and that does indeed hang, so
> >>>>> I'm confident the bisect outcome is OK.
> >>>>>
> >>>>> Kernels 6.1.6 and 5.15.88 are also OK.
> >>>>>
> >>>>> My system had dual GPUs - one intel and one NVidia. Related extracts from 'lscpi -v' is:
> >>>>>
> >>>>> 00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05) (prog-if 00 [VGA controller])
> >>>>>         Subsystem: CLEVO/KAPOK Computer CometLake-H GT2 [UHD Graphics]
> >>>>>
> >>>>>         Flags: bus master, fast devsel, latency 0, IRQ 142
> >>>>>
> >>>>>         Memory at c2000000 (64-bit, non-prefetchable) [size=16M]
> >>>>>
> >>>>>         Memory at a0000000 (64-bit, prefetchable) [size=256M]
> >>>>>
> >>>>>         I/O ports at 5000 [size=64]
> >>>>>
> >>>>>         Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
> >>>>>
> >>>>>         Capabilities: [40] Vendor Specific Information: Len=0c <?>
> >>>>>
> >>>>>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
> >>>>>
> >>>>>         Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
> >>>>>
> >>>>>         Capabilities: [d0] Power Management version 2
> >>>>>
> >>>>>         Kernel driver in use: i915
> >>>>>
> >>>>>         Kernel modules: i915
> >>>>>
> >>>>>
> >>>>> 01:00.0 VGA compatible controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Ti Mobile] (rev a1) (prog-if 00 [VGA
> >>>>> controller])
> >>>>>         Subsystem: CLEVO/KAPOK Computer TU117M [GeForce GTX 1650 Ti Mobile]
> >>>>>         Flags: bus master, fast devsel, latency 0, IRQ 141
> >>>>>         Memory at c4000000 (32-bit, non-prefetchable) [size=16M]
> >>>>>         Memory at b0000000 (64-bit, prefetchable) [size=256M]
> >>>>>         Memory at c0000000 (64-bit, prefetchable) [size=32M]
> >>>>>         I/O ports at 4000 [size=128]
> >>>>>         Expansion ROM at c3000000 [disabled] [size=512K]
> >>>>>         Capabilities: [60] Power Management version 3
> >>>>>         Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >>>>>         Capabilities: [78] Express Legacy Endpoint, MSI 00
> >>>>>         Kernel driver in use: nouveau
> >>>>>         Kernel modules: nouveau
> >>>>>
> >>>>> DRI_PRIME=1 is exported in one of my init scripts (yes, I am still using sysvinit).
> >>>>>
> >>>>> I've attached the bisect.log, but please let me know if I can provide any other diagnostics. Please cc me as I'm not
> >>>>> subscribed.
> >>>>
> >>>> Thanks for the report. To be sure the issue doesn't fall through the
> >>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> >>>> tracking bot:
> >>>>
> >>>> #regzbot ^introduced e44c2170876197
> >>>> #regzbot title drm: nouveau: hangs on poweroff/reboot
> >>>> #regzbot ignore-activity
> >>>>
> >>>> This isn't a regression? This issue or a fix for it are already
> >>>> discussed somewhere else? It was fixed already? You want to clarify when
> >>>> the regression started to happen? Or point out I got the title or
> >>>> something else totally wrong? Then just reply and tell me -- ideally
> >>>> while also telling regzbot about it, as explained by the page listed in
> >>>> the footer of this mail.
> >>>>
> >>>> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> >>>> to the report (the parent of this mail). See page linked in footer for
> >>>> details.
> >>>>
> >>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >>>> --
> >>>> Everything you wanna know about Linux kernel regression tracking:
> >>>> https://linux-regtracking.leemhuis.info/about/#tldr
> >>>> That page also explains what to do if mails like this annoy you.
> >>
> >>

--00000000000084d57705f370dec9
Content-Type: text/x-patch; charset="US-ASCII"; name="nvdec0-reset.diff"
Content-Disposition: attachment; filename="nvdec0-reset.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ldi446g90>
X-Attachment-Id: f_ldi446g90

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L252a20vc3ViZGV2L2ZiL2dwMTAy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL3N1YmRldi9mYi9ncDEwMi5jCmluZGV4
IDI2NTg0ODFkNTc1Yi4uYTc1YWE4MmJlMWFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bm91dmVhdS9udmttL3N1YmRldi9mYi9ncDEwMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2
ZWF1L252a20vc3ViZGV2L2ZiL2dwMTAyLmMKQEAgLTMwLDE2ICszMCwxOCBAQCBpbnQKIGdwMTAy
X2ZiX3Zwcl9zY3J1YihzdHJ1Y3QgbnZrbV9mYiAqZmIpCiB7CiAJc3RydWN0IG52a21fc3ViZGV2
ICpzdWJkZXYgPSAmZmItPnN1YmRldjsKKwlzdHJ1Y3QgbnZrbV9mYWxjb24gKmZhbGNvbiA9ICZz
dWJkZXYtPmRldmljZS0+bnZkZWNbMF0tPmZhbGNvbjsKIAlzdHJ1Y3QgbnZrbV9mYWxjb25fZncg
ZncgPSB7fTsKIAlpbnQgcmV0OwogCiAJcmV0ID0gbnZrbV9mYWxjb25fZndfY3Rvcl9ocygmZ20y
MDBfZmxjbl9mdywgIm1lbS11bmxvY2siLCBzdWJkZXYsIE5VTEwsCi0JCQkJICAgICAibnZkZWMv
c2NydWJiZXIiLCAwLCAmc3ViZGV2LT5kZXZpY2UtPm52ZGVjWzBdLT5mYWxjb24sICZmdyk7CisJ
CQkJICAgICAibnZkZWMvc2NydWJiZXIiLCAwLCBmYWxjb24sICZmdyk7CiAJaWYgKHJldCkKIAkJ
cmV0dXJuIHJldDsKIAogCXJldCA9IG52a21fZmFsY29uX2Z3X2Jvb3QoJmZ3LCBzdWJkZXYsIHRy
dWUsIE5VTEwsIE5VTEwsIDAsIDB4MDAwMDAwMDApOwogCW52a21fZmFsY29uX2Z3X2R0b3IoJmZ3
KTsKKwludmttX2ZhbGNvbl9yZXNldChmYWxjb24pOwogCXJldHVybiByZXQ7CiB9CiAK
--00000000000084d57705f370dec9--
