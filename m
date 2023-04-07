Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4456DB2C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDGS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:28:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312CEA276
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:28:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ja10so40628226plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680892083; x=1683484083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=racKSQFJw6htxGvl8wL9wTMwQ/BfxK72fBbPH3jrfzo=;
        b=q7Wm05yAXnSdYgLlHZrk+vSMJLG7IwbD5WNTN2nFku16vITT4ZPAtf5KS9mPxIa99m
         KDfOJdihPQ1164fFyY3YqTPPOWuusIcdkUrKaRuyIq7PR0uMFQBh3Y0e82P0CbvR0cNa
         KsKhHw81I8FMbcib5C6wFXXhdaqoihXftB7DHPg/TV3vKbqI5kNriwt7bhPm2Sj6sIOO
         j5tKKaoWBl0+mLS5lpixAw92WKEsDItL7rhFvwYIbeFIrG9/qNe2cwuoFq9RyOZJX+MU
         0N2hu+SHtyJBxahfkPydyCZ1eGhSoRYIct9meRQa2GdsQZ1nwN9pPjlJ+LuXihUPB/Hv
         aVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892083; x=1683484083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=racKSQFJw6htxGvl8wL9wTMwQ/BfxK72fBbPH3jrfzo=;
        b=ViomMHclRyhL1ojy4uC1UpAYLQXcXvw1quHgjZj7KCVnUTxUzgrI7Hr44NbXnDv9uH
         aYhfQDzqm8/hzmbwE9HLodhaiiNlV21fL7YFFVnbVvTAPF5AT438TBoJIY5UzkzVuETn
         wW+L2IEK8HAAYZXHgqjtBj1GkxNEFMrOZX/whzZVskHgG9CIdKn4J1owN7mep3d/niPS
         GERG/o04/cBPXhQdF3De81dOLR1/dlojfBdEFF9x9n/ubps7UIrF11kMQ3dn6lmgSFHd
         CvFuc9AGuceG4PlxIeWE+B/il+/i1Ti11Q9DEWGuwRBkBboL8oveE3PJY2bb54SsmrGc
         wGbw==
X-Gm-Message-State: AAQBX9cixwe0Wlextz1VBJtBvS1HCQyhhqAwWpsIJJQNKBCnx1NX+ADN
        yaZksI9mpc/NpfX2EMUlEGWLkCxhbmP6WtRPJO0lZg==
X-Google-Smtp-Source: AKy350aRREn50bpQ7xCS9LErMRNVeVNQfFgxRLmHVwVs/Hhc6bXBF8o0SRAxqojHcFOrhX1MsA8ejh9JM3OYefgOccs=
X-Received: by 2002:a17:902:da85:b0:19f:2aa4:b1e5 with SMTP id
 j5-20020a170902da8500b0019f2aa4b1e5mr1216879plx.2.1680892083395; Fri, 07 Apr
 2023 11:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230401010456.1866555-1-trix@redhat.com>
In-Reply-To: <20230401010456.1866555-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:27:52 -0700
Message-ID: <CAKwvOdkzW41CXskgY8h6V321kQyDv8DjvYC02YdK71QKEB2g=Q@mail.gmail.com>
Subject: Re: [PATCH] [media] mb86a20s: remove unused active_layers variable
To:     Tom Rix <trix@redhat.com>
Cc:     mchehab@kernel.org, nathan@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 6:05=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/media/dvb-frontends/mb86a20s.c:1572:6: error: variable
>   'active_layers' set but not used [-Werror,-Wunused-but-set-variable]
>         int active_layers =3D 0, pre_ber_layers =3D 0, post_ber_layers =
=3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Fixes: 149d518ad0fd ("[media] mb86a20s: add BER measurement")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/media/dvb-frontends/mb86a20s.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/mb86a20s.c b/drivers/media/dvb-f=
rontends/mb86a20s.c
> index b74b9afed9a2..125fed4891ba 100644
> --- a/drivers/media/dvb-frontends/mb86a20s.c
> +++ b/drivers/media/dvb-frontends/mb86a20s.c
> @@ -1569,7 +1569,7 @@ static int mb86a20s_get_stats(struct dvb_frontend *=
fe, int status_nr)
>         u32 t_post_bit_error =3D 0, t_post_bit_count =3D 0;
>         u32 block_error =3D 0, block_count =3D 0;
>         u32 t_block_error =3D 0, t_block_count =3D 0;
> -       int active_layers =3D 0, pre_ber_layers =3D 0, post_ber_layers =
=3D 0;
> +       int pre_ber_layers =3D 0, post_ber_layers =3D 0;
>         int per_layers =3D 0;
>
>         dev_dbg(&state->i2c->dev, "%s called.\n", __func__);
> @@ -1589,9 +1589,6 @@ static int mb86a20s_get_stats(struct dvb_frontend *=
fe, int status_nr)
>
>         for (layer =3D 0; layer < NUM_LAYERS; layer++) {
>                 if (c->isdbt_layer_enabled & (1 << layer)) {
> -                       /* Layer is active and has rc segments */
> -                       active_layers++;
> -
>                         /* Handle BER before vterbi */
>                         rc =3D mb86a20s_get_pre_ber(fe, layer,
>                                                   &bit_error, &bit_count)=
;
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
