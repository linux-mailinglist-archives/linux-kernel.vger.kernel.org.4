Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4C60CC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiJYMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:39:03 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9C18982A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:39:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13bd2aea61bso4553795fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IutFm7TPo7lfp6SgpCiJ/Hpf+tfEln5WIXNkT0ucXHA=;
        b=j561U14WHimRES7IqgYWRnSvRfLNoFltwKG3uJvQB5IPPjIoSECBIDsiKG2+gGIBxm
         k4jSJARue7arJ/nUxbvbOOR13zywUicDKyFPR/1VBLy4500CUW1PwBXH1O5a1UTsSnPG
         +sfmdLS3fHfn7Ra0B0G5Q3LnEc+xycnSofH9dg60nixFoXmzmWeWRHr7UFTs3+XQGglX
         CCOgPUzlTDrDNPr7XzEhaqwx59sjLorxKT1OcMeHsdI9wi/TcOLzuYKzbZjG0qsCQCN0
         HFiqvPTYRi+BN3e81FV3B1ZbNWuhYNq29RZvgCB9tDQk3hMD+QfPmTFHdcc4AhNo0WLB
         GAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IutFm7TPo7lfp6SgpCiJ/Hpf+tfEln5WIXNkT0ucXHA=;
        b=sqyo2n2hjpDVvW04lNTk4cEL6UbtloGGI2d2IchO8d4Y1Uk+qgO6XwBr8bryoX+Jkh
         iXViV3EjXrxATFYMt70ufS46fmhHKGVvh5fcsIx/0l38nPD2p1znaZDudWa09PP8ntg3
         XAoXrwsZX8EPUZV1eAvt3y2ybxauik1/X86zDg1LMnWT3E58JezXi/I1Jv82OddX1ZXh
         sXc2+X5/10zipusYp3lNQWMag6g1OZyVW3ocdJ4WzMcZUMIETotEHguLO9Fagb035/jG
         LCjWj7ODOdgA4snLKPncGKl5WCx0s1CU9XVHYryZv0EfwIlvBcbdq1lvHB9lXNhMSvti
         ETuQ==
X-Gm-Message-State: ACrzQf0j7rfoXucZTGMOMZwPurJAWxLIeTrwdQRM7DDtDxOnzQnSo3Jr
        xMaKy4pt6nkYBym6rLosGBLCdezviuv+l/kqEefAZ5dbBy419A==
X-Google-Smtp-Source: AMsMyM5dC6ebLZ/8gKYwSIDItp7Fe9+EpLsxHQYVcL9xkItqvkdcSrUD7yeywO7DCeeOBBmhJFSlE4YTEG1yvFXZVcM=
X-Received: by 2002:a05:6871:611:b0:13b:8097:2b92 with SMTP id
 w17-20020a056871061100b0013b80972b92mr8404419oan.44.1666701540932; Tue, 25
 Oct 2022 05:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com> <Y0aq8y5mEZi14lJ/@arm.com>
In-Reply-To: <Y0aq8y5mEZi14lJ/@arm.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 25 Oct 2022 18:08:24 +0530
Message-ID: <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Amit,
>
> On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> > On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Will Deacon (2):
> > >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> >
> > Hi Will,
> >
> > This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> > relevant crash in the attached log and device silently reboots into
> > USB crash dump mode. The crash is fairly reproducible on db845c. I
> > could trigger it twice in 5 reboots and it always crash at the same
> > point during the boot process. Reverting this patch fixes the crash.
> >
> > I'm happy to test run any debug patche(s), that would help narrow
> > down this breakage.
>
> Cc'ing Robin, maybe he has a better idea (that's commit c44094eee32f).
> Architecturally the change shouldn't make any difference since the cache
> lines can be brought in via the linear mapping at any point. It's just
> less likely to hit a real bug (software or hardware). It's also possible
> that arch_dma_prep_coherent() is used outside the DMA API (if you have
> out of tree drivers).
>
> Leaving the original log in place for Robin. A question I have, with a
> successful boot, what's normally after the bpfloader lines are printed?
> We should try to pinpoint which device/driver causes this. It looks like
> it's well into user-space at that point (graphics about to start?)

Further narrowed down the breakage to the userspace daemon rmtfs
https://github.com/andersson/rmtfs. Is there anything specific in the
userspace code that I should be paying attention to?

console:/ #
console:/ # start rmtfs
[   56.425631][    T1] init: starting service 'rmtfs'...
[   56.455541][    T1] init: Control message: Processed ctl.start for
'rmtfs' from pid: 1819 (start rmtfs)
[   56.487524][  T344] type=1400 audit(1666698550.979:267): avc:
denied { read } for comm="rmtfs" name="modalias" dev="sysfs" ino=6325
scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs:s0 tclass=file
permissive=1
[   56.487662][ T1821] remoteproc remoteproc0: powering up 4080000.remoteproc
[   56.506365][  T344] type=1400 audit(1666698550.979:268): avc:
denied { open } for comm="rmtfs"
path="/sys/devices/platform/remoteproc-cdsp/modalias" dev="sysfs"
ino=6325 scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs:s0
tclass=file permissive=1
[   56.515137][ T1821] remoteproc remoteproc0: Booting fw image
qcom/sdm845/mba.mbn, size 242400
[   56.535020][  T344] type=1400 audit(1666698550.979:269): avc:
denied { read } for comm="rmtfs" name="modalias" dev="sysfs" ino=7200
scontext=u:r:rmtfs:s0 tcontext=u:object_r:sysfs_remoteproc:s0
tclass=file permissive=1
[   56.621541][ T1821] qcom-q6v5-mss 4080000.remoteproc: MBA booted
without debug policy, loading mpss
