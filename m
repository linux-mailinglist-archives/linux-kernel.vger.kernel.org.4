Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8683738B50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjFUQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjFUQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:32:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C81BFF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:32:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77de67139ccso277088139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687365131; x=1689957131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7pFl36cnLq4fFT5cdeGMvVdtf+qKMYcr21cnnh8m+Q=;
        b=TyG9oIfW7IowrwGtJwtyFqIpihC6xEfN+bZafKvwPBDjH56sxuBPjtmrALTXUFSTmZ
         +Q3Cz+AxcPCSzurTncGwWC0WReIwES0yfNbiUwIt+7Ek12IATNaEYVaUykVfPBSrqkGl
         iSyW6GRyRNadsSeNHyvDKhdWtmoyG3bxKBERo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365131; x=1689957131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7pFl36cnLq4fFT5cdeGMvVdtf+qKMYcr21cnnh8m+Q=;
        b=BzC0eoE/Rmv1wRR2474rmZvwkV5AA1GhQyghbSqEocB+pwsFh+VewfS9flbb50gskN
         4RnEPFuVGnWyMCSQkUaQKdQVyTOQ2GZb7cdmczN9NrHXdF3/t70mMw+dMGrOibwu2PfD
         b0ngJLFSLMbsINRsrUH9xjKgAn6HNZWOkmR47K8MNRaehNnRwN2UFvE9fPa/muPIo0Ta
         pgaDSunZe2tw6USqJJwH2TbbdMvDP0x8KxkZQxoqq36qfWg+N9o4iLid3uE3IJkQI86G
         bjWjpB4ihQxUV9cG21gAoII48zxUsEenECjJohREMGcr2dOCk/BnooFDjssY1Psxnjmc
         1mtw==
X-Gm-Message-State: AC+VfDyWvDjydgWyCmXwFVimwc8NbMuOQf5YyJZHQO0LmDOUzj2X5wQg
        J9sVpPfwpLcw0asVYIKIaBLU0Q==
X-Google-Smtp-Source: ACHHUZ6vAbdVHdaVsHMCYz48nxDtgsSVMt46K8W12QUi/Yzyo17zqkMtUwhasa5qPqJ9ZXfIRXIkpg==
X-Received: by 2002:a05:6602:38e:b0:77e:3267:ca96 with SMTP id f14-20020a056602038e00b0077e3267ca96mr10533653iov.4.1687365131158;
        Wed, 21 Jun 2023 09:32:11 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id n3-20020a02a903000000b0040f91a65669sm1465572jam.21.2023.06.21.09.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:32:10 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:32:10 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <ZJMmCrrEkz4E9Dog@google.com>
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
 <20230620-hx3-v3-1-2acbc03ca949@skidata.com>
 <2023062102-booth-glorify-2b09@gregkh>
 <CAJpcXm6fRsonH+ZsA7YTpJGBW348r4ZCVSc1XGyhwajqTnn-Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJpcXm6fRsonH+ZsA7YTpJGBW348r4ZCVSc1XGyhwajqTnn-Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 06:22:41PM +0200, Benjamin Bara wrote:
> On Wed, 21 Jun 2023 at 18:07, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 21, 2023 at 05:58:30PM +0200, Benjamin Bara wrote:
> > > From: Benjamin Bara <benjamin.bara@skidata.com>
> > >
> > > As some of the onboard hubs require multiple power supplies, provide the
> > > environment to support them.
> > >
> > > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > > ---
> > > v3:
> > > - fix nits mentioned in v2
> > >
> > > v2:
> > > - replace (err != 0) with (err)
> > > ---
> > >  drivers/usb/misc/onboard_usb_hub.c | 39 ++++++++++++++++++++++++++++++--------
> > >  drivers/usb/misc/onboard_usb_hub.h |  1 +
> > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > > index 12fc6eb67c3b..a56e712d3a45 100644
> > > --- a/drivers/usb/misc/onboard_usb_hub.c
> > > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > > @@ -27,6 +27,13 @@
> > >
> > >  #include "onboard_usb_hub.h"
> > >
> > > +#define MAX_SUPPLIES 2
> >
> > Why 2?
> 
> I picked 2 because with 3/3, this is the maximum of "required" supplies. The
> currently implemented ones require only one (up to now just named "vdd"). The
> new one added in 3/3 requires 2, therefore I tried to be generic if some future
> hub might require 3 or more.
> 
> > > +
> > > +static const char * const supply_names[] = {
> > > +     "vdd",
> > > +     "vdd2",
> > > +};
> >
> > Do those names have anything to do with the number above?  If so, please
> > document it!
> 
> I picked "vdd" for the first to be compatible with the existing device-trees. As
> the actual names differ between hubs, I thought it might be generic to just use
> "vdd2" here. If I should add some comment like "if you increase MAX_SUPPLIES,
> please also add a supply_name below", I can do that. I could also implement
> "vdd${i+1}" for i>0 instead.
> 
> >
> > >  struct onboard_hub_pdata {
> > >       unsigned long reset_us;         /* reset pulse width in us */
> > > +     unsigned int num_supplies;      /* number of supplies: 0 considered as 1 */
> >
> > I can not understand that comment at all :(
> 
> This should just indicate that leaving the field empty means one supply is
> required. Maybe "defaults to 1" is better?

Whatever the comment, I suggest to put it in parentheses, rather than after a
colon. If you keep the current style maybe s/considered/is interpreted/.

Another option would be to initialize all existing hubs to num_supplies = 1,
then there is no need for a comment and the check in _probe(). That might
be the clearest thing to do, even though it adds a few extra lines.
