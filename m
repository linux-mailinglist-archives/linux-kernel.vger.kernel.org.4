Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47F6758CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjATPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjATPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:37:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC54C9260;
        Fri, 20 Jan 2023 07:36:23 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9so5618222pll.9;
        Fri, 20 Jan 2023 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzUIXogxNC2LuEDM1xVMXzkSxiYCr1nrc0O00OgWk8k=;
        b=TB16WPJZIflVsi0zlcQbnuKOCknFMT8RnyBgg1qnTo7yKx8+N6YVICzxScP5HQODuG
         o0eessBo5utL6uBJMcEE8XKEGpkxosLrMulIVZX09YaUtQHl4w6wmrUSlXxz3iU4+Zxe
         ISBYxLEBaehrPsRVwi55gOmxOHQLK/lX/FbjKXCIa3sEANyJOcfLqld7dNgPwPpP/Tsq
         OTE00csLFsU8hBJxIuiUOd2C55aJW8zZGmbXX8RfjH9xHL1oUhxtrHg8NtW4+w2F8GKN
         AebrekO+YNbH1Vr2HfA8XDBGXBtGy+e+5LW8KTi9y3Hd4FnmWCGOvXHY1pLr/84Urbi9
         wTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzUIXogxNC2LuEDM1xVMXzkSxiYCr1nrc0O00OgWk8k=;
        b=vlykmIGIfO5xrIhtHMGzwrAcE/YvQPVFpltzSR5zChiu1O/cI79ZyUIjfG787v964r
         89NeKpzOI4bBIs90s+nC4u2u+Af52wEKZAADddUk+O4kYPaE8zQmsrA/9VMCLddwg1LV
         8HjI3VyXFnjMRtINqRgr1khvcBW3XpHR4x2quttcFMdsLX/IPkHQ5KbLzg1Bc70kkVnu
         uxz5C+D089+wCB03JNtIE3oV2B+9ChkgAtnCRap3yjeJ2hYdHs6wA99tftz3wUshSpWS
         TrDuPdF0nW18aWasUYMLpe3TI0pfS0UaNuTfqYjnyT/G+P4pVRRj8DCUZv/d5jwbISqO
         eImg==
X-Gm-Message-State: AFqh2koUfrrOJR6ri4qyWVIWNHWzXLI9S7gFpvvdc3yi1AdFtSSM4uzs
        52ulc3UB7tU81Hkt8d9cMcA=
X-Google-Smtp-Source: AMrXdXvUg47NBubgdHUZ0ryXUX+qmjm+8K5V5RITNIEGsc94Qke9sNDv48/IGVW725kOihcfqngJ2g==
X-Received: by 2002:a17:902:ce82:b0:194:84ef:5f9c with SMTP id f2-20020a170902ce8200b0019484ef5f9cmr36426713plg.29.1674228971827;
        Fri, 20 Jan 2023 07:36:11 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b00192721d4f2dsm2866134plm.82.2023.01.20.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:36:11 -0800 (PST)
Date:   Fri, 20 Jan 2023 23:36:04 +0800
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
Message-ID: <Y8q05Cz+y2Zio//t@Gentoo>
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
Sorry, I sent a wrong message, it isn't be fixed in v8,
I send a v9 patch to add it.
> 
> 
> Daniel.
