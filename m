Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C726693385
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBKUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBKUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:07:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6F1A4A0;
        Sat, 11 Feb 2023 12:07:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m2so23321623ejb.8;
        Sat, 11 Feb 2023 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dOVQ/VbadOXgUJH1nohNnu6m/RvPVCPSLlnbgGu0n8o=;
        b=Wf77x5+sAbv7Cl63hpElfT3+4AdGMY7/cUE6sA63jD61eYYRug0piD6AVRfRhyDeLS
         lJPuFoCwQkruPPvHHC1wFfZkY9AtBtqK1a7CijHHqJGGtinXVip10S21tcVDaXWhOHKo
         7SmGiF7JA6Gwa83wRzcM9cuaVZgMzcLHKwBvROcToZVrV1NY+ymVNxAf799JcYfo9l8o
         BNsmUiTopW1OxzOyPPHsFzn02htzVRob5X938MBjCetmXOueLzcMEhmDTla2GFvn1iAy
         Z0/2OQt24u5VMh96oSWWQHX3hgB5PPWO9j9DIB8aRn8FhsnlH/QJXpfDKFLS4S1vcILM
         E7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOVQ/VbadOXgUJH1nohNnu6m/RvPVCPSLlnbgGu0n8o=;
        b=DOvOt9kI8tvfS1MXkBfXjM9L1Rgeuu/MPz5wbrdCSB/gKzc/b6qrdW3y3bTtC78BrI
         5si9WsI6K8cp1fEWm3E73V3DqyrHqWdDrQc/2bCSZC9DMYKEMgX/DeGGYP7ro5/1H7FJ
         ZCrb8LMnfXN6tYYfGK0D2ibyIo62hfkzIqJbBjAebFiWZa1ZXNFJkemxMe9HYTsvHnAa
         68nAqaHg0vkwsDVgYv0jIrgJzR1CYIL9B0+WSyr5o0epWM8qo20H/UIjw9Loykxdfpbm
         HM2L9Kj6zYee0wURTtVhYVdv2a0L7SptgtC5FcEZ6z/Zifb1VapmOKLCwnNQMsZ455Zw
         IOAg==
X-Gm-Message-State: AO0yUKUGg8Omps0AxZvi+eQEzdb5EXK6Wl1xh1Lhxuz/gKtl7Z5l4Rcq
        3PD+NysZQQAL3hZ1YfwqDNXPEtteGTiNKE9Jrpg=
X-Google-Smtp-Source: AK7set95wE6VpXCrAxJckx6+6bpsqZnVA4wUtVBvyrjj34YQLUEEKat7VLo6AGZgSMe7R9uPBD/KeGnl6Pz53R72Izs=
X-Received: by 2002:a17:906:241a:b0:877:a0e4:4cce with SMTP id
 z26-20020a170906241a00b00877a0e44ccemr2619690eja.4.1676146060547; Sat, 11 Feb
 2023 12:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20230210170721.1285914-1-christianshewitt@gmail.com> <20230210170721.1285914-3-christianshewitt@gmail.com>
In-Reply-To: <20230210170721.1285914-3-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:07:29 +0100
Message-ID: <CAFBinCDO6-UF0e556iLJ4Jr0h7DHcgeOFg5pOxfdb2TEh=iXgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: meson: gxbb-kii-pro: complete the
 bluetooth node
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
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

On Fri, Feb 10, 2023 at 6:07 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Add missing content to the bluetooth node to align it with the content
> used in (all) other GXBB dts files.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
