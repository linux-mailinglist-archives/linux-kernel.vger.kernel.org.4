Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619D611F42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ2COw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2COu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:14:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64021E17
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:14:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m2so6094230pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDK8T5NmQ15T3Y3MhW5583PsMeSXizv7saLpZEgSi5w=;
        b=lQ9++78IboKXH8BW9gPaX72w1C3a/CVdzZFWOnZxu5hv/gYMwXrQAorRyUcqen0QAI
         XEZmskNWstd9JKQiZ4+xYHsnqBdFJw513NvMAibfTDttrAUB82+H7OL9fcq8Oevo904I
         9VAs9vNtX9h5JpSGCXTGt6Ox1AzHBT8nvEw3wQ7/oNaLoNPZTNSC19YVGRoinusL0vby
         bdRjHe45BwOLyCtrjOlL4mU9WLV9ozmGdq2C6tuFwxfbvQN77SPjOS6Y1KF838xpK8bB
         gHlopJqGM8UoIj7pWkGpbEIxbneGxGyk9K5Sz4XYrqUg0x9IEmDzhrTiR2PEN7T8oaGY
         qLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDK8T5NmQ15T3Y3MhW5583PsMeSXizv7saLpZEgSi5w=;
        b=dqfRCIriTwuGu7m8AThMfyh+/MXhGuc/aEL+2u1UXsXP5l11fEHgwBFv8QUb89Mfh1
         qdGPNHI/OgX85XG5sHmNle54UPnDGBNNXdf0DqVoisqny4kaiKTCzFTbQqQtTR/4RZBn
         h2QsE9YcnoRktZ8P9qxrU//ZiWweqKOUtCpGrhbdsQWccSLvo766nUORqNCvDW+1WHsQ
         estphm606Rheo5mmN5b9ZzAfPATj1OKr/fHK48eJHIjln6s3OsxiHfdEuLP6ldOSKy6v
         HYBUMAbJqm65xuyd43hl1Rbqk0Y/MYcL9pdEqlcjirS6hJzQFgvZ9JqAvt2Vw8iHXnuf
         az/w==
X-Gm-Message-State: ACrzQf0iHKJNSHLGjdV9Il4HJ4bcEKZeH4f73gVhNbn2JY5ozNTEoI16
        HEk6LE69cbEHS1Ag7cfZlrg=
X-Google-Smtp-Source: AMsMyM6N0ZjKDOYAOuQLBc88T/xw2Lpx9gad2mMk/7c2+y7ptNvZRt8IiiupIhDy53rXFG01t0E8zQ==
X-Received: by 2002:a17:902:6ac2:b0:184:7a4c:fdd6 with SMTP id i2-20020a1709026ac200b001847a4cfdd6mr2122388plt.54.1667009688168;
        Fri, 28 Oct 2022 19:14:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id h28-20020aa79f5c000000b0056c058ab000sm121277pfr.155.2022.10.28.19.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:14:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8A62C10411D; Sat, 29 Oct 2022 09:14:44 +0700 (WIB)
Date:   Sat, 29 Oct 2022 09:14:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y1yMlEqtiQwUoy9m@debian.me>
References: <Y1wunXB2iv0QHr22@p183>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ze2qEGWK2BfWr8kw"
Content-Disposition: inline
In-Reply-To: <Y1wunXB2iv0QHr22@p183>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ze2qEGWK2BfWr8kw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:33:49PM +0300, Alexey Dobriyan wrote:
>=20
> I've tested it with kernel patch which installs rogue page and it was fou=
nd.
>=20
> 	$ ./a.out -h
> 	usage: ./a.out [-f] [-r] [-n N] [-s S]
> 	        -f: sequential scan
> 	        -r: random scan (default)
> 	        -n: use N threads (default: $(nproc))
> 	        -s: lowest address shift (default: 47)
> 	        -t: time to run (default: 256 seconds)
>=20
> Intended usages are:
>=20
> 	$ ./a.out -f		# full scan on all cores
> or
> 	$ ./a.out -r -t ...	# time limited random scan for QA test
>=20

The executable name is a.out, really?

--=20
An old man doll... just what I always wanted! - Clara

--Ze2qEGWK2BfWr8kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1yMjwAKCRD2uYlJVVFO
o6mtAQCu0+zj4PV2pSMfeUC9FbSzy9sTUb9HmKuUhW/dO15H8QD/TaxlV1f0aWye
AR5AxTINTLVs7C+8iTNyxh0hzch8vwM=
=rJ64
-----END PGP SIGNATURE-----

--Ze2qEGWK2BfWr8kw--
