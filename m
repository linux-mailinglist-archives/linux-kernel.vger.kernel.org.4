Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903B06DBDFD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDHXgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:36:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC1768D;
        Sat,  8 Apr 2023 16:36:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id xi5so4750112ejb.13;
        Sat, 08 Apr 2023 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680996976; x=1683588976;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6FhrMBFoJdzUcA3t3Wnsbff5tYmkBEVZpD1D+Jf5NI=;
        b=n/9kCvIBPCZp+18N5zqVm0hWuq+LUwDBTl0BJD0vrupHqFr2D1A3QgjEvb1tNItsQ/
         AUcVncAOSPSrFbaTibszSjso+rh7SrCwRjSnQ+aqNhZkzqR8L5HMaohVuYq8XxhoESjF
         Sgk1d907dKYqISM6mdAcnoY27a5tQVJka6+UGzRlP421QH611ac9lqknS/US7Wfn3kfm
         6Ardf2Q5Bmou2pfsyKAPbBiWFFCxncSzqyzWRLGgusO8Xgez9Qeg8uUiM3+hqnBgSjTG
         xwLF6c0h9M28PZLJ//jFzG705HxQi6px+RBnCUsAtUu4bV6xhZ/Dk15ERII/t6041Mct
         1U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680996976; x=1683588976;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6FhrMBFoJdzUcA3t3Wnsbff5tYmkBEVZpD1D+Jf5NI=;
        b=WXxf9f0znNa4JSevwG5ULmKKH8O6VfM35LECoBkoH52Nil4/eo4ydoEW7Tneotf2Sn
         +X+ujO8AhO2lMSpeoGD9mvYehug9eu+VqVjhVp5EcDQP3p7bYdU/RplnatkanKC6qr7I
         vjhKZUU4VQb18m+04j6c6s7mcWt6yn+6uh1DwcYCBgx5iZvi5MrgWTDVTuSHPvCrX+Hp
         X27s6WRKyxbaCGRLsAbIlgMN8B4f7LNvQL1Giy8fprfdEgkaF5qq8Zktdf3D+OfkJqnN
         gLR0Y8lLwZ8bRVX9CLj8TBpc72z8LyDo5cwGeGuG72+rw333OCM/OUxjZ55Q2tbLsZgW
         lFCw==
X-Gm-Message-State: AAQBX9fXIwNvFkGfejdaazziczeDi9HdzM4MsudnwU7RV9szBukaq0Xd
        MzGwlitY9ELBc4g+fVx95RKjRJUl3l6MgWePglU=
X-Google-Smtp-Source: AKy350azSQDnGDRoUl30SX8F/7DNT/3THmMqHzp4vz0BLGWSXuKLHBWS3NLKgw/7cbxRNOjm+286jypmLtY61Nx/zc8=
X-Received: by 2002:a17:906:380c:b0:931:2bcd:ee00 with SMTP id
 v12-20020a170906380c00b009312bcdee00mr1617332ejc.15.1680996975852; Sat, 08
 Apr 2023 16:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230214204945.4215-1-avolmat@me.com> <9f2debc1-6040-3182-5945-36e668eac171@linaro.org>
 <ZDBruk2t+gB0lSEL@imac101>
In-Reply-To: <ZDBruk2t+gB0lSEL@imac101>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 8 Apr 2023 18:36:04 -0500
Message-ID: <CABb+yY2YWJCxoAtcVhVO4RCcAELnbC-OD9i2odt1nxigopLDNg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mailbox: sti-mailbox: convert to DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 2:15=E2=80=AFPM Alain Volmat <avolmat@me.com> wrote:
>
> Gentle reminder, could someone take this patch into his branch ?
>
Why do you think it's not picked yet?
Please have a look at v6.3-rc1

cheers
-jassi
