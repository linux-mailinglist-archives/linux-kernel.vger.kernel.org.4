Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255473A416
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFVPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjFVPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:00:31 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A1212B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:59:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-62ffb475be0so56279916d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1687445963; x=1690037963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isuz+PQC54uI8U8TsiSi06GVeERGmJj43Np0iyUSrfM=;
        b=dmVv7bPr5iFp2PUKG6EmeBdAvXmiNR3KSnBPMouO1pNeZnqvux25rfVgFEEX5hqouj
         OEGTfONT4p8xLmJry1j+R04ZUSfHyXJ5jsOt7BkNXERYpD+kht6v4kNsqr38BirdMdNO
         zYYiJ0yTibnj1K1cCUGI88zgdWBtGUFcMwpRqgKa3zzE/8D6RwxzYXfl1AyzCCytdAj0
         ApZG9gmNwaHGnADQWCLl0lJC7DpWd1y/X8SrgrXikkIcGr4plRyzZe4XUb6yg2WezDZU
         guwfPZmzi8hqGmJPm8P1ICL4lziruJGt0uOzaKszwzj/8x/fdwjsNWh716DfhXK2yYod
         LdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445963; x=1690037963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Isuz+PQC54uI8U8TsiSi06GVeERGmJj43Np0iyUSrfM=;
        b=h87MHxc/Enui0SvPFKwiN7ZZxz/a7s6pc1QhLZhtkP4wsLGUPtBlnL4rTp5aO5yQCO
         TuCX0LAa4FItVa//zOKmVQ/lZx6PHDhuGB3ONaeMrMtQiNHsaT8nJr0MAMFNarIFSwaM
         wERJpt5POJtpUC5g276/EIoeY/6nHScyIJ/be9aQo1y1cbbd1sZ1EgBQKCkrqOn+C/I/
         Wpi7OfkB/HdJREtKVQtLry+PXojjWrqnMgopcrnxRsNSCz8SZmsrx/Rso54J8bId5lno
         7CFzMgUEZxD4aLkL/ODSClaeQACKorgyUxAkJYmzSxo99y++cJwvVrtFTvZMq8kS7dpr
         PWPA==
X-Gm-Message-State: AC+VfDyqB/nFqIOcjh4t0h9wxVHilotGdF6GD/51cH7XDpni+9teT/lJ
        9BzCgFFjYUemnDfJsMXsZo3g0bTHQxwWLa4WGSI=
X-Google-Smtp-Source: ACHHUZ5/R7baqHiN/5RHfljGCs+0RFR1fPdQ92oThBDCni214Ka5UIUJV9e4OiaFi5zT6J8G8DBvbw==
X-Received: by 2002:a05:6214:e4f:b0:626:3a98:95a with SMTP id o15-20020a0562140e4f00b006263a98095amr21177614qvc.22.1687445963256;
        Thu, 22 Jun 2023 07:59:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:c623::7a9])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm3891746qvk.39.2023.06.22.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:59:22 -0700 (PDT)
Message-ID: <873a993dc0e4cc9249593bca494ed25e1d0b7fa8.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: rkvdec: removed redundant blank line
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Emma Christy <emma.t.christy@gmail.com>,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 10:59:21 -0400
In-Reply-To: <20230621154247.43983-1-emma.t.christy@gmail.com>
References: <20230621154247.43983-1-emma.t.christy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time to fix this.

Le mercredi 21 juin 2023 =C3=A0 18:42 +0300, Emma Christy a =C3=A9crit=C2=
=A0:
> Adhere to Linux kernel coding style. Removed redundant blank line.
> Issue found by checkpatch.
>=20
> Signed-off-by: Emma Christy <emma.t.christy@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> Changes in v2:
>   - Fixed Singed-off-by.
>   - Fixed Subject line.
>=20
>  drivers/staging/media/rkvdec/rkvdec-vp9.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/=
media/rkvdec/rkvdec-vp9.c
> index cfae99b40ccb..0e7e16f20eeb 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> @@ -227,7 +227,6 @@ static void init_intra_only_probs(struct rkvdec_ctx *=
ctx,
>  				}
>  			}
>  		}
> -
>  	}
> =20
>  	for (i =3D 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob); ++i) {

