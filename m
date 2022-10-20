Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7B605762
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJTGfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJTGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:35:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F3BC608;
        Wed, 19 Oct 2022 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666247695;
        bh=vKBOYiiDYu+sfV4JLD93t9oJLcn4956Rbkypp34tJU4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MjAytoTji6RK32KGrWSd40phvZu23VqTiVuhwxXvdJqYtbW0htWzvO4CXzfiHoMky
         A/ni2xBEBeMEsSTweanADPfVkdN13tQwPiDbxROK2OPt4EU/RzmHfpQmahbAjIYImt
         XDwyzKYJvgzBxLYaxJRiWOX7fsPmiyn0iiAVTpEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.164.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1p0snG0UI5-00xvrF; Thu, 20
 Oct 2022 08:34:55 +0200
Message-ID: <991619f0-516e-bda4-57c5-93cab654d261@gmx.de>
Date:   Thu, 20 Oct 2022 08:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] video: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, thomas@winischhofer.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221019125738.54964-1-yuanjilin@cdjrlc.com>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221019125738.54964-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yuRjDwfr/9QcRKvx5rcMWrZ8MJ9vPAeABZBDX5+WmQ30KtjheYZ
 qkdF9nlstcFghYJ1JFqDHyN9PEVuDVT4UwpDSVMIY1mPOWQ4nwgKai03PeHQsbWXC1Dhfr1
 kHGGLgbLPcVekFebdjRKKLyNv3eYS57MoJeAHzZ7dnrztm8D+zbES5TZmVX0RdnN1XF7kPV
 qGL79GpJco6UB37x+ICmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBnwqRaSojc=:28fjBE6I6nlc9bB3Kce5MZ
 m5ANxO1Yt0peIkQBcMPUipNYJJlXIC4nvekJlBSNrxs9EITMV3L+AYvWRP9XV9M1npfOUCs7k
 MbHFZUtO3gGrjS2pXGpsPy20qWTnRizxhUDq1KuTrzaYZtTxqHMVh26ZVhfT/gubtGqoj0208
 2R02mlMoJAPn54/FE3UwEwGxiFwDuT7TWDcZIKXoEI/OktOhLuCH+c/ioz3swrMCbgeAAGcs0
 I0URm3wPf/dhOQ7bLnKUREoeCiafjZV0PNsRJrOeL8NUJEVDOKQcX6al7tTZWLFCOffVVBgbV
 /usBTGZVusb22ol2vhXxRgcNfJ1ka3A3/22wIChWmXPBd8gFrDa9wo9MncW46V0isf0FnQgD8
 yTZM1ad2AM9tdKYakq3uw/sOLxEePAAsT7DgMc6aKSnQ6g8U+zK/uO6IcABXoPP5vQM52/JnW
 XW3+m6QfX/4LJL8SwZCNf/8TYoO/rmjnDXDntBjPHPJb6dykOR0AoQP121FTkKHwzg8Y2Kd2U
 Gt7R+uOL+Xc+okk3wYYqaVAjGuhhMEGMbfwDnaJ0UqG+zBiMHXOPkma3M1nIOT+OWk35P17jy
 hnzmd53xiEjs3EmO94YPn4XN27zbGd/mPQ9ppATwuqL4wmR9ih8lUSOgTg6Xt5WH41JYbspze
 h3qC/AkwAmZZNLIqYa3IT2GsaudDooiE+j0YZKaYUOXaLHL7aHvSrFtrLc7bMy+A92AeEFt+i
 IS97FRaBf5cimVKsOZJgvjDgcePwEXN+f5O47oHVg9Dk50aa0+uz2dhiUvyejIcepA6bALfQT
 Yh5ZfpS/x/fVM1A8CnPG2A8wRJLqUzc4FFS0Hn6/tMwCHhkyeI/riLIFjMdVd/Dr2d92g5wfQ
 pUyNQ+LOOi0MpH6OuUNc2mDQxVJRSsInV8EHZyW7zVeP+/SYuq8m9MKASUCfYwS+NYebmIqDq
 vrCHHmKaajYpY5H9WofaSjwSSycH3PDtSIS63UeJc2M9QYZ35Gz0VqRe2y8IV8xd/w6a7jL9t
 DILSGuRlaJXuY/RfTpgZ5NevVq38eNksnu2MnqoB/QWESVZXpaZdYgPMLLva9ivJO0ZRs4JJm
 Whr2ODxK5ZZWoXAmCybFL8B660h4qaKQhETSxaFm0awcide6yuH7HiBpYLwSVTrv3QVgHaNxz
 vhZlcZH0mKEOCTMzDA8mO/alpG2JMDNM0Rb5RXEKQZMU2A9PQBInnJoiWdE3wL2A2feZqxgS6
 X9wu7X+RQe7vnFa5epLOjFED1eZhXZeFN82xvw23jnSFeqEzG1tzSiEjajYXLZYB4w6NR3Y1A
 pkiJJdCDRpnak2eXF90H277ygsaYvd/jBAW9AtwI87W1i8/1Mg49Q3zIUCRD7tMHQ/MB26nzB
 RCKwJo+zPHF8PxwAPMAuFHlTYSY36UPlep4UAR4hqjzwlK9b9kMxdnA1EEMDr3o5QelGYBxxA
 Gn11s+ab3lpiLuMhSiU/hjEIhBDuh3IteXtGfsu3yKV95HnCPkP4BTFxaUH1tC8eIzQ6XQpUU
 dC6CLTboaiFIYuAKh20VTFHi3n4OthvsdEVUxJ8Mpwaze
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 14:57, Jilin Yuan wrote:
> Delete the redundant word 'the'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

applied.
Thanks!

Helge


> ---
>   drivers/video/fbdev/sis/sis_accel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/sis/sis_accel.c b/drivers/video/fbdev/s=
is/sis_accel.c
> index 1914ab5a5a91..5850e4325f07 100644
> --- a/drivers/video/fbdev/sis/sis_accel.c
> +++ b/drivers/video/fbdev/sis/sis_accel.c
> @@ -202,7 +202,7 @@ SiS310SubsequentScreenToScreenCopy(struct sis_video_=
info *ivideo, int src_x, int
>   	 * and destination blitting areas overlap and
>   	 * adapt the bitmap addresses synchronously
>   	 * if the coordinates exceed the valid range.
> -	 * The the areas do not overlap, we do our
> +	 * The areas do not overlap, we do our
>   	 * normal check.
>   	 */
>   	if((mymax - mymin) < height) {

