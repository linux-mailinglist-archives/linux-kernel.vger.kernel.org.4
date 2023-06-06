Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F65724650
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjFFOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjFFOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAD10FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565c7399afaso67744507b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686062240; x=1688654240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmgZnUr1b9xU4SUQv8F6DDbasytmwWfxIIw2DgHMGFY=;
        b=TtIAkwgdFLdJAPhDartD9FEfvoZHXnmhC8BI2U+1f/91/hTN+qkEsGBHMtEqfvV3ic
         J+Xd9BCjC8n0l6s1eCUrzYgWV5AsXZC60J/7u9AvfusphMuYDtCAg6KafyPgt3nuv/Bq
         NcuOWg+b2hxz6vO61m2P9pXQ3/GidZkdrroiNywv+poVF+o4+d2NmQQtZwtjhtJY1DbP
         BhuaO5lic0zkqiMrWpZ2+1dzC2hSXz3Fl2Crm98x4urn8fg2gW7kkoYECMIPxS515RzO
         VgJRPPib30Jbcz+LvwKfmt/eBUaOdkE0YZ9saTN+avQ1XRFGVdBt7ZA1taO6YmKzEbiO
         5FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062240; x=1688654240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmgZnUr1b9xU4SUQv8F6DDbasytmwWfxIIw2DgHMGFY=;
        b=CLXhxPqG/QwRJonHklFARvCyJMdMpV5ULGiBXve4qLIHiGbsX42OUcvxF0aXmcncAh
         He4HEzuNCGBnGjisfHWtILLGmBEQ4w9dphqrRgSUrDTLrGzc/Oy/ufG5VERl3mncw5hA
         aaNYj4iqTeuydOHgRKxWtakz+j5QaGSj7IdXuxoWCXQbQZpgFUHULsiYBlj8C16nJahH
         CM56HgYukJXkGYCXdZ2TKjld1AQ0keI8NtYFSrfNMJl/247btGyL8kCKAVB06q/9+SHR
         2hsLjspCd6Oetr1C2D+PfaYQZmWv1yY4W/UcuqbA5j/uwhsxXNxFdaodcchHPieOuToy
         m41g==
X-Gm-Message-State: AC+VfDyJmDCyq+qf/1Y6uPM4o4KCaidDfgvL3lPS2lhoiaNlKIypZo+H
        bGXY4hQuPxBZ2re2x2sgu0248Qrp6OCmbULQngqhLw==
X-Google-Smtp-Source: ACHHUZ6v8qiXh1yfy1QM9EOwUVgiutshTW/CaJlHvGVutGzm45N3vYYql0zqEbMbAw3arUOgoht+dG7wDnmlKngKiKA=
X-Received: by 2002:a81:6e08:0:b0:561:d5a1:64dd with SMTP id
 j8-20020a816e08000000b00561d5a164ddmr3361406ywc.40.1686062239813; Tue, 06 Jun
 2023 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com> <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
In-Reply-To: <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Jun 2023 16:37:08 +0200
Message-ID: <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 2:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:

> > We have seen a number of downstream patches that allow enabling the
> > realtime feature of the SPI subsystem to reduce latency. These were
> > usually implemented for a specific SPI driver, even though the actual
> > handling of the rt flag is happening in the generic SPI controller code=
.
> >
> > Introduce a generic linux,use-rt-queue flag that can be used with any
> > controller driver. The now redundant driver-specific pl022,rt flag is
> > marked as deprecated.
>
> This is clearly OS specific tuning so out of scope for DT...

In a sense, but to be fair anything prefixed linux,* is out of scope for DT=
,
Documentation/devicetree/bindings/input/matrix-keymap.yaml being
the most obvious offender.

On the other hand I think the DT maintainers said it is basically fine
to use undocumented DT properties for this kind of thing. Having
completely undocumented DT properties might seem evil in another
sense, but I think Apple does nothing but...

Yours,
Linus Walleij
