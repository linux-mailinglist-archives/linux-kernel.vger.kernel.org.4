Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135E733039
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjFPLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjFPLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:44:29 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4083D30E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:44:09 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-43b27330e51so203904137.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686915844; x=1689507844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB5XD+iAFsa6BpjNlxD9JxMbG+RhSE7xi6kN/8wWgEI=;
        b=xfxUs3Oozpk0bv89JYbgckRsUv2DfT+oPr0M+haaeuC/ZWFXOvQ4d+Mx/zkf68RwuF
         +oeAdSvtHV0aciPK8Yz/6hbskIryWreY3paf4TTjjvFjyfqRvRG30LD+dsBKGFHwIe7v
         Pqp6w9cNz0hFQFqLCiSbPUQAD0/Ve32QFhervrAlAQ+CLbRLtovAqXXGMUkTNAve0zUT
         urglOfPjVN2B1Wf1GR9IcuhtDFVwlIJhHUSKAuwjZObLdijtvAhFE38OBg1qECWfGhku
         g5Bc5nLQpJtLMFBY2nCkI17YuSWo1pslnpkQGWOQtL0gFMy917hPjl7Q+gV8N0nBpkFR
         Xxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686915844; x=1689507844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB5XD+iAFsa6BpjNlxD9JxMbG+RhSE7xi6kN/8wWgEI=;
        b=gOwNJyRFjpaV9po3XPLNiA/PXDa6jVIOWwbX9hF245cGSrrRLE2vAOpaEgeS3Wb1Po
         QQ18V1hvXltaT5xjSCGavbUumRU+LA0oACMxovdJuq+BXwKEuQhiskrrrGGhstiFC+gp
         iFs/7Qa/6EG8zTeEG6CZz3NUiTI6ewroUku5LhO4hwzddjkRLFtC0n50eH2G23PNrmJc
         oe6HEQkGt4wSZ+cslj2+VCvn+HwAFh2Q4VbBnx2mVGtFMWjwZ6at+BPcX2vBOaVjlVKU
         3w0SdSxzmQ4nEFVKVAa/uipwJDpaVSbdOADj3ZoFjULkc3IgnbsUOS4XpH9aIaPOJ1XS
         XoZA==
X-Gm-Message-State: AC+VfDyvTt7E/QDYUMo0Aqn+jNr9OAdfTJRepfh9zGFkyKqiWT8Mxq7i
        Ji8XAZrbv8C/anHiVmQ992FeepGd2oR/kDE6s5iWVA==
X-Google-Smtp-Source: ACHHUZ4jLlWRn5phN+P6OMzwDhUjx4u50eUQ4fFLvwxzFDmB9IsvALU9pV2SQC00cwc3EVvQQFQSug79d9kT2vdw3+w=
X-Received: by 2002:a05:6102:482:b0:434:8401:beae with SMTP id
 n2-20020a056102048200b004348401beaemr1412583vsa.34.1686915844223; Fri, 16 Jun
 2023 04:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com> <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
In-Reply-To: <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 13:43:52 +0200
Message-ID: <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:57=E2=80=AFAM Paulo Pavacic <pavacic.p@gmail.com=
> wrote:
> =C4=8Det, 15. lip 2023. u 21:55 Linus Walleij <linus.walleij@linaro.org> =
napisao je:
> >
> > I doubt that the display controller is actually by Fannal, but I guess
> > you tried to find out? We usually try to identify the underlying displa=
y
> > controller so the driver can be named after it and reused for more
> > display panels.
>
> Yes, of course, the controller is ST7701S.

Hm did you try to just refactor
drivers/gpu/drm/panel/panel-sitronix-st7701.c
to support your new panel?

One major reason would be that that driver knows what
commands actually mean and have #defines for them.

Yours,
Linus Walleij
