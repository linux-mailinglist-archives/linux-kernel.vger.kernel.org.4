Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB25612134
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ2H6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ2H6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:58:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF267C1C1;
        Sat, 29 Oct 2022 00:58:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a14so9266905wru.5;
        Sat, 29 Oct 2022 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXtTPSuITrg2+Wy4LunD0+G8ePAn5HRW3Hi/3aiQfg4=;
        b=VL3s0jNQA7RA491qS7cZi7k8XgrFVYtNXkdFAxI0bFH4XDyUisdhMB1QqsKWnUiAP+
         Vwnv4l9ydJy+W57wBUi2BimEG6eJqEnJIwgkK790YY7ZqjB23sj106QrS8pf6FHtm10D
         X0AwmdNZMiqO1JoJTNv+/a5BJP1CcQ0mDA5w6A5NYF6yLFrLhTY2KOFgHuPDUnEKTWzr
         ovs/CD2B1LqKmc+mE538qwGYJr6c42do22KvcFhOFXoEL5AFLu2LsP8vXzn/VdUfud5a
         08d+IEly5kj+XfK8Z3sD4sz0yJDcf9vJKqq0I0rn4Kzxe1SnuYhdhudo/FRcXFKUFcYd
         Q66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXtTPSuITrg2+Wy4LunD0+G8ePAn5HRW3Hi/3aiQfg4=;
        b=b18IfXFdBVyDgX59cVpkfQzYIxeW8AbqsOOGJaTfGRDeAA6iwtD+uumaMHptLxzwI2
         gY90LYyJYyFKB8MxFcQeuj5c4D3pZQP0acOsw62gWvrgGkOcFXfN8oedLWTr9Fk8rU1c
         tVZR/aHsHAJ9hRJ32d2G2BLylZ6n6qH4i+yp1LxF6rpUVu2hDIpxJ+vjDuOKqzZL4w4W
         JwZjoWpHmcoX3QP6AfKmmYSUaZDmuH3jwz0NtyHSjSQj16MMD1n3KBS1u2AyCr+VJFui
         bvogUH5k9c7sldJL89Ft5IFBokBKZlyu56VKj1HBNf3W79ZPggpZM1HL+FTKcStGrJws
         KZcw==
X-Gm-Message-State: ACrzQf2vOpUixBCFTkNbMQJJZDsbCwSYMF/gKFSJfTu2yB/JhE2nNT0z
        TSRpUYWvuFKUKudt0V+nFEU=
X-Google-Smtp-Source: AMsMyM7x7N4SxHfnH95Ml8cZ4/P6kh2konHRNCxgN8S8anrkKdyJVfqQQcn3esvRiUB4DtDC4Dvl9A==
X-Received: by 2002:adf:a1d4:0:b0:236:9adf:a2e9 with SMTP id v20-20020adfa1d4000000b002369adfa2e9mr1636406wrv.463.1667030315104;
        Sat, 29 Oct 2022 00:58:35 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b00228cd9f6349sm795646wru.106.2022.10.29.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:58:34 -0700 (PDT)
Date:   Sat, 29 Oct 2022 09:58:32 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Mia Kanashi <chad@redpilled.dev>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
Message-ID: <20221029075832.GA8790@elementary>
References: <20221028082348.22386-1-jose.exposito89@gmail.com>
 <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev>
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

Hi Mia,

Thanks for testing :D

On Sat, Oct 29, 2022 at 03:28:10AM +0300, Mia Kanashi wrote:
> Hello!
> 
> Before device sends a battery report, you can notice garbage values in a power supply capacity.
> 
> You can see this by running
> `watch -n0.1 cat /sys/class/power_supply/hid-28bd-935-battery/uevent`
> and then connecting the tablet.
> 
> You can set it to a value here, but i think this is a problem in the global hid driver?

That shouldn't be problematic, because the charging status should be
initially set to unknown and change to charging/discharging [1] once
the device sends the first report.

Your desktop environment shouldn't display the battery percentage
while the status is unknown, so the initial values are ignored.

Here is my output of my XP-Pen Deco SW before receiving the battery
percentage:

 POWER_SUPPLY_NAME=hid-28bd-933-battery
 POWER_SUPPLY_TYPE=Battery
 POWER_SUPPLY_PRESENT=1
 POWER_SUPPLY_ONLINE=1
 POWER_SUPPLY_MODEL_NAME=UGTABLET Deco Pro SW
 POWER_SUPPLY_SCOPE=Device

And after:

 POWER_SUPPLY_NAME=hid-28bd-933-battery
 POWER_SUPPLY_TYPE=Battery
 POWER_SUPPLY_PRESENT=1
 POWER_SUPPLY_ONLINE=1
 POWER_SUPPLY_CAPACITY=99
 POWER_SUPPLY_MODEL_NAME=UGTABLET Deco Pro SW
 POWER_SUPPLY_STATUS=Discharging
 POWER_SUPPLY_SCOPE=Device

Jose

[1] Actually it should be set to discharging until this gets merged:
    https://lore.kernel.org/linux-input/20221028181849.23157-1-jose.exposito89@gmail.com/T/
