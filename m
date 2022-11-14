Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824576274B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiKNCsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:48:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918713E1A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:48:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l6so9206017pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ThTJ1gxqL1ALiRHgAYdU2jdOUr8v6DnijCwaPTFchA=;
        b=MGRsHP74CoOijlItElbyqTS5iU0VpwAIKNo6OoqKjSxAO6nRUICsAKpNs2yvmOdu8E
         BRP363rW9QWYnSuGC0gLJvSzWLzLytYRw8G1Z62zMxWqKq8DO/wrnzFdMZZigpML33py
         zCOu0hIq4h6+ymY+Otq5jLC6LdgrJpDXHnpy4EpNiy2lR/d16p5xXPGah6XQxpsGUCBM
         weeVlnBM+rs4yQNxN7hgXJNwrUTfw/raRW5SIhvzucvhgVmfXNA4xk7uC0gcMJ3F7xy+
         NdfdSC74bfE2+OtaXuDjB4lM3nGJo0Gz2v41UehID3mrwFT+8Dy0z0CC3MZ25GBpDJks
         8P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ThTJ1gxqL1ALiRHgAYdU2jdOUr8v6DnijCwaPTFchA=;
        b=5EVUD9JzIOvlzDfr/meMBGKJCov8DtiD4nfZWt3t7TMCzl7cd/fhdpteI5/nOJ2Pj5
         jMam07NYcQR76SYmnOxOwHYMjE6NVxZVYtiBYQjAbvVxRAi/HSDC30Prcjk4C0M1diEc
         +jYWWPh7cqiyaxkil5hveEZO1mL+CNYwhV4BG4XpfXNdFv53dJqpyqv/WfgJJoMS78a2
         j3C4vnl5yQsy/tSLZnEVsTvj9oYE8AIYrqgcZhgnEfYEzd1LCXD7gbFz976ru7Oa0Z+P
         eblLDpQ5/iihCMrSJeYd2GQT8sFAtxIJP2QJod2kaXVZ3+hRrI2wmzIbk0DqBzMPHhH2
         DktA==
X-Gm-Message-State: ANoB5pnUylubNrJn4HFRHK+zXTgoLqPexaz+6CpyKynFTFemRAcMIlUM
        ZHL7KRf2niaaiR+6cijtr2U=
X-Google-Smtp-Source: AA0mqf5cBlR+UyGR4S5YPE9A72+lG4C3X3M6EE1+8pIa8EVCLZGfuVHeWAozRy428d+/4ilFQi3J/Q==
X-Received: by 2002:a17:90a:4f06:b0:20a:2547:907 with SMTP id p6-20020a17090a4f0600b0020a25470907mr12095188pjh.37.1668394084267;
        Sun, 13 Nov 2022 18:48:04 -0800 (PST)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b00176ba091cd3sm5938528plh.196.2022.11.13.18.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 18:48:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2EF6310030A; Mon, 14 Nov 2022 09:48:00 +0700 (WIB)
Date:   Mon, 14 Nov 2022 09:47:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <Y3GsX8XcDCHVa5UV@debian.me>
References: <20221105232343.887199-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="js3W9H/L5uusqhQ8"
Content-Disposition: inline
In-Reply-To: <20221105232343.887199-1-qyousef@layalina.io>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--js3W9H/L5uusqhQ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 05, 2022 at 11:23:43PM +0000, Qais Yousef wrote:
> From: Qais Yousef <qais.yousef@arm.com>
>=20
> The new util clamp feature needs a document explaining what it is and
> how to use it. The new document hopefully covers everything one needs to
> know about uclamp.
>=20
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Hmm, why didn't you send this patch from your arm address instead?
On the other hand, thanks for including SoB from your sending address,
which is different.

I will be commenting for the content on your fixup message.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--js3W9H/L5uusqhQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3GsWwAKCRD2uYlJVVFO
o0dvAP9FBYdLILBYdNxFBKui9KF0BL6s7wkIAMpEi8gtjANvegD7ByLc1xGV8xdw
zwyKfQ4erwBRWM2hNiF9mSL9vmhozg8=
=SJGS
-----END PGP SIGNATURE-----

--js3W9H/L5uusqhQ8--
