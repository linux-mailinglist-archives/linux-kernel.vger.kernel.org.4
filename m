Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677F063F0BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLAMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:41:51 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F805801F;
        Thu,  1 Dec 2022 04:41:50 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1432a5f6468so1947258fac.12;
        Thu, 01 Dec 2022 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVtwBXUP6j6Bf0vdPQcEIuUGWHMzl8hlrxeZxCGBo7o=;
        b=KhG045o73gAmFqWPVI6b0QexsA2P0qKZqQzejNrLgPsrYZ7qF9JfRssadiaZa8N4j/
         tIliNbuFS/awGxcUqmszKcLkHMWDCYMU5EnHC5g87WdWxZvV1GBWs1Du9hiipCmNmRsS
         Znag6Gnz2iWCjRydCFJ8k8yJTdC+27BWPBJ179QhSIliBtfk/3TKIHdnPLyzZ06ib4j0
         QGGrh7pM/5uqmLlKtipMCh4DxaDLJZ3jIYsiy+95N8o/CYKBVm8/TRPxI5J6HdLUvRdD
         6koqAseyM+W5OvSaIEabjjJOvq8Uf1tQmhNVHAxtaC6G4pw5RfLTX7xefPMezRB3rx2U
         WNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVtwBXUP6j6Bf0vdPQcEIuUGWHMzl8hlrxeZxCGBo7o=;
        b=nX+d2vyaBELdVq8rre0wQAqAzAa6CqvH0vPRPwFZ4QJLM0VNrweU+cXGsPddkj8NcV
         5P+6gzCwof7V5nST0JfbxCNmVLOzkgeobr7aD4/07B4j+PWRyEJrZ3H1pPwJvuEHrwKm
         QVHSh0suly6CcYuoUgB/oNzTgjwWwsBi4Wy9lA2eD4LiBr2E7qk0f9FAiOD9/bOUKqb6
         7l9RPZmLNOZ0X3mqbPgV/3QSqHDs+Vs9aPx8G+e1ZgTSorZg+hQhj0V4meMtUjkMp+Tz
         aqggVi4BsMh3Fut02RVHWvK0OZM0TXIpJIHFabrQdPnJ1QCN55y3yQWNP/8GGiERqpfQ
         oYzg==
X-Gm-Message-State: ANoB5pk9T64uZugWf7Z7wEcnOtM633QlTDWuWhsOi3fBG03peQ5Es5hw
        Xb6YNXb2hRXkUeadCzxQNghsgZ2OhQR7E1U70xo=
X-Google-Smtp-Source: AA0mqf6lkTeE/LUL4X4zuNE/2/zR6AH8fXXx8wCNgAMioaIAtv49JXiRu83pwCnVTMXot34+PdI4JiacLxJtmuBETUo=
X-Received: by 2002:a05:6870:ab86:b0:13c:5763:9411 with SMTP id
 gs6-20020a056870ab8600b0013c57639411mr36055275oab.288.1669898510141; Thu, 01
 Dec 2022 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20221129140955.137361-1-gch981213@gmail.com> <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org> <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
 <7b3f97f9-34af-413c-aaad-9108b4f36c51@linaro.org> <CAJsYDVKXvJZaqCBx7RSsfVZkKTGdbp78GHA4mvmUdQwyEyGkBQ@mail.gmail.com>
 <c13b67ec-c030-302a-6315-fad18323923a@linaro.org>
In-Reply-To: <c13b67ec-c030-302a-6315-fad18323923a@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 1 Dec 2022 20:41:39 +0800
Message-ID: <CAJsYDVJyeuHsXFdi-OrMX-1maQbC_wLYko6dz=unmuG6B3DL=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 7:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> >> [...]
> >> So this is brightness of each color...
> >
> > I don't think so.
> > See the kernel doc for multicolor LED:
> > https://docs.kernel.org/leds/leds-class-multicolor.html
> > This property sets the sysfs file multi_intensity while the
> > actual LED brightness is controlled with another sysfs
> > file called 'brightness'.
> > Setting multi_intensity alone doesn't change the LED
> > brightness at all.
>
> If you had brightness, that would be correct. But you do not have
> brightness, right?

The brightness can be set using sysfs, but I didn't implement a
default brightness in my driver.
My original intent for this property is to set a default color for legacy
led softwares which can only control the brightness and doesn't
support setting the color value yet.

> Therefore the final brightness is always:
>
> subled[i].brightness = 255 * subled[i].intensity / max_brightness (also
> 255);
>
> Or your bindings are incomplete...

I do agree that adding a default-brightness will make this more
useful. I'll add this feature in the next version.

-- 
Regards,
Chuanhong Guo
