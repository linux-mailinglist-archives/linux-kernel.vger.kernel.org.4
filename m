Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A862305F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiKIQpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiKIQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:45:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC526CE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:45:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g12so26596704wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+B/DZlmnUVVmtW1rTqtwhIks9ot8Q7pdnxqrZsgcoHw=;
        b=wN7RR+Ipb9QwhtmXdPWwHQDEAWfqcYBImB50//FSmYOFHAYfgRAFMwqJ0byJF/EOLj
         tBnumsbl5i+pyUth2I9NU2rgyR3E+B3YhTB6GTs3a6nMk307dJIUxZ4XsigPtJ/Vbta1
         2DhO90nhM11+XF547CbVb9tGH/s7zNpdyZhacb35Bzz5SNVNXaYKOzETCkw3RRjfvu2z
         RWW241F3mSJlcteho07WTdPZEy1tggmcT7G+fUg/8YKLQ/Dsyl8+ltX0sSlcl5wk91Z0
         TQiy6N6xL3aaewDQt6In9kTB6s7ql89F3ZYkrgba5HBXTdVAhQuqq5eEFWUpuUJYq21P
         k9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B/DZlmnUVVmtW1rTqtwhIks9ot8Q7pdnxqrZsgcoHw=;
        b=7AH5JzQ9X22qrQdIAvZZicoSk2fOfLBvlF+IUzWe3QON3iVA1p0zMT4WB9cq1eZsEm
         veccvv93qDGapx8s10bC1CCq8m3dYj0g6TMIWPQHVdiL3cbgqrf6/EY7gttSzGu45i++
         JjCcEfqEGkYOzu7Cg26TTV1cqnWnBm0oqx6zIDWy7lCifH7V3l9xXWjgVn12zk3y/BIa
         iS80xTNvUKKDc+Rylgdgrci+QgvMf3gLAB5FhTtPG+gwLgoiowaytIxv9IZONZC7BKEx
         z+2rpxWCPd+3jyligoHj8UdeyQ5vp97rEMIqXEMzmd3ogP4b+aaNiq2KDeznZPvphHbt
         cazA==
X-Gm-Message-State: ACrzQf0otpdoL5ctzm4vN2249toQ9L4HEgqVMbQLh/8iFB+ud+qxFB4n
        e+4L+L+0ye7ALsFwxveP+tmNyjL6VQEyZo0iLb6Sjg==
X-Google-Smtp-Source: AMsMyM51EI3z3+fV13+ZvZRkrHaeThY4Z0deZ+uxqRIEtgCE6TC+ujKo24Us3GLPkbUj/K7KWSKhmWSk+HSlhXTnqao=
X-Received: by 2002:a05:6000:1c1a:b0:236:8321:d875 with SMTP id
 ba26-20020a0560001c1a00b002368321d875mr39225435wrb.45.1668012319491; Wed, 09
 Nov 2022 08:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20221109160904.183147-1-mpfj@newflow.co.uk> <20221109160904.183147-4-mpfj@newflow.co.uk>
 <2af9a47e-acc4-d2f1-8fc9-281385d18d51@linaro.org>
In-Reply-To: <2af9a47e-acc4-d2f1-8fc9-281385d18d51@linaro.org>
From:   Mark Jackson <mpfj@newflow.co.uk>
Date:   Wed, 9 Nov 2022 16:45:08 +0000
Message-ID: <CAAbcLfjR7JZ_W+JoAJ02_4eiVQPZj--=C1-uLjPvRGQYC1dNGw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: nanobone: Enable I2C temperature sensor
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 at 16:23, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/11/2022 17:09, Mark Jackson wrote:
> > The NanoBone platform supports a temperature sensor on the I2C bus.
> >
> > Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> > ---
> >  arch/arm/boot/dts/am335x-nano.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
> > index cecc2afaeff4..2be831927af6 100644
> > --- a/arch/arm/boot/dts/am335x-nano.dts
> > +++ b/arch/arm/boot/dts/am335x-nano.dts
> > @@ -212,6 +212,11 @@ &uart5 {
> >       status = "okay";
> >  };
> >
> > +temperature-sensor@48 {
> > +     compatible = "lm75";
> > +     reg = <0x48>;
> > +};
>
> This should not work - you put the node in some random place.

Ah yes, that should be within the I2C block.
I'll fix that.

Cheers
Mark J.
