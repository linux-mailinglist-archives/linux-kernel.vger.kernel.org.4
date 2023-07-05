Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2537487CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjGEPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGEPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:23:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E5F7;
        Wed,  5 Jul 2023 08:23:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-676cc97ca74so1408236b3a.1;
        Wed, 05 Jul 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688570586; x=1691162586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w7097cRvNXN5B9ztM5aV9skZJfwSNR3PrheUJuvTPg=;
        b=bDrlwd3E8G/aHUOf4qqSHiB+4uSiQ6bAeB8XY7SgW40436eUot76D5twnGdlLPqdXg
         Wq/YDQAgQE01ntlowC6lMh6ME9vTjz+5ev117xoDXjMa52Y/x227vtiT6qLOeOoEWJxM
         O9iWV4/1yfBKkRzlxmz4Y9Ayd82NglHIxxh52gFYZ5OvB1aSECVLGDIl2ffYDqYmNILO
         dAYpYCrQv8i4VOAydke5ixrlvm3EZeqnKVGSRc+4UJJ99iC7pnSSM3hjKCFR54eRlerP
         PpZjD+ISBkKCHp6rqbz6porN/LnYaq9OFH/1bFg830XyyO8f9JmknO1skUjNf8gMAkLQ
         5Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570586; x=1691162586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w7097cRvNXN5B9ztM5aV9skZJfwSNR3PrheUJuvTPg=;
        b=BLwKSfw+j83xo0AzEFgm0P529wyKLl6OE0bLa2fVA3SOpkvxKXYGdEJNSZ8qjZkAgo
         X6hm3SeOW+Xn7R8ZL+K22AUgzSHMMTEFXnduVEm2JlnVtPKY8fqefN7W3r2Fu2g53QPe
         ymRKWdUmJMCYRTdNflyouiURbuoPuprBj7xeSxtKLc+Ds6EFYQE1A2dXoT+ZiY4gTyNr
         FFjA5yqubMPDS7QVpYd0MaxK/Qwa3pvOlFMuzEESJeLGbztzEQl9rRIcgSHN8D+meL79
         Wfdt8f5xmJDHf36cQI6Pxd6tTqvtVEePzLSUqsLaL4Sh5h80GvrF3UUw4OvpLePg6OBh
         8Uqw==
X-Gm-Message-State: ABy/qLak6BGExbb3vmuDr8NXvfZnTNl0qNZzUKOWgmlbpFwaBpm1jUaq
        S4MShKxc3RjOvigA3ADrG7rDcffZGdlUXk5PGCQ=
X-Google-Smtp-Source: APBJJlExgnbHUndFrRe+r0wTN+1K89PPZ7621Ouk8+D9FQ88zdd7Z8A8S/gWoUCXkTbHt5ur4+AwvQs1vSKkm02pYPY=
X-Received: by 2002:a05:6a00:1d9b:b0:681:ed30:32e5 with SMTP id
 z27-20020a056a001d9b00b00681ed3032e5mr18180326pfw.0.1688570586526; Wed, 05
 Jul 2023 08:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com> <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com> <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
 <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
 <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com> <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
 <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com> <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <20230705104837.e620da576f22f28244daacb1@hugovil.com>
In-Reply-To: <20230705104837.e620da576f22f28244daacb1@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Jul 2023 12:22:55 -0300
Message-ID: <CAOMZO5D_p3hf+HVHNAijEevJRpzwmyGPcoHjiapsOx_ddsoksg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Nate Drude <Nate.D@variscite.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Hugo,

On Wed, Jul 5, 2023 at 11:48=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:

> Fabio: do we need to support both configurations in the Linux kernel
> tree, and if yes how do you propose we do it?

I would suggest supporting the new revision only.

Thanks
