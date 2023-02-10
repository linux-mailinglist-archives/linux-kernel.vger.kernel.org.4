Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B176920BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjBJOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBJOWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:22:14 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB7871F19;
        Fri, 10 Feb 2023 06:22:13 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15ff0a1f735so6850500fac.5;
        Fri, 10 Feb 2023 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9wsuK8CQ6IGV3HrmTR4Gn64C1g7jRgRc/QSt8vA9lw=;
        b=AjOVK5Jz9DGxSdc5VwaRjRTuycXqF2RrtKKVsvqiuQv8uWoFkh6szJt8g+AZcIum/r
         f7pl6BDaAzxAUf9xVJ2tj/QU7pQ4gSvCkc5fO+NWU6I56KIKOhUTBjlLEi4tDjJ6wQVW
         ClY6vggz3hzEosrn1/NWLBhYBRwOgtck4AzeQHLZn00tI98mdZm8F3JirfEINd/aFnIk
         NHFCqRRov6hi9wL6j4aQCUJru/ds8tVwQRxlnIYoJtAqRNDWOi+yqD+k/Bit6DzWgv9r
         EhNXH4dT0eRvTD06Bpswy86pS2iqEgbOOyq4v6SWMQN5f+M+VGeNt0zTJ+njbOdGVqhC
         /hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9wsuK8CQ6IGV3HrmTR4Gn64C1g7jRgRc/QSt8vA9lw=;
        b=hJHKRuuqvwMgbVFLYLKj8waWvH6ah/uKB1nSvmuN0PCO34Gz1AuwD6hF3+3Qhme0d8
         EfSDj/16UidauNagqWQqgaNt6XS5Bix0CAk8didz7DvTLbyYm1oLCQx/OBjy649cYccH
         TDsq48ImHM0fiQcjXhxxnwm9yw54uTB6lvchb+VIzqFSJDIhFaC3T62sL+dxIpsDceKT
         G4w0lyae3WyLoJ5eXDBX0M82UyMkTTPjhM+9Kgyt7YbFUEjfTdec2m+xZTipDnD/nNjZ
         KU5ybCV4lJGB2bXeKO9Mxr27N14lhx7bskzYstzTAWWlWNr5N/m2ta6siC1sFuYqFMqO
         LZfQ==
X-Gm-Message-State: AO0yUKVf5iFHR6sO9yLez+r91qbtEojdnfItff0B3a24LT8dJ5G7+2q/
        42zsUkZ3ge78bB5gTlwijqNiUaXMvbH1jNhVFQU=
X-Google-Smtp-Source: AK7set98P0XJa2N42JC2ASCw4jdrz2VO/mY9RYYNKuTQBW63Jqz4IDhzgZuZDEqZfbM+YDZgfIz1kUGDpsuW/xKVV00=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr1904010oaq.83.1676038932467; Fri, 10
 Feb 2023 06:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
 <20230210121735.639089-2-sergio.paracuellos@gmail.com> <b59d426d-8a5e-9eff-57f2-e36ebfdc5466@linaro.org>
 <CAMhs-H_6-2P7aaqSvFDypdfbf_YzhPW0r-GCP_xfO5TgyU6Bnw@mail.gmail.com> <992912ca-63b2-9882-eb7a-f7a40d432853@linaro.org>
In-Reply-To: <992912ca-63b2-9882-eb7a-f7a40d432853@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 15:22:01 +0100
Message-ID: <CAMhs-H_MhgksPO0B+wPs=sueWrSygWT=dGnPUi-biWR_HBQEeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 2:35 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 14:14, Sergio Paracuellos wrote:
> > On Fri, Feb 10, 2023 at 2:03 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 10/02/2023 13:17, Sergio Paracuellos wrote:
> >>> MT7621 SoC provides a system controller node for accessing to some registers.
> >>> Add a phandle in this node to avoid using MIPS related arch operations and
> >>> includes in watchdog driver code.
> >>>
> >>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>> ---
> >>>  .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> >>> index b2b17fdf4..cc701e920 100644
> >>> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> >>> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> >>> @@ -19,6 +19,12 @@ properties:
> >>>    reg:
> >>>      maxItems: 1
> >>>
> >>> +  ralink,sysctl:
> >>
> >> Thanks for the changes. I did not notice it before - isn't Ralink part
> >> of Mediatek now? Also compatible is mediatek, not "ralink"?
> >
> > Yes, it is. I was using the same prefix as for the memory controller
> > syscon phandler inside the 'sysc' node [0].
> >
> > I have no problems at all in changing this to 'mediatek' if preferred.
> >
>
> Yes, mediatek as already used in this binding is preferred.

Sure, I will do it and send v3. Let's wait for some other review
comments in the rest of the patches and will send all them together.

>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
