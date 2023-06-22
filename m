Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD18739979
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFVI0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjFVI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:26:19 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19D1FF7;
        Thu, 22 Jun 2023 01:26:15 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bf3934ee767so589825276.0;
        Thu, 22 Jun 2023 01:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422374; x=1690014374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JD5wRAEZM58Yir8EBgxb+4GGarUcKUmd8dxXVjzMK/E=;
        b=W9yGimMgXRAYWS1GtE6U6rzfzJDBE/aL5zHA4IzKllhrDS74VIxfnrtgEcRFLwv2Hh
         z6hPojLzH0csmR6BeJzGLuiQP4O0iMQLsQG4kywHX5cqzQ1sdbLJ4cnO4C+UHHrP444J
         mApB+7sGliruu3+ZoW4jrCekqSs9iF7cl7JEH3yrU9UluE+dtvYPHrcS/G5gIMXBSnJx
         JY1JwoOuiFZXbVdAn/Hm9dDnqtXeLcjYYBU1M2654LGrqGCtwHGX26lc+07Kzi+hXRTx
         hT4Gk+9IQSaj985/Dz+B3kNcGQYQJhgVw5/fsYclGqUQ2bZ0vG4GmBC4+S9iR4qf9DbV
         /hBw==
X-Gm-Message-State: AC+VfDy4b/JUnpdboEf4Suelv5rb5DrzCS5VgOKwDLOkpg/Qdy4f/k6V
        OvOrRaWfb79zvNI0AByDLMGW47GTD3UcZB4q
X-Google-Smtp-Source: ACHHUZ5kECN6Y/OwnZ49SIbe8f1k8x9HWspeDR16B5aFI9EAyJ+jC8w4LkWDUkm8GY8AmuqV+uYIqQ==
X-Received: by 2002:a25:50cd:0:b0:c00:8fa5:7633 with SMTP id e196-20020a2550cd000000b00c008fa57633mr3477913ybb.28.1687422374267;
        Thu, 22 Jun 2023 01:26:14 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id a36-20020a25ae24000000b00bcd5e12fb20sm1449996ybj.8.2023.06.22.01.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:26:13 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-57040e313c5so5980167b3.0;
        Thu, 22 Jun 2023 01:26:13 -0700 (PDT)
X-Received: by 2002:a0d:dd05:0:b0:56d:1a06:8ba0 with SMTP id
 g5-20020a0ddd05000000b0056d1a068ba0mr27215280ywe.9.1687422373700; Thu, 22 Jun
 2023 01:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230621133215.109254-1-tanure@linux.com> <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org> <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
 <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org> <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
 <20230622-hardhat-elitism-26f0d0df204f@wendy> <CAJX_Q+3+bdXd-NrsQymXerpWZuj3zb8CKHcZRNM_iLSZcp2Mfg@mail.gmail.com>
 <2fe41e89-9a26-e7ba-6ef6-2c9262bda43d@linaro.org>
In-Reply-To: <2fe41e89-9a26-e7ba-6ef6-2c9262bda43d@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 22 Jun 2023 09:26:02 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2Fc5sdp-0kHp99UEo_oiqTeO-LA95+Ak+aW0HMqDgtPw@mail.gmail.com>
Message-ID: <CAJX_Q+2Fc5sdp-0kHp99UEo_oiqTeO-LA95+Ak+aW0HMqDgtPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     neil.armstrong@linaro.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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

On Thu, Jun 22, 2023 at 9:13 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 22/06/2023 09:36, Lucas Tanure wrote:
> > On Thu, Jun 22, 2023 at 8:12 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >>
> >> On Thu, Jun 22, 2023 at 07:43:31AM +0100, Lucas Tanure wrote:
> >>> On Thu, Jun 22, 2023 at 7:05 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>> On 22/06/2023 07:32, Lucas Tanure wrote:
> >>>>> On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
> >>>>>> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> >>>>>>> On 21/06/2023 15:32, Lucas Tanure wrote:
> >>>>>>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> >>>>>>>> There is no need for an extra compatible line in the driver, but
> >>>>>>>> add T7 compatible line for documentation.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >>>>>>>> ---
> >>>>>>>>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> >>>>>>>>   1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>>>>>> index 01ec45b3b406..860ab58d87b0 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>>>>>> @@ -33,6 +33,7 @@ properties:
> >>>>>>>>                 - amlogic,meson8b-uart
> >>>>>>>>                 - amlogic,meson-gx-uart
> >>>>>>>>                 - amlogic,meson-s4-uart
> >>>>>>>> +              - amlogic,meson-t7-uart
> >>>>>>>>             - const: amlogic,meson-ao-uart
> >>>>>>>>         - description: Always-on power domain UART controller on G12A SoCs
> >>>>>>>>           items:
> >>>>>>>> @@ -46,6 +47,7 @@ properties:
> >>>>>>>>             - amlogic,meson8b-uart
> >>>>>>>>             - amlogic,meson-gx-uart
> >>>>>>>>             - amlogic,meson-s4-uart
> >>>>>>>> +          - amlogic,meson-t7-uart
> >>>>>>>
> >>>>>>> It does not look like you tested the DTS against bindings. Please run
> >>>>>>> `make dtbs_check` (see
> >>>>>>> Documentation/devicetree/bindings/writing-schema.rst or
> >>>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> >>>>>>> for instructions).
> >>>>>>
> >>>>>> Check back on the previous version, I should've posted an untested
> >>>>>> version of what you need to add.
> >>>>> I saw that, but adding a S4 doesn't make sense to me. And you didn't
> >>>>> show the entire change, so I can't understand what you want there.
> >>>>
> >>>> For sure you need something which does not trigger errors. If you claim
> >>>> adding S4 as fallback does not make sense, then why did you use it?
> >>>> Sending a code which is clearly incorrect does not make sense.
> >>>>
> >>> Sorry, I think we are talking about different things. It does not make
> >>> sense to me to add an S4 line in the documentation when it is already
> >>> there. So I could not understand or make sense of the patch Conor sent
> >>> in reply to my V2.
> >>
> >> That is just how it works. You need to spell out exactly which
> >> combinations are permitted. The current entry for s4 says that s4 is
> >> only permitted in isolation.
> >> Since you are adding "amlogic,meson-t7-uart", "amlogic,meson-s4-uart"
> >> you need to explicitly allow that combination. You'll notice if you look
> >> at the file that the gx uart appears more than once.
> >>
> >> Given the g12a was the most recently added compatible, it might make
> >> sense to follow the pattern that it had set, given the thing your
> >> original patch copied the match data from was the g12a. That change to
> >> the dt-binding would look like:
> >> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> index 01ec45b3b406..eae11e87b88a 100644
> >> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >> @@ -50,6 +50,13 @@ properties:
> >>           items:
> >>             - const: amlogic,meson-g12a-uart
> >>             - const: amlogic,meson-gx-uart
> >> +      - description:
> >> +          Everything-Else power domain UART controller on G12A compatible SoCs
> >> +        items:
> >> +          - enum:
> >> +              - amlogic,meson-t7-uart
> >> +          - const: amlogic,meson-g12a-uart
> >> +          - const: amlogic,meson-gx-uart
> >>
> >>     reg:
> >>       maxItems: 1
> >>
> >> /I/ don't really care whether you do that, or do the s4 version of it,
> >> but following the most recent pattern might make more sense. When I
> >> suggested s4, it was because I only looked at the driver patch rather
> >> than the code itself.
> >>
> >>> Krzysztof, I will check again with dtbs_check and re-send.
> >>
> >> Cheers,
> >> Conor.
> > I am struggling to understand this. Everything I try fails the check.
>
> I just applied Conor's change on top of v6.4-rc1 and ran:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>
> and the check was successful.
>
> Neil
>
>
I am sending v4 in a few minutes
