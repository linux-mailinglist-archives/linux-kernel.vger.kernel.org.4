Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ADC695FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBNJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjBNJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:51:02 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B82C646;
        Tue, 14 Feb 2023 01:50:44 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1442977d77dso18340010fac.6;
        Tue, 14 Feb 2023 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe8yVPzrMnIUl6apEVzc55u9ThbSlOHTJt+d/XNqBpQ=;
        b=FoNlIGMEkbUto+SUjmjcd8L1dsx8fku+QXe8RDMZV0KOl13DFXKrlcDXbaqDmevAk7
         y3dnOg2t62bxT+P4SmEIrZa19OwClG50D1Lc9B86ebEA+Y2cdcy9e3O+RjIn1roLZKfo
         hFTgDhsQt7HPqa4DHB91uBpyhnEkiuFC3SMOVeleNR7sfWjpkjFWqSWvH66sCNSz15MZ
         las0joADsaX1/wbx20f33H5pZRI8eIN29h64MWBbqR1WXs01d3c/xVJM+3mNgX1IpEHX
         YHw5aDbNWbVuSL04pDo/3FbectVgXHbImLyrN5AWWbt3UsDo4oPE/3RFVs3+ln8cHqCb
         1Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe8yVPzrMnIUl6apEVzc55u9ThbSlOHTJt+d/XNqBpQ=;
        b=3bkB14UQHlViv1fsvGUVuRw9E+8d3TE24b+p021dpGjKdEmEj/44V8PdeT2shA1RmD
         ZLaF7i+HBNTnIdPUlh8773p3a7jx1+3wp3YNaU9ZgSGePCir9WnuJndMst+syol0Asyw
         TjcRZyCBm/MFGz0W7eMJoEqjz4QKaK1rMc+eX4syblMmOTAbb3Rr5YVTk3hoptwJA6/L
         FPhhv/b2y1M3gbzRaoDBlKriHwNmKDSRCpeeKTak4J9yniErWDyuRKvSBGbYv38wtgvR
         +RdDcuzF8l2lY+Kz8Myfe0nXmL9vBr4E+WBTFqkOv79wcR6RCmsHSF+jyZnXGPX10me3
         0GIA==
X-Gm-Message-State: AO0yUKWorA/NZMKjdBYXPV/mLoxrqmFn3IQ+rImo/AORsUi3pOIUV60f
        3vNfsvFUebF31RgMwlNmM9687y/egbFFWqZTYRo=
X-Google-Smtp-Source: AK7set8yA4TFrz9HOcyIs8LGc+zMAs4Po5lzbzpOpbhri3fyBOhpF1ltlVqWyx2vHsKD6paMBlECrXhIQB3mcSovaUg=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr3832733oaq.83.1676368244005; Tue, 14
 Feb 2023 01:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com> <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
 <CAMhs-H_Cd9F+UWWe+dAA89r_huX_srtsgjh1qus93nGehQN1AQ@mail.gmail.com> <7f2e556c-ee11-fe4e-f4d6-94c761f976d0@linaro.org>
In-Reply-To: <7f2e556c-ee11-fe4e-f4d6-94c761f976d0@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 14 Feb 2023 10:50:32 +0100
Message-ID: <CAMhs-H8Ls2oTZ8LYguCdizNZN3cUC8kKA4e_L6BD3C3cFDP0tA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
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

On Tue, Feb 14, 2023 at 10:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/02/2023 09:54, Sergio Paracuellos wrote:
> >>>       return 0;
> >>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
> >>>       if (!drvdata)
> >>>               return -ENOMEM;
> >>>
> >>> +     drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
> >>> +     if (IS_ERR(drvdata->sysc))
> >>> +             return PTR_ERR(drvdata->sysc);
> >>
> >> This should be the backup/error path for original code using syscon
> >> property. Looking up by compatible is really not portable/re-usable.
> >
> > I can change the code in the way you are pointing out here but...
> > Why is it not re-usable? Compatible is not supposed to be changed
> > since in other cases the DTB ABI will be broken. I am totally lost
> > about what is an ABI breakage, then.
>
> How do you use it on other platform?

I see, thanks.

So if I am understanding you correctly I have to maintain the
'mediatek,sysctl' phandle and use it in the first instance and if it
fails I have to use regmap_loopup_by_compatible() stuff, right?
Something like:

...

drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
if (IS_ERR(drvdata->sysc)) {
         drvdata->sysc =
syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
         if (IS_ERR(drvdata->sysc))
              return PTR_ERR(drvdata->sysc);
}

....

So in that case, we can add the new phandle to the bindings without
any kind of ABI breakage and we can use old dtbs using new watchdog
driver code.

I really hope I finally understood this properly. Thanks for your
patience, Krzysztof.

Best regards,
    Sergio Paracuellos

>
> Best regards,
> Krzysztof
>
