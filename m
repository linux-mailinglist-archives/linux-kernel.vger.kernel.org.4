Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140A6AB26E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCEVRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCEVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:17:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E51420D;
        Sun,  5 Mar 2023 13:17:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ay14so27212198edb.11;
        Sun, 05 Mar 2023 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS5AcYNrckgnL2sP6eQtWDN1tf0SfVYtcQAm6inJXI4=;
        b=AUgaa8q8C2sDbArmeSk3yD3jEPgO38WCcM1Od9JCRecyVKnyiLK2OQdBIZATikadeP
         GDuiV6akZWiSkBkZxu6XVdlmJejG+VCUxQ2bTEm/LbC5AjHgBQ1tRbvnkDrJjz8ayzCf
         jJlca3jO5Kp+ZNwl8pSuGW6I7KYdlOi+1yCz7dwfSR+30EtDz2ECKKlFvixNklRWEsLe
         nOQVPBqCnIUw1UjKYPNcoOy8KRYpTKcpsnX23ClNDvXqpHPN+jz/h3M5gDik0n4gAlZ5
         jAQc/pS7jJvWemET7flfXT2H/gf5++LwJK5E4jp2LDtY/ft2KdDBOBwmFHSc/Wt2avqQ
         I6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS5AcYNrckgnL2sP6eQtWDN1tf0SfVYtcQAm6inJXI4=;
        b=p9Xyy8jctB6gDEzGZ/0KQEDIxbWhUToKEOQr504HkDxeiPmKfVQL1qVqxPSImQ+fO4
         sJ/WYJWYxwZNTJ3P7kcZQC+O8Mx6c27+mrQ6SaZvJAKLON6L6ai0Rx15KK/gpj2zS0mS
         VX9wwhLrKg/kwaOU/Ny0ww5mCy1CbcvcsCWYdd3ZOaFVc2SngQC4rU8aB/WdeWGy885E
         bixXrnDATCZ3LytIqG+czZFFmynvvcT1RotCN3YgNOt7cyrN6IChks+JSCcify+hD+cp
         93CXrKbUnLPTT3HlRcg3HWAhdT/6r5dtbXAvV/pwLXOFC3OhZ0QsL4DBBEVSjgibIsPO
         Hy5g==
X-Gm-Message-State: AO0yUKXMYjxxV/vwgZ30VGER2JoEerBiLOKVl2Tw2jXheBYxyozfWTVl
        vhN+BTfcr4N1MrUe5jyS7CKKV91G9/NW6OZd3gk=
X-Google-Smtp-Source: AK7set8Td9ISwWxiHsrPXLtAYj6N7KHZR3IphBtTmPwhjPRmMwEy8LJT7H19kndrvwl9iUciDggKq2CxGD07fOwnqfI=
X-Received: by 2002:a50:c05b:0:b0:4c0:2126:ac34 with SMTP id
 u27-20020a50c05b000000b004c02126ac34mr4595186edd.6.1678051049921; Sun, 05 Mar
 2023 13:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20230305134512.1596572-1-christianshewitt@gmail.com> <20230305134512.1596572-2-christianshewitt@gmail.com>
In-Reply-To: <20230305134512.1596572-2-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Mar 2023 22:17:18 +0100
Message-ID: <CAFBinCBAsQ-98C6x2VEXkU9kGvM6sE3e52E_Jo9NYZRLoykdpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for
 BananaPi M2S variants
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 5, 2023 at 2:45=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> BananaPi M2S ships in two variants with Amlogic S922X or A311D chips.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
