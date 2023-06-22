Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B5739790
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFVGnr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:43:45 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E219AF;
        Wed, 21 Jun 2023 23:43:44 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-62ff0e0c5d7so54101346d6.1;
        Wed, 21 Jun 2023 23:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416223; x=1690008223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjc9cUsPT2z8mtJnNxRhataxf2ELf1AJBFW6JAfUMCg=;
        b=YHI5pBikhL4qXwmB68yuvb3ap3m3IeS06bbfnkGtvhItPIhq0VNT1+XQar+RRTJBy9
         Ue3wwxiub3EefN0xqJ0KwnMJGLIt6rc8JhjHSW4FJVPMMBPZvTdUT49HLlSIFapGmo9Z
         422TnQksrmtOq9utuEulg/xOFGOPxUnJ96EQ6P0VfL4N4liblqAPHOnCkqfpRzvytJFB
         SoIRZYrMs852/6LcyK9P9ayV7ndhb/2PHMcrOKEkbNPTydFyre+4/EniK2+HRwdgmkqK
         B3qU9lMjk/2IriuVVw6Fge7nol/tjiF+8QOQ97nBpRS1hp5+nJKgahQKqzB7p4Sdjo63
         iuJA==
X-Gm-Message-State: AC+VfDxGEwG7dyxI4SmBNo2goCPvaa/d1NRKYuG1bPBSZo8Mc0g1qOhg
        wuWq7Sp5bjhKyiLNkzw4AoAI/ZP68d5xgB8M
X-Google-Smtp-Source: ACHHUZ52FiDMzlySJe7XsQnC5bhFu0nH/2stLO6ZD0reY/sgm+dfAWuhDDWC2+IwmxixSFUjyVpDiw==
X-Received: by 2002:a05:6214:2029:b0:630:f5d:49c1 with SMTP id 9-20020a056214202900b006300f5d49c1mr19632506qvf.12.1687416223274;
        Wed, 21 Jun 2023 23:43:43 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id p18-20020a0ccb92000000b00621268e14efsm3466016qvk.55.2023.06.21.23.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:43:42 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-3f9cf20da51so58180791cf.2;
        Wed, 21 Jun 2023 23:43:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1002:b0:3f6:b923:b58d with SMTP id
 d2-20020a05622a100200b003f6b923b58dmr22749027qte.27.1687416222287; Wed, 21
 Jun 2023 23:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230621133215.109254-1-tanure@linux.com> <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org> <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com> <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org>
In-Reply-To: <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 22 Jun 2023 07:43:31 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
Message-ID: <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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

On Thu, Jun 22, 2023 at 7:05 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/06/2023 07:32, Lucas Tanure wrote:
> > On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
> >>
> >> Lucas,
> >>
> >> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> >>> On 21/06/2023 15:32, Lucas Tanure wrote:
> >>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> >>>> There is no need for an extra compatible line in the driver, but
> >>>> add T7 compatible line for documentation.
> >>>>
> >>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >>>> ---
> >>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>> index 01ec45b3b406..860ab58d87b0 100644
> >>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>>> @@ -33,6 +33,7 @@ properties:
> >>>>                - amlogic,meson8b-uart
> >>>>                - amlogic,meson-gx-uart
> >>>>                - amlogic,meson-s4-uart
> >>>> +              - amlogic,meson-t7-uart
> >>>>            - const: amlogic,meson-ao-uart
> >>>>        - description: Always-on power domain UART controller on G12A SoCs
> >>>>          items:
> >>>> @@ -46,6 +47,7 @@ properties:
> >>>>            - amlogic,meson8b-uart
> >>>>            - amlogic,meson-gx-uart
> >>>>            - amlogic,meson-s4-uart
> >>>> +          - amlogic,meson-t7-uart
> >>>
> >>> It does not look like you tested the DTS against bindings. Please run
> >>> `make dtbs_check` (see
> >>> Documentation/devicetree/bindings/writing-schema.rst or
> >>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> >>> for instructions).
> >>
> >> Check back on the previous version, I should've posted an untested
> >> version of what you need to add.
> > I saw that, but adding a S4 doesn't make sense to me. And you didn't
> > show the entire change, so I can't understand what you want there.
>
> For sure you need something which does not trigger errors. If you claim
> adding S4 as fallback does not make sense, then why did you use it?
> Sending a code which is clearly incorrect does not make sense.
>
Sorry, I think we are talking about different things. It does not make
sense to me to add an S4 line in the documentation when it is already
there. So I could not understand or make sense of the patch Conor sent
in reply to my V2.

Krzysztof, I will check again with dtbs_check and re-send.

>
> Best regards,
> Krzysztof
>
