Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197AB61ED7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKGIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKGIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:52:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C115709;
        Mon,  7 Nov 2022 00:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667811157; bh=iRI7W/QU1cJZbiWjVLUSX5kKamrVwlbhRdK3X5/OYJc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nlsygfpqZU/71gN7QJEp82YXz7fNG+Ipuq5rAqofcc5tYsGdwHTz9Z9CLPBg1QRa/
         mbTP3VCMxbKWJ8pZhQKxkf86KQyLupdoC2wuh8H9q9JXViU8ot90e2HU6xRJIcsz4H
         V3J870dLBLn22gYFqkuK9clBFV1v8vOu0bTdfjcs4dhysuDsrEdBiwbcbywo3CHxFK
         gVjl7NLmcQpgZtWZiJCXjRVxobowLGR7CB7E+ti2wSY9QjeNEjRHbvhv3uzaUzgHM2
         T8CePU4+OwqC5Vw9q53+lFT+Ig3ox6KXT4vpgwsXX8GrMiMqHph7dYj97/09vORK11
         Eun2ScIMnnmFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.191.140]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1pWGQg08xf-00ehBl; Mon, 07
 Nov 2022 09:52:37 +0100
Message-ID: <5e52528f-e4a7-0aa5-b795-0cff80a153ce@gmx.de>
Date:   Mon, 7 Nov 2022 09:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] video: fbdev: pxafb: Remove unnecessary print function
 dev_err()
Content-Language: en-US
To:     arnd@arndb.de, b.zolnierkie@samsung.com, robert.jarzmik@free.fr,
        ulf.hansson@linaro.org, wangqing@vivo.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <278d64e0.bd.1844d4c7a95.Coremail.wangkailong@jari.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <278d64e0.bd.1844d4c7a95.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vgxJnNsimSpuwn3kVv4h30sgEDvxe1TqMkycvRhld3dN1CBbTNb
 cirLau/yhh7HBclzqrqixPy8ktn1jtwQSDFrpF/raYzeRgwoRV1ydCSr/8n1fL1QEK+GaEQ
 4USchyiL5usUlQQdpEZEIY2RqExktJvP2Iw0YOVs+W2+FqV9NrtHrBUy88pRdpftPf7MzDg
 KsIrej/SrMpGuuMpEO7Jw==
UI-OutboundReport: notjunk:1;M01:P0:Fi3ciiG9BaU=;3RmSQ8aQx9DarEbQVh70IdhJfSq
 CWBBzmhO/iJ/X6e96gqICmiDIOalEwt6rElV3glUyo5giZm1OezYS2kitoqKaH/AlGd1HYTD5
 Wo8Tr8LomMBiAq1ntaKaqpekRW04hvyyNFKtj+jW2YpKswkLh1xvpqGFjoQMykeQQ/DuuPf7A
 cBRr+njKZMUKbhjy4pGgkN4H0LOoy4krXKpbBM2UcXhzRNJFCXDaGd5FQ7CZpglZ01qCRWxIs
 +bSvdDYrgxBi2ssdBYl3nqokjbA7i81D+Y4iQhQLuirmQ5CfTphvNZvBlpklXKL6PMl4iZy2v
 OVnxZpEQInncGLivqyNfsQ4/f1jvMc4LWMOSfRi7Svw3r0B6FxSGKr1gHpM5MDezAATVYYuuU
 jGcCDhJkySG2TP9ANgL8iJL0rPE1BnT+C0t9NdoY+ii7sU8JxZcawOw+glTXF0nhEoo6fxm09
 uV42c85SorKuh1n8LPEF9NXP7zh1NY0SaHjwBbao842rbi+ybimkO9gTbETqdholj8UvK4TC0
 f1+mnomn7W1O7eX+pxMCPwW+DbQaseRDBml56Q1btmaAWNlO9ji8VPuS24HtqnUpkfFCy2bn+
 CXbCcY7ymPekQ9u5WeQSgZki/iJVa/y6lPJ9KBBGHlCvFGM1dGKojenAMDEOGfi1CAHZIZAOl
 pgfh1FmsNuyZbdbTuAz2XN8u2m+MSCbJmN0w7/iC1vv1zMxW9x97PZsw6H75ImgVq4fV44/hP
 FK8COyhE00FLJd8/yr56vSUER/sM3668Km+i48JIWh4nqsT+gPjwBe3ZH/3egOs8N0uTL/jLz
 B03qHXIjh6qVZ+P3GE0iGJuZteeLjtWxBmMz5kvijXH/WMPQ/eFyVaZ8TSwd0ozHSfNpWfWtj
 +BkT2BF4VDA7MGwft50GbL7eeu3xnm5fRrx3KiNTlq7n+bSt//b4LQai0DA6IhF5HuXS1kGyN
 kQJWeYCCVoXhbKdpjnDgVfeoNsc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 15:16, wangkailong@jari.cn wrote:
> Eliminate the follow coccicheck warning:
>
> ./drivers/video/fbdev/pxafb.c:2330:2-9: line 2330 is redundant because
> platform_get_irq() already prints an error
>
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

applied.
Thanks!
Helge

> ---
>   drivers/video/fbdev/pxafb.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 696ac5431180..c46ed78298ae 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2327,7 +2327,6 @@ static int pxafb_probe(struct platform_device *dev=
)
>
>   	irq =3D platform_get_irq(dev, 0);
>   	if (irq < 0) {
> -		dev_err(&dev->dev, "no IRQ defined\n");
>   		ret =3D -ENODEV;
>   		goto failed_free_mem;
>   	}

