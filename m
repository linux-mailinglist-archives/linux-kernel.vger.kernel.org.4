Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C43627832
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiKNIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiKNIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:55:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D51BE91;
        Mon, 14 Nov 2022 00:55:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso9963986pjc.5;
        Mon, 14 Nov 2022 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HR9P7zKDMW3cvd2Jzy9gdBg7jDLfTliN9t0QdH38uC8=;
        b=k1aAHmpudMPnmmJzMx9XJ+M200gMG9hJ3TKsiCEnT2+JM4UUIIJAimAjZ8oSt28XwK
         OizPtqX+mue+30Co+i+zSK2K/IpD5PZeGPtaLuiKGwrF3fga6+UxKIZrw23inCrzr83z
         SBuZghcaB9tLIRJdK4AcluzX6+fL1xWVnkTgdVmxxtY+a1S2Qrk5eMSse5Vs7zi6qdiK
         fH0O1eBwrK5ohEk2+ah582fJr36kwrK6mNmtvpGcmN/fciGGS0icxjhxtDTgD5zlg+JA
         7/lJHiJPCcgGrL0YE793kjKFNf68Na9gCs84+/DZETrJd3fjLzQj6kCJcmq+fFmWL/we
         Xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR9P7zKDMW3cvd2Jzy9gdBg7jDLfTliN9t0QdH38uC8=;
        b=wxbcpDRFiTn1qBADhAoSzjKeCjpjxeXJeVvU9CvedxScerZH5WQdtvMgLfx4k8C+X0
         TLbo/2x9JNHJfl9KB/kXe+3DuGNsOUhkmVR+P6qeYiybY9NpfDAopSiCsrwVu6v3VMd6
         xtEHD6moMQiEwkMC10i+Zn4vsfZdbM4iz181D7vaqFOTZr3635bk0Q/6D/T1C1duMNMK
         LUIMTZxcUyVi5W1pbn8Srmr9SmvLONyekrfXibI/k+FW6DtbCYhCavCkkG69PJyWlc5i
         iCCr8vSp/1p3ZNB0TOW5xGveKhpkTF0XrWB8OKvyfdQlxxwqNnVnUDib0NbWtL6j3dL2
         2wsg==
X-Gm-Message-State: ANoB5plBYE71j3qIQ9U7xQFy1FytSz/1q1C0dHrXybTcSuPOhlx/rxhb
        suqmJ9evvY9eD5NsTtEl9340kAOgDeQNpw==
X-Google-Smtp-Source: AA0mqf5mZ2n5x8+R0Vu+IaNJ8Odh2314RiZTIzus7TXohdNN6/T8n3UWyJZ/EgN1iwHa4RFbsgeuDg==
X-Received: by 2002:a17:902:7202:b0:186:9b7d:f0c9 with SMTP id ba2-20020a170902720200b001869b7df0c9mr12898481plb.58.1668416108491;
        Mon, 14 Nov 2022 00:55:08 -0800 (PST)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id h2-20020aa79f42000000b0056c2a85c097sm6165167pfr.20.2022.11.14.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:55:07 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D6BD81042EC; Mon, 14 Nov 2022 15:55:04 +0700 (WIB)
Date:   Mon, 14 Nov 2022 15:55:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <Y3ICaCPX61EOn/KN@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7WRnNdsftvyBSXEC"
Content-Disposition: inline
In-Reply-To: <20221113152629.3wbyeejsj5v33rvu@airbuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7WRnNdsftvyBSXEC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 03:26:29PM +0000, Qais Yousef wrote:
> Thanks! I have the below fixup patch that addresses these. It made me rea=
lize
> my html output could look better. It's cosmetic; so won't post a new vers=
ion
> till some feedback is provided first.
>=20
>=20
> Cheers
>=20
> --
> Qais Yousef
>=20
>=20
> --->8---
>=20
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/=
index.rst
> index b430d856056a..f12d0d06de3a 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -15,6 +15,7 @@ Linux Scheduler
>      sched-capacity
>      sched-energy
>      schedutil
> +    sched-util-clamp
>      sched-nice-design
>      sched-rt-group
>      sched-stats
> diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation=
/scheduler/sched-util-clamp.rst
> index e75b69767afb..728ffa364fc7 100644
> --- a/Documentation/scheduler/sched-util-clamp.rst
> +++ b/Documentation/scheduler/sched-util-clamp.rst
> @@ -169,24 +169,27 @@ could change with implementation details.
>  2.1  BUCKETS:
>  -------------
> =20
> +.. code-block:: c
> +
>                             [struct rq]
> =20
> -(bottom)                                                    (top)
> +  (bottom)                                                    (top)
> =20
> -  0                                                          1024
> -  |                                                           |
> -  +-----------+-----------+-----------+----   ----+-----------+
> -  |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> -  +-----------+-----------+-----------+----   ----+-----------+
> -     :           :                                   :
> -     +- p0       +- p3                               +- p4
> -     :                                               :
> -     +- p1                                           +- p5
> -     :
> -     +- p2
> +    0                                                          1024
> +    |                                                           |
> +    +-----------+-----------+-----------+----   ----+-----------+
> +    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> +    +-----------+-----------+-----------+----   ----+-----------+
> +       :           :                                   :
> +       +- p0       +- p3                               +- p4
> +       :                                               :
> +       +- p1                                           +- p5
> +       :
> +       +- p2

The code block above is diagram, isn't it? Thus specifying language for
syntax highlighting (in this case ``c``) isn't appropriate.

> =20
> =20
> -DISCLAMER:
> +.. note::
> +  DISCLAMER:
>     The diagram above is an illustration rather than a true depiction of =
the
>     internal data structure.

The DISCLAIMER line above isn't needed, since note block should do the
job.

> =20
> @@ -200,6 +203,8 @@ The rq has a bucket for each uclamp_id: [UCLAMP_MIN, =
UCLAMP_MAX].
>  The range of each bucket is 1024/N. For example for the default value of=
 5 we
>  will have 5 buckets, each of which will cover the following range:
> =20
> +.. code-block:: c
> +

Again, why ``c`` syntax highlighting?

Otherwise no new warnings. Thanks for fixing this up.

However, in the future, for documentation patches you should always Cc:
linux-doc list. Adding it to Cc list now.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--7WRnNdsftvyBSXEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3ICZAAKCRD2uYlJVVFO
oxzTAP91SQV2sUAfb8KpjDND49+RN0oPj9m6X1HvfIe84iwYaQD/SZMwOaKVGXxX
4RN1JV9biThAMBnOmGe5hT0C3nCrVws=
=zvFR
-----END PGP SIGNATURE-----

--7WRnNdsftvyBSXEC--
