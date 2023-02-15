Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049D3697D67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBONaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBONay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:30:54 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C739BB5;
        Wed, 15 Feb 2023 05:30:33 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16346330067so22897970fac.3;
        Wed, 15 Feb 2023 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4qykj63UJf7GGMu3AeFW/Cix8FHMY/Z5cChBHKcGMk=;
        b=NzQma3AeTuGF9zf2Aoyo25zuJOn665qQ8fsmJxxzl3Wj2zRi2jS8uAqJpbdfWILeaM
         97oMNGmo9mJRLoVnwkXN6F04rf4Eh3Ix/Qg3D4lffnnsWGOu2GqR4LZhilu4R0y2+OM6
         cwv0s11fZNW6roDLP1uWarSXY4j4HgBMegEv6hfaPYEvvs+ypWpJXNLOKM/aIGnRuwjG
         5z0aUsYTxauIAgXMcEqqTfVHsGskcBzmluabtfpYCig0ZnAtbLb3wIJM/ObQy0barcax
         rrT3t6yK/03/NWVdXwN1QkfZl5g+Dx7TSdZj/URs6AIOCa7Iec4DtOrICqWAi1YY2MGz
         AM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4qykj63UJf7GGMu3AeFW/Cix8FHMY/Z5cChBHKcGMk=;
        b=N7ON++FNTZtMM/Pkxi0WsUFbZWR0BbK9JIPdHSbNNTpsjeQ8yMxTlIw2ibfo2suKZy
         6zmXvTFS+viwu5XsDYs/DqUSvLH/r+oJx0e5/1S3xXHjGZAxGKy0AyAG/ngziD63VLuM
         nwYYm3Tp+YY2I4afJaLirFIKl9moSKq6F6wa/ImfRZ/HeDLFoFqAgXUen89EKOs3TMHA
         0v4f9QywvH6sG52I7IoJRKh1C1qXWIF/QBJkNtPgiMY959C7gyvj24pakAGbfr0mPSaS
         gJYThBj7F2jyVi3TAMsqP2FbsUVnrFKJXkOEyHMMUKn9Wy+MiwkrpIh8BAQQlmL1eeQV
         317w==
X-Gm-Message-State: AO0yUKUnMeB133XXlzb6F+6K+0luBYi9dO+PHv2b+OacaJEIw2tXiPzS
        htd64QGwUAZhpf3FxTLWkr8KZLlYdBYUEM9d31g=
X-Google-Smtp-Source: AK7set9ki4pg0AuPCD9fr8wF88TxedgHHpBoHt9MD5W5LvjEFLJ0fT+W3KgH4JkIIHpUWCGfqvT8bmgkLNLACbBG4+4=
X-Received: by 2002:a05:6870:2051:b0:169:d2b7:df22 with SMTP id
 l17-20020a056870205100b00169d2b7df22mr327851oad.245.1676467832510; Wed, 15
 Feb 2023 05:30:32 -0800 (PST)
MIME-Version: 1.0
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com> <Y+zYIyaWt1tQcUt7@sirena.org.uk>
In-Reply-To: <Y+zYIyaWt1tQcUt7@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 15 Feb 2023 21:30:21 +0800
Message-ID: <CADiBU38MztMgusoCCGfEt2fdNhB7hC=4t3h_UN6-3s3FEvpXgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek RT5739
To:     Mark Brown <broonie@kernel.org>
Cc:     cy_huang@richtek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Brown <broonie@kernel.org> =E6=96=BC 2023=E5=B9=B42=E6=9C=8815=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Feb 15, 2023 at 10:00:56AM +0800, cy_huang@richtek.com wrote:
>
> > +  richtek,vsel-active-high:
> > +    description: |
> > +      If property is present, use the 'VSEL1' register group for buck =
control.
> > +      Else, use the 'VSEL0' register group. This depends on external h=
ardware
> > +      'VSEL' pin connecton.
> > +    type: boolean
>
> I would expect this to be GPIO controlled rather than fixed in
> the design, at least for some systems?  The name suggests it's
> supposed to control the polarity of a GPIO too.  Sadly we don't
> really have good infrastructure for fixed GPIOs AFAIK...  ideally
> this would be a GPIO and then if we need to hold it high then
> there would be some binding we could connect to the GPIO that
> says that.  We don't have that though so for now a fixed property
> might be OK.

It's most like two phase buck controllers internally. 'Vsel' to
control which buck output.
Each phase has its registers (voltage/enable/mode).
The common usage of 'vsel' pin is to connect the pin by SoC suspend/resume =
pin.
This can be used to implement system low power design (like as system
awake 0.6V, sleep 0.3V or sleep buck off).
I haven't seen the usage to connect it directly by GPIO.
