Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A763D74A34C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGFRmK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGFRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:42:08 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2E10EA;
        Thu,  6 Jul 2023 10:42:06 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHSzK-001UkR-DR; Thu, 06 Jul 2023 19:41:54 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHSzK-000vaV-5w; Thu, 06 Jul 2023 19:41:54 +0200
Message-ID: <29ad9e3d1a83d03190626ba66b7d71c833776982.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 19:41:48 +0200
In-Reply-To: <c63b387a-e670-fed1-86df-83bff46789a1@roeck-us.net>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
         <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
         <c63b387a-e670-fed1-86df-83bff46789a1@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.14
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter!

On Thu, 2023-07-06 at 10:04 -0700, Guenter Roeck wrote:
> I tried rts7751r2dplus_defconfig with no modifications and the following minimized
> qemu command line.
> 
> qemu-system-sh4 -M r2d -kernel arch/sh/boot/zImage -serial null -serial stdio -nographic -monitor null
> 
> This hangs after "heartbeat: version 0.1.2 loaded", so it doesn't
> even get to the point where it would try to load a root file system.
> After reverting this patch, I get
> ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---
> as expected.
> 
> I tried with qemu version 6.2, 7.1, 7.2, and 8.0.

I'm curios to hear what Geert and Sergey have to say. I hope we don't have to revert this :-(.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
