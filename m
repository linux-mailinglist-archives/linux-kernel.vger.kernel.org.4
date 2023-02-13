Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD45693E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBMG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBMG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:58:17 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C296DA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:58:13 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B7C571C0003;
        Mon, 13 Feb 2023 06:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676271490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5ffWlE9Fge2l3HWz1yfAkL/3WPC9cXbFyLq3aIvwmM=;
        b=SZDqO7IDfZsY4Hk+jjtdzCZZ11rveeU8rlYTCNWwKp2QtoV3ZjJVMG0d9fOu42SZb2j0kH
        zZopAmGbEj358Sh+1ExUev/dshwTZEXjncnykRlWKTn8zT3r/PXCF5gxFTDTctekrK6JBI
        59iqQhXuhFR+rC++3ZDn8YvxifMfONqXclbIfl19GpDltNVs8wlYWM4e+sPyqafXoGQvrb
        Xiy52t8tdRuipp8yRkPN+vMGkSc2D/3QBDBVaOHfpr+vSgdv93nv0n4VYSaelzyjJEOkf2
        OS6WEWannD4vJ7Sl4W5I9Z5Zpi7L1oexPL5iMB0c9DCvOJ5yu5m6RyAk/LXoXg==
Date:   Mon, 13 Feb 2023 07:58:08 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Message-ID: <20230213075808.45c9c4f6@bootlin.com>
In-Reply-To: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
References: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Mon, 13 Feb 2023 09:05:47 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> ./sound/soc/codecs/peb2466.c:1851:2-3: Unneeded semicolon
> ./sound/soc/codecs/peb2466.c:1887:2-3: Unneeded semicolon
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4045
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  sound/soc/codecs/peb2466.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Oups, I missed those. My bad.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
