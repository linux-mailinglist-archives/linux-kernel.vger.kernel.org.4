Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AF6161A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKBLVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKBLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68D15A1C;
        Wed,  2 Nov 2022 04:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF0B618FE;
        Wed,  2 Nov 2022 11:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B853AC4347C;
        Wed,  2 Nov 2022 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667388108;
        bh=y6jA1qc/WukXbdnJwL8P127OXjOsKWmTp8cHhQGAsss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUJ1ZKx0yghv6TKuKMouii1GOMY5H1esec69h2OTdYkHDrwTsv45wrMCdHtBMpbC4
         L/gF3GtO2pLeF9bOWhUF8w4jfjJiymYEll94AxxfIx9ZZj39CmgUpyOtG/cOGpzq5X
         STcVXik+2IgXMdHGXMfHjOdIiuruA+eUT8qBdcVT8ovkDkZGgr/DAS72RehXCnASq/
         AOC78AnIVxPT8wpQF6vFHD5gpQUJB4d5Bkl37J1dzwcmiPNKCwMyvX/R91zPYuIziE
         1hd4N4o8lttwLBU0f27YvCQxebpcTX4DGYtVNFLWJhsaggf53XLy5gAXnwfYuVwdzx
         2q/AJoScGmi/g==
Received: by mail-lf1-f50.google.com with SMTP id g7so27711454lfv.5;
        Wed, 02 Nov 2022 04:21:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf3cEWrHBmi6GUklz6sHoyBKUOZSVXgjyBnmwT94cdA/ysjAkcGB
        v2G3oC77uO0ebgYS/joj53+rEJtCRr+u66+RsQ==
X-Google-Smtp-Source: AMsMyM7n4p9mPcI4wH0CR8GOhTrHwa9Qm734EamjzWOPQhZCF4pM+Opa28ho7vRj6nl3H4gpCETQNqI02fcLXr7e3Lw=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr8821466lfv.17.1667388106632; Wed, 02
 Nov 2022 04:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221102035249.19776-1-zhuyinbo@loongson.cn> <20221102035249.19776-2-zhuyinbo@loongson.cn>
 <166738767754.3460253.533656720238446457.robh@kernel.org>
In-Reply-To: <166738767754.3460253.533656720238446457.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Nov 2022 06:21:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+H6dgdQJJ0t=3N7q-VYbmO5cJq1VfLOu2mrm+fbg37jw@mail.gmail.com>
Message-ID: <CAL_Jsq+H6dgdQJJ0t=3N7q-VYbmO5cJq1VfLOu2mrm+fbg37jw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: hpet: add loongson-2 hpet
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Yun Liu <liuyun@loongson.cn>, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 6:16 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 02 Nov 2022 11:52:49 +0800, Yinbo Zhu wrote:
> > Add the Loongson-2 High Precision Event Timer (HPET) binding
> > with DT schema format using json-schema.
> >
> > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.example.dts:21:18: fatal error: dt-bindings/clock/loongson,ls2k-clk.h: No such file or directory
>    21 |         #include <dt-bindings/clock/loongson,ls2k-clk.h>

I assume this header is available somewhere else, but I have no idea.
Please describe dependencies below the '---' or no one can apply this.

Rob
