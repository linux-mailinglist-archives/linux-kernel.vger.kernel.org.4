Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C60635A81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiKWKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiKWKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:49:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6915F2A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:35:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b8so13448978edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdk6ayM1Ct66O9yHo4VxrA9gKbs+xznnUkFGTJiMlC0=;
        b=ixd/SW/4mbmK6Eq8U/7u9FDripN0Ee0KDzFNOLNcZkTXpLexIRwydzZqRg+uK2N2Ru
         Dcdxr5iVaE74MXUhXzk1nNzoxluSpStPsJ/g5j/xJskSFfxW5u2r9voPSKtL08AendVN
         3nlEF2kGhoNuamYFmkMBRY1/o/FaI4tEX6WcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fdk6ayM1Ct66O9yHo4VxrA9gKbs+xznnUkFGTJiMlC0=;
        b=u9AthH4LXYPgfmyetsBOapDZkLwkrjAA9FtJcTNp4O5XcIUsWAMnb4f0YoWxVPnHF4
         869y2u81AsLzd7O/3ejE6IIBHIksnty6CfApCdvU2vCLcpL1ysy0dWycfwUOY9XQ7ixh
         m/CMJYmbwFqP+lcX4ctfeO/sl6Tq4LLmE2mhFFrJ0GqZ7ranEHDrBNbjgOZYMHRdDkk+
         qK9eMFITd1bCMVjvudbe/XnhQ3AMMn7L/+S0EVU4QsbdAkoNGGm1C9xAj+B5j02awsFa
         QSHD4ldAfixk9rgNMQ0p0FcpkIOTXI55kHLoBAQ4ejYH/IF1VXfUbjlqkheOVn0F08Q8
         VX8Q==
X-Gm-Message-State: ANoB5pnMgTTeYsTpqU0TMqlZCeFDD0aLIMy/E1Uc5uwRNCJNJ6oYETka
        llya9LeuvqgEsyXOA1Fquxtadg==
X-Google-Smtp-Source: AA0mqf74EvznZPyWVMWqJcVg8W8zFDmrOicPF2lAdmAcsc0cuX+YS8xaKiCmanEDyWJxlD9Befz3bw==
X-Received: by 2002:a05:6402:291b:b0:461:60b1:5c6d with SMTP id ee27-20020a056402291b00b0046160b15c6dmr13199766edb.182.1669199720603;
        Wed, 23 Nov 2022 02:35:20 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-55-94.cust.vodafonedsl.it. [188.217.55.94])
        by smtp.gmail.com with ESMTPSA id e12-20020a1709062c0c00b0073d7b876621sm7043433ejh.205.2022.11.23.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:35:19 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:35:17 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
Message-ID: <20221123103517.GA2874916@tom-ThinkPad-T14s-Gen-2i>
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i>
 <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gaert,

On Wed, Nov 23, 2022 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
> <tommaso.merciai@amarulasolutions.com> wrote:
> > On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > > By moving support for the USB Syntek DC1125 Camera to staging, the
> > > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> > >
> > > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> >
> > Patch itself looks good but we have some style issue. Applying this
> > patch I got the following warning from checkpatchl:
> >
> > WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> > #10:
> >
> > You have to pass only the first 12 chars of the sha1 commit into Fixes
> > msg:
> >
> > Use:
> >
> >  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
> >
> > Instead of:
> >
> >  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> 
> I always use 16 chars, to avoid these becoming ambiguous in a few years.
> 
> Gr{oetje,eeting}s,

Thanks for sharing this info.

Regards,
Tommaso

> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
