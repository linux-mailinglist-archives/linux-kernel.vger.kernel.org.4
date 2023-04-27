Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6666F0D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjD0UwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjD0UwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:52:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1FDC;
        Thu, 27 Apr 2023 13:52:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a6b17d6387so16752855ad.0;
        Thu, 27 Apr 2023 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682628731; x=1685220731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR+/9DpeopUiM5YSJXbZl2rmLc3o+piGI4JEyCJO8oM=;
        b=mzYDCodeHjkhiD7jAHvq1QpoZPsIEl1MD3qlQqShdThcUQAiUhpc1QaTSDW0l6XKF7
         qp5XvNmYOiQ0AMeiSpyqLaqVgObfVt3RPzy9YtI9i4UG1KJ1u5EyZJI1c/qot0JuyiEv
         NEN+6BHfMDOQDweAZASBO5Tip2D2Ll6o/b/XaVpWM6Pqh7W6sewAALyRr0Ra/vG8pLKX
         8KBkHTcHr9lVQU5u3w935j2twVoB1VqZDuNnihBZDsdavTnWNw4kPZTMgjmwUwj+UJDk
         O1F0z8bN7gcPsW47LA+OTN4Sa0RSBEDpPtts+irZQHYtqwxFcGAHCQrT5p4YERYTxleY
         HbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628731; x=1685220731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR+/9DpeopUiM5YSJXbZl2rmLc3o+piGI4JEyCJO8oM=;
        b=d1qM+U7fICiFEwplfI8zB3snYkgftOhp/Eapx1qc7jgkK6ajdrpKqo17agETZ6acH2
         cE73bzBH88x3fZ4cb+e0tzthzc0uipWtLUFcBrftCkP+96cMnCOg5+cQCZTThI1DB+4c
         45LNmsc6k5hYug2W2oJ9StvR+sRPsc10fGkcPTX59mBH/AGSsjY704yfROa+YA8ivjRK
         j2dSwztCVS/TemNmuZDIK+1UJM/0fZpEh4q76hA6IbkVXfjXIPh/fdmbdQraEUHplspx
         ffIF3pW//d6Rkbm7XXNX+C+T+Scr4oKAYz1CaqY33Ky/YBuNEVsYjqEKlGGZaZXjt8ht
         XVew==
X-Gm-Message-State: AC+VfDxXLhRnLcCiLmKooBjLUz3p3wJ2rPVInzEs69wz3tHiq7htijs6
        5usFFaP4xY0QEcUkkei37K5K1HkrMc+vGsAGUL8=
X-Google-Smtp-Source: ACHHUZ4JjkFDdzQoZtgomdvZX/XPwMSNCbWslul8zziLmHOqiCscInu2cNIRY7v7ZaLzWsZ4JONaCbs0Ls6PjWGr1Mg=
X-Received: by 2002:a17:902:dac1:b0:1a6:93cc:924b with SMTP id
 q1-20020a170902dac100b001a693cc924bmr3506650plx.3.1682628731135; Thu, 27 Apr
 2023 13:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230427195538.2718661-1-hugo@hugovil.com> <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
 <20230427160608.f051241d750404939296f60d@hugovil.com> <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
 <20230427162251.518a956ce7a9dcd88352725a@hugovil.com>
In-Reply-To: <20230427162251.518a956ce7a9dcd88352725a@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 27 Apr 2023 17:51:59 -0300
Message-ID: <CAOMZO5BYeKhwb+ehrYQZ86QECDYnkQ=qUxLjq7sv5vOFbZT2=A@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 5:22=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:

> Hi,
> I am trying to properly add a "Fixes: " tag, but the description for this=
 tag indicates that it is to report that "the patch fixes an issue in a pre=
vious commit".
>
> In this case, I cannot identify a commit that introduced that bug, apart =
from the initial commit of the DTS file which didn't have the reset propert=
y present?

You can add:

Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite
VAR-SOM-MX8MN System on Module")
