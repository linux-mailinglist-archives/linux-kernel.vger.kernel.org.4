Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEE7396DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFVFcp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFVFcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:32:43 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA441AC;
        Wed, 21 Jun 2023 22:32:42 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-762092e1fb7so602573785a.1;
        Wed, 21 Jun 2023 22:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687411961; x=1690003961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrcyGT7ymU1XVYwyjlMrGW0IAiKkeL72CA1S1fw36WM=;
        b=WzQnR6cAUZCk6PWcVtVh+J5x0A5B6hb68mKUdB/9cX4qzbITOpsEj+dST5F7SJpPTD
         GRRvybo4NI0ltUKIKS0NgQNUABa21M1O9vCNja3qJB0AeQURyfemiTfq8PywHWhXKSKy
         ARrms5n0BUOsmOZqKY0dUBIv8SqQlA7W1uXyRxkeV6IU5tfJtLkze4LBgJbmulZG0pDd
         NZF8Q++6E5nucdrJl0XQmGNREG5AKu1HnKPpOXVkuQmn0tjjH27r+udrrlhoyiIf09DY
         KGfFNX7n0vERQyp8o7/NU3eI0wUr1lJRyB5Nq2guwLNK/VCJFp0busIbycv6vqoaVEpM
         vAAg==
X-Gm-Message-State: AC+VfDxwAOPSTe6TQyPpUfC3c92XsL0pTXWx6nGQwMSgUEfvyKxQGiZX
        pqEVNQoYuVmaxDR0utxDEFGTC7owCDpEjVkD
X-Google-Smtp-Source: ACHHUZ5DhXFv5EJe7LUjFt4D5WRByV+CEhvlG01IfpurJTeqpTxd4a2+FcgSOcyb++elFaUshPEVFw==
X-Received: by 2002:a05:620a:6501:b0:75d:53f0:4eab with SMTP id qb1-20020a05620a650100b0075d53f04eabmr19215626qkn.42.1687411961116;
        Wed, 21 Jun 2023 22:32:41 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a005100b00763b49dd16asm2428723qkt.53.2023.06.21.22.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 22:32:40 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-763dc87aac4so108143485a.2;
        Wed, 21 Jun 2023 22:32:40 -0700 (PDT)
X-Received: by 2002:a05:6214:d63:b0:632:1c72:c379 with SMTP id
 3-20020a0562140d6300b006321c72c379mr3440084qvs.51.1687411960027; Wed, 21 Jun
 2023 22:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230621133215.109254-1-tanure@linux.com> <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org> <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
In-Reply-To: <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 22 Jun 2023 06:32:28 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
Message-ID: <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
>
> Lucas,
>
> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> > On 21/06/2023 15:32, Lucas Tanure wrote:
> > > Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > > There is no need for an extra compatible line in the driver, but
> > > add T7 compatible line for documentation.
> > >
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > index 01ec45b3b406..860ab58d87b0 100644
> > > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > @@ -33,6 +33,7 @@ properties:
> > >                - amlogic,meson8b-uart
> > >                - amlogic,meson-gx-uart
> > >                - amlogic,meson-s4-uart
> > > +              - amlogic,meson-t7-uart
> > >            - const: amlogic,meson-ao-uart
> > >        - description: Always-on power domain UART controller on G12A SoCs
> > >          items:
> > > @@ -46,6 +47,7 @@ properties:
> > >            - amlogic,meson8b-uart
> > >            - amlogic,meson-gx-uart
> > >            - amlogic,meson-s4-uart
> > > +          - amlogic,meson-t7-uart
> >
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> > for instructions).
>
> Check back on the previous version, I should've posted an untested
> version of what you need to add.
I saw that, but adding a S4 doesn't make sense to me. And you didn't
show the entire change, so I can't understand what you want there.
>
> Cheers,
> Conor.
