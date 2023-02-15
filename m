Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF9698445
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBOTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBOTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:16:51 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284537B67;
        Wed, 15 Feb 2023 11:16:50 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15ff0a1f735so24210003fac.5;
        Wed, 15 Feb 2023 11:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW1m1yQHM9XDpw4IOvOruehCKlPQgSONUVgmXhDIYf8=;
        b=DmtfHShl3BgpBNdHv+KGWklz+TahdeWqQ4e9yanyPRLno846RzVixMhWRim4U+NukO
         bo74e5TP20AK7Q+ofdeOLEWDf4Mis/g/NuGitKJrMzA2ITmO3+Yo1CrDjYraZrSdGzkE
         V7/T0PubWWgy5BOpTClyuSCDaeN/sVwnexF5WTng6T2MppA0V1PlCDkuCHRDU+9pdPXo
         a6FTvQHPYx4ic6ZMdAgZoJSTU2f1OsV5b4JmzW6YLL2Lwc6SxV9vgWCyoKFTms6Jyvg/
         OghvnkyTk+/1j08ahft/QubfcsaZBUUN5xbJK4GC+TU9+yzAEzzQ3aMODl/trDDB0lBa
         QaWw==
X-Gm-Message-State: AO0yUKWwY82ibKTYlldD/yv+zsyVxVbZxYwesihW4u6gJjG0P8UO/WMm
        hh48wewwGGOxGtD0gFEQww==
X-Google-Smtp-Source: AK7set9i3pcpR00UkNEQS3Uh8VyZQHo+YJjV/Yrf/s71LptmDnJn6po1KLPiFeqH5Dnm4F9xM9ROwg==
X-Received: by 2002:a05:6871:60e:b0:16d:2b42:811a with SMTP id w14-20020a056871060e00b0016d2b42811amr1849530oan.17.1676488609294;
        Wed, 15 Feb 2023 11:16:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec22-20020a0568708c1600b00143824af059sm7361240oab.7.2023.02.15.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:16:48 -0800 (PST)
Received: (nullmailer pid 424169 invoked by uid 1000);
        Wed, 15 Feb 2023 19:16:48 -0000
Date:   Wed, 15 Feb 2023 13:16:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Message-ID: <20230215191648.GA408047-robh@kernel.org>
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
 <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
 <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
 <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
 <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
 <Y+uiaqvdIL4IpRlC@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+uiaqvdIL4IpRlC@sirena.org.uk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:02:02PM +0000, Mark Brown wrote:
> On Tue, Feb 14, 2023 at 03:26:14PM +0100, Alexander Sverdlin wrote:
> > On Tue, 2023-02-14 at 15:11 +0100, Krzysztof Kozlowski wrote:
> 
> > > OK, but then I like the example - if datasheet would use name
> > > "clk_clk_this_is_clk" would you still find it meaningful?
> 
> > > Every clock input in clocks is a clock. There is usually no need to say
> > > that a clock is a clock...
> 
> > I see you point, but this is legacy code (sound/soc/cirrus/ep93xx-i2s.c)
> > which took these names back in platform data times... I also see that
> > rather majority of *i2s*.yaml use something "*clk", so maybe it could
> > be accepted for legacy code?
> 
> Even ignoring the whole legacy thing these are industry standard
> names for the clocks - they are pretty much universally named and
> referred to with the clk suffix.  I can't see what removing it
> would accomplish other than reducing clarity.

Agreed.

If a clock is called "Nclk" then I think that is fine. If it is 
foo_bar_clk, then yes, 'foo_bar' is preferred.

Rob
