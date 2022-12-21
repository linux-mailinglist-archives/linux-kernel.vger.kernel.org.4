Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6596C653306
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLUPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLUPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:15:23 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246F2D2;
        Wed, 21 Dec 2022 07:15:22 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c9so6916902qko.6;
        Wed, 21 Dec 2022 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSVDVHaemmH+mIzEkud4Y2H9dpJqCTRHQXGqE74rkD4=;
        b=E/k1pESyDNT0fmW1KDXkxKlMKFHFb3TAsT+znKo0YfZMI9QeIXkZ28JdC8k6d0TEqg
         kMTIvOaAoylhQTqKE3dnvcd19ujmbkLlVMWPNPzSVa1F+bEOSCUpvDArCEW1W9F+vDuq
         mbZEkmhd6//gmp0dQmuLSGIPeQsLVDuDDmutxlK1e502Kn7VwAaIdlmwI93b5KaxygqC
         o1ACnkVs7NPlxhcldcVm4ymWHG2IXlTNS1IAlsGjwB3trRoAQ/GbJJo69kE5aw+GyJ3O
         DpCqOvapSJJFL2Sqo2awATJs/1gxX+RoJeKizKNS1uaVlNrjfy7qBea6ECcme/eMStSm
         lDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSVDVHaemmH+mIzEkud4Y2H9dpJqCTRHQXGqE74rkD4=;
        b=HFJHlGWAs5PQYrW8Z5jEk8HECTtwM4lE6d5HTDkyQRI0rnBvmZ1PMoTnKIRnFXXIju
         vCsHAgTCXSsGVFIo4E7bBE2+yI+D/1k5+Fnp+lk6X5Gj1coJgsNrQ+czvAsWjm1nYODp
         r/8NOFIFr6oGRNY/ZJ6d8kQXuFjeSWLjYQ2CHqio4ooO9uqrEmq5CafNqkzqx7ROhd4u
         BoZjdce+8DYl5yjLLY53kAfK/89B6vWtmyCNrd29zMYyCdNpPiOe0A7BrS6LlhQANHbs
         qDpQpJO7+NOtBGh2T1Q5xOY8Vp53n1QO0uG7gqdNgRIE7mgVT1s/uFls2nLIiSXclGkp
         PDZw==
X-Gm-Message-State: AFqh2kpZH7yfwpczGU66Dcp7DGhtvsUS/s0SMSGZB+zsJMXLPOU4lxQE
        PaSvF27Qp1Kjv8pyMn6MEvk4Lwe3UrDAWKJyL50=
X-Google-Smtp-Source: AMrXdXvw17YIL8LZxC1dLOjCHIOlH0nKaK9Wif0hLJqBKzaqabfdLwIZI/O1F7uLmtjuNcPwX4UrG1PLH4X90jqQ9aE=
X-Received: by 2002:a37:b93:0:b0:6ed:d040:c175 with SMTP id
 141-20020a370b93000000b006edd040c175mr68894qkl.536.1671635721427; Wed, 21 Dec
 2022 07:15:21 -0800 (PST)
MIME-Version: 1.0
References: <Y6MQ2b8JyST6fPVE@VM-66-53-centos> <0dda49c1-2162-d473-0c4c-591519096008@linaro.org>
In-Reply-To: <0dda49c1-2162-d473-0c4c-591519096008@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 23:15:10 +0800
Message-ID: <CAMmci2UC0kG-4us+RO4NQ2-5kd_1m7jK5+PDWVXvR+khofcmGQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. So the two SoB lines should be swapped? They should be changed to:

Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
12=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 23:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 21/12/2022 14:57, Yuteng Zhong wrote:
> > From: DHDAXCW <lasstp5011@gmail.com>
> >
> > Add devicetree binding documentation for the EmbedFire LubanCat 1.
> >
> > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> > ---
>
> Thanks for the changes. The SoB chain is not correct - wrong order.
> "DHDAXCW" does not look person's name and we need real names.
>
> Best regards,
> Krzysztof
>


--=20
Y. T. Zhong
Student of The University of Hong Kong, major in Computer Science.
E-mail: zonyitoo@gmail.com
