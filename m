Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D673983C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFVHhF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:37:03 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05661995;
        Thu, 22 Jun 2023 00:37:02 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-570808d8ddeso66789027b3.0;
        Thu, 22 Jun 2023 00:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687419422; x=1690011422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuUJjlZbFPNY43FuR0Z534E1rySnymoUTOyJbJ3pOqo=;
        b=bvzAgxzBMi38S3JemuW3tezf43JxtAVvX9b9MYRspvilWRA0pTFo05h0DAEQWbcgOl
         kLUUrUiGPIdxOuHDVaV0E04jdevrr0mBmFCC9zmkUCDLFpx4kHZ64ma5E0eqPhKUtPNz
         Jb2Zl2dKi4Dv5kGz59M5aPgPDwcnkpw/kqA+jE4S8elfrXO13+UhGl2aMl/6sKRI/dz9
         7tYOY79E8IXrOdGuoHxEFKc1zRbql2nPM+VPWvh+2wzOM1/rvkMAOMpVepUpRskB7map
         2dioeqjVO3Y0tfakSXB0kYN+n+ey5+PxxbNRtBNvOBsHKL4VD/BbEPqDT4IOWU73tqs6
         mEsw==
X-Gm-Message-State: AC+VfDzikCxMUK4KfpNcX0asERjrTTdLm8ITtWZWk9JjfpanDw6A9LCs
        ZrwYmXfe6YnBq2V35+z6h1EM+rbIHRx04Lzu
X-Google-Smtp-Source: ACHHUZ7YZZrIRH6dE6lcfExxNAsDfZ6MbBceCLL68mhDO0/4nFmpvH/E7/GPoJ+cUK3k7E/jl2Q3fg==
X-Received: by 2002:a0d:d9c7:0:b0:565:a3e6:1b7b with SMTP id b190-20020a0dd9c7000000b00565a3e61b7bmr16290725ywe.18.1687419421678;
        Thu, 22 Jun 2023 00:37:01 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id n66-20020a0dfd45000000b0056d5344b071sm1670573ywf.84.2023.06.22.00.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 00:37:01 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-570114e1feaso76409197b3.3;
        Thu, 22 Jun 2023 00:37:00 -0700 (PDT)
X-Received: by 2002:a81:5215:0:b0:56c:e2c1:6695 with SMTP id
 g21-20020a815215000000b0056ce2c16695mr16348313ywb.50.1687419420742; Thu, 22
 Jun 2023 00:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230621133215.109254-1-tanure@linux.com> <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org> <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
 <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org> <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
 <20230622-hardhat-elitism-26f0d0df204f@wendy>
In-Reply-To: <20230622-hardhat-elitism-26f0d0df204f@wendy>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 22 Jun 2023 08:36:49 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3+bdXd-NrsQymXerpWZuj3zb8CKHcZRNM_iLSZcp2Mfg@mail.gmail.com>
Message-ID: <CAJX_Q+3+bdXd-NrsQymXerpWZuj3zb8CKHcZRNM_iLSZcp2Mfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 8:12 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Thu, Jun 22, 2023 at 07:43:31AM +0100, Lucas Tanure wrote:
> > On Thu, Jun 22, 2023 at 7:05 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 22/06/2023 07:32, Lucas Tanure wrote:
> > > > On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
> > > >> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> > > >>> On 21/06/2023 15:32, Lucas Tanure wrote:
> > > >>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > > >>>> There is no need for an extra compatible line in the driver, but
> > > >>>> add T7 compatible line for documentation.
> > > >>>>
> > > >>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > >>>> ---
> > > >>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> > > >>>>  1 file changed, 2 insertions(+)
> > > >>>>
> > > >>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > >>>> index 01ec45b3b406..860ab58d87b0 100644
> > > >>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > >>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > >>>> @@ -33,6 +33,7 @@ properties:
> > > >>>>                - amlogic,meson8b-uart
> > > >>>>                - amlogic,meson-gx-uart
> > > >>>>                - amlogic,meson-s4-uart
> > > >>>> +              - amlogic,meson-t7-uart
> > > >>>>            - const: amlogic,meson-ao-uart
> > > >>>>        - description: Always-on power domain UART controller on G12A SoCs
> > > >>>>          items:
> > > >>>> @@ -46,6 +47,7 @@ properties:
> > > >>>>            - amlogic,meson8b-uart
> > > >>>>            - amlogic,meson-gx-uart
> > > >>>>            - amlogic,meson-s4-uart
> > > >>>> +          - amlogic,meson-t7-uart
> > > >>>
> > > >>> It does not look like you tested the DTS against bindings. Please run
> > > >>> `make dtbs_check` (see
> > > >>> Documentation/devicetree/bindings/writing-schema.rst or
> > > >>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> > > >>> for instructions).
> > > >>
> > > >> Check back on the previous version, I should've posted an untested
> > > >> version of what you need to add.
> > > > I saw that, but adding a S4 doesn't make sense to me. And you didn't
> > > > show the entire change, so I can't understand what you want there.
> > >
> > > For sure you need something which does not trigger errors. If you claim
> > > adding S4 as fallback does not make sense, then why did you use it?
> > > Sending a code which is clearly incorrect does not make sense.
> > >
> > Sorry, I think we are talking about different things. It does not make
> > sense to me to add an S4 line in the documentation when it is already
> > there. So I could not understand or make sense of the patch Conor sent
> > in reply to my V2.
>
> That is just how it works. You need to spell out exactly which
> combinations are permitted. The current entry for s4 says that s4 is
> only permitted in isolation.
> Since you are adding "amlogic,meson-t7-uart", "amlogic,meson-s4-uart"
> you need to explicitly allow that combination. You'll notice if you look
> at the file that the gx uart appears more than once.
>
> Given the g12a was the most recently added compatible, it might make
> sense to follow the pattern that it had set, given the thing your
> original patch copied the match data from was the g12a. That change to
> the dt-binding would look like:
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 01ec45b3b406..eae11e87b88a 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -50,6 +50,13 @@ properties:
>          items:
>            - const: amlogic,meson-g12a-uart
>            - const: amlogic,meson-gx-uart
> +      - description:
> +          Everything-Else power domain UART controller on G12A compatible SoCs
> +        items:
> +          - enum:
> +              - amlogic,meson-t7-uart
> +          - const: amlogic,meson-g12a-uart
> +          - const: amlogic,meson-gx-uart
>
>    reg:
>      maxItems: 1
>
> /I/ don't really care whether you do that, or do the s4 version of it,
> but following the most recent pattern might make more sense. When I
> suggested s4, it was because I only looked at the driver patch rather
> than the code itself.
>
> > Krzysztof, I will check again with dtbs_check and re-send.
>
> Cheers,
> Conor.
I am struggling to understand this. Everything I try fails the check.
