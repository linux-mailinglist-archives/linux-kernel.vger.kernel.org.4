Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24E75E5FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIVKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIVKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:19:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A31DCCE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:19:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so3587248wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ju6BSMep2KJyGnXzsed5+vjZslhWJvx3S4Wq5/v4xCw=;
        b=SUzZ8/4LQ4z00agprzqQeqMQLmjUXi2wsNvMkS8ormVPl6wY8bqlkFmPrSOEZLelmN
         Qz7hfA5Me6aZW1tPo3cjvgDzPdn94oBcjCv3CCyOO8iVWqve6ksrMFi4slrgPXRK+1PZ
         +u3ITed68JlvQLhmeUkCjPh4qYLfkzNsyk8BZyWNo6qii9435XtirTue6McBo9COeZTe
         XAG1B0zphCcLCRCXNmFUYjWKppoQ3zdqPcXpnd3etpE8iY3PzVE1lGn7m0xRAox5B1rj
         zOep1puhY+R4piUYjcxzwW9UeyQqtnbtu4U6+scj0oED1JQk4uofgsAggHeNDVcV3l9d
         Dohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ju6BSMep2KJyGnXzsed5+vjZslhWJvx3S4Wq5/v4xCw=;
        b=DAQS/aLpH8NdyR4EEVIh/CoWzn5B5uwooQiVc36cjchP51qoCJ4wUpvKWARuasra6n
         +7/OHNBwgVmpiNS2H/Qz4N7n5YKIVU2Z8p3lbmMxY/6fvA6kdoRV/expJgg74zkeIub3
         x7YWbEOStcIjQ56EYJYk4jIM25bqR+UK3kIfwR7ZNJfQ4x96JqgT2UXQzlrFOZbtOX8k
         PykO7OitYMlTqOViQt1f0lYeZhkH3MHxKnQqnRDuDAqyrRcj4GbQJHIEG8Di6zeiWlVp
         ieXvl/VBeloTm1B1ixpQHqjrzkVVIF6SjqEF+kIy3tbZGIhQLgX08dFp5Hh4o4WA51o7
         9Esw==
X-Gm-Message-State: ACrzQf02sPDoDa54w2V2DGAvdSa0sj1JcLavOxqidaHup+tVOJdYSJhX
        P8Va40Oa7SL2BkC57mXJf+12Zw==
X-Google-Smtp-Source: AMsMyM4OscS0C1jykeo4QICxF2cHBCMYygPB7nFReh7fcMsWjdX9Dluta8CohpeAWrA95czQeAow/w==
X-Received: by 2002:a05:600c:42d4:b0:3b3:3de1:7564 with SMTP id j20-20020a05600c42d400b003b33de17564mr1831131wme.152.1663841950631;
        Thu, 22 Sep 2022 03:19:10 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003b47575d304sm6500817wml.32.2022.09.22.03.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:19:10 -0700 (PDT)
Date:   Thu, 22 Sep 2022 11:19:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
Message-ID: <Yyw2nAAjN6NxmS09@google.com>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
 <20211008031953.339461-3-zhang.lyra@gmail.com>
 <YY5wPh0rwRvFjSRG@sirena.org.uk>
 <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, Chunyan Zhang wrote:

> Hi Mark,
> 
> Sorry for the late response.
> [1] is the v1 on which we had some discussion. I hope that can help
> recall the issue below.
> 
> On Fri, 12 Nov 2021 at 21:46, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Oct 08, 2021 at 11:19:53AM +0800, Chunyan Zhang wrote:
> >
> > > +properties:
> > > +  compatible:
> > > +    const: sprd,sc2730-regulator
> >
> > I still don't understand why this MFD subfunction for a specific device
> > is a separate binding with a separate compatible string, the issues I
> > mentioned previously with this just encoding current Linux internals
> > into the DT rather than describing the device still apply.
> 
> I understand your point. But like I described previously [1], if we
> still use the current solution (i.e. use devm_of_platform_populate()
> to register MFD subdevices), a compatible string is required. I'm open
> to switching to other solutions, do you have some suggestions?

Many IPs encompassing multiple functions are described that way in
DT.  I don't have the details for *this* device to hand, so my
comments here aren't specific to this use-case, but describing each
function individually does describe the H/W accurately, which is all
DT calls for.

Can you imagine describing an SoC, which can be considered as a huge
MFD, with only a single node?

Does the regulator functionality have it's own bank of registers?

-- 
DEPRECATED: Please use lee@kernel.org
