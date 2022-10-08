Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA95F8546
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJHM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJHM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:57:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E24F383;
        Sat,  8 Oct 2022 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665233855;
        bh=s+2+2kycVD9oyxcdU/CavIImGGRGVwDZHztfoj8Vdes=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S+P6QkFtEtGR/I6BUlypr84qpccLaw6XNLi91ooKExguq1dKpjAnIL811mH1iafSn
         IR4Z958MhMmrMYFkj6f0/bfQtRntyfAjRPTrYLXMe4q3uDGnm5DTOZO1L4HL23IU7y
         DnMXFRZ67va38yYViA3v6y4etal2BW2wBcfgp2wU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.144.139]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1oWccP05He-00OquB; Sat, 08
 Oct 2022 14:57:35 +0200
Message-ID: <061577e4-418a-62f5-0d96-f66c9e53ae27@gmx.de>
Date:   Sat, 8 Oct 2022 14:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] video: fbdev: mb862xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <58bf3cab7a6a7797f109ea40490cf5520c4b565d.1665034339.git.christophe.leroy@csgroup.eu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <58bf3cab7a6a7797f109ea40490cf5520c4b565d.1665034339.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FH56TXrZlbSdrpLmwtbkT9cBWXgZNBLcTpb5BJh9gv7c5tUsMtZ
 hbV9GzMN1OW5oK2Wc77JFgdv9GXYH/BrxrbrJB01JE9CLQjIg4jj3FI9LWNR8VOn1jEJajd
 KSwU4O4u1MsHM+6bv1+qxDF9M86gDSL9gs3BuduL0f3ff/0qqkxBR486zIalt2EPwuUDxBg
 9Gz+Bomaa1SYf9SpjV0MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z61PNc56Pmw=:Gy7kftq1Dg2MKWyWB3g8dq
 dP2Qma40SOmW7R4G9LylhiOFRPWUQ+51m6cELbZY6iZ81Uk2I3QASQGJDr0yzlj/9Xt/4oFgv
 Of46S5jdskSV3ooZKpotxH+PreKYbxbjw72wtV7K1jb7N6x6fwGGq8B0HLwme7O9DwNOZ0TmU
 je0CK9aYEtuVSulmM0Xlo+lQh+AUp25qnXhsjApecjZNlxAi7ssMSo60ZYkacQPcSFs9pbap9
 OoYwMRnLkkDvbkceArK/XT9fBXtOztOuKtJWEvj7PFF5Fp/mVDvT8PT0T13B004tWKO9PF9pZ
 Fke5DgqcKOeuyPg7Skhm4veSQK7VT2gczGIGFr7ISCk2bt0GXc3IJYA/Ai6irTwUUT36jELcc
 GI6OzDDxAHoWgabPgWolBjRcSanlfISdakWToHiQtjQbXaOO1UQBqReRnX/X+4uf1yEzX1c/q
 rKxNf1G7ZTM5MotIh7nt4V4DViQYjtbGCK1rCJJqskm2+s2RqAXOmGg8Tiinj+eEzKeUoaxRf
 ER+ZKhoVjRg9iQluGxW2ArZbdv1fetawXhuD9A9cG+lGlNXnYhngBN8C+VpUx9xsY7UYvNRTv
 GfQobjP4mVcAs6TPn5CZFAAJ1C61VMNtL7cpLMfOz6FWLLSdogl36wA9H4DbhtBxO0Rzn+zSR
 +js4Bhu57byQHdbSCT0bwhULt/uD4ugGCbqXf6y+PbaQUA01F2/qI17mdR8kW7ytm0MbLoEgu
 MJ35VLUZuPhkK9CAjcMVmBviTblt47lpARbpY9l6d9DbcdF0ws5wT4TjaxgqYksljBHkcYfqH
 xFhcaCpJfPJIJiFAg6juYKABNFLNs8Xeot3vSwC7FmCJLh/XtpxL8Jz2/ZIySeT74k7cHizs5
 kB17uqKc+C1QFX87mgJ+rh22VNCJ1gY5ZyD3DtYEUR3YEle/yh5AlmA6FZeMToh3I91Lp79Br
 bdjP12XK4Tqe3qR7LmrbVmZvs2u6/by9hsoO576MWDJwEP60zz2HfMs88zYubn1T1+Fx+FzAd
 vEDX/WemziWuPGsyP9IrHp0hTk+9YN7m3jVT2h0UhekpNkrhRZoYNdv3dzbmuPjVZOZj7j/Hv
 VZ2UUXS0EHbECsgPgkqT3fiAy96eCEfK4IEzFUJbggFRbfCfjQggSmPzcMgmZWcEHTXIatK4p
 GTqJePg0PxkJdEcRHKXDfzShvWNPEifUXzbxuj/vkYSedZ/IUiRQFFQb9XZsxyrvKo4GUSVsr
 /dRRSkzOxATs0jt7cMNfUrP5wZkDnRFz+ksa3hZtfwhTsjZOjsXJkXNWJZDalXshX0/+ZGkph
 5IbrY0CLr3x25mxJfP4vPPbswjp6iguOBXF4WyFYyB0TJGHVKtf7BRUgmDBZyG3Zgxy4xZmZ+
 twOLBLVSGgQS0YwhVcozWRyprAgoEV6fZnN4iGQRz6viBBli7/t43q4z2jt+5IFLqx8w6gC9P
 yYxJGolit1ksaj2bhwGOGRUUoLXBpTqgHDVzGEOsNLkSjG0EpXNuYTNabkTtcrxBNVpWGQ0jP
 4DToTQhK36J12rm7N/jSrdT55+feVvK7F2lL/3BVkkpYS
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 07:33, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
>
> On some architecture NO_IRQ is 0, on other architectures it is -1.
>
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
>
> So use 0 instead of using NO_IRQ.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

applied.
Thanks!

Helge


> ---
>   drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/=
fbdev/mb862xx/mb862xxfbdrv.c
> index a7508f5be343..3f605d2d8f0c 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -692,7 +692,7 @@ static int of_platform_mb862xx_probe(struct platform=
_device *ofdev)
>   	par->dev =3D dev;
>
>   	par->irq =3D irq_of_parse_and_map(np, 0);
> -	if (par->irq =3D=3D NO_IRQ) {
> +	if (!par->irq) {
>   		dev_err(dev, "failed to map irq\n");
>   		ret =3D -ENODEV;
>   		goto fbrel;

