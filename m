Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A01741497
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjF1PJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjF1PJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:09:17 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF21715
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:09:15 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b056276889so2152956fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687964954; x=1690556954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQFXM7LoMXWobaAJZ3RZKI3cUbo9p+ZmED0c5tG5e8o=;
        b=aFkpfco7/EqtSeH8SvrioWbyX+Ie6tKQ/zdB41Apheqb0+GWe389VsNoqIegt1qEQf
         TQ3oLh241qOkxJ6WUHW7zQkl0qKXdY8CRGa8M9bxehKI2jDjp4eb01wV+tw0DhV1jfWO
         NFlMjr/fqIG7/AmLOuFg65aPOT9UZAw89SasI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964954; x=1690556954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQFXM7LoMXWobaAJZ3RZKI3cUbo9p+ZmED0c5tG5e8o=;
        b=WVhAlaGufKtJfdw048pVS6Lcn1x2Pirn6Rg5VkS4f4uWFqpRlLUkvVrB64xsNBGFYw
         5vd8MrA/oVlIASLGoVm3ZyQG4U2d2ZmBWbe37bPU1vL2LJ+rNKm0Y+9q+0MZ3OKZPzLY
         puhOATfWZCKE+PWzwlhhRhqgNm3Lm0J5/IVRkuHntkRBLFbMCxFchrWMsHkMPTcc72V1
         1JirMS9WoMmhs895bEx1erhTQeMHDcQfIOUEQocusckjaDFhCD17mAnvU8rpkzQbW305
         xL/AIUCmKYfXUhhNuYSaA2Dfuqzo0EdBfmvPgTlM+9XizP+0AEOIMHWzTX5lpM2HsesM
         PuNg==
X-Gm-Message-State: AC+VfDw9Tee5BAg2INroS4ZI4RnUbHha1GR+BnKDsbIjFS3i6EIphXo+
        mhirB4xcgJ9Zg9Rg9w1EdTJ8pkrP6iRiLsS7eJYqvcFQ+398ZWd6Owg=
X-Google-Smtp-Source: ACHHUZ7mEBIwcDekNUgmogdX1cBOPhK0TtMzNVRdpWwdf24243yY8Fh3zjN7XTDZu/RLnFFOjNTB1StBdw8SgOnw3a8=
X-Received: by 2002:a05:6870:5b18:b0:1b0:b13:c18 with SMTP id
 ds24-20020a0568705b1800b001b00b130c18mr13876523oab.3.1687964954543; Wed, 28
 Jun 2023 08:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230628130339.206261-1-mchehab@kernel.org>
In-Reply-To: <20230628130339.206261-1-mchehab@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 28 Jun 2023 17:09:01 +0200
Message-ID: <CAGXv+5FT64iMSebcT3b9TP2NhEt5e05bjy5HC4AvzM_+n-og=A@mail.gmail.com>
Subject: Re: [PATCH] media: dvb: mb86a20s: get rid of a clang-15 warning
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:03=E2=80=AFPM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> When building with clang-15: this warning is produced:
>
>         ../drivers/media/dvb-frontends/mb86a20s.c:1572:6: error: variable=
 'active_layers' set but not used [-Werror,-Wunused-but-set-variable]
>                 int active_layers =3D 0, pre_ber_layers =3D 0, post_ber_l=
ayers =3D 0;
>                     ^
>         1 error generated.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
