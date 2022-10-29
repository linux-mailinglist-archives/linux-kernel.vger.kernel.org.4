Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D706124DA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ2SNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:13:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC423156;
        Sat, 29 Oct 2022 11:13:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so5620854wma.3;
        Sat, 29 Oct 2022 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDxO2pKvT3MS7KSv5X7lg9vi1ecnoaB+3SxtNFM477k=;
        b=ExgcMbiKmgJavYnBYUqphuJGb5VETIz2vRLZCZyRJ/p1K71m+apneLA7LQtskXEoil
         FXU23Wx1omcTPnZ/x+MYntBhs1ICzmHDHhuzjCkZQmeAeZb4A3VxF7wVOpcuIx50GJ8p
         ZJ18/wKiWsy1u3iHtbMplh+wZox5gB+IrPTyAJJYsZ2dSbpLO5uBwIFonVwctIWMYg3y
         WVIG/pS3YZPsdbkQZzdJdDHRUmuXIJz7vPk/2wcC003c4NHCIRS+JBwEtNEZetQNgIHr
         N+U98cQ1qB14v/osnnm/+nFGiY/UEwXUoeMwI5Oilsx8x901lAawyGtweCI/pvuZn2PK
         rJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDxO2pKvT3MS7KSv5X7lg9vi1ecnoaB+3SxtNFM477k=;
        b=F7sTEP6sTzs8BHkT9rf4W7uUSbsEKPqNYtfetxtHuLNNj/ACpeDXBNzgv+ACBab2VQ
         he0kdJrl0+c79yzlGoFA1Yfar15t+X9dwSQ8NiXOEgh5B2gUIJPWuUhEEhNPihTch5T5
         54pGetOh0Ha0Ksg4Q+BgKWumpFfmq1t80mG6E/yEn0lH8qYzbu/AQMKQ/jYd9+7KE4WR
         JidTUsrogz12cawVfKSUAvpLwuymQktz81h6GWXoJ3P514tzanLKdgrypOyQ2650FCmn
         vDBO4VXeKQnzwxGirbsIoTDMNO66YSqhg0z6KD3huDTer1tp6YY47QvfGVQyquzxg+K4
         sEMg==
X-Gm-Message-State: ACrzQf249GsTo20xGKpZTI/zzvBDL8uvo5d+oyogHqRYS1/ZQmZ+AUmX
        G8zZrtupOgBihJ+707gcIDY=
X-Google-Smtp-Source: AMsMyM7w6VKyKCNXDJ/GIHrfDJ7B1rro3BXI5f92u4GLjY3/8Ts3bc3wRCSKkTUzpds3ESpxPXBigw==
X-Received: by 2002:a05:600c:6008:b0:3c6:c3fa:c173 with SMTP id az8-20020a05600c600800b003c6c3fac173mr3210012wmb.190.1667067225065;
        Sat, 29 Oct 2022 11:13:45 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003c6deb5c1edsm2407563wme.45.2022.10.29.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:13:44 -0700 (PDT)
Date:   Sat, 29 Oct 2022 20:13:43 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Mia Kanashi <chad@redpilled.dev>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
Message-ID: <20221029181343.GA145588@elementary>
References: <20221029161240.15548-1-jose.exposito89@gmail.com>
 <20221029161240.15548-2-jose.exposito89@gmail.com>
 <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Oct 29, 2022 at 08:34:46PM +0300, Mia Kanashi wrote:
> On 29 October 2022 19:12:39 EEST, "José Expósito" <jose.exposito89@gmail.com> wrote:
> >The XP-PEN Deco LW drawing tablet can be connected by USB cable or using
> >a USB Bluetooth dongle. When it is connected using the dongle, there
> >might be a small delay until the tablet is paired with the dongle.
> >
> >Fetching the device battery during this delay results in random battery
> >percentage values.
> >
> >Add a quirk to avoid actively querying the battery percentage and wait
> >for the device to report it on its own.
> >
> >Reported-by: Mia Kanashi <chad@redpilled.dev>
> >Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> >
> > [...]
> 
> I've tested this patch and now power supply status is correctly set to Unknown and capacity is set to 0 initially.
> 
> Just a note that that issue occured not only with the dongle, but a cable also.
> It seems that tablet just doesn't respond to the query.
> 
> Thank you for the work!

Thanks a lot for testing it, I'm glad it's working :D

Jose
