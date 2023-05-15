Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEF702931
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjEOJla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbjEOJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:41:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543A4C32
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:38:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96aa0cab88dso540918466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1684143477; x=1686735477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1umpD1Q0BARp14yG5etCeutnvUghZER7FsSDhDr7vNs=;
        b=1On4akDeNwD08zQZqtFvg1vfMgOFettnQ892Q3EGUqILoFdRkSaqa3lpRq0i2kXdwi
         cSAjoU1cUBTop8qhrc7sotDhywZv8/MDUnjPxYXwhQzadYvp60LrWmk1wr80sJuRrPhY
         DJ7AZr2mT+nsu6f9KH24Omc4bN/LJUczGqYQKvc2qM32BoZ3pjndGlaS3CyqWiJPLoI1
         dpP1qp8GYCpTuby0dbmjfpzBPPh0VyfPwEzrhyBz2SxvgrV/geyK15jkfQpEWcr/vPtg
         IDVDRFTvuJx4ipYg3rih9C8jxzbZhNNP4n9iSTcyAnGVanBmfdj9jCajhuQRA6O5RbAm
         ufqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143477; x=1686735477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1umpD1Q0BARp14yG5etCeutnvUghZER7FsSDhDr7vNs=;
        b=PRS+tXP2aIbLO5FIuVaLf334eMd0txkuUKMDizLBkEwGS4cNejtdAExLPbIs3fXRGx
         I2JJirVymlVQxIG436Nm4ikzpUwk/6YXfqFhjN0GDKB1UsSOtK3YcQviEroc6AtGjJre
         pDT5NSl9LswdmgdB4CQUw4jBZ6wPxS0EVawEOyNS9aXoIb7CiO4PtJ36KAp/0X8IftuD
         SYVKxw1wdp66D5mDfrFizRhRm8gineszlLbmGH50gW3S+ZvQGMQDIhZhAPOu2QPRtV34
         +ReA6A7yESuCjxGLl1tGKLreG1c7r66nEcwzqjWSoSLuRQRxVA8x/1Fnm+oM2QEbCI1K
         prEg==
X-Gm-Message-State: AC+VfDyx1hHZPzoT/5AYOqiHqLIHJQFNv3fU2s51d9NJXMK6fIWm5slj
        UngYi56Hi/smV24MCmId2s0buA==
X-Google-Smtp-Source: ACHHUZ4RIbp4UdbE5JYwZ9tdrcGKo6bg/hPAFOsYlkW4+6vtOEjKswbwxkKrph1jtfRwHVsP2MCBXA==
X-Received: by 2002:a17:907:97ce:b0:96a:4bca:8408 with SMTP id js14-20020a17090797ce00b0096a4bca8408mr16379768ejc.60.1684143476937;
        Mon, 15 May 2023 02:37:56 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id la26-20020a170906ad9a00b00967a18df1easm9224120ejb.117.2023.05.15.02.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:37:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 May 2023 11:37:55 +0200
Message-Id: <CSMR1BXJMLYU.1YUU6374U6T7H@otso>
Cc:     <amahesh@qti.qualcomm.com>, <arnd@arndb.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Abaci Robot" <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fastrpc: Use memdup_user instead of
 kmalloc/copy_from_user
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Yang Li" <yang.lee@linux.alibaba.com>,
        <srinivas.kandagatla@linaro.org>
X-Mailer: aerc 0.15.1
References: <20230515092604.79990-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230515092604.79990-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang Li,

On Mon May 15, 2023 at 11:26 AM CEST, Yang Li wrote:
> Use memdup_user rather than duplicating its implementation, which
> makes code simple and easy to understand, and silence the following
> warning:
>
> ./drivers/misc/fastrpc.c:1259:8-15: WARNING opportunity for memdup_user
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4949
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/misc/fastrpc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f60bbf99485c..a897dab13c61 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1256,16 +1256,9 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
>  		goto err;
>  	}
> =20
> -	name =3D kzalloc(init.namelen, GFP_KERNEL);
> -	if (!name) {
> -		err =3D -ENOMEM;
> -		goto err;
> -	}
> -
> -	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.name=
len)) {
> -		err =3D -EFAULT;
> -		goto err_name;
> -	}
> +	name =3D memdup_user((void __user *)(uintptr_t)init.name, init.namelen)=
;
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);

Don't we still need a "goto err;" here to free args?

Something like this:

  if (IS_ERR(name)) {
      err =3D PTR_ERR(name);
      goto err;
  }

Regards
Luca


> =20
>  	if (!fl->cctx->remote_heap) {
>  		err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,

