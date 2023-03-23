Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FC6C5C68
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCWB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCWB5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:57:11 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432D211EC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:57:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i6so23223952ybu.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679536627;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OliN5SU9p8WB/u3ZBRw6Au/EilEaml/KOeJO/ZVXuUQ=;
        b=Gg47yRo4aboyjGitlgoge2zrj4x7S2XBFTRRS3NW/DORKWY2+Ph6F8MIoCMcn7kNbz
         QUWcKgpBSPH3F/wQGpg4MM8QFc3uFVCtMAKpJz9u9chUqYbnDziXiwWmenHm0zrhH5Js
         btK1JJx2lTJh5AAUrS1+60dEO4Hj5lw/huykP4JSywfh3L0bLx1pycJE2ZaWSY3R6vhM
         7vaIkQ5hHSBDomrp13dkAjpfI+3VYqD9NmZJCdRxnneSBS4w3u0IiLm1rXvt2lxVQG5g
         OTdsTcQHy0jPvqpjAKSwznWNok4OiBjYNCNjbCVqtRRTdnG68U7MskMT8LfX+X19cjgF
         +y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679536627;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OliN5SU9p8WB/u3ZBRw6Au/EilEaml/KOeJO/ZVXuUQ=;
        b=t1wmbz3h3phRC5sAKLo3CvsAUlhmcP9W4uYdS2nbh0UTGxcmyr9/5McJcNeCgczcij
         sCsjUZ3vUYCGBnRZ/GGdA+NmUKAv/YzdxS7a8mb4Qqz3Yj8IEMy+bLLKeno3AsRGNVtx
         MCBIvdhgGiK4JwvlQTPa2hST3C+AxXRx3aT+rH2Nj+eg9Vpt8HjkDo9k//Jaf7yp6mlN
         7kqbnwMALk/QulMqd+/7SDYr8Bxk0apMqAWGCPUAuNX7LiLWa2hGRs+/61PGmaXUnwHk
         Nfl46cBC8BUj8F19+SIdCV0GWO/a7thtko/8Y+8vXcuz0i4JM9Pn7IvXqa4ITDbYAhrP
         kaRQ==
X-Gm-Message-State: AAQBX9frKv9ro8hA/yFpErp7cezE3k1GaeoXC1rjhnFeZzF9iRK8uh8J
        kmP5xXnzkgrwkpvuL22TlcI3gIK40z61jkXWi3A=
X-Google-Smtp-Source: AKy350YBAIl8p0CcAb7DvPvd6SaeANyl6hb7iXj0Hampngqr+Ez263Ws3Q1hcWrUS/SPHGN1gDC0tUJEpw7hHlZU8do=
X-Received: by 2002:a05:6902:1811:b0:acd:7374:f15b with SMTP id
 cf17-20020a056902181100b00acd7374f15bmr1167835ybb.13.1679536627180; Wed, 22
 Mar 2023 18:57:07 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>
Date:   Thu, 23 Mar 2023 09:56:56 +0800
Message-ID: <CANPLYpD8Ty9QjMf3vs9n8wCCFyaHiiRpYM-b3kNGiA0r3q+sEg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound
 for systems with a ES8336 codec
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, posteuca@mutex.one,
        tiwai@suse.com, yangxiaohua <yangxiaohua@everest-semi.com>,
        =?UTF-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        Zhu Ning <zhuning@everest-semi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Regarding playing the speaker and headphone simultaneously, is not
> > something I took into account. Is this even a valid usecase? The intel driver
> > for es8336 doesn't seem to support it.
>
> Yes, for example consider a critical notification - the system
> may wish to ensure it is audible even if the user has taken off
> their headphones for some reason.

In practice the speaker and the headphone are conflicting devices, see
https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/Intel/sof-essx8336/HiFi.conf

There is no such situation, and the system doesn't produce sound from speaker
when headphones are plugged in. The user may manually open speaker using
amixer sset 'Speaker' on or pavucontrol.

The GPIO thing on Huawei Intel platform is too complicated, they use two GPIOs
for headphone and speaker, and the headphone GPIO is inverted, which means low
means on and high means off. Luckily there should be only one hardware config
for the AMD acp3x platform GPIO and you may just choose the correct one.
