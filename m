Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E611D748563
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGENtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGENtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:49:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9629F7;
        Wed,  5 Jul 2023 06:49:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-682ae5d4184so245250b3a.1;
        Wed, 05 Jul 2023 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688564952; x=1691156952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuYXAnLC1GEa0aUM7vMLrZwJokRnFKJrVYJTizeDpio=;
        b=KiG7bYw0wJJfpIJp9b9ruWPurgt5aZ4Uk9nuENkUYqfgCKdazxVc7TUhwOEeJ3CeV8
         Gj88c2Vn4BOWejD7qMOmDSYBcyUO33HH74sCAEfdIMVnmaC3cv485fz9QP2NCMNkWXYG
         9Rf/R0MrQNxQpFPMTkjmAZRQdAsY+Utw+3jsPe30rjQ+pVWdTTAYKyNny3n8bKlQZO/R
         AU5BhoYkTSTLeRpB6rg+hz5pi7PpM9K5A0BQzgabt20M/Fpc6wDu32786BrwQoLm3zJk
         nIsInt/zGFd1ukTrBIjLVxmmBzx1AfVXCVAHa9vAL+VkQ7oRWrrXsXYsGZAIT4uZT14X
         +UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564952; x=1691156952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuYXAnLC1GEa0aUM7vMLrZwJokRnFKJrVYJTizeDpio=;
        b=E6f7l0aNImzEH7LAoxrQgnrn40R5JMIruHeqHF8+hhmNua25z6jzw1KpvkSL4YGqU5
         z7Hv5niX3us2reVPRZQhrabRKgJz1DB3LUlPjFKB4lEUFlugMX1bU6agMQxutAKjZvfv
         x3KM4qIvB/+NRDMFQIvDkVv9LliOcmDPJS8ppk2svvdh3EJFUM3qsDfVQ/ZXI65rtI7J
         BuqBLre4ddHD7wEJskXQpcC9TdMLsJjoNlHNDznoiJDPRoWeVJhHvIA41S83E/UmxC1k
         28wD6Y8ivoWSlgfikwJAx2XsgUFiEFbAptWsA1dYGnyVyRXe3f7IB2doQiL6yoQLckBF
         ovIA==
X-Gm-Message-State: ABy/qLZmGO8Yodt4QdE9uLtPC2etM5+zInlogpLePrw9LyjR/hHz/tvA
        v5r5MBoU6x/ESSgEtlYSUE7mMgTjh0DI8IkVFWA=
X-Google-Smtp-Source: APBJJlGoEDFnZYoQCmUR5h9nWmsSCcz2h7frUqqnTArXL/TlBN0YsL1JBetG1VH6F6tCbE8lLJZomLrpnfrcVfLWzwk=
X-Received: by 2002:a05:6a21:6d89:b0:12f:dce2:b392 with SMTP id
 wl9-20020a056a216d8900b0012fdce2b392mr713706pzb.6.1688564952242; Wed, 05 Jul
 2023 06:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
 <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com> <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com> <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
 <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
 <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com> <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
In-Reply-To: <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Jul 2023 10:49:01 -0300
Message-ID: <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Nate Drude <Nate.D@variscite.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
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

Hi Nate,

On Wed, Jul 5, 2023 at 10:42=E2=80=AFAM Nate Drude <Nate.D@variscite.com> w=
rote:

> The patch 'drivers: extcon: ptn5150: Add irq-is-id-quirk' referred to by =
Fabio is required for OTG to work correctly on all versions of the Symphony=
 board.
>
> I can submit this patch mainline, do you think it will be accepted as is?

I think it is worth submitting it to get some feedback from the
ptn5150 and DT maintainers.

Thanks
