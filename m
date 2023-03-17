Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FF6BF115
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCQSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:53:22 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE3C796E;
        Fri, 17 Mar 2023 11:53:20 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id r4so3225192ilt.8;
        Fri, 17 Mar 2023 11:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhejdJ2QzRiuDi7NcPcw8B7d/cMeKEhfekni41Gxpkk=;
        b=7WAEfeVFDcEnA4SDzyXkrgw1Qiq58T6odvHnIWejT4A2zAEPWBeO2RCoemmW+3B/sg
         NLZNFpPukC/v+suk9XAw+agtM+inMkTGwd6CkNuv9VHHKlI1s9cq4l68mLhosKhhq0OX
         zadDhOneyL3wz4G3CVlyeOGFM1djtS2uLBsBbpaPoOGtTCinXsTP5OEXXm7c0LTwqKcB
         hWeuVoT26tZagmRwoZNAlHDdF5yPUsdae85s8aC30Jq7BoRhF2F/jX8f8R14XmiMPf4L
         e2LpZqaFvKAq4UJ5p4OJTINEuShwccqZ9Xrrn5NAX/DEVeo19JrCqiUiyrX24fxi/2GL
         /hpQ==
X-Gm-Message-State: AO0yUKVXYkZACwIfx/tEsP4G+ADE4XcxYZ6L6vyI0b6/l3ZqMIVywuoI
        +WsrCSHimeqPZJzzW5FHyQ==
X-Google-Smtp-Source: AK7set+MH4oe7paXw4mNYBNwZmQ3XrzicpMki++gWyEP2w53ywhZy/ZcN6LTqzsa+uss+FVSLWKCcQ==
X-Received: by 2002:a92:dc01:0:b0:317:99d0:8ad6 with SMTP id t1-20020a92dc01000000b0031799d08ad6mr246243iln.16.1679079199880;
        Fri, 17 Mar 2023 11:53:19 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n24-20020a02a918000000b004050d92f6d4sm905689jam.50.2023.03.17.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:53:19 -0700 (PDT)
Received: (nullmailer pid 2616891 invoked by uid 1000);
        Fri, 17 Mar 2023 18:53:17 -0000
Date:   Fri, 17 Mar 2023 13:53:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Message-ID: <20230317185317.GA2608140-robh@kernel.org>
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:48:25PM +0300, Dmitry Rokosov wrote:
> On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
> > On 13/03/2023 21:12, Dmitry Rokosov wrote:
> 
> [...]
> 
> > > +#define CLKID_SPIFC		84
> > > +#define CLKID_USB_BUS		85
> > > +#define CLKID_SD_EMMC		86
> > > +#define CLKID_PSRAM		87
> > > +#define CLKID_DMC		88
> > 
> > And what is here? Between 88 and 121?
> > 
> 
> Explained below.
> 
> > > +#define CLKID_GEN_SEL		121
> > > +
> > > +#endif /* __A1_CLKC_H */
> > > diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > > new file mode 100644
> > > index 000000000000..8e97d3fb9d30
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > > @@ -0,0 +1,20 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > 
> > I found in changelog:
> > "fix license issue, it's GPL-2.0+ only in the current version"
> > and I do not understand.
> > 
> > The license is wrong, so what did you fix?
> > 
> 
> Sorry don't get you. Why is it wrong?
> I've changed all new source files to GPL-2.0+ except yaml, because yaml
> dt bindings schemas require the following license:

Why 2.0+? The kernel's default license is 2.0-only. Are you (and 
your lawyer) okay with GPL v4?

But this is still part of the DT binding and has the same license 
preference:
 
>     # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

However, the header licenses are complicated due to .dts licenses which 
are all over the place. The requirement is dual licensed and matching 
what includes it.

Rob
