Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A02737E80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFUI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjFUI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:59:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B2210B;
        Wed, 21 Jun 2023 01:58:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2508497b3a.1;
        Wed, 21 Jun 2023 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687337909; x=1689929909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5LRjNW+DMVQyDVYt4QbuO/2vLZPFCxGg8HQRH+1HMw=;
        b=iLwM2ePFQcTi29RnxJctEOJkmS5MLhfI00MGVBOSKeM8UzrTvts8v90Pt78j/E84lY
         e7fOmDaTtsaPKaMPA/lo5JPMAP/Lz0f0ibtnTTrtbNQHiHcQXkz8sZ1BNWhQQRlXd5/p
         TUAz4swOXHmIrDsmYuFbl1zDbMs9/yRL6TnsR/6lTKnYdj5r2r5h6Xp/p+svfM1vvprL
         X4y7lqKlIgdvGsFiFDI2kV78ltghKCpKwFmWfh7BJu+5DKl6rkQggzy64PNiFBKktRKm
         uada3/X8WOyk3DmqvcjJtLhDx8YTnML/Oag9j+P5dRJMBl4iTSbIZ3JFmR+LNfiK60jh
         X1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337909; x=1689929909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5LRjNW+DMVQyDVYt4QbuO/2vLZPFCxGg8HQRH+1HMw=;
        b=Vw7+Oidli40naUthncpopsTRv8On7sVxo9fjqmsnvlyBKMUb6uLwWLkkcCGbnK57Rj
         aqw5eacS4yr2wHptQvABVzQQy4VTNnrAYuFjBnSJuYWD899a8BEzsmmJAwNMGgAKyQAk
         H1A5vByypHACTItcSZgNFrUcDBbmhVazcPGeCnPX2awrJ2iyFKLxqEbC4mZW2Sn5dasW
         d+ZR3EIpOuYWjrMGx32fv/QBSQpTjlWXLCxxi0CQooV4MixhYBEysBoHwaHozKvvs4dH
         cs7PZtizkUJgNkhapwuLbf5o92o3jDpQ5C6JTfnj2tGBJLs5e5Yfpu7QA/c174ZZZXEL
         L5sw==
X-Gm-Message-State: AC+VfDwA+0x9pAFp203YKGhaYBxoxPsahaFS1BGO5omFuVmWMBC9dM0h
        X0LwfktVxWyjrtUeWQtMXkLXa9doMVU=
X-Google-Smtp-Source: ACHHUZ71rKwyV9VEfl/z+0vn2b2qUDpdUqK4LftuBZw+WJNmSIyZ53OovRgv3kbNZPwLyJpINF2zHA==
X-Received: by 2002:a05:6a00:2d04:b0:65c:2ea:2c5e with SMTP id fa4-20020a056a002d0400b0065c02ea2c5emr15162799pfb.29.1687337909153;
        Wed, 21 Jun 2023 01:58:29 -0700 (PDT)
Received: from debian.me (subs10b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id n24-20020a62e518000000b00668a06ddf2bsm2218132pff.83.2023.06.21.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 01:58:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2D3F28AC0D78; Wed, 21 Jun 2023 15:58:24 +0700 (WIB)
Date:   Wed, 21 Jun 2023 15:58:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     zhumao001@208suo.com, sumit.semwal@linaro.org,
        benjamin.gaignard@collabora.com, lmark@codeaurora.org,
        labbott@redhat.com, Brian.Starkey@arm.com, jstultz@google.com,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] dma-buf: heaps: Delete repeated word
Message-ID: <ZJK7sC4i+MK98k/+@debian.me>
References: <20230618143813.15142-1-dengshaomin@cdjrlc.com>
 <20230618143813.15142-3-dengshaomin@cdjrlc.com>
 <0c1649d3a7eca54b639b3990c186f482@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFoz0p8LOyNaa+xq"
Content-Disposition: inline
In-Reply-To: <0c1649d3a7eca54b639b3990c186f482@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFoz0p8LOyNaa+xq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 10:50:43PM +0800, zhumao001@208suo.com wrote:
>=20
> Delete one of the rebundant word in comment.
>=20
> Signed-off-by: Zhu Mao <zhumao001@208suo.com>
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/heaps/cma_heap.c
> b/drivers/dma-buf/heaps/cma_heap.c
> index a7f048048864..80bc95955188 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -319,7 +319,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_h=
eap
> *heap,
>              kunmap_atomic(vaddr);
>              /*
>               * Avoid wasting time zeroing memory if the process
> -             * has been killed by by SIGKILL
> +             * has been killed by SIGKILL
>               */
>              if (fatal_signal_pending(current))
>                  goto free_cma;

Your patch can't be applied because you sent it with Roundcube, which
mangles whitespace. Please resend with git-send-email(1) instead. And
don't send patches as HTML email, either, because many mailing lists
bar HTML mails.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--UFoz0p8LOyNaa+xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZJK7rAAKCRD2uYlJVVFO
o2EoAP47NUroxZgIZQh0vj02VHoj+aMX37I9RIvQFddU757PxAD/Qy3tkx+VtR8d
hMR6p/WtGknPVw4KTMDCWwwQv4fHMAQ=
=MKC1
-----END PGP SIGNATURE-----

--UFoz0p8LOyNaa+xq--
