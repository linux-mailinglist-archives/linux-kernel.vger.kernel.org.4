Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553DD60E9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiJZUKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiJZUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:10:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89DFAA43;
        Wed, 26 Oct 2022 13:10:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p3so14330149pld.10;
        Wed, 26 Oct 2022 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HX5FXVs0tYEVxnsB10H21VSQGViE9QVJS+3ibaLV0YE=;
        b=aO1pFCHMxZYIKOLlM2bkwmdPEcF3WO9cJAcLp8nW/40b5s1Lg9tUv4R7EYW3ogT5du
         bfyBLTqEQntFjtOMwAglpr4IujwPOc858KE6Y1JuqsxiBmijkmnbcIe0Wlf4DddMGeEE
         sRf7dcqiw1sPTeF95XL66BN5isWsMFMH77jJHRJeHaapefcmV/+iwZO8CMStYBTe937y
         ZwRUUhJZDJCSOUc+Q60INEV9AVzaFj9IO/UpaQIEE6CNXQNx0HzT9YoWtYl6hBqItsps
         cNRxYORfKCdLvwklV1NotL3k2bV7/XHG0Fk22Na9K1+impNf9VHp+WUquaSteraX9q+Y
         eE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX5FXVs0tYEVxnsB10H21VSQGViE9QVJS+3ibaLV0YE=;
        b=pFynftRm9ofOwNk9HuaLr1Uf2Ckzm6p5fx/UyxK8se5b5/zlhwKhP89SKMZeYR3dK1
         vDO66MC7t6gwTqIF7bGtWtTJj1A0DHlWgwuF0jTjGh6OAEFXmaTjzbixNP2hEcD/08Cb
         qLojfSErrpOHTCAv+uNtbJrQwjXZ2+MLqLwNmdLSmnikm4wjkDLLsNCxgOhaABbYvh3X
         taA07V+t/7cyCstBMglqL5ZxbtBiZozuIbFlK7eOSHLYvuHpPfL+wFFy0Az7pZeEALvQ
         DfQ2HOc0yRqOEE1YpbrDat2AYThkdeKpnAt2A9fA7DA2CohL6EzoOdTRd7qphNZtA0+V
         OFbA==
X-Gm-Message-State: ACrzQf3LzmjlrlcP9h8Ad8iQ/aU+QTWGT7FMVGrAioqBFFOhwjugmtPB
        4Wcd0M5bxc1j+ej0Gh6TNCZYakrPht6JJD4nkYM=
X-Google-Smtp-Source: AMsMyM4vJUlOcUNnKc4pc7DyNhJBsvsHuLZxaNdhqXhgbRmhx5dKzHKugsXl6DIuI1Ny9f00UQDOW9fQtBaldUhFGPU=
X-Received: by 2002:a17:902:e552:b0:179:e795:71c5 with SMTP id
 n18-20020a170902e55200b00179e79571c5mr45471024plf.57.1666815024302; Wed, 26
 Oct 2022 13:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <yq15zo86nvk.fsf@oracle.com> <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com> <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com> <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
In-Reply-To: <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 26 Oct 2022 16:10:12 -0400
Message-ID: <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        =?UTF-8?Q?Christian_Gro=C3=9Fegger?= <christian@grossegger.com>,
        linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microchip.com>
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

On Wed, Oct 19, 2022 at 2:03 PM Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
>
> On 10.10.2022 14:31, James Hilliard wrote:
> > On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
> > <martin.petersen@oracle.com> wrote:
> >>
> >>
> >> Christian,
> >>
> >>> The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
> >>> repaired with Konstantin Khorenko (1):
> >>>
> >>>    scsi: aacraid: resurrect correct arc ctrl checks for Series-6
> >>
> >> It would be great to get this patch resubmitted by Konstantin and acked
> >> by Microchip.

Can we merge this as is since microchip does not appear to be maintaining
this driver any more or responding?

> >
> > Does the patch need to be rebased?
>
> James, i have just checked - the old patch (v3) applies cleanly onto latest master branch.
>
> > Based on this it looks like someone at microchip may have already reviewed:
> > v3 changes:
> >   * introduced another wrapper to check for devices except for Series 6
> >     controllers upon request from Sagar Biradar (Microchip)
>
> Well, back in the year 2019 i've created a bug in RedHat bugzilla
> https://bugzilla.redhat.com/show_bug.cgi?id=1724077
> (the bug is private, this is default for Redhat bugs)
>
> In this bug Sagar Biradar (with the email @microchip.com) suggested me to rework the patch - i've done
> that and sent the v3.
>
> And nothing happened after that, but in a ~year (2020-06-19) the bug was closed with the resolution
> NOTABUG and a comment that S6 users will find the patch useful.
>
> i suppose S6 is so old that RedHat just does not have customers using it and Microchip company itself
> is also not that interested in handling so old hardware issues.
>
> Sorry, i was unable to get a final ack from Microchip,
> i've written direct emails to the addresses which is found in the internet, tried to connect via
> linkedin, no luck.
>
> --
> Konstantin Khorenko
