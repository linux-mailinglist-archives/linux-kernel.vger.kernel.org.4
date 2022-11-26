Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06518639589
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiKZKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKZKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:52:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293391E724;
        Sat, 26 Nov 2022 02:52:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z20so9360598edc.13;
        Sat, 26 Nov 2022 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwwipdy31NHjiHIp4+jSprZe/paV6ne6H7EJhuI0Zgk=;
        b=aL7ROWLCIfZfdgF2nW4eXf6kXsRQdr7NMkKl7E8N0/RnHOKE2lDXHCiUQAlQLY9mDF
         ZiKIfe7mvT8SmuE8awyMS3VagkHF8c6iMa9WwiBS3S6R9j16syUgFfucqtB9Tc302Y8H
         O46ihHVHc5KJRhZkcw/awxhXCd8qMAgfxo+s1NVLVqhdfJSc2W7BqHkyxqxh+osJ5jmg
         8jiZG65sQXsCOjCd9bMpBrbzUdfoFXRXPt3gWHtJLuJGByvlTN0KTuOqyvZtCvPQvyXr
         TX/OPWd1QujVoLm3XflLjjObhZHZ/5q4P9N29S+Oxd+MYhxswPe5IWigyk1fzgoHcHk8
         Qzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bwwipdy31NHjiHIp4+jSprZe/paV6ne6H7EJhuI0Zgk=;
        b=bRnndt0ZTV4r7tWHbsJ+sAaHH8yvLGGRYhVEBctoqkCSHnV8Znm9aRvV9aAzpAelT8
         sxyQ0TGh9nqSjjhU7eqRv/EBK8GNqIDw0mtWlkOj18DCdJWhnJrN7mLJAAQEeRvLT57I
         I4oL5Utrc3svWotTA7ateOk/0SlGBL7aUEHpF/N/tVkGTWUXgN917iK9FnytsGJy1pLu
         g2rKGqtRPiP6cRIPCqJ/QWqDah0eeqPgmwU7ry8/5LeWEz09h29f4rVjyERiHNYfrO7o
         ikfLLSOlM04Hwo7+fyBxCZkY0DWlj+qfM0n//P91DXpsu3PGHGbLrWKGc1ixyYz3z4ZX
         IK7A==
X-Gm-Message-State: ANoB5pl6zCVd1xr4Mp9aTFecHSxJJjOHeBDizRu7a6QzGKnRfydNrMui
        pIxscI0/7hXLRzdsQvhGkWzlTp7p5yLOLMa1Wxc=
X-Google-Smtp-Source: AA0mqf51THiuObU58rNSIgqv7N3wH1TLck61ni2C0m4TPqTpl2mCEa0apl4q4hdOrxWjO3BCdZmoSCnUBfBmGBoGbwY=
X-Received: by 2002:aa7:cc99:0:b0:44e:cd80:843b with SMTP id
 p25-20020aa7cc99000000b0044ecd80843bmr25863455edt.126.1669459928564; Sat, 26
 Nov 2022 02:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-2-shravan.chippa@microchip.com> <Y4DlZWqlVf6zYZTo@valkosipuli.retiisi.eu>
In-Reply-To: <Y4DlZWqlVf6zYZTo@valkosipuli.retiisi.eu>
From:   shravan kumar <shravanmicrochip@gmail.com>
Date:   Sat, 26 Nov 2022 16:21:57 +0530
Message-ID: <CAOPdzVa7Fb3Nwfs8ZzTLGJkJ6KMbqAs3KB6p-fu2jKVO0qNv4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: imx334: modify link frequency in examples
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Nov 25, 2022 at 9:27 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Shravan,
>
> On Fri, Nov 25, 2022 at 10:38:02AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > -imx334 sensor is configured to 1782Mbps/lane for 3840x2160@60.
> > -But in device tree bindings exapmple we are passing 891Mbps/lane
> > so modified to 1782Mbps
> >
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > index f5055b9db693..ea3c93f97d65 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > @@ -82,7 +82,7 @@ examples:
> >                  imx334: endpoint {
> >                      remote-endpoint = <&cam>;
> >                      data-lanes = <1 2 3 4>;
> > -                    link-frequencies = /bits/ 64 <891000000>;
> > +                    link-frequencies = /bits/ 64 <1782000000>;
>
> My understanding is that the original frequency is correct --- 594 MHz
> pixel clock, 12 bpp, four lanes (and DDR).

As per my understanding, other than these three parameters there is
one more link frequency (communication frequency from imx334 sensor to
MIPI CSI2 controller).
thanks,

Thanks,
Shravan.

>
> >                  };
> >              };
> >          };
>
> --
> Kind regards,
>
> Sakari Ailus
