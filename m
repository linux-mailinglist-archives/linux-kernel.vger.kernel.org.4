Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2A6C7813
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCXGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCXGj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:39:59 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20B10D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:39:57 -0700 (PDT)
Date:   Fri, 24 Mar 2023 06:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1679639994; x=1679899194;
        bh=t8jpMN3wfbAQuj49A582R+IEs96xm9DZzn+g2KuauyU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BYXA0/5YuV1Mln4WmAEtlUIS+6rncvW94XSn1d6MCU2fXseNVD8VqjtVHPirutP+R
         h2thlHKG9Djbq+BcAUAiex4HO9tNaovz4/4NptN1JDkvnEdgm47uJskbXM5KxCxxLS
         AR5n+/9NfpE2EQJ3HEJJRzg5FVv/chmc6vSm2Y2hlelkwu/6Xae3tmCF8v3a9nfyqD
         h5ICqSzQI6y/lCVxW864auAHwt0iPAtMmatSjYwotsn0Oe6TUT7XQ1yL0YUyLpQLzB
         cUvl+tXxVNEEQK1VLZYZ4Vy15MxamSda9amGr7vOWHYdWOGDgsVeP1uFyZl4qg38FB
         AY2mvMsVqwKjg==
To:     Tom Rix <trix@redhat.com>
From:   Juerg Haefliger <juergh@proton.me>
Cc:     jdelvare@suse.com, linux@roeck-us.net, nathan@kernel.org,
        ndesaulniers@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] hwmon: remove unused superio_outb function
Message-ID: <gqQsy2yvABurRT9U-4tOiaWH2TVeWQYwyGv1404EC-DjGvEaetDVDaumJCJUrmHirk1-npBa4cVtU-19HfGJSvpF28Qmd0Qw4ANatYC-ZMo=@proton.me>
In-Reply-To: <20230323211535.2637939-1-trix@redhat.com>
References: <20230323211535.2637939-1-trix@redhat.com>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org






------- Original Message -------
On Thursday, March 23rd, 2023 at 22:15, Tom Rix <trix@redhat.com> wrote:


>=20
>=20
> clang with W=3D1 reports
> drivers/hwmon/vt1211.c:198:20: error: unused function
> 'superio_outb' [-Werror,-Wunused-function]
> static inline void superio_outb(int sio_cip, int reg, int val)
> ^
> This function is not used so remove it.
>=20
> Signed-off-by: Tom Rix trix@redhat.com

Looks good.

Acked-by: Juerg Haefliger <juergh@proton.me>

...Juerg

=20
> ---
> drivers/hwmon/vt1211.c | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
> index 4a5e911d26eb..fcd4be7a5a85 100644
> --- a/drivers/hwmon/vt1211.c
> +++ b/drivers/hwmon/vt1211.c
> @@ -195,12 +195,6 @@ struct vt1211_data {
> /* VT1211 logical device numbers /
> #define SIO_VT1211_LDN_HWMON 0x0b / HW monitor */
>=20
> -static inline void superio_outb(int sio_cip, int reg, int val)
> -{
> - outb(reg, sio_cip);
> - outb(val, sio_cip + 1);
> -}
> -
> static inline int superio_inb(int sio_cip, int reg)
> {
> outb(reg, sio_cip);
> --
> 2.27.0
