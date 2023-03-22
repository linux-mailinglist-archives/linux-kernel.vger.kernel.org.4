Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97D6C5234
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCVRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCVRTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C682CC63;
        Wed, 22 Mar 2023 10:18:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53d277c1834so350367177b3.10;
        Wed, 22 Mar 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5/aVehBsgh0kzDWGWqpxifEfBtyQggusoaHEV8RT/M=;
        b=fTnHzZ+vROjiscjk5DTXVVgaqhY5LcEvflX3LkNzqg5LrJbZOhuT/8gG1mZYC3Dg44
         rZbTiyNFhHgMyancDn019aeLQzbaTvhgbkoBBVVg8l8vJ1IBIY7E7sOBVzFHQ0njxClC
         YQCuU+ROgb3B6FuT5crCquG5FNDrEuzGzhEIeHUccgvlygWIeyXL6yoyCZwo7o44CG2A
         p/ZQ+YUlneZZZuWZK8rUO8ILIdrqXuw7oEvqfrEydaMqh+9pLP7Wt9w/gFiSawDiNBEu
         dlpualbfDcQCKf2MgZSy1Z2/yBhiGPsbXRgb2RMh3ZsjBsCX0eGRAAw4nn4jFA3oRhoS
         IeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5/aVehBsgh0kzDWGWqpxifEfBtyQggusoaHEV8RT/M=;
        b=JuJJqQXarWk0sztRL3JN2B0JmKirqBEyY7TXUdr0uto/8VOFjCBORvGDMQL3iErtKV
         dKIJPftywp4jz2OBuJopon0+xoWBNvMTeq/isETGYCaci6V0cd7osJphiUxY+0k9MpUr
         ScuAiCAk4bGl1lL3IBzXNYCCG6xXvtmAgdiB6/H05I2Kcc3RaqejyWkDuwZxx4lECfI2
         HPnmYTXSLOjClV/r8R5GmIW2z06U5muVpWcHIxOqNTSpU5Pr/zedaKKlrAuYF83aY1/m
         8kw9dtXbzsRZNiPLCmUWPT+J8sapj5/7N9zoW1Wm46HhcACDAbj7wZMX5IjKOicbR1Rv
         bzJg==
X-Gm-Message-State: AAQBX9dUSaRDBkafC/eAaOwUlXbMyqnbMUa6MtAHmejCS8lhzFfiXkkh
        GfUeqwUI/hAM+vH4PWZY8DIChlrxVrwCPBnmmfM=
X-Google-Smtp-Source: AKy350aJ8+5bIapFVS2V7Xlh6Fx35AQq+ZxlQkFE9XnIFYFz+3BqwQOvw7YXnSl+EBHR0JTaw+qhUBvq/a2f3kxUYkM=
X-Received: by 2002:a81:b149:0:b0:544:b7ff:b0df with SMTP id
 p70-20020a81b149000000b00544b7ffb0dfmr344866ywh.2.1679505518520; Wed, 22 Mar
 2023 10:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210315122605.28437-1-noltari@gmail.com> <20230321201022.1052743-1-noltari@gmail.com>
 <62d8aff43456051cb607999a7db0b5cd.sboyd@kernel.org>
In-Reply-To: <62d8aff43456051cb607999a7db0b5cd.sboyd@kernel.org>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Wed, 22 Mar 2023 18:18:27 +0100
Message-ID: <CAKR-sGfzV0MXY_qGZCepZxXc3uWzWYb3v9fsJdAhoqOA6ikiTw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clk: add BCM63268 timer clock and reset
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, william.zhang@broadcom.com
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

El mar, 21 mar 2023 a las 23:54, Stephen Boyd (<sboyd@kernel.org>) escribi=
=C3=B3:
>
> Quoting =C3=81lvaro Fern=C3=A1ndez Rojas (2023-03-21 13:10:18)
> > Broadcom BCM63268 has a timer clock and reset controller which has the
> > following layout:
> >   #define POR_RESET_STATUS            (1 << 31)
> >   #define HW_RESET_STATUS             (1 << 30)
> >   #define SW_RESET_STATUS             (1 << 29)
> >   #define USB_REF_CLKEN               (1 << 18)
> >   #define UTO_EXTIN_CLKEN             (1 << 17)
> >   #define UTO_CLK50_SEL               (1 << 16)
> >   #define FAP2_PLL_CLKEN              (1 << 15)
> >   #define FAP2_PLL_FREQ_SHIFT         12
> >   #define FAP1_PLL_CLKEN              (1 << 11)
> >   #define FAP1_PLL_FREQ_SHIFT         8
> >   #define WAKEON_DSL                  (1 << 7)
> >   #define WAKEON_EPHY                 (1 << 6)
> >   #define DSL_ENERGY_DETECT_ENABLE    (1 << 4)
> >   #define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)
> >   #define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)
> >   #define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)
> >   #define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)
> >
> > Also excuse me for the delay in the v3, but I totally forgot about this=
...
>
> Please don't send as a reply to a previous round. It makes applying the
> patch series more difficult and buries the new series deep down in the
> mail thread.

Excuse me for that, but other kernel maintainers prefer it this way.

--
=C3=81lvaro
