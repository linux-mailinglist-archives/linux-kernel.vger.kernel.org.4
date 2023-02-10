Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC69691F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBJNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjBJNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:14:25 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401AADBD0;
        Fri, 10 Feb 2023 05:14:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bh15so4380499oib.4;
        Fri, 10 Feb 2023 05:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WURipjti3ACK/6v57Rr/FeTpbbBRqu0TgbTLSq4UKsA=;
        b=c1upJ4Wdy7J0j4yVU45u+W5xbJCOK0vQ/6OXshpOXH5szcU0eoNVtY78TBqVjC5/C/
         sMBhPZdwnNfWo9yh3haUjYAKvie2KBtry5woXijKPzCddFtui1WwaPKPcf9yi1kTPXdD
         TMEknUsibuhXCpGGCh2KiN4qkwiIcNtFLuS2dbIYe4POcASPiQ2HGDJNGSTc16UEL5Hr
         dEiLI5gFwTgLDdHeQgXM2tKahtV6tuE+IjCtkiHqrfWcVhuQ61AetY4Wnrc4raRVOqVX
         vlK4usTvvjreg0kiC3H0MOZGgBaNJxQ7HsWfSNwcWDWAgCo+KJ8j/8d4DAk/Qp25r9Fj
         zO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WURipjti3ACK/6v57Rr/FeTpbbBRqu0TgbTLSq4UKsA=;
        b=gHXAqOocwfLcDIrGNoIX7tgV7+MNzlrGswlfp9WykgTkr1v2/2NwksdA3NV/f6qsPF
         6WgHzoj9hqpLCrB/rbXLljSbCKekh//X5282BU3DIXYRC//QeUzpLHe2N0cHji7tZRjg
         MMg04D7tH+FcpQQpeuiDC+M87AXTxgjmFyo8TucXxzR/GMgyphH3IQWdjZN5k2rk5G+E
         Aexpvc9g9d4Pou14P27OXrbmjcG9Yw09SjXChicdYgcZkZ6mUO1lNncx2iraKbTCz4QV
         guGwRGPXD7PclB4sigKCQPvYaLy5JoU8becGbZ4B9eAhVJI6vmOn5aKawC+q89yPshUp
         JLbw==
X-Gm-Message-State: AO0yUKWTFqSGAxUB85LKdtHiKDbzSkbemFB3UuktlW+2ehxsvVAT57An
        SNoA2PfDl3O6l1iSvXrM8ie0Khm8OWLM5rISzUU=
X-Google-Smtp-Source: AK7set8MYcT/BYf8aP57qlVZfhT1B66jpnr2aPMsltJCS9xjdZkBRXOaMEnFW56y2tbBpq+qP5xUsIlmpCFKVIaCP0o=
X-Received: by 2002:aca:d909:0:b0:37a:d1e1:65aa with SMTP id
 q9-20020acad909000000b0037ad1e165aamr1159856oig.83.1676034862530; Fri, 10 Feb
 2023 05:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
 <20230210121735.639089-2-sergio.paracuellos@gmail.com> <b59d426d-8a5e-9eff-57f2-e36ebfdc5466@linaro.org>
In-Reply-To: <b59d426d-8a5e-9eff-57f2-e36ebfdc5466@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 14:14:11 +0100
Message-ID: <CAMhs-H_6-2P7aaqSvFDypdfbf_YzhPW0r-GCP_xfO5TgyU6Bnw@mail.gmail.com>
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

On Fri, Feb 10, 2023 at 2:03 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 13:17, Sergio Paracuellos wrote:
> > MT7621 SoC provides a system controller node for accessing to some registers.
> > Add a phandle in this node to avoid using MIPS related arch operations and
> > includes in watchdog driver code.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > index b2b17fdf4..cc701e920 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> > @@ -19,6 +19,12 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > +  ralink,sysctl:
>
> Thanks for the changes. I did not notice it before - isn't Ralink part
> of Mediatek now? Also compatible is mediatek, not "ralink"?

Yes, it is. I was using the same prefix as for the memory controller
syscon phandler inside the 'sysc' node [0].

I have no problems at all in changing this to 'mediatek' if preferred.

Thanks,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/ralink/mt7621.dtsi#n67
>
>
>
> Best regards,
> Krzysztof
>
