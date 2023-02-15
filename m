Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517E6697F72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBOPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:22:47 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF00E06A;
        Wed, 15 Feb 2023 07:22:45 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id n26so3143900ual.7;
        Wed, 15 Feb 2023 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GWrEpYw1oDyFs1i/41lWQOwVP0ig3lg6jt+eM6m0lQ=;
        b=gNbEon3ATmONadDkZN/crTJGjpPIaOut4JDt2sV2R57Dw1Xt7gwxUkYG21ZXO1o/Go
         p/nqfjP0SrmWBxQo+tmDwLVBe8kq9KXYlQMnqPhUV+ljF8znbcNzohj1jDGRSyZO9WAE
         UZYKPUNT/AQ+YF7PxBt5Zq7UkJVKWqriH+Ya5OIoGrc2sRO8xekcBBMckeb+KvgpFjg3
         JBhLHgg78avdH/lWADpN1SgARvFGASRXGCbR33XKA/avy3494q+7Qg3TzelPnQfeVwLr
         VmLry8JIbdqB/lWf7buztuDaa6g6kzTeRzyAs6ikJIv9Zj/1rkF/d/ZQeZNYH2tYON0j
         ZSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GWrEpYw1oDyFs1i/41lWQOwVP0ig3lg6jt+eM6m0lQ=;
        b=LoW0/J0cBi1HI7ghK0Xdll+yZOg1YoMu/fDVWueFG225B+NZXNDbxFMXImqs/bIcVh
         X6guNvVGtrJy/U0Sa98W8IkEBNuatfCQVojJdTVCYf8PxdmHyhgXzgz0feYbNGqjASbL
         GOXMjeQ4jLmkNUhLeirRSyn9HntbgBUVcMvk3WfOoJOVoVtjM+h4e/X8X5F6BXUXjV3F
         u9R50uT7SXMY+F39HjooD/0tgmCxpUvyT5DpCd9IuUOuZ8htCrZEh8EiK1t0ogZxElJ5
         cVF+dK8e5JN3faZyscVYNfixiTAUgy8HoSaZ73j+exag15+4spVxpZ6mBKTBFo5pJQEi
         NnuA==
X-Gm-Message-State: AO0yUKUuNuvDc6paHJNb/5iMnaRtLBRc4k777u/qFVWpLgKFoVN20E8z
        2BVQ52PK0nvxmLhKONORT9yoe4Hz7c0+Yio1FA4=
X-Google-Smtp-Source: AK7set8wTuoiA3mCAfz0aaCZdiHMLvmddGL/QP5ChqBubs3g2Q7JlCNmnUEjQcxpeNNJFGu3gsjjUbXmWCpukqRQIYc=
X-Received: by 2002:a05:6130:2104:b0:68a:570a:8ddb with SMTP id
 cl4-20020a056130210400b0068a570a8ddbmr317846uab.4.1676474564598; Wed, 15 Feb
 2023 07:22:44 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
 <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
 <CAM23VxpzY6qYsdTYxe01FT7AJvEbODf8X_vq8ALL35TfyrB8xQ@mail.gmail.com>
 <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com> <0f5aafed-7b1a-99ac-57fc-c5de9a269b92@youngman.org.uk>
In-Reply-To: <0f5aafed-7b1a-99ac-57fc-c5de9a269b92@youngman.org.uk>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 15 Feb 2023 09:22:33 -0600
Message-ID: <CAAMCDed2eaygbYxFWDMBKELJ27XKNUZgGsJ1MKQK8qMCUTy+wA@mail.gmail.com>
Subject: Re: [dm-devel] RAID4 with no striping mode request
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Heinz Mauelshagen <heinzm@redhat.com>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        John Stoffel <john@stoffel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMART on the disk marks the disk as FAILED when you hit the
manufacturer's posted limit (1000 or 2000 writes average).    I am
sure using a "FAILED" disk would make a lot of people nervous.

The conclusion of you can write as fast as you can and it will take 3
years to wear out would be specific to that specific brand/version
with a given set of chips in it, and may or may not hold to other
vendors/chips/versions, and so may have quite a bit of variation in
it.  I think I remember seeing that, but I don't remember what the
average write rate was.  The one I just found says 200TB of writes on
a 240g drive, so about 8000erases per cell was the lowest failure
rate, with some drives making it 3-5x higher.


On Wed, Feb 15, 2023 at 8:53 AM Wols Lists <antlists@youngman.org.uk> wrote:
>
> On 15/02/2023 11:44, Roger Heflin wrote:
> > WOL: current SSD's are rated for around 1000-2000 writes.  So a 1Tb
> > disk can sustain 1000-2000TB of total writes.  And writes to
> > filesystem blocks would get re-written more often than data blocks.
> >   How well it would work would depend on how often the data is deleted
> > and re-written.
>
> When did that guy do that study of SSDs? Basically hammered them to
> death 24/7? I think it took about three years of continuous write/erase
> cycles to destroy them.
>
> Given that most drives are obsolete long before they've had three years
> of writes ... the conclusion was that - for the same write load -
> "modern" (as they were several years ago) SSDs would probably outlast
> mechanical drives for the same workload.
>
> (Cheap SD cards, on the other hand ...)
>
> Cheers,
> Wol
