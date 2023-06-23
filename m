Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A473BE1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFWRxs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjFWRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:53:46 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45E2136;
        Fri, 23 Jun 2023 10:53:45 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5728df0a7d9so8371437b3.1;
        Fri, 23 Jun 2023 10:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542825; x=1690134825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvsLdT639PCbMIODrmN1JmfHHDk3gCbxCBi4kyaJ9fk=;
        b=cPC8oMX/iNTjnqqtlRw8ZkssLewcdWmf4d19+JCNwWXuKm3HoYGFkJat0YB0KS4oMF
         FAf60dASGavmxdumXNW/cAmWQIEIHsmPiuz6BWDlZ0zPVSSoFa1Hlx1OacfT47zh0THN
         bpJj8kinB/krZ5aTII8RWuFSwmrWhR5T7KtXUyJNI6JjbQDQn8SKXZe5cBL3eXZ1zaO8
         I14iDxohnKDOQPbWzIilrJCw5qHk7PIoEbUBloJjYNWxx3lu4tmFtbE+l0shbbz4szbS
         sKGwWWiIkWgU0Ri+ZWOS9kuoMMx4A6Ov4+FCaT5Jl/f5iadj0+7oj8uv9RrhTCBGpBRJ
         ZcsQ==
X-Gm-Message-State: AC+VfDwnecGhMYvq+8QVD7rQwzBNGwcfq4Gryrz0b3Y40Nu4KFSqQAgv
        x72hkBLDWjdo9PxyqYgGsTVJROPPTJlYgdPm
X-Google-Smtp-Source: ACHHUZ7HZpOiRR30jhKaLUjJRu/yiBEdFbrmQ9OVVmIviloPYphYHFGW1nqdqos7Tpgl+tmRUwgvYw==
X-Received: by 2002:a0d:dd88:0:b0:561:9d66:e1a with SMTP id g130-20020a0ddd88000000b005619d660e1amr25139437ywe.34.1687542824639;
        Fri, 23 Jun 2023 10:53:44 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id t62-20020a815f41000000b0057682d3f95fsm196889ywb.136.2023.06.23.10.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:53:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so752794276.0;
        Fri, 23 Jun 2023 10:53:43 -0700 (PDT)
X-Received: by 2002:a81:60d6:0:b0:570:7fcb:9506 with SMTP id
 u205-20020a8160d6000000b005707fcb9506mr21842972ywb.37.1687542823789; Fri, 23
 Jun 2023 10:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230623081242.109131-1-tanure@linux.com> <20230623081242.109131-3-tanure@linux.com>
 <a885b97e-aaf0-cb72-f25b-71054d6d3fe2@linaro.org>
In-Reply-To: <a885b97e-aaf0-cb72-f25b-71054d6d3fe2@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Fri, 23 Jun 2023 18:53:32 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2qZg+RuwxmnM3rzs_akt_UMJRx+=aMxf72P-sGNjm9uw@mail.gmail.com>
Message-ID: <CAJX_Q+2qZg+RuwxmnM3rzs_akt_UMJRx+=aMxf72P-sGNjm9uw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 9:51 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/06/2023 10:12, Lucas Tanure wrote:
> > Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > There is no need for an extra compatible line in the driver, but
> > add T7 compatible line for documentation.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > index 01ec45b3b406..ad970c9ed1c7 100644
> > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > @@ -50,6 +50,10 @@ properties:
> >          items:
> >            - const: amlogic,meson-g12a-uart
> >            - const: amlogic,meson-gx-uart
> > +      - description: UART controller on T7 compatible SoCs
>
> Your description is rather incorrect. This is UART on SoCs compatible
> with S4, not with T7. Otherwise what do you expect to grow later when
> adding more compatible devices? Just drop the description, it's kind of
> obvious when done correctly (but can be misleading if done wrong).
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
Sorry, but S4 is already added in another way, which accepts just an
S4 compatible string.
But for T7 we need a fallback.
Could you let me know what you're asking here? Redo S4 and add T7? Or
do T7 in another different way that I didn't get?
Do you want a v6 patch series? If yes, could you be more clear about
how you want it?

>
> Best regards,
> Krzysztof
>
