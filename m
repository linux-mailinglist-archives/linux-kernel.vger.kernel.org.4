Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C007362FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFTFIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:08:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC61E71
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:08:25 -0700 (PDT)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBEC1423EF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687237701;
        bh=kYHiqY0MrmuYOQjx/9zPX9Eu/K7YT+C3YLGg4BNkKMQ=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UGWYbdwAgdh75VBmXRWciBFshgQIqLBrfFUT4X/bIsd2Vf9eL2LVnGMdnZtd9fH8h
         Y9Eh18aDDuH0s+QEu/Z+UVmCT+0DQ8ry8YXiY5mQrwGfuea9qO6ZPb1JlFKz2QWNpR
         hloJkujhUaJWsZYbC88Zhch/hT/4KDyvsnImAoxvE3b042+EpBFYwACA7Lm4jeZXKU
         MMoe95U6cKlYFfbraifQYmV4eugrguXQaqmVzozowDeyCJORu0fbOUDcOPrbeIwo7Y
         tSb3jT558wKNHM/pPdRb1UZeZA6PHT90JG8D8KI2GHE+7n9fT7KcuvMfaatsQYvFop
         JluVW6V2MxGgw==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so3138377e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687237700; x=1689829700;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYHiqY0MrmuYOQjx/9zPX9Eu/K7YT+C3YLGg4BNkKMQ=;
        b=S0mWtUO4Qm0JDFfSDCkeQmlM9YeodJqkEuxGOR6vwHdL0QhfZnNik7/2sHxznZTTIY
         KFjl/xZIGZhoPtwdYMcv+4gstwHJC+RrHzpbijEwi5oE49T3u3WQW8EofQTsP0vijSKA
         ctssaoa5D030iErS5ek1dvp5gHA5KAXihk7mQrvsCO84fw5Pq3bVN2/HjYIdvRqph4Hf
         7Z8PxyPtgkywFkQn3/0ljil32jbgtgJF6l0qoj/cU5qdJLjOulW/CG+3eQSsQQ5jBE6H
         zJAVfqjtFmtBPf3R8VvKLfTbNa+4n6+Lq0SgGYltXOcSg50WRvAbShITKE89j/4Ho+7h
         lTFw==
X-Gm-Message-State: AC+VfDyo16F2X+B365fRPTJq1stYMwUxZVYwmmmMSWmgWn/w5E3fZR9u
        jzPFZejp6YtZVEcbufCM02TXOJiVNmHq+HGm3pnxogNT2zyc3xV5C0z8vfKUJf6Jpoh+hOgvV7j
        QcYVy27IW4LuIKbfymaHVNpURlOYxsjXDlEPDQwvObvFGpWlhYHBx
X-Received: by 2002:a05:6512:532:b0:4f8:770f:1b04 with SMTP id o18-20020a056512053200b004f8770f1b04mr1430005lfc.0.1687237699870;
        Mon, 19 Jun 2023 22:08:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ml787KUueP3m3sr+JeQpNhdsMKcAJhcImYx4vsWXakhX+FZUrxJU3CNpSuEPCRQjER4LtIw==
X-Received: by 2002:a05:6512:532:b0:4f8:770f:1b04 with SMTP id o18-20020a056512053200b004f8770f1b04mr1429991lfc.0.1687237699554;
        Mon, 19 Jun 2023 22:08:19 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc859000000b003f90ab2fff9sm1360281wml.9.2023.06.19.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:08:18 -0700 (PDT)
Date:   Tue, 20 Jun 2023 07:08:15 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <konrad.dybcio@linaro.org>,
        <ribalda@chromium.org>, <joel@joelfernandes.org>
Subject: Re: [PATCH] drm/msm/adreno: Update MODULE_FIRMWARE macros
Message-ID: <20230620070815.2c0bd60f@smeagol>
In-Reply-To: <yl7qxypdzlzwmmp3b43vz5xo6jxey4zcpdxurcvfzujxrawz36@lneajulwoy4k>
References: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
        <yl7qxypdzlzwmmp3b43vz5xo6jxey4zcpdxurcvfzujxrawz36@lneajulwoy4k>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vDXuG4klP3vp2xxWUE+QEvn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vDXuG4klP3vp2xxWUE+QEvn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jun 2023 21:25:01 +0530
Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:

> On Fri, Jun 16, 2023 at 02:28:15PM +0200, Juerg Haefliger wrote:
> >=20
> > Add missing MODULE_FIRMWARE macros and remove some for firmwares that
> > the driver no longer references.
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 23 ++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index 8cff86e9d35c..9f70d7c1a72a 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -364,17 +364,32 @@ MODULE_FIRMWARE("qcom/a330_pm4.fw");
> >  MODULE_FIRMWARE("qcom/a330_pfp.fw");
> >  MODULE_FIRMWARE("qcom/a420_pm4.fw");
> >  MODULE_FIRMWARE("qcom/a420_pfp.fw");
> > +MODULE_FIRMWARE("qcom/a506_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a508_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a512_zap.mdt");
> >  MODULE_FIRMWARE("qcom/a530_pm4.fw");
> >  MODULE_FIRMWARE("qcom/a530_pfp.fw");
> >  MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
> >  MODULE_FIRMWARE("qcom/a530_zap.mdt");
> > -MODULE_FIRMWARE("qcom/a530_zap.b00");
> > -MODULE_FIRMWARE("qcom/a530_zap.b01");
> > -MODULE_FIRMWARE("qcom/a530_zap.b02"); =20
> Why are these not required when "qcom/a530_zap.mdt" is present?
>=20
> mdt & b0* binaries are different partitions of the same secure
> firmware. Even though we specify only the .mdt file here, the PIL driver
> will load the *.b0* file automatically. OTOH, "*.mbn" is a standalone
> unified binary format.

Ah thanks for the clarification.


> If the requirement is to ensure that all necessary firmwares are part of
> your distribution, you should include the *.b0* files too here.

I'll look into that. IMO, everything that the drivers can load should be
listed for completeness.

...Juerg


> -Akhil
>=20
> > +MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
> > +MODULE_FIRMWARE("qcom/a540_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a615_zap.mdt");
> >  MODULE_FIRMWARE("qcom/a619_gmu.bin");
> >  MODULE_FIRMWARE("qcom/a630_sqe.fw");
> >  MODULE_FIRMWARE("qcom/a630_gmu.bin");
> > -MODULE_FIRMWARE("qcom/a630_zap.mbn");
> > +MODULE_FIRMWARE("qcom/a630_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a640_gmu.bin");
> > +MODULE_FIRMWARE("qcom/a640_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a650_gmu.bin");
> > +MODULE_FIRMWARE("qcom/a650_sqe.fw");
> > +MODULE_FIRMWARE("qcom/a650_zap.mdt");
> > +MODULE_FIRMWARE("qcom/a660_gmu.bin");
> > +MODULE_FIRMWARE("qcom/a660_sqe.fw");
> > +MODULE_FIRMWARE("qcom/a660_zap.mdt");
> > +MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
> > +MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
> > +MODULE_FIRMWARE("qcom/yamato_pfp.fw");
> > +MODULE_FIRMWARE("qcom/yamato_pm4.fw");
> > =20
> >  static inline bool _rev_match(uint8_t entry, uint8_t id)
> >  {
> > --=20
> > 2.37.2
> >  =20


--Sig_/vDXuG4klP3vp2xxWUE+QEvn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmSRND8ACgkQD9OLCQum
QrdPYw//QzGQ0R5KDY7yYZt83rqtfWawMZuuBi9PMkzDHZWRYkFYdmeVGDdxtAm4
od/7vmulM8dUSjdiTvbSmnxi4kapgysgi9xFpZ6y998+V/FPlFU7bYAbjV43c0xo
2WeklNS4fKaoJg0jVMbVFegQIRENqKj9xwqbNHlDKhPNRELiU7lpMDRBJalzICdi
FuwZvGv59ah+voSxHNpo0e9et659RjgqxvxlS7ivWLR/gimoCURRXj+oLD3nKtav
ibG704hNsnEPqGvf9NQi+C3NTMZPF123EpiXyNQoe6J158Xg6dgur0oBPyn97TFX
rrsm+9usyGPzfrwdtwdz9OtqL0wCT9uOD12W+E8MqVBryU8HHRdCt/ZQkkJ5sz1V
6+wHya9PseGN5zCRBOr+flAjRmfNDCLcveB06BmhXSEUk1CmPHhJvUAfKgrMMK+n
R0BUF+V2/r82AcPQpx1rNuPWeEeSsgGwq/gq+Bbp8lJB9BYm/IDst9fch711WV70
70AsC5zdSN/E75TJpQ9qqG/ZafWzPoI5YhYx6MOIHxwvmFBgSBLHUqCrSSVargjF
qAYkTizvh4BMknx5hL+XfReFriTRkU93eyTHwOkXFN5BTKPFFIWSA6CFF+1+wiNy
GYQ8qgldRA6YZFXjF3FN/+oTAmwzjp/ZBgAI1C36IVWqinwjXV4=
=rUQw
-----END PGP SIGNATURE-----

--Sig_/vDXuG4klP3vp2xxWUE+QEvn--
