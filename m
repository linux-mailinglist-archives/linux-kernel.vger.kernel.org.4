Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143477479B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGDVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGDVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:50:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79AE62;
        Tue,  4 Jul 2023 14:50:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-656bc570a05so1256733b3a.0;
        Tue, 04 Jul 2023 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688507412; x=1691099412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDOcAVSsw6sNPQ1uR+8PfZeGGSfhUEnnmrUTWHUwDOQ=;
        b=hrmpPMtCWQ4qBdcKGywPYo2OZwd1ut66EblB+ipzRqgeQ3ZdY8FpQyiVNFCyUWmhWq
         sZoFGFKVHD1BrtnoiPzF2v/0xYFi0CSchlTqIIMzEJnoSPkGf0Ox6Z5hI7yZaaw+DPtY
         fFa/XcGzQzFdmi3Dqwyeh/Bf8GENaXdqPbvsu3i1KvB32lt/hul3nPYFX2FEw0olT6Nj
         7inCkflQ/HZoXrN38BeePzj/ly7VCnvD8SXTwQhJbMXI7kxeZ/rVN+AHAl4h5nwforI9
         YOxhMdaY0x9Vg1ogi/NrEMGhq2b3xIDsVdTPNlXVfum4y1XEV1tywthW2fiQWWRsx7EC
         ZR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688507412; x=1691099412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDOcAVSsw6sNPQ1uR+8PfZeGGSfhUEnnmrUTWHUwDOQ=;
        b=LIRD3d+Bq9lD/u+1KXX90w9I1Oylx9LeZCql1qu245G59j7XQyIAbGQSHsNIz1Xm1z
         28Y78h2bzuGYJUhd8+Xp92KK3qzZqwlB3zrETStjowdzHuHLtBy/uZ0ZE/uRMjJi6lmc
         82WEN68mj5kh9eUNNwkPyEcSNucQJ9T30Pg3Jvm+s/xw3q6btS9KMAYZD32+obsLbROY
         xEENi0foT9Qs1P4DK7JByBfY1ClfAtw4JQevgIeWJpoPnHZWddB4faUvSXkzivhf9GtU
         Fs0FY1GeTgzRqllkpT9eRGmMpnQ2f5Sj5g7H/O25kipfURPl7V7V8rITnfPyo33B/MS0
         b+cw==
X-Gm-Message-State: ABy/qLaX8dqHcx0nd0TmRrh72H6OTbPzAXACtaziPOhMMQrkJaFeMXUn
        ioUHXaWCCg4bimTp6t2p2PCbhIZta9XBlt1aTNw=
X-Google-Smtp-Source: APBJJlE5A/X8x+JwDY5J0QMqiS89l5raq3NXmtntSqYG1HdWPj/B2623QBasV67u7vXc/zAo1agOCd3dJNI0ZV9WNXM=
X-Received: by 2002:a05:6a00:280a:b0:676:2a5c:7bc5 with SMTP id
 bl10-20020a056a00280a00b006762a5c7bc5mr16152131pfb.1.1688507412276; Tue, 04
 Jul 2023 14:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
 <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com> <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com>
In-Reply-To: <20230704172801.f11422b3f947c625f53af871@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 18:50:00 -0300
Message-ID: <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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

On Tue, Jul 4, 2023 at 6:28=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:

> Hi Fabio,
> it is important to remember that on this board, like I explained
> before, the INTB pin is not connected to anything.
>
> It is only the ID pin (9) that is connected to the GPIO1_11 pin.

Now I looked at the schematics and you are right.

In this case, GPIO1_11 should not be represented as irq then.
