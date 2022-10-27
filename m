Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED1260F7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiJ0Moi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiJ0Mof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:44:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42610EF;
        Thu, 27 Oct 2022 05:44:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso1356789pjj.1;
        Thu, 27 Oct 2022 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WP+7R/Fr2VMJLa5AXizn+zOIuwCy4AiCbk7L9UfX4Zw=;
        b=agwMaoXKy9Wbn7+kG/2zoL2ab09hLBHI3OWHuBTISVwNYL2VkJUvzxCRoL49OCshBj
         vLioT/vawmbM+eFCEGMjfNYBG7euvnY+eyE98TBYycgStlmJnIPInsn8srezL58PDRl3
         GbQRFNvB+CskWz5NEW4VF4ylYuXxQLQIFGWxPAPRT4aobnXX5r3NioqpU61GBtW1SsyN
         78gcwnit22wAzscY5gBg5HbZTcffuWqOnD8XVVJwUvz5JS9yy9l/rcL1J9r7YFGn9Tdr
         T1bD5t0YqlJzWkGgCkwslI3+2L9jbWFoe1V7+E7bwxjo1dJHsQjhJGvfdnoIhxetRjTP
         9fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP+7R/Fr2VMJLa5AXizn+zOIuwCy4AiCbk7L9UfX4Zw=;
        b=6B41eLZMsDqwt/MrRi7vQHP22TnnzhdYMDP+9LMMg/nagqjG87MMynk++E8lVGPzdt
         jTqpFq0JMX7CgdLlqf1c59hvVDAbbJTz8wots0SBlji2dl4VZu9e3rrN+sXj/41duhB5
         47PeEcDlSvURniUtvpR0SsQAIPJU5PRTKYYkBQ702moTehYSUyovDRAD/+K8CJjqehMv
         ucVz0X6Rmv2yxsJaYq00tJLpODQdjfUFj8pRznt0g5OuupfVFV33eNvmXAeaneJTjhqW
         Hq0f85WJO88kGzpkF7+QKfBgf1JIvvI9qATz+LOks+kI0UlreUAmBhWmOueOTR0XJVF3
         iX2Q==
X-Gm-Message-State: ACrzQf2UCeY0S2EO1XLD9XHYYC9Ejz63P3nez1GdwWwcTbZAWsrIt/FO
        VfEaXsB9I0RHpEeM1GKCvQw=
X-Google-Smtp-Source: AMsMyM5+O8XthDRDSKyEQ3I1jHlcTzZmKX7d/XfEB3c8kCa+btVU5AIiiGXo52VS5hqEqrrzqoO+lA==
X-Received: by 2002:a17:902:c20c:b0:186:b3d0:f77 with SMTP id 12-20020a170902c20c00b00186b3d00f77mr17479095pll.26.1666874668179;
        Thu, 27 Oct 2022 05:44:28 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-37.three.co.id. [116.206.12.37])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b00186b3c3e2dasm1125991pla.155.2022.10.27.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:44:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 28834103F96; Thu, 27 Oct 2022 19:44:25 +0700 (WIB)
Date:   Thu, 27 Oct 2022 19:44:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dma-buf: cma_heap: Fix typo in comment
Message-ID: <Y1p9KT1ZZ0bqIhdu@debian.me>
References: <20221027072642.23787-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XHaG62drdJ2C2Nnp"
Content-Disposition: inline
In-Reply-To: <20221027072642.23787-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XHaG62drdJ2C2Nnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 03:26:38PM +0800, Mark-PK Tsai wrote:
> Fix typo in comment.
>=20

Comment on what function? I had to see the diff context.

> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> index 28fb04eccdd0..cd386ce639f3 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -316,7 +316,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_h=
eap *heap,

Oh, you refer to cma_heap_allocate(). Please mention it in the patch
description.

>  			kunmap_atomic(vaddr);
>  			/*
>  			 * Avoid wasting time zeroing memory if the process
> -			 * has been killed by by SIGKILL
> +			 * has been killed by SIGKILL

Duplicated "by"?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--XHaG62drdJ2C2Nnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1p9JQAKCRD2uYlJVVFO
o2ycAP4mutv5A+U0sVGBxomMJwORB1VaIuTIp/xeL/6OqueMIQEAq2u8IOVlVke8
K367ezUx4yUU08CTyQcg97a1puTuqwU=
=bsZY
-----END PGP SIGNATURE-----

--XHaG62drdJ2C2Nnp--
