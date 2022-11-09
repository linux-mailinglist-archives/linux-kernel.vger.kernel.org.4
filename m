Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7A622C02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKIM6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiKIM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:58:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243CDEE;
        Wed,  9 Nov 2022 04:58:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b2so46433525eja.6;
        Wed, 09 Nov 2022 04:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQHgfqffbVgla+88Htum6DFfKPDcz14zpacfU/5ZRZ8=;
        b=Zz15VJmKPUWGTaf43DGvgv79gH9V2SMiMUI2cJQwldlE9ouewC+mskB9a+scsomex6
         Bjv0D9jIo4JKylBaXsOJ8pGAmsqKKBbW9QlwIE3fbCUGPvLlYaxZRB1MqVWkLfAh1jO+
         gkUfkt4vB9oLqDaI1DRhYXrUrU41EjBHFSksl6zfbv/PBRbDJAOOJwE43QeExpkmTaiC
         n9GQj6L+VcbFYNw+Y1zGGMew/WsxV+y6oXkUVLnnD094HbBFmb/Yn63uJmAPWgNg3bX0
         mGuj52GGDtDk3MMdhMsh2QjrPoxyV6CDH4BKXuIlXHVgP2UCisED9n/75C9Kgm7Mhgj4
         DrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQHgfqffbVgla+88Htum6DFfKPDcz14zpacfU/5ZRZ8=;
        b=jF6CEPPsDtaDtiLV9XOLYZk4DrkBlEtPOZ7eJKQy0hrGBk7F/PrpbnhvUTt3ebH0qj
         wrjB7cSBhy4bq9XDUg1ydvt6Gw0HH+J4GXxfBIoFd+hpCpSbdopJjtH+xEI1PbbSR/lv
         5DJJ1Ry6DLugF2Qt5OxjCSLcHjPYqX1Ib66niAGw+9mKX9Xxvh6RSqjm7+RpDTM2A5bO
         fY3SFx0Gb0J9UXh6OX3fsA1H/RB8fHirZ/XbQWOHL84lDn5pBO0+92b7dMK3xNRh+O1o
         KiLxUDNcZlGAyP6Ueor8w5fTrSqNxxAcistyq9/xVByfU1asI8s6ruFwrsGsA2FNx0l4
         bFqg==
X-Gm-Message-State: ACrzQf1z4U4kx3zFnzu+L1hR57athwh9He9IkHiL5zDYyL8EIImpCPZO
        gq8hNsN/2TPxYP5d4/RQFzo=
X-Google-Smtp-Source: AMsMyM7xsDMSs3xrAO5j9GXB59+YuBqN1/C8t/WbaD09iXDj5xe4+wjxtiONP2okqHabAlzjAVVjHQ==
X-Received: by 2002:a17:907:a429:b0:7a6:a48b:5e52 with SMTP id sg41-20020a170907a42900b007a6a48b5e52mr55841066ejc.411.1667998704453;
        Wed, 09 Nov 2022 04:58:24 -0800 (PST)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id b1-20020a1709063ca100b007ae566edb8bsm5380645ejh.73.2022.11.09.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 04:58:24 -0800 (PST)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     ike.pan@canonical.com
Cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        erayorcunus@gmail.com, hdegoede@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        pobrn@protonmail.com
Subject: Re: [PATCH v2 0/7] Add camera access keys, IdeaPad driver improvements
Date:   Wed,  9 Nov 2022 15:58:20 +0300
Message-Id: <20221109125820.14879-1-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0b298830-47cc-bb94-0e73-493e4e9244f7@canonical.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com> <0b298830-47cc-bb94-0e73-493e4e9244f7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/22 06:56, Ike Panhc wrote:
> On 10/29/22 20:03, Eray Orçunus wrote:
> > Nowadays many laptops have camera access keys, yet there is no usage codes
> > mapped to them, even though it's introduced in HUTRR72. Start point of
> > this patch series was adding it and making IdeaPads send it to userspace.
> > But later I discovered that camera_power attribute of ideapad-laptop
> > driver on my IdeaPad 520-15IKB doesn't work, so I can't toggle it with
> > that. I managed to find a way to check whether an IdeaPad supports
> > camera_power attribute (which sends VPCCMD_W_CAMERA to EC), don't expose
> > it to sysfs so userspace will know that it can't toggle camera access via
> > camera_power, in my case, after receiving KEY_CAMERA_ACCESS_TOGGLE.
> > 
> > Along the way I discovered that old IdeaPads, like S10-3, may not be able
> > to toggle their touchpad as a regression of a commit aimed for newer
> > IdeaPads, so I reverted it.
> > 
> > Also I noticed that I can get/set the state of my keyboard light,
> > so one of the patches also adds supports for this kind of keyboard lights,
> > which I call "partially supported keyboard lights". I expect that commit
> > to add keyboard light support for 520-15IKB, 330-17ICH, 5 (15) and more.
> > Currently only tested on 520-15IKB.
> 
> Thanks. Also test on my ideapad s410 and it looks good.
> 
> Acked-by: Ike Panhc <ike.pan@canonical.com>


Thank you :)

I need some advice since I'm new in here, sadly another patch has been
merged to ideapad-laptop along the way and currently it's not possible to
merge patch #7, does that mean I should send v3 of my patch series?
And whom should I wait for merge, x86 platform drivers maintainers?
I think that is the only subsystem whose maintainers haven't replied yet.

-eray
