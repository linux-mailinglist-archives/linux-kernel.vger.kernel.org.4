Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC13620AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiKHIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:10:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1422BDF92;
        Tue,  8 Nov 2022 00:10:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so19608299wrt.12;
        Tue, 08 Nov 2022 00:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4QtVwIE3iZ0eHUBerHEnwY8Oj652LtFgZcRYLE4Yt4=;
        b=DkgSIIBu+pZGOaqX8BayQHmLJe8c/9VaQWRuMrnAyGSf4M4P1Ut5+8SUUcU9m9I7zb
         zuP/tqO/wSuU3QlJrg0wtSqMtZMDKNpURwmCwLIBEwm/yj6LjGUdPeh4aNhFE00IkKkj
         be6mIbgXgLyF09oyq76hHVG/XfxG3rPOvTyRaNG6LcUJlgl6QxRKCyMflID9josFKbCZ
         pBgNd4pujg5xyUvyZjC+dvnbWmEOrqbP6dI7Jz4kqApMpJNVk74kncPP5tiz0AOSCqR8
         FjaJeNxg80RGj977KQbeXdarNhLnDEBAgBs6ZcAh02fckQT8/GhiEXsscSGhcIul6C0o
         jHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4QtVwIE3iZ0eHUBerHEnwY8Oj652LtFgZcRYLE4Yt4=;
        b=cO+gk6T0Q8R5/ZFUO+JM9MRE73LkxssV8F8w5Vv45gs3nbQYdtDkim6xn8gyoc/eS6
         Jvdx2HhN/z86zgKMSmQFuUAUSQV2US5mIEdnnh8vimHUNLL9OlysjkWLf6/dz83AirP6
         JEDsCRAyCITxxJvRhd0RxMpZNsDB12vHRGyCfcEPDeEZooePY1JT9cg51Y6N550kSNSf
         FR2WhYVXmOnWMg+9tRGxDuzXMQvYwyzc1FyfF7UMYuEJj+J0Z9nvj6R4L4ZcGyBRL44y
         BPg4JHuh30MAeuXyeLSt2ZtUmDNTH85fHbf2UL2BP0x3hRSZeYvehcH5tdkuvBJEA/s8
         fjRg==
X-Gm-Message-State: ACrzQf13M2mVGGf/gBpT16MVAIebUw2KDT+hrY5iFy9BEAlN+jZ57LsW
        uGrzECBDbUkIidSej/vdeeE=
X-Google-Smtp-Source: AMsMyM4kUvDPIy5Y848LkhbCiK8D3HDVHquXnAcIQWaFpwuBVc2yEvuVjN5j8IAtFHnVw1tRkghoLg==
X-Received: by 2002:a5d:5c0f:0:b0:236:c429:361a with SMTP id cc15-20020a5d5c0f000000b00236c429361amr30800977wrb.475.1667895024558;
        Tue, 08 Nov 2022 00:10:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b0023662245d3csm9451993wru.95.2022.11.08.00.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:10:24 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:10:21 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Deepak R Varma <drv@mailo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: patches for staging:media drivers
Message-ID: <Y2oO7fU4whKr+3hb@kadam>
References: <Y2eSCZJNWn6DzCUu@qemulion>
 <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:29:30PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 06/11/2022 11:52, Deepak R Varma wrote:
> > Greetings to all.
> > My name is Deepak R Varma and I was part of the recent Outreachy internship
> > round. I learned during this program that patches for the media drivers were
> > prohibited to be included in the Outreachy effort due to lack of bandwidth for
> > the maintainers to respond on those.
> > 
> > The Outreachy round is now over but I am continuing to work on code improvement
> > and changes. I would like to know if it is okay for me to now identify
> > opportunities in the media drivers and send patch proposal for your kind
> > consideration. I intend to send couple of Coccinelle identified code
> > improvements as patches.
> > 
> > Please let me know.
> 
> I won't say no but since the media maintainers will need to apply them,
> the problem is the same.

Yeah.  Me either.  Those rules are for Outreachy so they don't apply to
anyone else, but at the same time no one is going to Ack your patches
without seeing them and especially for a subsystem they don't maintain.

I always try to think about if maintainers will want my patches.  Like
I sometimes see people returning -1 instead of -ENOMEM but, you know,
unless it reaches user space it's not technically a bug.  You can't go
around fixing everyone's bad taste.  But everyone likes bug fixes.

regards,
dan carpenter

