Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395A5F8580
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJHNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:54:15 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AC3FD6D;
        Sat,  8 Oct 2022 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=Zs3yse/FCc/d/dZqMfl/7G2TNvLufktmf9MIa0JGpys=; b=UFvvdHiVxRouMXUh+R18sax4A7
        K/xKg4nWLVld9dBRwZatPGbocpqoozbMOIAbhonSn6953ElnavnoVuWW8oqraZtM7jBl5Sy5zCUPA
        pps9CdY4CabpcvC1IGEOYuxpP8aOBGTCb2AZ1uWlXYBuKe7q3ojlaciEh4hJ6DIOSeitCZ5cmrwh2
        fHB6fyI51TObKQgBPtMym1DRUEY1fqByGJIM02dzpyO0pWRIBCtDbwuMoUaaTB/C4oV6rrOjCvsod
        sjSEn9qP/le7yP8UDBd6Yy43zDcK2Ee5Zhs8KF7ruZdI1z9US0wI/GUUIil3yHHsnfOi7AWULYV+8
        5HUrJdag==;
Received: from aurel32 by hall.aurel32.net with local (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ohAH9-0022Yw-9i; Sat, 08 Oct 2022 15:53:59 +0200
Date:   Sat, 8 Oct 2022 15:53:59 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Dan Johansen <strit@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>
Subject: Re: [PATCH v3 00/13] Add support for the Hardkernel ODROID-M1 board
Message-ID: <Y0GA92rYss1Wslgr@aurel32.net>
Mail-Followup-To: Dan Johansen <strit@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>
References: <20220930051246.391614-1-aurelien@aurel32.net>
 <8e84786d-8ae9-0f51-3438-24fb340199c6@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8e84786d-8ae9-0f51-3438-24fb340199c6@manjaro.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-08 14:11, Dan Johansen wrote:
>=20
> Den 30.09.2022 kl. 07.12 skrev Aurelien Jarno:
> > On the ODROID forum, Dongjin Kim said he is not planning to submit a new
> > version of the patchset adding support for the Hardkernel ODROID-M1
> > board. I therefore decided to address the issues reported during the
> > initial review, and I also did some small fixes either because some
> > things changed in the meantime on the kernel side or because I noticed
> > some warning or issues when using the hardware.
> >=20
> > I continued writing some additional patches to complete the ODROID M1
> > DTS to almost fully support the hardware, the drivers being already
> > present in the kernel.
> >=20
> > This new version includes feedback from the linux-rockchip mailing list
> > and from the Odroid forum.
> >=20
> > Changes since v2:
> > * Renamed "Rockchip RK3568 Hardkernel ODROID-M1" into "Hardkernel Odroid
> >    M1" and fix the sorting.
> > * Fix sorting of arch/arm64/boot/dts/rockchip/Makefile
> > * Collected Acked-by and Tested-by
>=20
> Even though I added my Tested-by to this series, it seems I didn't test it
> on eMMC.
>=20
> This fails to boot for me on eMMC, but works on SD card and NVMe.

Thanks for the feedback. I do not have an eMMC, so this the only part
=66rom the patchset that I haven't been able to test.

First of all, which version have you tested? The v2 includes fixes for
the eMMC, there was a conflict with the NOR flash. If the problem is
still there in the v2, could you please send the boot log or the error
message?

Thanks
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
