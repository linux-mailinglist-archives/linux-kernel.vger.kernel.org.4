Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D7732A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbjFPInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343618AbjFPInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:43:39 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E4F2D7F;
        Fri, 16 Jun 2023 01:43:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-57023c9be80so5111817b3.3;
        Fri, 16 Jun 2023 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686905018; x=1689497018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcAlkMME68B/DMn58wIZvDIpfRVrA5pKETi1cowyEQ4=;
        b=LIShMYjdoGP04ZnI9mYPlm7+KOnQsqxwC3N1HHcwpk+mB25s3KACUgXvZomQesEUva
         8etO1cgSUlojGFMmcnm0VepC1cjTnz+DZxryzhQG0ISyow8S95Uun+nw4r5cQ/Adzjvh
         O5KZdqKIRLIAnZZo2077iRtcyNPverwIdLAun37ln/jyP64+Ntoqe1BrNJn6w8uW3Q4+
         RXjRAsPqoTSD07zBQXRQWz1bUyXXPYm04untstdJp4zIpxs2t6Y4fYl8fKHG6l/Bqhzx
         SHzJqGOMqKsMIj/wWOaBNo4qIlYXcvhNBJoNGtA5QEcFiqHw6HVji1nXXDdQLQUKNEGh
         AHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686905018; x=1689497018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcAlkMME68B/DMn58wIZvDIpfRVrA5pKETi1cowyEQ4=;
        b=B+B///svyVyuGnBHQu4v20C8yCaJpmCfgDKRDN9NfaMaHiZPiu++bLxu2Ft300DhSr
         UABc6y5a1QsyTjgks0ZFAG1NiKdWTkd1SybBCKEtjLzCKgLES3Z/AxLFLxt4OwYvsonZ
         GDQ6BH47IdTAbJRvgnoFqQUEIaxEZaILFj409t1utLXQjG6VYj4ZVdx2dPTqxS5Oj/rT
         3JonndBp2uoH9PQgQ7ae1smrO0IZ/Ep3TFxJOf3ZShG4gbN9MHykvO773tMAiiQgH9T3
         UorOEFKxju97dNIBCyctFMsr9l0iDD6w648u3OfieYTyTDJnYfL8I4wR8wTsziZvlGvV
         BULw==
X-Gm-Message-State: AC+VfDxTHAosHY60KQhj99gHXRjTNky/Bw2i6y4BKwZa5gSswpCvO9Wu
        +yFVw+bo9NXnyb9M8yrIP1lk9eKDmacq146lIQ==
X-Google-Smtp-Source: ACHHUZ7HXl5yZodGeTdNksuSc50SL1MwuhTSo/SCJY8XtVdKpO+fiVayDP8lN7Mq22lZDtZ8KzYaROiwwX8QDM9oh6M=
X-Received: by 2002:a81:7bd5:0:b0:56c:e2db:8d07 with SMTP id
 w204-20020a817bd5000000b0056ce2db8d07mr1000781ywc.33.1686905018211; Fri, 16
 Jun 2023 01:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230615144423.828698-1-privatesub2@gmail.com>
 <20230615144423.828698-3-privatesub2@gmail.com> <20230616080326.2vtkfeyzwx542hk7@pengutronix.de>
In-Reply-To: <20230616080326.2vtkfeyzwx542hk7@pengutronix.de>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= 
        <privatesub2@gmail.com>
Date:   Fri, 16 Jun 2023 11:43:33 +0300
Message-ID: <CAF4idNm55=uFUTuoMaFHopMXZA04pQbhQDg4D8kpzp-G7rVSRA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

=D0=BF=D1=82, 16 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 11:03, Uwe=
 Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>
> Hello,
>
> this isn't a complete review, just a first quick look. Up to you if you
> follow up with a v2 fixing the things here. If you don't I will take a
> deeper look at a later time.

Thank you for your review. I will take your remarks into account when
creating the v2.
