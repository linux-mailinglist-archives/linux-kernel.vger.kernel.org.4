Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2373379B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjFPRqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:46:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73722D50;
        Fri, 16 Jun 2023 10:46:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so187046b3a.3;
        Fri, 16 Jun 2023 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686937602; x=1689529602;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc5mcss5JysJBaV9ccwFaXAHdESboYdCtDsaOK3hEYE=;
        b=SZATOSCOGgdIJkARUx83+P/197aE/7PgooTDajaWYJVQI03IX3rHpgECGS+V1aZZMQ
         SebN4eOO7kd/3PS+pM3zBHCJ6GmCTZgruPue546oy22ZHhws1awpxuQcr663UbJuuQ9e
         a9v85ZjvQ08NDOgt9sjy6PhWoueKnRJhYSFgjosDEvO9pNAY9K9Jv0bBmFgBK5LJNWVT
         dWjtz1MRJRGYNYLihHOhSkNrIPbM8WxGayAFeyCj7TvJ+ohtcIn1yqokS+p07AmkKTyi
         BS1xpMKub6eXAdXVJMBCV96H/ttVdUyZSd4U8lg2i/SmSzgqSq3qLoBcVNSzsnL9wiGB
         ZL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686937602; x=1689529602;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc5mcss5JysJBaV9ccwFaXAHdESboYdCtDsaOK3hEYE=;
        b=Q77ev/YoZz7Y5k3J4B+QliNbBy0Yj7M+Wyit8aQSbq4vmwOi1o9slX4NNu3varWrxF
         cex2+gkVRFNLCFlQY2zqqnTEvx2888I5b+IRxS3Nn6xfnDJn1SXzvq3USKVO2nx9geEw
         JFC6KsE8oWjcTlUJzr1VEObKOA3pHly5xL3FQrl3bL6ytl7eYGvk4KivUtiScxuCe0fM
         NFX6svGf0BT+B4t4uQkmEYZ227bKRXYAs0llIbg8m1SPwOdGBpbYMGe/Txw/OgO2Xjdc
         pESmI+cvs16NboK7SUkEMcnDk1+Yvw/nwedHVYEuXwezhIIUlviRnLV+VQi6jQvlpHHh
         gR5w==
X-Gm-Message-State: AC+VfDxZozZPBVKO48hcny7yenXnVsZ5owaRtMwflcxUYd8rdVPOkU1t
        lnTzMYxW0IsjbshQ5sfNKJk=
X-Google-Smtp-Source: ACHHUZ73wt3phJfWuHNDQLZmbwJSQOBqFPmzjpCfia8jzzIzR3DtmP0nYXQhQ6B+qGFc5U/2Nq8hjA==
X-Received: by 2002:a05:6a00:198f:b0:65f:2fbd:370a with SMTP id d15-20020a056a00198f00b0065f2fbd370amr2941290pfl.30.1686937602062;
        Fri, 16 Jun 2023 10:46:42 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b0064d2ad04cccsm1466778pfo.175.2023.06.16.10.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2023 10:46:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v3 1/3] Docs/RCU/rculist_nulls: Specify type of the object
 in examples
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20230615181004.86850-2-sj@kernel.org>
Date:   Sat, 17 Jun 2023 01:46:16 +0800
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <390935BF-9EC0-4D88-A277-7B37D68CC6C7@gmail.com>
References: <20230615181004.86850-1-sj@kernel.org>
 <20230615181004.86850-2-sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8816=E6=97=A5 02:10=EF=BC=8CSeongJae Park =
<sj@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The type of 'obj' in example code of rculist_nulls.rst is implicit.
> Provide the specific type of it before the example code.
>=20
> Suggested-by: aul E. McKenney <paulmck@kernel.org>

Paul E. McKenney

> Link: =
https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-l=
aptop/
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
> index 94a8bfe9f560..4b66e2fd2fb5 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -18,7 +18,16 @@ to solve following problem.
>=20
> Without 'nulls', a typical RCU linked list managing objects which are
> allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
> -algorithms:
> +algorithms.  Following examples assume 'obj' is a pointer to such
> +objects, which is having below type.
> +
> +::
> +
> +  struct object {
> +    struct hlist_node obj_node;
> +    refcount_t refcnt;

atomic_t

> +    unsigned int key;
> +  };
>=20
> 1) Lookup algorithm
> -------------------
> @@ -142,6 +151,9 @@ the beginning. If the object was moved to the same =
chain,
> then the reader doesn't care: It might occasionally
> scan the list again without harm.
>=20
> +Note that using hlist_nulls means the type of 'obj_node' field of
> +'struct object' becomes 'struct hlist_nulls_node'.
> +
>=20
> 1) lookup algorithm
> -------------------
> --=20
> 2.25.1
>=20

