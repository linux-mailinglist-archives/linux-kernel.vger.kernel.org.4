Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B906C2DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCUJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCUJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:29:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC76E99;
        Tue, 21 Mar 2023 02:29:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so10667978wmb.5;
        Tue, 21 Mar 2023 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679390963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uHph1RCcCMxEyyxylwFED3FpSIUdpvkqwOHRakgeag=;
        b=oXXBPv3kh7GIgeLcExIahE9APHsSHas/UaQrRt9AMuuzuHVakzREsIZQV7qDXuzkwj
         Aut2qvbeW7R6v+BcvX154IEXeCKhnn4h03KF7HJZHiBCJhH3A70Nq62Q1OI9nbQ1veDm
         FQEg6mKS1/Y0K7Yt13u0V7uI5g6HM+kEOWk5Be1vbpTR+YYK33QRHTac/BcPI83/QIPF
         I0atFE5bd9r/l0+WptE0Ofj4xBHBJYsysVQbfVhBJAq//cr0tvoe4HGMUpVxbTbOlNSp
         j/WE2xXV9IkI6yasEvNWbCN/eiyhfBQ0hhECwWtpx/EcjekkgimvwdvK/sRtdvrW5k9K
         kQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uHph1RCcCMxEyyxylwFED3FpSIUdpvkqwOHRakgeag=;
        b=NNDhpcUGNAQvK9HLf6yVKkgUPsylyJ1yINDBi1lujXHEcX4gIfMLeYSIo38IpGWrMC
         NFshIMCBNAimg25AjSCEUmRSBtuqp+5B7Nm8bDLpLqyp6NUBm6X58/7tyCbgg8LbuV40
         SL6kH4AFVCs2UqadFk+eCsGsaOm3a9ZAb33MvFbQjddj9ei7LwIJnM30Mr962/0T6TZd
         2OseQqtK/XGfF0KKHpcyUgvg7DqMyvH320gd/5TByWx5x8quTyeoOST03EyyjyTkdtgA
         2cMYX8Ibhd+fbCPlg9p8cgdtxR40bjv1DQ2+bwAgb+lPXRu/yJBshC8xE/VO6UZNZFaG
         msgA==
X-Gm-Message-State: AO0yUKX9vU+fBIbeAsb23M8bPWGj+ABBw/xgYUtlWVJeTU/YGbubGFdR
        m7uRAjK/U2UAjD7KZeYeB6w=
X-Google-Smtp-Source: AK7set8m8l1KBcrGaQeUuJdX8jUhoE7/xDwDdbfGpIbkxyiTXnYDnff4hqAzIRzWngx85WIaySIVsQ==
X-Received: by 2002:a7b:cbc2:0:b0:3e1:374:8b66 with SMTP id n2-20020a7bcbc2000000b003e103748b66mr1609067wmi.40.1679390962873;
        Tue, 21 Mar 2023 02:29:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b003eb192787bfsm12930779wmk.25.2023.03.21.02.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:29:22 -0700 (PDT)
Date:   Tue, 21 Mar 2023 12:29:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Daniel Palmer <daniel@thingy.jp>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
Message-ID: <b8cdf7dc-9bd9-410b-a637-c63e1becc056@kili.mountain>
References: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
 <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:33:19PM +0900, Daniel Palmer wrote:
> Hi Lukas
> 
> On Tue, 21 Mar 2023 at 12:38, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7
> > SoCs") adds the config MACH_INFINITY and MACH_MERCURY. The MACH_INFINITY
> > config is used in the gpio-msc313 driver, but the MACH_MERCURY config is
> > never used to configure anything in the kernel tree.
> >
> > Remove the unused config MACH_MERCURY.
> 
> Because work is still on going to push that stuff.

Is there a link to the patchset?

> 
> nak from me.

This stuff hasn't been used for years.  We generally don't push dummy
code.  It's super easy to add it back when the time comes.

regards,
dan carpenter

