Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB05B8175
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiINGSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiINGSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:18:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD57198E;
        Tue, 13 Sep 2022 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663136304;
        bh=hVIAn5awenrseL8mpc+1yh9xfy2xNQVLTcdMQ1gc4fw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cnMZPieFRuizhOLQLmaKLrOE2btqIO/CtSnH2bxVxP2+7UWVq/TSjZZODAiFXgmnn
         UBvp8UzrqhRP3Iyd0J6jtsk5G3YHNhVzbeCnFSxH/K2lKEIqrcpS2ZUFiV3r6jUceY
         aoXsoCg+o3JE+lHJtzL2yh/DKeTK+YaL+Tqwa3js=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.164.250]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1p4L1P3xrA-00neGk; Wed, 14
 Sep 2022 08:18:24 +0200
Message-ID: <f346579c-e6a3-d2bb-1c21-d914aeb9a77d@gmx.de>
Date:   Wed, 14 Sep 2022 08:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] parisc: Increase the usage check of kmalloc allocated
 object a
To:     Li zeming <zeming@nfschina.com>,
        James.Bottomley@HansenPartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914060428.4039-1-zeming@nfschina.com>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220914060428.4039-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p7GIC9NaSGhRukQXbQQtIiSlvWg9k1oCybwIFLtXRBtk2Y2W6gW
 RFQdnCZq84pZFTDeUWntqkRHxkjluL6rEfOyxCJ0gya/5XZzN/BmhDm5ZifBvH8USR4F0LM
 nXulw2gSqQPiaVrbhsspFmX3uztnHuUoIdWAQZ5ztyiHzTtuEMRF/QI0BKdA39RZUrn8lML
 p7NoqnmxNaA4fqo7Uc2pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gpBTBjNr3jc=:SP8hao8n4jQ6YVTwqQboDN
 i768pCVh+V7u35N6NUFiQXvO3dzoDU5gdkJYx1WVLgHLcsvzZIVIhSBRi+GyVMYOGJcPBj7Zg
 Mm7aNnS0cNruwuZWXdjhYA4rx1JPXUbtJkiNw8cSqDvF25/AHJeaVlxtOrlcoQfAkXHgS34gx
 oXwY21kp2EXR/KmtZJFx1+vkCv92UAzHbWgCpWQJi47pXPgtWhTDvCmQQf3W3cNdMeSmXa3eL
 Ygx6HC34vWHJLeI2KMUdJz2+h6l91ZEFYC1ylU9wU1gLbeaSOVSjPlog1J7xKalc8en5vB6KV
 T9x8CLi9ATfe0cYchs9kB+6WHwb1EBzKzTYh4q+Ea85o1hx6aPfrTH3Lqd/TKYnjjI03QjUg9
 oi6LhuhqWXEm/uxYqDF+dQixov2PSSMYG3l0db/pGfxz2K5yDjkpgXHRH084pZ5sf2BxQWUtd
 8o7mEjlMGbs2gUDUg7yhbfKxvPC1jwMhO37Qi8AOZp1ES8nBa+Y1RP57uK73ffC47RJ4vZPG/
 /bdCHkseVuCtNjj1U+r8S1al5A0qnh9aJT1GEd808MH7DUYkShF3nCdN4z7FrA4nnKst8XLhh
 NltcBc+RMQY7HPM2lMubn5DVXpWTBs5rETFHvYyOQhJ+fhv3yzTVHhQTO8BBs+g62kgF4SV9j
 PcGsz1L+cj8sib1r5TQFeuS5PrjciIR5E0gzt4M/6SGstXAaOFhD42SRwcQXNzRvtkuscqDOx
 n+8sHONqkAD6aQ9ahBRj8dO/YMm1Wcy1Pn9IobcxpfVj+Uy1ByQ5q4hVkyydOrF1lYILQbT39
 gbFh05w4fFyjpOdSbN8gCY23Rdy/AHh1CznmNJYq0XUicEEDSaJr7P3UKZV4gpjVFeO/zTRe8
 LiWAeA6g9lp+oo7hnxpFdNyM3GRavMj0XIN2EFlqFCpy29ReI3vseoP4yMMZX7RYipcMs59GZ
 lpZDyzJ3eBc1HMm2QMFWWwcfdliTrVTnS/o0PvEbWjAk+kDdb0ggtsy0DJCHUsXI5mTYrm7MU
 mmRnIQidxv4LuwoES3JcncSuAgydd1zuIMlIo6wFMGeQtUUpDjcupcdo1NsYcRyLeXlFMQuWJ
 em2PivIYjE6mB/WWZzeSxlUnyG+7mTF3mGK4xXaKS35aAui147iV8pBhzxZGlbtrY4q+FsA98
 FW5mET+wdpWBsa75Vy6792p/0p
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 08:04, Li zeming wrote:
> In the case of memory allocation failure, no alignment operation is
> required.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   drivers/parisc/iosapic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
> index 3a8c98615634..33de438916d3 100644
> --- a/drivers/parisc/iosapic.c
> +++ b/drivers/parisc/iosapic.c
> @@ -229,7 +229,9 @@ static struct irt_entry *iosapic_alloc_irt(int num_e=
ntries)
>   	 * 4-byte alignment on 32-bit kernels
>   	 */
>   	a =3D (unsigned long)kmalloc(sizeof(struct irt_entry) * num_entries +=
 8, GFP_KERNEL);
> -	a =3D (a + 7UL) & ~7UL;
> +	if (a)
> +		a =3D (a + 7UL) & ~7UL;
> +

As you said, the adjustment isn't required, but it's still ok.
So I think the additional "if" isn't necessary and so I'm not
applying your patch.

Anyway, thanks for your help to try to improve the code!

Helge


>   	return (struct irt_entry *)a;
>   }
>

