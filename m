Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1A737CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFUHhV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjFUHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:37:17 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED1118;
        Wed, 21 Jun 2023 00:37:16 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so4477190276.3;
        Wed, 21 Jun 2023 00:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333035; x=1689925035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBbxlv9gnoM9pjw8kXntm7KKExMqeh457d11frY80Iw=;
        b=aL6ASVWsMK+nrRrm4KrUTisLQWI0pRVH6ApcZoStMrau7SLcSA9BvretnoMt+vDXfb
         SfGWt4S1jB+3OnG3PNtjt1SxtUynwchNFp8I1NOmK2ZrzM8NmlvTNIR0FCO5/pQ67KXx
         ORl1pmT5fGxul0hSbNP6pUm89ASQeT53bC4Ko4H+5cmfDaXgLlYZJJS2JJRrCG5Iav8W
         yMsm001dNZbxHI1DfcOg4jE/lvL/QK1czX7fpo9jdNmvWUVvcIaaLEEOfs+SiRJSEKbb
         pzbe0TIF6+XoAI1Nqmua1DlLyYdfAYGw9DMUTRO9RR9umJlTEl6wjJVhv/79YzWymgCS
         Aueg==
X-Gm-Message-State: AC+VfDwm9gzWepOYBmSAliVOwLlPPc4IjQKMhO9f+439k5USxipTtDRp
        lDqdXjZlYGVzgc2d3BxLU5Xb0sYHD7e6gpSY
X-Google-Smtp-Source: ACHHUZ5QwD25W7i4rV1q2MqyhTGrg69WSczWlnar6VFw7/caEBhxq7pGydP2i7H+C8GV+qWyTxQNiA==
X-Received: by 2002:a81:4992:0:b0:568:8e96:7008 with SMTP id w140-20020a814992000000b005688e967008mr11287029ywa.0.1687333035332;
        Wed, 21 Jun 2023 00:37:15 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id d187-20020a0df4c4000000b0055a07e36659sm954239ywf.145.2023.06.21.00.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 00:37:14 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5702415be17so48956087b3.2;
        Wed, 21 Jun 2023 00:37:14 -0700 (PDT)
X-Received: by 2002:a81:4992:0:b0:568:8e96:7008 with SMTP id
 w140-20020a814992000000b005688e967008mr11287000ywa.0.1687333034038; Wed, 21
 Jun 2023 00:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230620134857.238941-1-tanure@linux.com> <20230620134857.238941-3-tanure@linux.com>
 <ZJIjtphyKdC48JrN@ofant> <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
In-Reply-To: <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Wed, 21 Jun 2023 08:37:02 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
Message-ID: <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yixun Lan <dlan@gentoo.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 7:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/06/2023 00:09, Yixun Lan wrote:
> >> +            apb4: bus@fe000000 {
> >> +                    compatible = "simple-bus";
> >> +                    reg = <0x0 0xfe000000 0x0 0x480000>;
> >> +                    #address-cells = <2>;
> >> +                    #size-cells = <2>;
> >> +                    ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> >> +
> >> +                    uart_A: serial@78000 {
> >> +                            compatible = "amlogic,meson-t7-uart",
> >                                               ~~~~~~~~~~~~~~~~~
> > if you introduce new compatible string, then at least you need to document it
> > so Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml need to be updated
> >
> > but my qeustion here, why bother introducing new compatible string if nothing
> > changed with the compatible data? given the uart is same IP with g12a, can't we just
> > use "amlogic,meson-g12-uart" for this? no only it will reduce the structure length of
> > meson_uart_dt_match[], but also relieve maintainer's review burden?
>
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>
> Best regards,
> Krzysztof
>
Hi, I did not understand the recommendation here.
Can I add "amlogic,meson-t7-uart" without Documentation changes?
I think Yes, as I can see a few compatible strings in dts that don't
exist anywhere else.

My idea here is to add "amlogic,meson-t7-uart" for future use if ever
created, like if we find a bug in the future that is only relevant to
T7 soc.
But for now, fallback to s4 uart, as it seems to be the same controller.

From Krzysztof said in the writing-bindings.rst, I am following the rules.

So, what's the path forward here?

Thanks
Lucas
