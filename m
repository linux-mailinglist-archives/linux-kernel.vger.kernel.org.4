Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D860BD13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiJXWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiJXWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:05:22 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AF1A0C35;
        Mon, 24 Oct 2022 13:19:12 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id t4so7147524wmj.5;
        Mon, 24 Oct 2022 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9ed7bMV3pZPwp5vouAUj8oUDbSAtj4hiuKrUSv/lak=;
        b=agOIyiO5ryyJk3ZIcpmVzCeFNdSLnKfhi5W3NLU6tdTBM3MxHzy5ZOPjmjjpnS80/P
         fnZE3cSyIsAOrBXUPM4+St3sCnjNCSRDCv2joHN+oVmS8tOpNxRAZnyo/MlSHWdmk3OK
         G0/lOJM2zC9V8UhH4+RfCmnl7xtZ+hrZ8k/RSCSTx5IVs7Wen5bZwyiaF0DOtnJw+2Ln
         4T18Y+mWm5kZJHadzP9L6S1xJEal4SkqaUeJ/Tb51kIJyJdK9/H9zfZ90tMc1Wj5lEio
         cd5I4CAKfcCctNzpY06qlm8G3hCEKdAwakl8FyRCTm4PcdZms/+X6Za7k5iH1wmttDzp
         p19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9ed7bMV3pZPwp5vouAUj8oUDbSAtj4hiuKrUSv/lak=;
        b=xfekLot2bfYEE6Mok4bBx19XhpWfhkDSaGoahuoTaDdatSZRj5uz95jvTuGp42W9z2
         1d0xdIY8RdNQgtwfZPfPu3iJ8nxdDuN9cKJ1ehMmZO4OSOZ0MO9Pz3NUCDd3WOZENrQw
         zQXsWyPM0SA1vK8GwiWdrB4H9HtC3ArRo4riYVRdgBfN0gyHuSKnXg+jgDlmbcBD2OZe
         LACiLZt5tOqUIZ4MySJgkb1sSCMrA5YqfBdZgW3sSBZnUeTfAyuyw82TT4CjV119iS9W
         +R5AFeJrMMGJE5nNI0egQxM2/kwnlGJ0IWAPZozUwlrHZ12BjDKv3uyQGfUaPndi5GZA
         yj0g==
X-Gm-Message-State: ACrzQf0Vj3a1Dx3RIZQL79+Ck7om4WauIypf4zm9iIyjAuyf+v4Nr9kA
        2nsnBsLNNhe+67RSCZgtGiLf4lCTc1K8fyHzKsA=
X-Google-Smtp-Source: AMsMyM7xa4Ly82aRqbE40+JOrlCjUC2tANKr0UN56zsNRY6I52d2j/9oCji2atR3311eDNCP3jJF3h92LfkJopZA+ys=
X-Received: by 2002:a05:600c:5122:b0:3c6:fcce:e4e2 with SMTP id
 o34-20020a05600c512200b003c6fccee4e2mr24525426wms.65.1666642598270; Mon, 24
 Oct 2022 13:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221005085439.740992-1-megi@xff.cz> <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core> <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
 <20221021193248.2he6amnj7knk4biu@core> <87edv0sxup.fsf@bloch.sibelius.xs4all.nl>
 <CAMdYzYp6ShLqKxdiAjaRFiRF5i+wzfKiQvwPMzyQLAutWZbApg@mail.gmail.com>
 <875ygbsrf3.fsf@bloch.sibelius.xs4all.nl> <5a8f9934-1959-7962-d575-e3c2f5bc6ade@arm.com>
In-Reply-To: <5a8f9934-1959-7962-d575-e3c2f5bc6ade@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 24 Oct 2022 16:16:24 -0400
Message-ID: <CAMdYzYrXp1kgdRpBmnfiFrXcdkk6_oWozpywgCYbNo_MU+8+=A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>, megi@xff.cz,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, frattaroli.nicolas@gmail.com,
        s.hauer@pengutronix.de, frank-w@public-files.de,
        ezequiel@vanguardiasur.com.ar, yifeng.zhao@rock-chips.com,
        jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 7:05 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-10-22 18:24, Mark Kettenis wrote:
> >> From: Peter Geis <pgwipeout@gmail.com>
> >> Date: Sat, 22 Oct 2022 08:19:57 -0400
> >
> > Hello Peter,
> >
> >> On Fri, Oct 21, 2022 at 4:52 PM Mark Kettenis <mark.kettenis@xs4all.nl=
> wrote:
> >>>
> >>>> Date: Fri, 21 Oct 2022 21:32:48 +0200
> >>>> From: Ond=C5=99ej Jirman <megi@xff.cz>
> >>>>
> >>>> On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> >>>>> On Fri, Oct 21, 2022 at 11:39 AM Ond=C5=99ej Jirman <megi@xff.cz> w=
rote:
> >>>>>>
> >>>>>> On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> >>>>>>> Good Morning Heiko,
> >>>>>>>
> >>>>>>> Apologies for just getting to this, I'm still in the middle of mo=
ving
> >>>>>>> and just got my lab set back up.
> >>>>>>>
> >>>>>>> I've tested this patch series and it leads to the same regression=
 with
> >>>>>>> NVMe drives. A loop of md5sum on two identical 4GB random files
> >>>>>>> produces the following results:
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>> fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> >>>>>>> 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> >>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> >>>>>>> 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> >>>>>>> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> >>>>>>> b9637505bf88ed725f6d03deb7065dab  test-rand.img
> >>>>>>> f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> >>>>>>>
> >>>>>>> Before this patch series:
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> >>>>>>> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >>>>>>>
> >>>>>>> Though I do love where this patch is going and would like to see =
if it
> >>>>>>> can be made to work, in its current form it does not.
> >>>>>>
> >>>>>> Thanks for the test. Can you please also test v1? Also please shar=
e lspci -vvv
> >>>>>> of your nvme drive, so that we can see allocated address ranges, e=
tc.
> >>>>>
> >>>>> Good catch, with your patch as is, the following issue crops up:
> >>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=3D16=
K]
> >>>>> Region 2: I/O ports at 1000 [disabled] [size=3D256]
> >>>>>
> >>>>> However, with a simple fix, we can get this:
> >>>>> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] =
[size=3D16K]
> >>>>> Region 2: I/O ports at 1000 [virtual] [size=3D256]
> >>>>>
> >>>>> and with it a working NVMe drive.
> >>>>>
> >>>>> Change the following range:
> >>>>> 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> >>>>> to
> >>>>> 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;
> >>>>
> >>>> I've already tried this, but this unfrotunately breaks the wifi card=
s.
> >>>> (those only use the I/O space) Maybe because I/O and memory address =
spaces
> >>>> now overlap, I don't know. That's why I used the 1GiB offset for mem=
ory
> >>>> space.
> >>>
> >>> Meanwhile, I have an NVMe drive that only works if mmio is completely
> >>> untranslated.  This is an ADATA SX8000NP drive, which uses a Silicon
> >>> Motion SM2260 controller.
> >>>
> >>> So for me, a working configuration has the following "ranges":
> >>>
> >>> ranges =3D <0x01000000 0x0 0x00000000 0x3 0x3fff0000 0x0 0x00010000>,
> >>>           <0x02000000 0x0 0xf4000000 0x0 0xf4000000 0x0 0x02000000>,
> >>>           <0x03000000 0x3 0x10000000 0x3 0x10000000 0x0 0x2fff0000>;
> >>>
> >>> This also needs changes to the "reg" propery:
> >>>
> >>> reg =3D <0x3 0xc0000000 0x0 0x00400000>,
> >>>        <0x0 0xfe260000 0x0 0x00010000>,
> >>>        <0x3 0x00000000 0x0 0x10000000>;
> >>
> >> Now this is interesting. I've been reading up on PCIe ranges and what
> >> is necessary for things to work properly, and I found this interesting
> >> article from ARM:
> >> https://developer.arm.com/documentation/102337/0000/Programmers-model/=
Memory-maps/AP-system-memory-map/PCIe-MMIO-and-ECAM-memory-regions
> >>
> >> TLDR: We need a low region (below 4g) and a high region.
> >
> > Well, that description applies to a specific ARM reference design.
> > And it appears that the PCIe-RC used in that reference design does not
> > support address translation.
>
> Indeed, that's not an "interesting article", it's just documentation for
> some other system that isn't this one. In fact it's a system that
> strictly doesn't even *have* PCIe; the reference designs are not
> complete SoCs, and all that is being described there is the interconnect
> address map for the parts which are in place ready for a customer to
> stitch their choice of PCIe implementation to.
>
> The equivalent for RK3568 is that you *do* have "low" and "high" PCIe
> windows at 0xfx000000 and 0x3xxx00000 respectively in the system
> interconnect address map. How the PCIe controllers choose to relate
> those system MMIO addresses to those to PCI Memory, I/O and Config space
> addresses is another matter entirely.

Unfortunately we are working with insufficient documentation and
without the detailed understanding of a system integrator here. I'm
fully aware that the Neoverse N2 is not the rk3568, however
significant chunks of the rk3568 are based on ARM IP. Looking at how
ARM expects things to work by comparing their reference documents to
the hardware we have on hand is helpful in determining what we are
lacking.

The specific portions of the documentation that I found useful are not
the memory maps, but the generic descriptions of expected PCIe
regions. Combining those with other reference documents (unfortunately
most x86 based, but we have the unfortunate reality that PCIe has a
lot of x86isms to deal with) is quite enlightening. I've been pinging
various representatives of the IP and implementation on the mailing
list about these issues for about a year now with no responses from
the Designware folk. You have been pretty one of the only individuals
with the level of knowledge we need to respond and I thank you for
that.

Based on what I've read I suspect that at least one of the two
following statements is true:
a. Mark is correct that translation is broken in Rockchip's
implementation (unknown if this is a SoC or a driver issue)
b. We do in fact require IO and Config to be 32 bit addressable to be
fully compatible.

These issues are compounded in rk3588 where we have much smaller
regions in the 32bit space for PCIe, so a definite answer on the true
requirements and limitations would be quite helpful.

As always, thank you for your time,
Peter

>
> Robin.
