Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66020640113
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiLBHgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLBHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:36:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F77DA68
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:36:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a14so138401pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbODqIjS81SwQuow+R79rV5HGGg99rOMnlakf1X53U8=;
        b=GipLt+N98JQPhXxkywATRWygpbfRv/U+/6DdjziXIbzEWyU2tKwpqChD9qnbXjlo0L
         mnTUPANlc5ZVH9RvltZRFHVUu5bEt1kNsBjvnJHVdbYhcvOjboii7CP5wiZqRQHriPQe
         xv/4d124vC5zecrbxQy3Of7952tL70dYxHez9Rl6VsRTMwZnZZ4oAGJ4n47z8PmwSJ4l
         TbcFphucBZ5YsKiaT+T+b6N6/VBeb/ZYDXrqogW6/aANZLuSoFISJEPDrYbS+K8R084k
         fy8igQxdGJ95/KWKj1WzpS4j3PZQgJLkmUMkZ0PuD/v5yFpKiQoqod0exm4aByJwdJiB
         w7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbODqIjS81SwQuow+R79rV5HGGg99rOMnlakf1X53U8=;
        b=oL58+1ovYu0BYhPhEzBnGgZjqwgdF9JpN8EFXSxDZAsjU2tssZ+2dKlaj3xTx0DzNE
         WxoWbjBrbV5Rcd537crIOq5A2/4F+G0aYf6NBcw5u6Mr1MQn1DbFSgdfBooG+5KRxwUS
         8bWbSY+b/SBAnkLOopmWKXayfcgmg8wgiOHT5vbU4dcYlNZrE0erfzsUDNsedQ7JL9KW
         akvXBWQYBdHEuFPl6wRVlmU8GrZ5ybE+hx6Ey+6Idnmr0P1TQlCvmv5L1du7a+b4Mrby
         QIQ8FJSxmYjR/6fx2tmeg1dVtpWwXwOm9r0+GBN1PzPdCCjCQF+4mPyX+4QwFiqGV/4N
         DqJQ==
X-Gm-Message-State: ANoB5pkIbW3MoOHC9cnfITmIvDlNIEs54CmlqxpDLWn0AIRLMOwEPkzH
        Shc4MCxva6D5q8YlMMOex38=
X-Google-Smtp-Source: AA0mqf6WbUtDGkEB5Ak7dhx5BF4ooD3dN+clOlGzCHEGAnfMHaL10PI/BGo46qtp+Li0pkh0Ta8AfQ==
X-Received: by 2002:a63:1a5a:0:b0:456:f79e:4e95 with SMTP id a26-20020a631a5a000000b00456f79e4e95mr42900852pgm.607.1669966568329;
        Thu, 01 Dec 2022 23:36:08 -0800 (PST)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm6097548pjc.6.2022.12.01.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 23:36:07 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D949C10449C; Fri,  2 Dec 2022 14:36:03 +0700 (WIB)
Date:   Fri, 2 Dec 2022 14:36:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vschneid@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Minor optimize ttwu_runnable()
Message-ID: <Y4mq44pyzVqkedBp@debian.me>
References: <20221112033910.73273-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oruVC0Asy+vvciNw"
Content-Disposition: inline
In-Reply-To: <20221112033910.73273-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oruVC0Asy+vvciNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 12, 2022 at 11:39:10AM +0800, Chengming Zhou wrote:
> This patch reorg ttwu_do_wakeup() and ttwu_do_activate() to make
> ttwu_do_wakeup() only mark the task runnable, so it can be used
> in ttwu_runnable() and try_to_wake_up() fast paths.
>=20

s/This patch reorg/Reorganize/

Also, please rebase and resend.

--=20
An old man doll... just what I always wanted! - Clara

--oruVC0Asy+vvciNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4mq2wAKCRD2uYlJVVFO
o2XlAQDc5XhzbyAD3Ww83PMxQoYrXDa4342jRmr3NZQK8ikGRgEA9WlS7EQeyTmK
YOeGQCee7Sl5oiymUlkc5S3y2suHlgY=
=EwoQ
-----END PGP SIGNATURE-----

--oruVC0Asy+vvciNw--
