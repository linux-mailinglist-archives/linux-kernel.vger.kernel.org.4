Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80166573EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiL1I2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiL1I17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:27:59 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3ED62
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:27:58 -0800 (PST)
Date:   Wed, 28 Dec 2022 08:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1672216073; x=1672475273;
        bh=+uicGGm0rVG9mzz/n12xPS2vmSjzqNkzmFdxb9rQ2LI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RL82hTzWGuigd1S5CdU1vgaxGRQpSGB2L5NKWl4+YVucFrYYsHpePNBv/Iv/fLAz3
         sMBZ9APhZk/d+caMYHJWJP/x5uSQyoeHFEU/IJPZ/eVvZoelHRtq8qXheIjOY+Qrzg
         yfKErvo4FSpHSmNYvev7p0TZfH6vemnYx1zNTtXJ8ECH7QzXg51gIDIgogew1pnIxj
         Bs9BogVEuwJIWv7gjWTDr0GaGnghAQo22egSPFuPPrPgGWMyZTBEzPbZ193rcVr/Ru
         DTvbzMvXTbh5kQ4WIgY76GehyUulgEXN9K4XTxKLeTpjry7LKZTd3UVbl0ZQO1ASrh
         62Djuueaq7Smg==
To:     Aditya Garg <gargaditya08@live.com>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank screen on Linux
Message-ID: <20221228192740.1ec44a3d@localhost>
In-Reply-To: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
Feedback-ID: 28131841:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 21:44:06 +1100
"Aditya Garg" <gargaditya08@live.com> wrote:

> The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in
> MacBook Pro 16 inch, 2019 (MacBookPro16,4).
>=20
> The GPU fails to work on Linux, thus a blank black screen gets
> displayed on boot.
>=20
> If nomodeset is added as a kernel parameter, we are able to access
> Linux easily.
>=20
> The link below contains the journalctl of the failed boot :-
> https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7
>=20
> Thanks
> Aditya

I'm not sure if it was an unrelated issue, but on older versions
including 5.17.1, psp_v11_0_bootloader_load_sysdrv would timeout and
return -ETIME. I'm not sure when it started having Mode Validation
Warnings instead, but these errors are what it previously had:

[    5.136077] [drm:psp_hw_start [amdgpu]] *ERROR* PSP load sys drv failed!
[    5.136233] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading fail=
ed
[    5.136351] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of I=
P block <psp> failed -22
[    5.136458] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
[    5.136477] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
[    5.136540] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
[    5.137815] amdgpu: probe of 0000:03:00.0 failed with error -22

The patch used to test this and the kernel log I received from someone
using that patch are on this page:
https://gist.github.com/Redecorating/645a62eec4fb06e03f384396f483fa37


