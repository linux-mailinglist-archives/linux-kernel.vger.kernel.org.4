Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDA734342
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjFQTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFQTL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:11:59 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC681BD;
        Sat, 17 Jun 2023 12:11:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55b00ad09feso1322198eaf.1;
        Sat, 17 Jun 2023 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687029118; x=1689621118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlH50w/lGf6mW2MwO3XhrZFEyFgixoel0ZP0BL1Z9fw=;
        b=YEE0X9dryej3Q4hwa5Tfj5uYkVxud9GLbnf53NIs79bl1oQ/R+NsIeIUI68kml/D9Z
         OFqnMx30H0v0zo3l5e5IsEEfo53NDPhsyDp1H2y9ypFe5jjtdT1t9J0gNBglz8Vqils2
         C8tOfzf4ReN+9Q4dN7T8KUTIg/Z20dYGqmy4v74V8MWQ8fyhMUEVZLiWhVa002xXdnlA
         bSbkXLpl9a3dyyFAf9ytYz+Vh8q6shGIAK3bZaIbjnXT85I/TsO/uPX+1uDVACtgNx0u
         hH9lTsLWk4tqc1CX0urOWX4/4G0fEtx+V14Zhs6/98W2CwgEvxTlOmEblxJAF2iE6aZL
         YA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687029118; x=1689621118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlH50w/lGf6mW2MwO3XhrZFEyFgixoel0ZP0BL1Z9fw=;
        b=cR8RG51JepU3P+TmdwM5I8VFr/KjIAEm5xGhucjRYHLqvhllHA/uOjKpYT18C1MW+x
         WAWGirrW+3GlZqfEpPIQ/Oovb18pmIe5FpSTbL/Ecj6SThq6VtfMQdWFZIgr+bnubpq0
         23g8ZCXCsgdit0FgAGwuS3I2ZM0GN6vOq+KgSaAWIZLRRjUnL0Rgc0dEc1FuDtf5Spii
         CSf++pGL1nXR4qCw0Q7s4KpcfGaQ4o46my9IoIhvG/z+dA/4s0S0zkymFh4uWPgcMRPo
         BmlNDFVLSH2FILIHUEKscgFACCuAkGvCRL3tkNhkT9nNnEIooGV7pnmMfbgz/fVJ/MXm
         7wgQ==
X-Gm-Message-State: AC+VfDyByMIDc2j+sz2qH82f8j9mgKGJtfJsBnv9GBEkBdsl5vXjBsfg
        kTfRi88Fts/seAjXrrtg05i3CEig8YiB8IS/gGc=
X-Google-Smtp-Source: ACHHUZ6wln3/fsd/ED/5tSNG4OxHKfqiLIODoeeyfXH0tuWXADIBWT4HJaE4MC/hKbkDwV19nwOoM/uHRQV8iaTywko=
X-Received: by 2002:a4a:cb99:0:b0:55e:3aeb:2cda with SMTP id
 y25-20020a4acb99000000b0055e3aeb2cdamr749758ooq.3.1687029117705; Sat, 17 Jun
 2023 12:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org> <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
 <05e3ff33-ad4e-d2fb-dfd5-7b5265881b74@linaro.org> <CAMhs-H-ncXC37SAMkLfrFmpRi0ORkkCV9rQmrtmw_ndOLo+J0Q@mail.gmail.com>
 <10f01535-ab4f-b0d4-306b-a90f4ad19008@linaro.org>
In-Reply-To: <10f01535-ab4f-b0d4-306b-a90f4ad19008@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 21:11:46 +0200
Message-ID: <CAMhs-H-uc_VzZ4MS0VLn9AajFRM-BYKEn4zGJ36H3EmL0oX-WA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>, arinc.unal@arinc9.com,
        devicetree@vger.kernel.org, john@phrozen.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 7:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 17:37, Sergio Paracuellos wrote:
> >>> The case of
> >>> searching for compatible is a mess since as you can see in the
> >>> bindings there are tons of compatibles to search for, then (this code
> >>> is common to all ralink platforms).
> >>
> >> Compatible is one of the ways using ABI.
> >
> > Ok so it is also a broken approach, then.
>
> What is exactly broken approach? Fetching by compatibles? Somehow many
> other platforms do not have problem with that, even for multiple
> compatibles. Why yours is special?

I guess it is not special but I cannot figure out the way of getting
this clock using compatibles...

>
> Anyway, it is not a correct way to get clocks frequency. There is CCF
> for this, although maybe Ralink does not support it?

This means to use clk_get() if I understand properly but it does not
work at all for ralink...

>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
