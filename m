Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7D61519C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKASfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKASfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:35:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37BC19016
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:35:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e15so5955754qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp/5zmqM/RRSJ5KnMbkLWKzmrtWigi1LkGGYrFbPaTM=;
        b=lxPCP9+nJSjdQo6Cqjh3U+VVEYZCf36lwRLzVrnii1J0qX8AjtVnp1GhYk9fHuLo9N
         pQicVNcZpOzHvXErSZ5wbIkWAAoPCn0qXsEJsJ/EXr9vvdm0iMAfD4H7Ri9xT55OpE88
         3oLbIaD8tVpkb5rI7AcBE8NhB/gjgQ9ghGR3Q36Xfm0vSh7Lo/U5Dj87H6vrqhuOSta5
         baQEkkhi1b4KI2eNyc+sCvEjv3C+jTdB+hJGL56e8bMJ62dn87HK0Dc6tAqXmp2mXsVn
         ngCAipTmduycuO72KZ538lIUebALfLpxndTznamUTITFyqcyqQMis5RT1/pUZ2+76Quj
         xFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yp/5zmqM/RRSJ5KnMbkLWKzmrtWigi1LkGGYrFbPaTM=;
        b=B3N5I0dHjDUQT6g5lyHumGg0xHj36aTKt2pAonEF84jGZtg11zLv6t8vhyejOkXOm1
         HsNK/JdPuhNjIdEevoYwd/7aXGoR7vSPB9OsqC5BkqkQk/iEfFOGltOcBzagBOe/NdiY
         xj0kMOHtfIRn3ATX76i2BApxwtG5si15vJL0H0SfGSwBOocRH9xlUfIcckjhOb7Lp4A6
         zFbh7cw6I2YPobNQ0t+CrbT/y0pFHEqlSSqf6BA0bguZgROKVj2Q747roY4qhUmkJelx
         8ARKispPVph3Lw5pTwzWxxgIWjTtIA5uLeWDXCleKYrj5qgtbmnSrdBw5NBEoqWaaAm0
         b3tg==
X-Gm-Message-State: ACrzQf1B2rtSOl1bdsp9RJNmZ3YWO0928UckuptmaRNCh+c+J5OgdcwW
        PESomJp2JzBPOAb5QkIi//ETjrDReesEozCun1bvRAv1pqbIixxq
X-Google-Smtp-Source: AMsMyM5nJwkXIV9Yq3G5AGu4VggIq65hvmlUkP2Q2uokcZtgpBbuQ4JE7I3Pa1+EPgNxTowyIJ4IHcCpxV2ucpqR5UI=
X-Received: by 2002:a05:622a:147:b0:39c:dc0d:7d0f with SMTP id
 v7-20020a05622a014700b0039cdc0d7d0fmr15920035qtw.281.1667327706975; Tue, 01
 Nov 2022 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667305446.git.tanjubrunostar0@gmail.com> <Y2FjuHeVzY5VYG97@kroah.com>
In-Reply-To: <Y2FjuHeVzY5VYG97@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Tue, 1 Nov 2022 19:34:55 +0100
Message-ID: <CAHJEyKV98M5P2N7qvdwdP8R_=wEmc+_TpTk+RFSo5a+sCO15Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] some checkpatch fixes in the file rxtx.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 01, 2022 at 12:37:58PM +0000, Tanjuate Brunostar wrote:
> > These fixes are focused on the function s_vFillRTSHead
> >
> > v2: changed confusing changelog messages
> >
> > Tanjuate Brunostar (2):
> >   change the function name s_vFillRTSHead
> >   Join some lines of code to avoid code lines ending in (
> >
> >  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
> >  1 file changed, 22 insertions(+), 26 deletions(-)
>
> Please look at your subject lines you are using here, and look at the
> mailing list for previous patch submissions, and at the git log for this
> file, and fix them up to have the proper prefixes on them.
>
> As is, I can't take these.
>
> thanks,
>
> greg k-h

There is a version 3 of this. Please review it instead

thanks

Tanju
