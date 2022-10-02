Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFC5F2312
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJBM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJBM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:28:47 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCE275E5;
        Sun,  2 Oct 2022 05:28:46 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkv1q4tdsdyy1rk42mgbt-3.rev.dnainternet.fi [IPv6:2001:14ba:446a:dc40:6f18:157:2316:5143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 5964B20153;
        Sun,  2 Oct 2022 15:28:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1664713724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdEGfEX5D6fEiBO00y0GCZcmskA0l5KIE7Y9ti+khrY=;
        b=N9cUc1Y36ToMufTqa1N+fSNPa0Ydn6agkB/HKJ+/DJcH6Y5P9Ep9gH5M9aWjZROMGnKUHp
        +VcbYHkboA3qhO/KkER0Em3K60zV/nfo0KcRlZZE2D/PXyMUd/iqV0gQu4MYp/CaXbY+nJ
        il7YYh3RqXGhIubVWEsdjDFAlOMs0lk=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id DA26E634CBE;
        Sun,  2 Oct 2022 15:28:43 +0300 (EEST)
Date:   Sun, 2 Oct 2022 15:28:43 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shravan.Chippa@microchip.com
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        Prakash.Battu@microchip.com
Subject: Re: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Message-ID: <YzmD+yNv0Ryj/8IC@valkosipuli.retiisi.eu>
References: <20220920051023.12330-1-shravan.chippa@microchip.com>
 <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
 <PH0PR11MB56118BCE8F6B5E045485A71C81529@PH0PR11MB5611.namprd11.prod.outlook.com>
 <YzHYi2FQN1R+Ge4w@valkosipuli.retiisi.eu>
 <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1664713724; a=rsa-sha256; cv=none;
        b=aae/7IYtlXfoquFZlGONHeHt0KhdGzWJ2Jn21P9kaiyM0p+oW8XA7gBf/kqPb0pOoetlcd
        L9dUh5TB96q+lXf7FrYr0nF0b0Y/o2jw7UN0GwLjlFdok1b4ZNCY5BapcggagLbSO1X91B
        lvfjhgEMLZS+4+fTAd0slWMsfkxiYRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1664713724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdEGfEX5D6fEiBO00y0GCZcmskA0l5KIE7Y9ti+khrY=;
        b=fvMkF08VF5x1/jUhxGTdKM7WWWx6f6R2247MBXbyB+nUho99WOmED1TivK66IUPX8B08Dn
        /4cWeS53SCjYkYGDCAEMnAe92Qj95zJoWcodT9Esmju812MHh28YFsh8v+7hJ7ZdWHMeZx
        Eij0m8aaWgADasXCcSSD3WMipW7AxB0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 08:51:46AM +0000, Shravan.Chippa@microchip.com wrote:
> > > > > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > > > > +             return imx334_write_regs(imx334,
> > > > > + raw12_framefmt_regs,
> > > > > +
> > > > > + ARRAY_SIZE(raw12_framefmt_regs));
> > > >
> > > > I think you'll also need changes to the pixel clock calculation.
> > > >
> > > In this driver pixel clock read only variable.
> > > Pixel clock change maybe in different series.
> > 
> > Please address it in this patch.
> > 
> > Is the link frequency affected by this patch as well?
> 
> I will try to modify my patch with the default link frequency available in the driver

Also check the frequencies the driver enables will be available in
link-frequencies.

-- 
Sakari Ailus
