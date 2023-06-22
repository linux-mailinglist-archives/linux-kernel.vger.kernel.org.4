Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3611E73995A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFVIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjFVIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:22:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE151BF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:22:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bfee679b7efso1533598276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687422174; x=1690014174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkAmp/eBQd0cTktY86obokW51TRlbdxhv/mUSDQv+nU=;
        b=ryTD1haolYTGV5QhKbwvtO1zw8ha75NRjxLsZio0r8q11fXJAp1d1UhuGi2mBdtzoS
         Yd8SdHE7/3KfHvnaMlTK2Nz5jp/oI5ytf96D2RrI0CvQAMmTVufEaiix0nCH1Hy517jj
         1wadPnb2zAVAiqSyEeMfPJSjfROYLnwTCflkT3TIU/a13cBP0m0nhByfFDf5r+waO8rX
         nIhExbPbf6vWiCRZIBWWsQnwoOLnSjLZ/EK8aM88r1L1O3QHg2bsosfvD+x98vx8TSMb
         /ap4uqa2wSP7grW2zTnOgcwoS2qRShdC+FlDAkjXmtQ1a1EaHiz8i4AAeTUaj39uEkma
         FWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422174; x=1690014174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkAmp/eBQd0cTktY86obokW51TRlbdxhv/mUSDQv+nU=;
        b=R5hXSQlnH2wVjAViGqCmHBjHH02dTXcwn+BiaBcl6hEl5Fjje8Zcf/kcrxAjuReg25
         FUvYiDMKl/zbdwcbNeWkwcpW42gyzDt1n8j4xozv32aNdagNZWU3WVS4XDxQnfJKIWLi
         J6OdZ0V5rH4qakVorJnfzf0Y+jTlTewjRs8C4BpW9rb0Ybp+Ae9lklykZfk2HMDz1FJR
         1ut+TWwP6k+D+ZkL/g/wualmqSVGh1mKcufE95hvbiQn6VCj5h2a1zjS3BzqENntEFYO
         PsazKQaifhU5Af+DfH2Jekvf55g0XL8Us1CRPyiQQS9bn0/y5PKYcDC2qm4+hf+jvkFR
         qUAg==
X-Gm-Message-State: AC+VfDx85hor2rxkJmYdHIWgHAgkMzmZEOYQ/jaLZJC6X+mZ3qLBFLr/
        Kif4OmhoAXjQKcwpYDayUO7cGB+6VvDUOePAHwZbGg==
X-Google-Smtp-Source: ACHHUZ7Vioh9y+yKvbETL5ubLi54HUryu5nk222T86+SVNsggRygRKWvIYgL7sfC92drn2aQWX+t3txSMmBU+WaJnRs=
X-Received: by 2002:a25:9112:0:b0:bc8:cd2c:2fb with SMTP id
 v18-20020a259112000000b00bc8cd2c02fbmr13116488ybl.9.1687422174141; Thu, 22
 Jun 2023 01:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com> <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
In-Reply-To: <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Jun 2023 10:22:42 +0200
Message-ID: <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Paulo Pavacic <pavacic.p@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 5:09=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.com>=
 wrote:

> A lot of modifications to st7701 are required. I believe it would
> result in a driver that doesn't look or work the same. e.g compare
> delays between initialization sequences of panel-fannal-c3004 and
> panel-st7701. I think it would be optimal to create st7701s driver and
> have special handling for st7701s panels. If there was a flag for
> whether panel is st7701 or st7701s it would end up looking like a
> mess.

What matters is if the original authors of the old st7701 driver are
around and reviewing and testing patches at all. What we need is
active maintainers. (Added Jagan, Marek & Maya).

I buy the reasoning that the st7701s is perhaps substantially different
from st7701.

If st7701s is very different then I suppose it needs a separate driver,
then all we need to to name the driver properly, i.e.
panel-sitronix-st7701s.c.

Yours,
Linus Walleij
