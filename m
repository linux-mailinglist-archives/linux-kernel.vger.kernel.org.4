Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFA619D30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKDQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKDQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:26:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA36A31EF6;
        Fri,  4 Nov 2022 09:26:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso1976097wms.4;
        Fri, 04 Nov 2022 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2fhgP41PsL/y3ZYnL/j3Up8uTJqyMHNAuWy+KZ/ETPA=;
        b=UgMuHWFXGSx2QnjrIO8j7TMtMqpbJkh00y2iwVE2YvQsCYsp/3j5pfHti1iNYtK7SE
         1m5fZG6PJjSHFr4Uocgnj/aw0qy+V/P1Q/IEqwR2j/Dzy7lqQfNyLtEX+pzdUCEoBauM
         6byUjX2RQZHeu17JpxomH8DvxU1KoLOmwfVomGSiylX2zL6QFctBctfkN7zQjYwC+O2M
         H4emA7akCk44OrMblohWs+BIm2SPPDxMNP7x93hC7GkXdv8/WAmbcNu0nSdNOfPhyd7Y
         ulVaZB7F0d+0T6YqiKQF64hea18f0rPEsxIU/LWJ6HZve9t/SufVPZ4/2GVeSss3Laac
         XSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fhgP41PsL/y3ZYnL/j3Up8uTJqyMHNAuWy+KZ/ETPA=;
        b=byxiFXi9dmxxaaBhs/OEN+My1sDGfwEx5w5Idj4NqB4kFi5FBmOXH41tNgH5boZzHe
         FapDwvRO7hjG5Uu9r+GdtCzS0R3AHd/6bXdNo9+LNhopaC9YHx5X+aSxBvQVKIQmkAVH
         SU+XEhKSd3iZM7TC9cWAc2GjVd/0hz7CJU9aYgyoILwbLD5ytbwSci5W1bTgrEc9tA4E
         PzntYZvg1h/mEu27SGbp/gOeksJPHLOV6VVPKgq7xRWzyUnUJB+fR46Fu7ZnkP6M1Fao
         FTY7Bp4MhjUmmy1UrzlEllBZ/joGyEcn2iWh/cU9a11oaQ1IwuYH1ZfSGKVb5u6qhCZR
         Hy8Q==
X-Gm-Message-State: ACrzQf0fdYtp3mnROWS3YVjRFfhF90o3MQu9NRvEPicd4fckrhxelsgu
        0Q997x6dPULc8Op7d7nOOEs=
X-Google-Smtp-Source: AMsMyM5xuNuKyVDObOFxlfvOoLwQFOgy7bHhuE+ae1u88Xp1TQiUAOGG6Cl88SlQx0iR0gdwCMZL5A==
X-Received: by 2002:a05:600c:154f:b0:3cc:767a:4653 with SMTP id f15-20020a05600c154f00b003cc767a4653mr35350951wmg.70.1667579206254;
        Fri, 04 Nov 2022 09:26:46 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id bw26-20020a0560001f9a00b0023659925b2asm3758370wrb.51.2022.11.04.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:26:45 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:26:43 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Mia Kanashi <chad@redpilled.dev>, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, pobrn@protonmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
Message-ID: <20221104162643.GA6601@elementary>
References: <20221029161240.15548-1-jose.exposito89@gmail.com>
 <20221029161240.15548-2-jose.exposito89@gmail.com>
 <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
 <nycvar.YFH.7.76.2211041412500.29912@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2211041412500.29912@cbobk.fhfr.pm>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 02:13:34PM +0100, Jiri Kosina wrote:
> On Sat, 29 Oct 2022, Mia Kanashi wrote:
> 
> > >The XP-PEN Deco LW drawing tablet can be connected by USB cable or using
> > >a USB Bluetooth dongle. When it is connected using the dongle, there
> > >might be a small delay until the tablet is paired with the dongle.
> > >
> > >Fetching the device battery during this delay results in random battery
> > >percentage values.
> > >
> > >Add a quirk to avoid actively querying the battery percentage and wait
> > >for the device to report it on its own.
> > >
> > >Reported-by: Mia Kanashi <chad@redpilled.dev>
> > >Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> [ ... snip ... ]
> 
> > I've tested this patch and now power supply status is correctly set to 
> > Unknown and capacity is set to 0 initially.
> > 
> > Just a note that that issue occured not only with the dongle, but a 
> > cable also. It seems that tablet just doesn't respond to the query.
> > 
> > Thank you for the work!
> 
> Based on this, can I assume that I can turn
> 
> 	Reported-by: Mia Kanashi <chad@redpilled.dev>
> 
> into
> 
> 	Reported-and-tested-by: Mia Kanashi <chad@redpilled.dev>
> 
> for the final version?
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

Thanks for adding the tags and reviewing and merging the patches Jiří!

Jose
