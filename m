Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D03741690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjF1QiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1QiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:38:16 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0110EC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:38:15 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-44363f4f128so57868137.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687970295; x=1690562295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rn3u0ULRq3S4nohWqNLCsgwds6G/tMj1KjrgHd3RE7k=;
        b=m/za4tWDIYnI2zMaoIm+KspBwG08+McjjOvGNux9yOFaSd2K2FNh3j897DjpYvolI2
         4QuKFFK4wY1P5HKSh8lI2eVj9W1mtX860faimjaMhaEhSba1RukzmnLy8CgdeOYjLDKH
         UZ04avTcID9QXuO3a6bNDGDIzjO1Hwl25y5DSiF+ez0ScXdT4XGTS3xIxl2l8UnNSIq2
         QbTnWr0awRrUMPOvcrpsWa5+1FLo/UpRxRDUshyZiJGhWfncm8V7LCAnUIsfjs+7SK1v
         rKPiT5w48Twh6go9C2tk9R6Rg4ptfnN5ToTm01CDtbDQVDeV9Zw6tS/FqyMlGDjSieSC
         If6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970295; x=1690562295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn3u0ULRq3S4nohWqNLCsgwds6G/tMj1KjrgHd3RE7k=;
        b=ZY/zb90pexHDTfIt3rZNFv1Xf6PByxVvU8RGe4jCBypIj+7f+3EEfk0LdF7Qngmdps
         A2sWAidF7tSBGhtOXs8mrI1pccCqJBpdAFHgja2YRnnc7tWlaJgo0/MaICNRDZTsDPgj
         cxe/wi6BHqeSnpHkLHLvla7Oek1VB7Nnda0X1xsj0zsPfBLolR5P97usNEuhWzI3hAIe
         yYoFB7Di3/0rFNS0rmMeq2qRyCBKDNDSVRI2jPSyDhUq7lXuef/3p3339C7VgvwUxDwO
         DslNpF2+97fcx3x9vKucUtp5Tr62W7hdU/Pm8Zxj7H6bwfU1Oc1uKY9g9iNUxJDlkYSu
         Mwhg==
X-Gm-Message-State: AC+VfDya5P+Lk1WsBNoW8zslE1PzYGaXfJjVeG6mB/ntXy+RRkg4WvUK
        am0qOUu5iEv82LuOiOYLf2ydPR4+pjrT5+UjRMQ=
X-Google-Smtp-Source: ACHHUZ5WOSszSUtM7ee8J6Hjl5/gPi+ToBpeawbfMHl4UHDUxikQBhuXzAoFEtx+jyvpV6XiBzOisEYI1GgSB85h0F4=
X-Received: by 2002:a67:f487:0:b0:440:b564:bc37 with SMTP id
 o7-20020a67f487000000b00440b564bc37mr810987vsn.3.1687970294736; Wed, 28 Jun
 2023 09:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230625155632.32403-1-franziska.naepelt@gmail.com> <7caa96fb-4fb6-fb87-5d0c-fa6985fa127b@gmail.com>
In-Reply-To: <7caa96fb-4fb6-fb87-5d0c-fa6985fa127b@gmail.com>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Wed, 28 Jun 2023 18:38:03 +0200
Message-ID: <CAAUT3iM7eAYH5AcN=Ko9jDstEUGqXxG7Q6qjp4O9qF_e2WkUVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix some checkpatch issues
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Am Mo., 26. Juni 2023 um 19:09 Uhr schrieb Philipp Hortmann
<philipp.g.hortmann@gmail.com>:
>
> On 6/25/23 17:56, Franziska Naepelt wrote:
> > This is a series of patches to fix some trivial checkpatch issues. Not all
> > issues have been fixed. I intend to submit another series to fix more stuff.
> >
> > Testing:
> >
> > ---
> > v3: Series to contain only remaining patches.
> >
> > Franziska Naepelt (3):
> >    staging: rtl8723bs: Fix space issues
> >    staging: rtl8723bs: Fix alignment open parenthesis
> >    staging: rtl8723bs: Fix remaining blank line issue
> >
> >   .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 164 +++++++++---------
> >   1 file changed, 85 insertions(+), 79 deletions(-)
> >
> > --
> > 2.39.2 (Apple Git-143)
> >
> >
>
> checkpatch prints the following warning:
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Franziska
> Naepelt <franziska.naepelt@googlemail.com>' != 'Signed-off-by: Franziska
> Naepelt <franziska.naepelt@gmail.com>'
>
> I propose you change the git email matching the one that you use to send.
>
> When testing you can compile the driver with this command:
> make -C . M=drivers/staging/rtl8723bs
> Typically a compile of the entire kernel is not required.
>
> Please use the subsystem and driver also for the Subject line of the
> cover letter.
>
> Bye Philipp

Do you want me to submit v4 to fix the email address as well as the subject of
the cover letter or are you ok with me promising to make it properly the next
time? ;)

Thanks,
Franziska
