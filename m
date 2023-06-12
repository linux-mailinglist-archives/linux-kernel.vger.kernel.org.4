Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064D72BA12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFLISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFLIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:17:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02BB3584;
        Mon, 12 Jun 2023 01:17:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso6009578a12.2;
        Mon, 12 Jun 2023 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686557852; x=1689149852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RgjaXpEXsHKymgoZwVAer6HS1GkgWzeejMdXZmBJCA=;
        b=feZKdABYE4vr0/NYmcc9gHJ+PR5oKfdKIGeOnjty5TMRvE8Kf3x/25BlUC/YevRf3A
         jpSTRgRNFWCSTB2nGom8Azd3j5v4iuDtw1kwHFypuv+ZQCQDj4Um3K+Kc/68sjdXlIQ3
         +C8p/IFKrHF1iNClgAlJgppEO2YQXT8Jcemow3vQ4SZ1CRtC4sV1dbvNGTqihj8PVCtO
         djckobs1jZL6CMyhDqol7VJBSTlig2FFj87b2+XaSY9L7nwnZXNvI+/LN0yENHERKebe
         JXYAVYJjDLqFNxUj4dBY05LSW9N/atu3TUJeNY3llYeCmiivAGMF/gdklFewXBdvVUs7
         e2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557852; x=1689149852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RgjaXpEXsHKymgoZwVAer6HS1GkgWzeejMdXZmBJCA=;
        b=UmsSKzKf67bY3Yesidjf4OER95VCDR8gr6lz4DByblhVjq6F3UJeL0Z9hXOijPR26U
         GbWzz0mSSGUGl/cMpFzuK4gACi7vP1N7gJECIW2fp1Mq71YXCBShOH5PWDzVbIbR4mh6
         IU9rzxL3ZuD5E56GEtxufzIW3RrAlP+wwrIzZpqygxswpAGBky4Ml09zA1E2VhMmbf2E
         wSTrihc++UdHiHvnP/5lp8L4jUp0qsJuY7SRMjYuNCfH6Q+/cVGxKp3rMWSM3jnEB7mv
         NnPu7enGISnEYXX4cL2XLnogBXQG6zYsIyqN8OB5C4iECxUBbSQReIorSvACWYUbBX6O
         6CMA==
X-Gm-Message-State: AC+VfDygmDjs/ZgzMMjaosNK249S1Wu5xE03iDff9WNvXer0XwrE2Vuh
        zuXb0PH99v6ZoyicOwEY86oDyKoBGVK78C4/l1M=
X-Google-Smtp-Source: ACHHUZ7FCeE2TU5RO0p4ZuTCrHCZsjmIYAyrRLpmWVGZEiXpCqk8v7qvN+gL76ATcUoQUnkiopkcmT1f+cSgMJTc7b4=
X-Received: by 2002:a17:907:9307:b0:974:2169:5f81 with SMTP id
 bu7-20020a170907930700b0097421695f81mr8955047ejc.22.1686557851593; Mon, 12
 Jun 2023 01:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230612063429.3343061-1-bigunclemax@gmail.com>
 <20230612063429.3343061-4-bigunclemax@gmail.com> <20230612-wriggle-remindful-89d5105c94ee@wendy>
In-Reply-To: <20230612-wriggle-remindful-89d5105c94ee@wendy>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 12 Jun 2023 11:17:20 +0300
Message-ID: <CALHCpMjxboLn2eTjOJkE2JAzH3S8OB3v9fWqDOdeipAmLvLx2Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add thermal sensor and
 thermal zone
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
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

Hi, Conor

=D0=BF=D0=BD, 12 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 10:55, Con=
or Dooley <conor.dooley@microchip.com>:

...

> The RISC-V patchwork automation is complaining about this patch while
> running dtbs_check:
> arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb: thermal-zones: c=
pu-thermal: 'trips' is a required property
>         From schema: Documentation/devicetree/bindings/thermal/thermal-zo=
nes.yaml

I didn't add 'trips' because I'm not sure if they should be the same
for the D1 and the T113s.
Maybe it's better to drop 'thermal-zones' from this patch and add them
later in separate patches
for T113s and D1?
