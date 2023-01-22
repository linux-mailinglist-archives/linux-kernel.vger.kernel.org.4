Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5443D676BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjAVJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAVJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:32:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E092C5BB4;
        Sun, 22 Jan 2023 01:32:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C3A60B8B;
        Sun, 22 Jan 2023 09:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F6C433D2;
        Sun, 22 Jan 2023 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674379943;
        bh=uC3/a1QYuk7Er+b6doMs59esn5PttAah1q0oML9AKJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+3Mz7aSZxzP4hvHOHhdO/uvNEAUbRDUYGdu1xmdPQt1BkAVKn+L/UlhRgl2eNfvL
         RQHLiNXFHdO/BqxMkAnOeVJ3HAWMI0REfQtZ7PowO3RcdDcoM952iCsgUFhmFC0QDQ
         qYu6Ih2jRq+tAS7RyxjFngQb/h0I79vC3Mkduwvz6iEzIw+Oaw4nhij4SbK0Pe1xE7
         2flCdKyFAchyWWCi8P5LoJWKGkEVICodixudo1TlR9hT/Em1eYph+LC3igBAmfFJMG
         4HEl9565sFmAy+Zov1/pzI1Qt9zUZMfQxiOW4svgNXznUEyiGFXaM/diS8B15kf5EQ
         pfEKRvNcWLgOQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5018be4ae8eso70237937b3.4;
        Sun, 22 Jan 2023 01:32:23 -0800 (PST)
X-Gm-Message-State: AFqh2kp2iJL39r78H7TxM0UcRM1+AEHwXSAa8bluAcmmpACSh/Sz43Be
        kQUNa7qvdMYkyXzFrMHD66oVA/fkep+7pPR+b1U=
X-Google-Smtp-Source: AMrXdXv9TOgeuY1xgAbnP/G4ibHYtrwjCNO32Mt2B3HYIAybSnOd/Eeext8RtG65ea1RGvyvZZ23R35TAP8Qv2w3Sas=
X-Received: by 2002:a81:9b92:0:b0:4d2:755a:fda3 with SMTP id
 s140-20020a819b92000000b004d2755afda3mr2014674ywg.182.1674379942560; Sun, 22
 Jan 2023 01:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20230120113246.1a0a03fe@canb.auug.org.au>
In-Reply-To: <20230120113246.1a0a03fe@canb.auug.org.au>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 22 Jan 2023 11:31:55 +0200
X-Gmail-Original-Message-ID: <CAFCwf11xZJi+-12FRO4yKhLHOkN_CEsa_W2RnGUkWHcEm+CiDw@mail.gmail.com>
Message-ID: <CAFCwf11xZJi+-12FRO4yKhLHOkN_CEsa_W2RnGUkWHcEm+CiDw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the accel tree with the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 2:32 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the accel tree got conflicts in:
>
>   drivers/Makefile
>   drivers/accel/Kconfig
>   drivers/accel/Makefile
>
> between commit:
>
>   35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
>
> from the drm-misc tree and commit:
>
>   45886b6fa0f1 ("habanalabs: move driver to accel subsystem")
>
> from the accel tree.
>
> I fixed it up (I used the latter version of Makefile and see below) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/accel/Kconfig
> index 4989376e5938,a5989b55178a..000000000000
> --- a/drivers/accel/Kconfig
> +++ b/drivers/accel/Kconfig
> @@@ -23,4 -23,4 +23,5 @@@ menuconfig DRM_ACCE
>           different device files, called accel/accel* (in /dev, sysfs
>           and debugfs).
>
> + source "drivers/accel/habanalabs/Kconfig"
>  +source "drivers/accel/ivpu/Kconfig"
> diff --cc drivers/accel/Makefile
> index b1036dbc0ba4,4df38885d6c6..000000000000
> --- a/drivers/accel/Makefile
> +++ b/drivers/accel/Makefile
> @@@ -1,3 -1,3 +1,4 @@@
>   # SPDX-License-Identifier: GPL-2.0-only
>
>  -obj-y  += habanalabs/
> ++obj-y  += habanalabs/
>  +obj-y += ivpu/
>
Thanks Stephen,
Fixes looks sane to me.
Oded
