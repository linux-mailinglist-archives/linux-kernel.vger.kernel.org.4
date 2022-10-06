Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2B5F6863
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiJFNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJFNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:42:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14704ABF1E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:42:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s30so2911065eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Id5u+YwMh8EIQyD6UQ9gBbVQTk4z95mUxG8Ako7JiLU=;
        b=B6IRePY+nYFuAqdFxgcyb61PdJANuXx9HUGsGpgi+Pmszh0jX8m07qNRCvkxVfPmVL
         M2kDeEDe4ch8aaA/RA4RGe2P2aogk7t1DffRMQm9IxjrxU406vv3PYKszf1pGqu6xVKQ
         ExpKaRlmaNNtrQXP0B33HucfdVPBPEDVbnwNF0kVLUc8IzFjwBQLTitIxr5uq+uJsyGe
         qoUot0o8rir3Ga+kDEz0sjCiSZDIDH/gmf1zCYtQVIjwbj7qSfGpc76GeZcGNdOkt9LT
         NUXFyxAKndbUgoVMxYzWeAh0BeIrl8AFfGdxEmlCbTQS9P8qHfOqu5M+cG4B5vzLssJZ
         dyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Id5u+YwMh8EIQyD6UQ9gBbVQTk4z95mUxG8Ako7JiLU=;
        b=n/SjB8kIXs9GLaFqBprRATwwK7v8Yse0YCzWNJaJy9oJejbPN9W8ucLGounrlWD0yh
         KXnbpTk0u87lVXVzltQQNU1JoJ9mrFe5x5AxEa3zlqbkxLY1Gc2bbeMQISXMWIE9Etyo
         a5va/mcLW7FJzbo8EZZCAyDfO8NDXomWp24QqxBb7h7Och81nvSzLT0ws261tYGfEi+/
         FMmGkPMA2LuAOg6jA6X3BORyt+czpuRZHZQbVEkyLvY/5RPNS6n0OeGxhw0pGiRoaqsq
         Tp8Jhcl12duqWL+Q13RtNuFVPfWKCVRnzqGOmromAeuH7sx+36c/NakiP9siymcvaR3Q
         UW5g==
X-Gm-Message-State: ACrzQf0ano/IvwVL689eKg1mICzZa3QnFG74MfL5eNF8yrlj83/TjW9H
        Utlo9a4sMAdDz1YNLRdOKZA=
X-Google-Smtp-Source: AMsMyM6VnORS5wTcEAbXy82G2/5kyncnh1yDOhSBWYlfTwzQYzzcyASPiE6MIoc7Oxr3hxlet3COgw==
X-Received: by 2002:a05:6402:440f:b0:435:2e63:aca9 with SMTP id y15-20020a056402440f00b004352e63aca9mr4590748eda.162.1665063767561;
        Thu, 06 Oct 2022 06:42:47 -0700 (PDT)
Received: from nam-dell (wlan-247051.nbw.tue.nl. [131.155.247.51])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00459d0df08f0sm1620698edh.75.2022.10.06.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:42:47 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:42:30 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Brent Pappas <pappasbrent@knights.ucf.edu>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Message-ID: <20221006134230.GA14040@nam-dell>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
 <20221005235728.GA118549@nam-dell>
 <Yz7WVCzAviUYstX9@knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7WVCzAviUYstX9@knights.ucf.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:21:24AM -0400, Brent Pappas wrote:
> The 10/05/2022 19:57, Nam Cao wrote:
> > On Wed, Oct 05, 2022 at 04:10:44PM +0000, Brent Pappas wrote:
> > > Replace function-like macros "HB" and "LB" with static inline functions
> > > to comply with preferred Linux coding style standards.
> > > 
> > > Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>
> > > ---
> > > diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
> > > index 1d1fe8bff7ee..8a8fbc274b73 100644
> > > --- a/drivers/staging/most/net/net.c
> > > +++ b/drivers/staging/most/net/net.c
> > > @@ -36,8 +36,8 @@
> > >  #define PMS_TELID_MASK         0x0F
> > >  #define PMS_TELID_SHIFT                4
> > >  
> > > -#define HB(value)              ((u8)((u16)(value) >> 8))
> > > -#define LB(value)              ((u8)(value))
> > > +static inline u8 HB(unsigned int value)                { return ((u8)((u16)(value) >> 8)); }
> > > +static inline u8 LB(unsigned int value)                { return ((u8)(value)); }
> > >  
> > >  #define EXTRACT_BIT_SET(bitset_name, value) \
> > >         (((value) >> bitset_name##_SHIFT) & bitset_name##_MASK)
> > 
> > I cannot apply your patch. I think your email client modified some
> > whitespace characters.
> > 
> > Check this for more information:
> > https://nam02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv4.10%2Fprocess%2Femail-clients.html&amp;data=05%7C01%7Cpappasbrent%40knights.ucf.edu%7C3748a695ff1e438ecd0b08daa72d66bf%7C5b16e18278b3412c919668342689eeb7%7C0%7C0%7C638006110693613730%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=rq2pgVr1dqT2k9hC21LXueqMeIcVyk2Qjvjl1KtkhsU%3D&amp;reserved=0
> > 
> > Best regards,
> > Nam
> 
> I have followed your advice Nam and am now using an email cient that
> leaves whitespace intact.
> 
> Should I reply to this post with the corrected diff, or would it
> be better to submit a new patch with it?

It's up to you. Replying sometimes make the conversation messy, but for
this case I think it's fine. Don't forget to add "PATCH v2" prefix and a
change log.

Best regards,
Nam
