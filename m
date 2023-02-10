Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB2691E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBJLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBJLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:38:57 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3832A6C7;
        Fri, 10 Feb 2023 03:38:51 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bh15so4185039oib.4;
        Fri, 10 Feb 2023 03:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94HhLZErt6tptJHKl864lXCVSB3thrXy6dwt+pBa51c=;
        b=R5upjjTKnzH4g9QpGIHa0f5qmZDvx3e8nLzmqvj5DijyduOJU6Vck18dxSboy8ycN6
         bkVhdxyy3VBBZ1YGrK7WojTrZbcg+PAxPxp6dNV/VXkoQANyPGzvcjILBSQ2G3f6STdH
         k0uaI18Ewb8hECiIWvyRz7twZfww8peCLMTghfsq08xiByLJSjFxGedSiue6lUkb9FYv
         jBPPvKpBr2uA3lYU6apI9t2qHggiTOmOew2k7n9I2SfxWeSZ7JnZYKqbb1SiMKYhiF6J
         xMqbCyDgqZFpLLnOOHjSDzM8UH5ei5sKuEhwsMOpk6nC/oat3oIrLFACCOZbMElr7a3b
         /6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94HhLZErt6tptJHKl864lXCVSB3thrXy6dwt+pBa51c=;
        b=E7vC4TJSIv4WwIsTptSGteO2DoMyrh9q4QcUTc6zOd6WVRG/YgDNxma+i0JNOJFAft
         Rv6TW298wPD8hUd1PQ8l1un3V6TTlEhQVBnnccZrnZIFaDJY3huYC9UNerg9PG96hO96
         u+Hh6vPNvTtjSBiNhSVzfdSWWF1qhrdTQt/KLdYiPYLO/OOO8JMNrYGlmCGwS6VMld19
         kuKRXTJ25EYBcpVMs4qPZgEiFUiMvhReOl3NksKWjkJzmRqt1ZLCIUoxe0g2VJCyfhu0
         qVrj7xvNCbH/m/hFpnlNOdTYv8e0rCb9InaPro3blFbYFDrZQttHGx6SoAjmVC8pdK6U
         vWVw==
X-Gm-Message-State: AO0yUKXfdCc2QcNpHFMmKUTAmLF25uM4Nkv2tJtIJSMVtv2qfRkINnCt
        PoPTE7V2xi4+D2p61OQVk7VMxEVQuaACiGbGB10=
X-Google-Smtp-Source: AK7set/ubUws40cQ2vkTOkYAzkszvk+IasHiO0DtUU+SZZxvFdGRf2CzvH0oEnwNqH3p605m6DTiVTzMH5A9ZHT8MRU=
X-Received: by 2002:aca:d909:0:b0:37a:d1e1:65aa with SMTP id
 q9-20020acad909000000b0037ad1e165aamr1140240oig.83.1676029130415; Fri, 10 Feb
 2023 03:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
 <20230210065621.598120-2-sergio.paracuellos@gmail.com> <a0a141ef-b5ab-f84a-9a77-7b6d1f54ccc9@linaro.org>
 <CAMhs-H-w3O_Yjo7CcGdXyw0bSeqefR32Oj4hhQWsVVWoThNLyA@mail.gmail.com> <a592580a-df1f-1ebd-5752-8c2dd1b770fb@linaro.org>
In-Reply-To: <a592580a-df1f-1ebd-5752-8c2dd1b770fb@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 12:38:38 +0100
Message-ID: <CAMhs-H_NBtZV4kJtyMwkPqd1gZ1nQLRH1fbf7gqeJa13tOB5PQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: mt7621-wdt: add phandle to
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

On Fri, Feb 10, 2023 at 12:27 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 12:22, Sergio Paracuellos wrote:
> > Hi Krzysztof,
> >
> > On Fri, Feb 10, 2023 at 11:59 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 10/02/2023 07:56, Sergio Paracuellos wrote:
> >>> MT7621 SoC provides a system controller node for accessing to some registers.
> >>> Add a phandle to this node to avoid using MIPS related arch operations and
> >>
> >> I don't understand this part. You claim you add a phandle to this node,
> >> but your binding suggest you add here a phandle to other node.
> >
> > Probably my English is not the best here :-). Yes, you are right, I
> > just want to add a phandle to the 'sysc' node in the current node.
>
> Then why do you need syscon compatible here?

Clear now. Will drop that in v2.

>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
