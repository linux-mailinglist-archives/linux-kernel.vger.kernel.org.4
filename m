Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221A675890
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjATP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjATP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:29:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C52C64A;
        Fri, 20 Jan 2023 07:29:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v23so5645862plo.1;
        Fri, 20 Jan 2023 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3iDoMJbnRKpRfKhk81+1OwaFEBot8AK23yaBuGdK8=;
        b=hgL85ZaqP6xkBJhm4n/1oiRGWuBvACMT8oRk+Q7oJCI0EF/XpXS70egr7zANYUa69x
         vMW5Gv2HuX8FvBE7WTogZzUcVE8K9bC5f0m4D+SMMBfepJHm3Y2AD95bm2ngUR7bkEl0
         d0V1PQA9rJJ2YOU8C2DGYCoiFBItUBzrbxm0GpVp9zF1RZ29lx9g+6C07t4UXo8HfeGY
         wlwB+xWRueVtazh1OpNN7cAu6CsNCJ37Sj8ZAQbgGFkYbCywugACAisc7/H6ihoXVr6C
         g4vxbP30dhabfcvGMMhw3UPuWtlrusNSmIFcRg2TLSrSufG6fm2SOKS6DFjqeSYuUCxu
         eXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul3iDoMJbnRKpRfKhk81+1OwaFEBot8AK23yaBuGdK8=;
        b=wJw8qpf9n8PM5eax+lXy3fbUynG2E/GbiyPEaRocOf58x2zNio3iH/PeSqTRMt1rmU
         EgcJVDQSyeHG7CJkSRUdWWXOc3iSaob9wMRGEPNBwICxweRRIT61FytuVlyZazBpy1PX
         G96etXwN8A9prr3a6cowq/thDsx/CrYvRZOkW+02tsTSiBimYzl+kiukM1Bls0To/+Cl
         Qarva+9//EI7VoMGXMA+Q4Bpsfw3DwBBGGJIxWE8fDMPAknajrOGMOx256crm155jwZw
         JDCXVDSc+Z8M9TzOjrorQivs3j79dM8xVSGtofo4aTyYzA3NRE2MzS/shSmc+jisxkJt
         6Olw==
X-Gm-Message-State: AFqh2koe/8RRFrx8HjOOc4l5MSqc3omHKqF0XcMKJMV7lv/LewKHpdUs
        YAbyFt9/YzCP3eG6aHtJS8c=
X-Google-Smtp-Source: AMrXdXumMAZRnOcjUhzgN86mucVy1/T6eUZElVp1f89wmzB5tY/SeqFKOTVGUyj572QsW9U8f9n/Ag==
X-Received: by 2002:a05:6a21:170f:b0:af:9dda:b033 with SMTP id nv15-20020a056a21170f00b000af9ddab033mr16021707pzb.37.1674228582783;
        Fri, 20 Jan 2023 07:29:42 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b00478162d9923sm10458730pga.13.2023.01.20.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:29:42 -0800 (PST)
Date:   Fri, 20 Jan 2023 23:29:34 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8qzXpNV5dA0UnFs@Gentoo>
References: <20230120094728.19967-1-lujianhua000@gmail.com>
 <Y8qxofrfiQbRmsGZ@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qxofrfiQbRmsGZ@aspen.lan>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:22:09PM +0000, Daniel Thompson wrote:
> On Fri, Jan 20, 2023 at 05:47:27PM +0800, Jianhua Lu wrote:
> > Add Kinetic KTZ8866 backlight binding documentation.
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > [...]
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > new file mode 100644
> > index 000000000000..b1d0ade0dfb6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > @@ -0,0 +1,74 @@
> > [...]
> > +  current-ramping-time-ms:
> > +    description: LED current ramping time in milliseconds.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
> 
> This doesn't look like it goes low enough (wasn't there a value lower
> than 2?).
> 
Yes, I have sent a v8 patch to add it.
Thanks for reply.
> 
> Daniel.
