Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBEA621A99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiKHR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiKHR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:28:56 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0912181A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:28:52 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322d768ba7so16992548fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oDWWLDxoPnzZ6USIzm5f9SEA4GEDZRpuNi854PScv4A=;
        b=pDP+u9yNB+44jg7gz5IsifqKrthEEdk1MWJZ4aHL46qqKHQNtD/IJzKRHMYQtPLq0Y
         9lTP2PGthqd6TQsIoEp6SrHO8Ryp6BUaALlKurVo/xGLOaHS3y2wurD3urtu6ChkKtYW
         x6PFBinhAtDMuMGHntgkGy9FH4lhId1Iog3ijuZmJQaPp6GYUyRNwdcLR5lxGbMu1Xrj
         bTgpSM6VErvf8N+A/6jjKq7Hzh5hV1YaX7yTNhSNUWoLER9Bpl+QzfpYJx67V8YkhzlQ
         WDvcoGKXJFU+gYBfHjBAOAzAO8CJTrbkV6r4mg1zXUxwTiD+Dl2YVnp49tnAaXliWSYe
         LoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDWWLDxoPnzZ6USIzm5f9SEA4GEDZRpuNi854PScv4A=;
        b=DgVULE0tAtrWUZAJ7cXmsDuU0G26QVbyVaG1Pl3qwU2Qb8ToCMzZlC0m4XaeuEHpK4
         OP2B00WBw0eETrtB7LXxzHotInmB4g5P1wCzCFwUpw6h6jkQXLj7owssnmdle0K4brcX
         DDDBZFY9djGFWqxldEEpzaJ9TMBGdhA2ajv35jJDFcJI5DMI3/u0QrLnMDudTY6sO61E
         8aze0ZRvngjEk27Xfzy+tK6u2ZhWekYe6OrOo/0xrN4rlc7vVyucd8UVt4hT7JwYz4vZ
         eSvg9TfKBH9DlLMsr+mQJlvdFSFhS7WyJQ804sRe+WlmqGbwCVwdhd/rJUvd437cDgmF
         2z+g==
X-Gm-Message-State: ACrzQf0IO24qN+82p2nh0MZSKw0ufFpHrWr4pbDFUxeunmlflBsRTEoA
        4RKlwBeWWsznPfx5JmWHlpkokH3RI4Kb7EE7HUzX1RLrDVY=
X-Google-Smtp-Source: AMsMyM6uevInzOtAMKTohNAr/s1boPWTvilzBwSUQMAAdyDL/DFaeAww6r5/PKcLT1D69uX035BfHA3BDx3Idt7LQ5w=
X-Received: by 2002:a05:6871:7a1:b0:131:946a:7b30 with SMTP id
 o33-20020a05687107a100b00131946a7b30mr42802578oap.67.1667928532149; Tue, 08
 Nov 2022 09:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com> <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
In-Reply-To: <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 8 Nov 2022 22:58:16 +0530
Message-ID: <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 18:08, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > Hi Amit,
> >
> > On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> > > On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > Will Deacon (2):
> > > >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> > >
> > > Hi Will,
> > >
> > > This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> > > relevant crash in the attached log and device silently reboots into
> > > USB crash dump mode. The crash is fairly reproducible on db845c. I
> > > could trigger it twice in 5 reboots and it always crash at the same
> > > point during the boot process. Reverting this patch fixes the crash.
> > >
> > > I'm happy to test run any debug patche(s), that would help narrow
> > > down this breakage.
> >
> > Cc'ing Robin, maybe he has a better idea (that's commit c44094eee32f).
> > Architecturally the change shouldn't make any difference since the cache
> > lines can be brought in via the linear mapping at any point. It's just
> > less likely to hit a real bug (software or hardware). It's also possible
> > that arch_dma_prep_coherent() is used outside the DMA API (if you have
> > out of tree drivers).
> >
> > Leaving the original log in place for Robin. A question I have, with a
> > successful boot, what's normally after the bpfloader lines are printed?
> > We should try to pinpoint which device/driver causes this. It looks like
> > it's well into user-space at that point (graphics about to start?)
>
> Further narrowed down the breakage to the userspace daemon rmtfs
> https://github.com/andersson/rmtfs. Is there anything specific in the
> userspace code that I should be paying attention to?
>
> console:/ #
> console:/ # start rmtfs
> [   56.425631][    T1] init: starting service 'rmtfs'...
> [   56.455541][    T1] init: Control message: Processed ctl.start for
> 'rmtfs' from pid: 1819 (start rmtfs)
> [   56.487524][  T344] type=1400 audit(1666698550.979:267): avc:
> denied { read } for comm="rmtfs" name="modalias" dev="sysfs" ino=6325
> scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs:s0 tclass=file
> permissive=1
> [   56.487662][ T1821] remoteproc remoteproc0: powering up 4080000.remoteproc
> [   56.506365][  T344] type=1400 audit(1666698550.979:268): avc:
> denied { open } for comm="rmtfs"
> path="/sys/devices/platform/remoteproc-cdsp/modalias" dev="sysfs"
> ino=6325 scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs:s0
> tclass=file permissive=1
> [   56.515137][ T1821] remoteproc remoteproc0: Booting fw image
> qcom/sdm845/mba.mbn, size 242400
> [   56.535020][  T344] type=1400 audit(1666698550.979:269): avc:
> denied { read } for comm="rmtfs" name="modalias" dev="sysfs" ino=7200
> scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs_remoteproc:s0
> tclass=file permissive=1
> [   56.621541][ T1821] qcom-q6v5-mss 4080000.remoteproc: MBA booted
> without debug policy, loading mpss

Hi, I can reproduce this crash on v6.1-rc4 as well and would really
appreciate some help here.
I could narrow down the db845c crash into USB crash dump mode to:

# echo "start" > /sys/class/remoteproc/remoteproc0/state
[   50.987035][  T431] remoteproc remoteproc0: powering up 4080000.remoteproc
[   50.999628][  T431] remoteproc remoteproc0: Booting fw image
qcom/sdm845/mba.mbn, size 242400
[   51.095967][  T431] qcom-q6v5-mss 4080000.remoteproc: MBA booted
without debug policy, loading mpss


Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.XF.2.0-00371-SDM845LZB-1
S - IMAGE_VARIANT_STRING=SDM845LA
S - OEM_IMAGE_VERSION_STRING=TSBJ-FA-PC-02170
S - Boot Interface: UFS
S - Secure Boot: Off
S - Boot Config @ 0x00786070 = 0x000000c1
S - JTAG ID @ 0x00786130 = 0x2008e0e1
S - OEM ID @ 0x00786138 = 0x00000000
S - Serial Number @ 0x00784138 = 0x710cee0b
S - OEM Config Row 0 @ 0x00784188 = 0x0000000400000000
S - OEM Config Row 1 @ 0x00784190 = 0x0000000000000000
S - Feature Config Row 0 @ 0x007841a0 = 0x0050200080000400
S - Feature Config Row 1 @ 0x007841a8 = 0xe000ffff00007fff
S - Core 0 Frequency, 1516 MHz
S - PBL Patch Ver: 1
S - PBL freq: 600 MHZ
B -        94 - PBL, Start
B -      5279 - bootable_media_detect_entry
B -     44106 - bootable_media_detect_success
B -     44483 - elf_loader_entry
B -     45046 - auth_hash_seg_entry
B -     45242 - auth_hash_seg_exit
B -     51093 - elf_segs_hash_verify_entry
B -     57888 - elf_segs_hash_verify_exit
B -     58515 - auth_xbl_sec_hash_seg_entry
B -     65894 - auth_xbl_sec_hash_seg_exit
B -     65896 - xbl_sec_segs_hash_verify_entry
B -     66654 - xbl_sec_segs_hash_verify_exit
B -     66679 - PBL, End
B -     81191 - SBL1, Start
B -    205082 - boot_flash_init, Start
D -         0 - boot_flash_init, Delta
B -    208620 - xblconfig_init, Start
D -       549 - Auth Metadata
D -    188459 - xblconfig_init, Delta
B -    402051 - sbl1_ddr_set_default_params, Start
D -         0 - sbl1_ddr_set_default_params, Delta
B -    410042 - boot_config_data_table_init, Start
B -    414708 - CDT not programmed, using default
D -      4544 - boot_config_data_table_init, Delta - (54 Bytes)
B -    429226 - CDT Version:3,Platform ID:8,Major ID:1,Minor ID:0,Subtype:0
B -    434930 - pm_device_init, Start
B -   1514660 - PM: PON REASON: PM0=0x8000024000020021:0x0
PM1=0x8000084000080020:0x0 PM2=0x8000084000080020:0x0
B -   1574837 - PM: SET_VAL:Skip
D -   1140425 - pm_device_init, Delta
B -   1577826 - pm_driver_init, Start
D -      5337 - pm_driver_init, Delta
B -   1586610 - PM: Trigger FG IMA Reset
B -   1590239 - PM: Trigger FG IMA Reset.Completed
B -   1599450 - PM: EntryVbat: 4221; EntrySOC: -1
B -   1599481 - PM: ADSP result: 0
B -   1604025 - PM: Manually set ICL 500mA
B -   1607106 - PM: BATT TEMP: 29 DegC
B -   1611132 - vsense_init, Start
D -         0 - vsense_init, Delta
B -   1647762 - Pre_DDR_clock_init, Start
D -        61 - Pre_DDR_clock_init, Delta
D -   1651575 - sbl1_ddr_set_params, Delta
B -   1655326 - sbl1_ddr_init, Start
B -   1659261 - Freeze IOs = 0x1, 0x1, 0x1, 0x1, DBG PDC Tr = 0x0,
First Pass expire = 0x0, First Pass complete = 0x1
D -      9058 - sbl1_ddr_init, Delta
B -   1673169 - do_ddr_training, Start
D -         0 - do_ddr_training, Delta
B -   1679787 - pImem Init Start
D -      4422 - pImem Init End, Delta
B -   1691743 - clock_init, Start
D -       244 - clock_init, Delta
B -   1695037 - Image Load, Start
D -      2867 - APDP Image Loaded, Delta - (0 Bytes)
B -   1707024 - usb: chgr -  SDP_CHARGER
B -   1707359 - usb: qusb2_1: hstx , 0x5
B -   1710836 - usb: PLL1 locked , 0x5
B -   1714435 - TCSR reg value 0x10
B -   1718034 - Image Load, Start
D -       457 - Auth Metadata
D -      2837 - Segments hash check
D -     13664 - XBLRamDump Image Loaded, Delta - (582427 Bytes)
B -   1811090 - DisplayLib: LAB/IBB GetStatus(LabVregOk) failed after 25ms

B -   1818166 - DisplayDxe: Resolution 1440x2560 (2 intf)

B -   2129632 - usb: init start
B -   2130760 - usb: ss_lane_1st
B -   2132834 - usb: usb_lane
B -   2136708 - usb: qusb2_1: hstx , 0x5
B -   2138385 - usb: PLL1 locked , 0x5
B -   2142137 - usb: id_p , 0x1009b
B -   2145461 - usb: VBUS High!
B -   2245898 - usb: suspended
B -   2435120 - usb: HIGH , 0x900e
B -   2567246 - usb: HIGH , 0x900e
B -   2670702 - usb: ENUM success
