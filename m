Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C36927B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjBJUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjBJUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:16:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55237A7F5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:16:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id x10so4488535pgx.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676060205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvG8ud036bG0Ka459g+GKn8ZfnyHhVaXS8x0E5NDNX0=;
        b=LM0SABIxTnYfDjC0tb3g9hN4ycdijLB8RtQ6CjWZ5PVJHtpPxh1QGSJ2/Wd8FD2cLX
         EjDYVFmPj4YuaLm+eeJe9LxIj2ufXmZ7IB5IMq+rCBUNc9LdFM3HvC0djcxvLnxP6nWk
         W8315heKNcI1lFTPtPtn6CLu24giSOk5SqWXqBM3gE+RmtfHZrO+TGhZgb+vuF6fSl9p
         ZML1CzR8MQvnOJ8E8AZI+orFi7J7UzAldjlgeeuRbBj2TAxBM8Rnoc/kObb9Y55q0/hS
         1TxjLnpy6+uvS0g+VymBXMiSI4sDTXUB/UZ20kEwDk3H9epF5rA5bvz2D1Y9t7KAEGe3
         lnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676060205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvG8ud036bG0Ka459g+GKn8ZfnyHhVaXS8x0E5NDNX0=;
        b=DfsYtU0bIjIJwa0CLdiODIj0LtxwK1sm05D+G1C4zl+ZdjCI/fJAOdmDWvywfelfo8
         M1cjhWTNyDiW+9161IWCv1U1hFOPiAbmRtpWAPorQWiPEWBu98ilOpOBTAlF20ir6uLE
         pL2QSYhrM7XDsOJ4NKM5oaMEGxT97ugwQPFisC4HmlPQLNBUqx4qOe59xLzELzwVwz2d
         VIvxwDq4j/MrmE7qOvQp3Xm/3B6MskwAjg+4pUsk11JnvxlPSZYeAwvjyjcgHUwWowHC
         c681NpCeBrjmiRGlJ5QUMeV5ylC2oSWIguCIjnJABfLniYToA3+tO0+jeCEruJoX7PzP
         4AQQ==
X-Gm-Message-State: AO0yUKUdYtkVtlReUhbbIURR2ySHCLJj5ku0etvImrjLttQQJJ8rRgXg
        RHpDGLqp05jKxkx1aMOIx2C0nU1SdO7H5cnP9rZQHw==
X-Google-Smtp-Source: AK7set/0b8F/MfV9JCwQ1S3R3HgjZhxcQHwcE6oll9s5wRLKhHO+9p9yqwo1eqDd9nV0YxytHo7Bl1tjeC9dKMjcXUs=
X-Received: by 2002:a62:8489:0:b0:5a8:4dea:7015 with SMTP id
 k131-20020a628489000000b005a84dea7015mr1901634pfd.36.1676060204745; Fri, 10
 Feb 2023 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <202302101520071730986@zte.com.cn> <Y+Yqhy3zWWOGQLSS@e120937-lin>
In-Reply-To: <Y+Yqhy3zWWOGQLSS@e120937-lin>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Feb 2023 12:16:08 -0800
Message-ID: <CAGETcx_UHptYJXyTG31QckS=kCDjSwCJTLUyq0vh0KaPzyT-rQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: remove duplicate include header
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     ye.xingchen@zte.com.cn, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 3:29 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Fri, Feb 10, 2023 at 03:20:07PM +0800, ye.xingchen@zte.com.cn wrote:
> > From: Ye Xingchen <ye.xingchen@zte.com.cn>
> >
> > linux/of.h is included more than once.
> >
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/firmware/arm_scmi/bus.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 73140b854b31..b2d242178fbc 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/device.h>
> > -#include <linux/of.h>
> >
>
> Hi Ye,
>
> thanks for this.
>
> Looking at next-20230210 it seem like the linux/of.h include that you
> removed was added by:
>
> commit 96da4a99ce507bb98e2ba77018a2f91999c8c12b
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Mon Feb 6 17:42:03 2023 -0800
>
>     firmware: arm_scmi: Set fwnode for the scmi_device
>
> ...AND indeed there was already a linux/of.h include added by a preceding
> commit by myself
>
> commit d3cd7c525fd2ecce3a6c963f314969a54783d211
> Author: Cristian Marussi <cristian.marussi@arm.com>
> Date:   Thu Dec 22 18:50:45 2022 +0000
>
>     firmware: arm_scmi: Refactor protocol device creation
>
> ...BUT they both hit next- together so the clash.
>
> My series is queued for the next merge window on soc/, not sure about the
> state of Saravana series, but if that series will be queued too for v6.3
> we'll need to pick up your fix indeed, Ye.

AFAIU, my series is queued up for 6.3.

-Saravana
