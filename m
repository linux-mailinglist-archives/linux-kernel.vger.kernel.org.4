Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A889607F12
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJUTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJUTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:32:55 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164BD2505C3;
        Fri, 21 Oct 2022 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1666380768; bh=iOjw4y7HyVQfS/8t6MNRacekJ0y7x8kJRV6uNTkBJP0=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=skRno2TLIS5tzhoN0iDFf8oexHduUUk8zEsykGbBsArZyzIUvFLy9zHy2T8EQySCa
         YDZPX/DVV9wdf0FupcqvLZkw/h37sXIuU+VD7n0yqvMtbC206xPnsZWdDUQPltBPYn
         ePHp0WY+OB8R+YynJQrr+atNQtYJlQM+2a0D/Vk8=
Date:   Fri, 21 Oct 2022 21:32:48 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Message-ID: <20221021193248.2he6amnj7knk4biu@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core>
 <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
 <20221021153913.l5ry6v4mcnzcmj2v@core>
 <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:48:15PM -0400, Peter Geis wrote:
> On Fri, Oct 21, 2022 at 11:39 AM Ondřej Jirman <megi@xff.cz> wrote:
> >
> > On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> > > Good Morning Heiko,
> > >
> > > Apologies for just getting to this, I'm still in the middle of moving
> > > and just got my lab set back up.
> > >
> > > I've tested this patch series and it leads to the same regression with
> > > NVMe drives. A loop of md5sum on two identical 4GB random files
> > > produces the following results:
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> > > 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> > > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > > b9637505bf88ed725f6d03deb7065dab  test-rand.img
> > > f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> > >
> > > Before this patch series:
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > >
> > > Though I do love where this patch is going and would like to see if it
> > > can be made to work, in its current form it does not.
> >
> > Thanks for the test. Can you please also test v1? Also please share lspci -vvv
> > of your nvme drive, so that we can see allocated address ranges, etc.
> 
> Good catch, with your patch as is, the following issue crops up:
> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=16K]
> Region 2: I/O ports at 1000 [disabled] [size=256]
> 
> However, with a simple fix, we can get this:
> Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=16K]
> Region 2: I/O ports at 1000 [virtual] [size=256]
> 
> and with it a working NVMe drive.
> 
> Change the following range:
> 0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
> to
> 0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;

I've already tried this, but this unfrotunately breaks the wifi cards.
(those only use the I/O space) Maybe because I/O and memory address spaces
now overlap, I don't know. That's why I used the 1GiB offset for memory
space.

kind regards,
	o.

> I still haven't tested this with other cards yet, and another patch
> that does similar work I've tested successfully as well with NVMe
> drives. I'll have to get back to you on the results of greater
> testing.
> 
> Very Respectfully,
> Peter Geis
> 
> >
> > kind regards,
> >         o.
> >
> > > Very Respectfully,
> > > Peter Geis
