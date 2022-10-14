Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F15FE859
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiJNFNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNFNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:13:05 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE3194FA2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:13:03 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t186so4380415yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMCPnT3v2PBlDPmAGk/RgTs26GIDgj01lKP1JfEInTg=;
        b=ezC0WBj9HReRFd76bOLSCH4C0zFVvbob1oRsgEEfZCwQY4vPwe5vJPv2j+euzodocT
         CzD7jCDSwBNt+T1cQdA9bueA4cHasIPqp6jdx7MipLykfVHh7nQuPM3wTc66C1rbuvlS
         +KxPpVWuVbg0WZ578nRS/GO0qitGCq07KtMy48R1UXwghe9El47hnaFs9pslpnM4uOA4
         B0WiA1dJ1/SYZK+J7wPZY1zE+fQCJWlmijOEU0lxWmFZ84MhpWfNdZdudiWpkssQNg29
         Le0NDB34FXYqO/HH0jt6hle1wQkeTg2IDIeYMriHJ+U7zSYjg72j+/3eumje6+cW6RWR
         xSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMCPnT3v2PBlDPmAGk/RgTs26GIDgj01lKP1JfEInTg=;
        b=aQQML5VDrDdw+PfskExqmVdLkvnta13ceqZrAlD9e8aDMszcZOXqufr5aSnF6TX8G3
         WCcGuEsc5GRDIHq1LCk7JN5YFYVQ82DEdVfhEgy2FWmQ4uVjsWTTZomXMlTP+3nOxj1T
         zPYKlsjXpGQ+dkoogwB6O7U0kmS0VR5BzMmnpnTcvT8wFYy5zo1NeplErq2DwXWr5Wtz
         ETrQ479ucWZWY/sqJETusiGP46ArjdLSuN9N9vwtk2ONlkDlMT/GaxgV7zyUdcmj0RBC
         uUkhBAGhJqC7WnTW5pYbiBQyEGXsXwO8MvanaSfcCO9MzmkOjhyUYtq56mBFCIgZaD3Q
         P5VA==
X-Gm-Message-State: ACrzQf1iIWVSxHA9WPtEkFORAtIr8UMq77rkbt9jXej3xbbUKF0nYkv1
        Ukky4UMA9SMzPXGF4GOuvVnhmPjYjjIJOqWgOEk2Vn6C55E=
X-Google-Smtp-Source: AMsMyM6W/RmxEI4ALl6zh9mmrd29vhQjRQSZcs/+Y08C60vWPMg1dr9tzS12K0hLu3drMqigPqp55xIQHo+V5GpQuG0=
X-Received: by 2002:a05:6902:10a:b0:6af:b884:840e with SMTP id
 o10-20020a056902010a00b006afb884840emr3184698ybh.330.1665724382854; Thu, 13
 Oct 2022 22:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221014004150.2470359-1-jcmvbkbc@gmail.com> <mhng-60ebc2fe-ff0c-4ad1-a24b-7f5368345b1a@palmer-ri-x1c9a>
In-Reply-To: <mhng-60ebc2fe-ff0c-4ad1-a24b-7f5368345b1a@palmer-ri-x1c9a>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 13 Oct 2022 22:12:51 -0700
Message-ID: <CAMo8BfJegAEo+bmJThD00jNYizpDamQ-XZMNuse7vvFFAbN2jg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the 'T:' entry for xtensa
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-xtensa@linux-xtensa.org, chris@zankel.net,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 8:51 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Thu, 13 Oct 2022 17:41:50 PDT (-0700), jcmvbkbc@gmail.com wrote:
> > All development activity for xtensa architecture have been routed
> > through the github.com/jcmvbkbc/linux-xtensa tree for the last few
> > years. Update the 'T:' entry in the MAINTAINERS file to reflect that.
> >
> > Github deprecated the git:// links about a year ago, so let's move to
> > the https:// URLs instead.
> >
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 72b9654f764c..98cf4476d135 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20097,7 +20097,7 @@ M:    Chris Zankel <chris@zankel.net>
> >  M:   Max Filippov <jcmvbkbc@gmail.com>
> >  L:   linux-xtensa@linux-xtensa.org
> >  S:   Maintained
> > -T:   git git://github.com/czankel/xtensa-linux.git
> > +T:   git https://github.com/jcmvbkbc/linux-xtensa.git
> >  F:   arch/xtensa/
> >  F:   drivers/irqchip/irq-xtensa-*
>
> I'm assuming this means you're taking it through your tree?

That's correct, I've applied this patch to my xtensa tree.

-- 
Thanks.
-- Max
