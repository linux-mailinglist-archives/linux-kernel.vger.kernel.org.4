Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D6605C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJTKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJTKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:35:42 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED024B0C4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666262125; bh=VhN67bXT0itmKjXgVI45C2R1vHjRepe0Kb9Pi+xEtqQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Mif79EZLoeznCgQ0lXr1SVfFtqssM1xVfL4aplIsnm4ziVIdnBoNLWftuGLRblNYM
         HdWWBqOwgbaTp2FuEKMosZoSLhCbuI+wuN4fZVkItD3jJia/O/w7bVBzKW3weDHdXo
         xEWbdQVqJqxmVpArES10HSImc1NEvooCN9MGDUpM=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 12:35:25 +0200 (CEST)
X-EA-Auth: 3fqsQwinURa5yNBDG3ytptSeV5h8uXROphmeEhi6S4t+vud9l8NgbbMmBkXc5IAaXX1mjKyMlnqBLwgLXF2aLKXcNYG6g8YK
Date:   Thu, 20 Oct 2022 16:05:19 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v3 06/10] staging: r8188eu: Add space between function &
 macro parameters
Message-ID: <Y1EkZ7+1yiH8PI0a@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666249715.git.drv@mailo.com>
 <79e0aa96b1c8b2bc0c0f8ef9e651ab254629c7a8.1666249716.git.drv@mailo.com>
 <114d7521-a15-9569-cb38-69f4bb8990f7@inria.fr>
 <Y1EcmphZyExVVttR@debian-BULLSEYE-live-builder-AMD64>
 <8e7c457c-a58a-9c2a-ba0-d520c5e0f53e@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7c457c-a58a-9c2a-ba0-d520c5e0f53e@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:21:35PM +0200, Julia Lawall wrote:
> > > > -#define PlatformEFIOWrite1Byte(_a,_b,_c)		\
> > > > -	rtw_write8(_a,_b,_c)
> > > > -#define PlatformEFIOWrite2Byte(_a,_b,_c)		\
> > > > -	rtw_write16(_a,_b,_c)
> > > > -#define PlatformEFIOWrite4Byte(_a,_b,_c)		\
> > > > -	rtw_write32(_a,_b,_c)
> > > > -
> > > > -#define PlatformEFIORead1Byte(_a,_b)		\
> > > > -		rtw_read8(_a,_b)
> > > > -#define PlatformEFIORead2Byte(_a,_b)		\
> > > > -		rtw_read16(_a,_b)
> > > > -#define PlatformEFIORead4Byte(_a,_b)		\
> > > > -		rtw_read32(_a,_b)
> > > > +#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
> > > > +	rtw_write8(_a, _b, _c)
> > > > +#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
> > > > +	rtw_write16(_a, _b, _c)
> > > > +#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
> > > > +	rtw_write32(_a, _b, _c)
> > > > +
> > > > +#define PlatformEFIORead1Byte(_a, _b)		\
> > > > +		rtw_read8(_a, _b)
> > > > +#define PlatformEFIORead2Byte(_a, _b)		\
> > > > +		rtw_read16(_a, _b)
> > > > +#define PlatformEFIORead4Byte(_a, _b)		\
> > > > +		rtw_read32(_a, _b)
> > >
> > > Could these be inline functions?
> >
> > I am actually not seeing these macros being used anywhere. These macros were
> > added recently [commit ID: 7884fc0a1473c2721f496f1d1ddc9d2c91aefa53] in 2021. I
> > am unsure if they are intended to be used in the future or can removed entirely.
> >
> > Making these inline functions can be done, however, will we need to measure
> > performance impact? I will need help and time for this evaluation.
>
> Inline functions shouldn't have any performance impact.  For these simple
> things the compiler should inline them.

Understood. For these simple cases, it should not.
>
> The reason why a macro may be needed is if it is not possible to find a
> single type for all of the possible argument values, or if some argument
> values are assigned to by the macro definition, and not just read.

Okay. This is helpful. Thank you.

>
> I would have suggested to look at all of the uses to see if there are any
> concerns like this, but if there aren't any uses, that won't be possible.
> There seems to be no special knowledge in these macros that is worth
> preserving, so I think that they can just be dropped.

Sounds good. I will drop them in the revision.

Thank you Julia.
./drv

>
> julia
>


