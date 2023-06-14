Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80272FDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbjFNMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbjFNMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:07:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE301FDE;
        Wed, 14 Jun 2023 05:07:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75d54faa03eso199302185a.1;
        Wed, 14 Jun 2023 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686744434; x=1689336434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpftmWhYrmfspx1PS5npjXbFOLkpVAXBf5OKu43lD1E=;
        b=bR28+jkpH/xw/0kRoHyU4zg/AEMWX2zI44haQToRNTK69f5CZszjfRVGN8dR1u/lLb
         v1Lu/5ntmIwgghOoezal+KFjGw2xUuHzfXJnG7+MH0EC1P1TesKemBTEsa2vyrhoiBeq
         lvOV1PNQwJRqpwM7V4QvE1vsBwmoqmC5H70IjQHLZ8Px7Gm24nkc/NjGZhkobrRuNy6D
         S8f9y9F7CgXobxHcyG4p9w/gcWev78R26WNINyzpQsCchKhxzBTfJLeZYMizAalrGUdh
         KfLiJJkh1IK06PYUPeqVTiDym3+a2FToQcbU9hVSUh5Ml+pSIlmc1bsx09QTWFnX43Hv
         ZWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744434; x=1689336434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpftmWhYrmfspx1PS5npjXbFOLkpVAXBf5OKu43lD1E=;
        b=Q2KVC6mwRXjpHppXZL/t0DA0QgycEINIMeL9AQlvzPGbtSNzJLOvHJwFJY/ngdG5xU
         Mxi526ZJ0eAIqE3K17mJOofm5SqniGmxy5a+7Y+btieQIk8J5QkyUYUy15pVI6HYOQT4
         5n4NWa4X+vWuibCgvPttAM3mu30eejjbgWoC67YZz7g+mMqLe+s0El5hbOURq1+ekwss
         DB0RP5T5uW3HKev6ZhMUYrnXB2dr7rHylLmpqh9GCud+YaefQRVct7EiHdmaoZ2RhTXj
         iSsjuhErepj68UYZMpILiZSWy9FS/+0BEEpEjH6/OhPccgvpftKrSGz9KyAqJXlExdTk
         HG2w==
X-Gm-Message-State: AC+VfDxN714y3eXkZ8cChSm/r538wiMV9lW9s9uLkZO9glGIfvCxfmCJ
        4WgfOgfovTZhIC2e82HvCFZoOksCBdS3PsrJTL/S6xRX7Qw=
X-Google-Smtp-Source: ACHHUZ7/W/9uNSg0CWK/HEL9y/EqE5WCuy6F2k0Khf2kA2H31yhioTeJhgiaMLUql+1WGbP3bGYaYbVAxy+ARAVTA+k=
X-Received: by 2002:a05:6214:e83:b0:62d:fc19:b1c3 with SMTP id
 hf3-20020a0562140e8300b0062dfc19b1c3mr4592459qvb.50.1686744434203; Wed, 14
 Jun 2023 05:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230613093757.5380-1-luojianhong@cdjrlc.com> <b41c50989125dec782e1fbd2793d0ecf@208suo.com>
 <209fbe59213d89c3e7e3a5fe6030e19e@208suo.com>
In-Reply-To: <209fbe59213d89c3e7e3a5fe6030e19e@208suo.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 14 Jun 2023 22:07:02 +1000
Message-ID: <CAGRGNgVULqZzu2_bqBSSdnjSj=EuO3-0BS3TBMk=RHL8O32NmQ@mail.gmail.com>
Subject: Re: [PATCH] ath: Remove unneeded variable
To:     baomingtong001@208suo.com
Cc:     toke@toke.dk, kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingtong,

On Wed, Jun 14, 2023 at 1:23=E2=80=AFPM <baomingtong001@208suo.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/net/wireless/ath/ath9k/gpio.c:501:5-8: Unneeded variable: "len".

Coccinelle / Coccicheck is unable to accurately detect unused
variables as it can only analyse the code as it is written and
doesn't, for example, expand macros. This produces false positives
like the one you're trying to fix in this patch.

> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   drivers/net/wireless/ath/ath9k/gpio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/gpio.c
> b/drivers/net/wireless/ath/ath9k/gpio.c
> index b457e52dd365..f3d1bc02e633 100644
> --- a/drivers/net/wireless/ath/ath9k/gpio.c
> +++ b/drivers/net/wireless/ath/ath9k/gpio.c
> @@ -498,14 +498,13 @@ static int ath9k_dump_legacy_btcoex(struct
> ath_softc *sc, u8 *buf, u32 size)
>   {
>
>       struct ath_btcoex *btcoex =3D &sc->btcoex;
> -    u32 len =3D 0;
>
>       ATH_DUMP_BTCOEX("Stomp Type", btcoex->bt_stomp_type);

ATH_DUMP_BTCOEX() is a macro that relies on a bunch of local variables
being defined, one of which is "len". If you'd compiled this code, you
would have spotted this problem immediately.

A "correct" solution to the "problem" here might be to add the local
variables to the macro parameters or move the definition of the macro
closer to where it's used so it's more obvious that some "magic" is
going on here.

As others have said, you need to fully understand what code is doing
before producing these sorts of cleanups, otherwise you'll produce
incorrect patches like this one.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
