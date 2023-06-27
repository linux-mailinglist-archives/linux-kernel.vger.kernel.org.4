Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B873F7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjF0Iv1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjF0IvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:51:24 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CEF120;
        Tue, 27 Jun 2023 01:51:23 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-56fff21c2ebso44861717b3.3;
        Tue, 27 Jun 2023 01:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687855882; x=1690447882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xP6wkKdVTdDwoYQc7PHGzeZpIcm2xdCM8uEJq+8Vkio=;
        b=l12gasXUj2XRwFouiEjuWIhTAQGAalLkLVUPPka9MQMiSsOz7eU5wq8EiYlWAUVb/S
         Vyw8G5qwbFwhoOYLqKDcra7iULTKHTSYUZoRL1PekVHNkn18s75HOgP9agNom9wi6eCR
         7L1LqH4F3yCcHJ1+yzl2IkxCu+nrICjJT2C9ZyvdBK6civTUfQrWdVKAv0kBFNQ2WZ9H
         LFkzMuUkAmJaLYwn79jb/mYVWPrHkOGwSq2ce1Vd9MOJY8P74uWjwpfqJ9NLNoN8WEmQ
         prUv0uMV1k1oJqC+I9yt72td1HoojLw4z7iCdsPsELbHDGl+NEMut4poXQ9/TXrs1M5w
         saMA==
X-Gm-Message-State: AC+VfDwxKAdrhgQjSUQpebPk/xuY1RLlcJcSHIJ8Vh3/fNgThkVpT80T
        T0MbdjHr9zjb2omsfgU1EvZiY+U+BiyLSAib
X-Google-Smtp-Source: ACHHUZ7emZ+6IvN3nOcxlWYDgCXYbPcOWCJxn7/jdwuF8Lihuh29GbhFBby2WisvwMH6RzzfSombXw==
X-Received: by 2002:a0d:ca56:0:b0:573:974a:d264 with SMTP id m83-20020a0dca56000000b00573974ad264mr19941490ywd.49.1687855882071;
        Tue, 27 Jun 2023 01:51:22 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id b126-20020a816784000000b005731f3c8989sm1705873ywc.62.2023.06.27.01.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 01:51:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c14476f8401so3181264276.3;
        Tue, 27 Jun 2023 01:51:21 -0700 (PDT)
X-Received: by 2002:a25:29c6:0:b0:c1b:2fab:b802 with SMTP id
 p189-20020a2529c6000000b00c1b2fabb802mr6022656ybp.17.1687855881181; Tue, 27
 Jun 2023 01:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230623081242.109131-1-tanure@linux.com> <20230623081242.109131-3-tanure@linux.com>
 <a885b97e-aaf0-cb72-f25b-71054d6d3fe2@linaro.org> <CAJX_Q+2qZg+RuwxmnM3rzs_akt_UMJRx+=aMxf72P-sGNjm9uw@mail.gmail.com>
 <4fba1603-5741-ec1b-122f-d6a92803f49a@linaro.org>
In-Reply-To: <4fba1603-5741-ec1b-122f-d6a92803f49a@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Tue, 27 Jun 2023 09:51:09 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3GX5NEtx7DA-vapU45dVooTpXxrwUZsNVAKd9JN2kKXA@mail.gmail.com>
Message-ID: <CAJX_Q+3GX5NEtx7DA-vapU45dVooTpXxrwUZsNVAKd9JN2kKXA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

On Fri, Jun 23, 2023 at 6:56 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/06/2023 19:53, Lucas Tanure wrote:
> > On Fri, Jun 23, 2023 at 9:51 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 23/06/2023 10:12, Lucas Tanure wrote:
> >>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> >>> There is no need for an extra compatible line in the driver, but
> >>> add T7 compatible line for documentation.
> >>>
> >>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >>> ---
> >>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>> index 01ec45b3b406..ad970c9ed1c7 100644
> >>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> >>> @@ -50,6 +50,10 @@ properties:
> >>>          items:
> >>>            - const: amlogic,meson-g12a-uart
> >>>            - const: amlogic,meson-gx-uart
> >>> +      - description: UART controller on T7 compatible SoCs
> >>
> >> Your description is rather incorrect. This is UART on SoCs compatible
> >> with S4, not with T7. Otherwise what do you expect to grow later when
> >> adding more compatible devices? Just drop the description, it's kind of
> >> obvious when done correctly (but can be misleading if done wrong).
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> > Sorry, but S4 is already added in another way, which accepts just an
> > S4 compatible string.
> > But for T7 we need a fallback.
> > Could you let me know what you're asking here? Redo S4 and add T7? Or
> > do T7 in another different way that I didn't get?
>
> I comment only about the description, so why touching anything else? You
> did not add here T7 compatible SoCs. You added here S4 compatible SoCs.
>
> > Do you want a v6 patch series? If yes, could you be more clear about
> > how you want it?
>
> No need. If you are going to send v6, you can as well drop the description.
>
I can't just remove that line, as it doesn't pass the checks.
I will change it to S4.

>
> ---
>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you do not know the process, here is a short
> explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for acks received on the version
> they apply.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>
> Best regards,
> Krzysztof
>
