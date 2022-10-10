Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA895F9EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiJJMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiJJMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:31:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE706161;
        Mon, 10 Oct 2022 05:31:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q1so1852032pgl.11;
        Mon, 10 Oct 2022 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUsv9lLV87y8Jc+WxRiT977Cv06zKT6369DMp240Xs8=;
        b=Ekqrk1S3UTBSAeccA5NT/zag1zrwyk3nOYPRAC9tU7jrT9YA4x0solFrGL+ZHeE4Up
         ggYaQ3AbS1JHxFcC+qtF3w/BOTo7MuuTYkKa7VyQey5hug1d3wroa6L2ljdlh523EIer
         +37oXmm7O3Z91mUcoTaUo+X4bssSVU2iFBKhYneklQeP/Ao1pGuDIowALOkLeY0EqgXL
         1+pkN/gCnzijAsGmwy98MstyYNULbQcxuVHnWx56zRsC1+b0Gxc9bWzOpaizRZavMdm1
         t0jT9pMhUe53lJp49Ebl8VK2iCHC7Qv1hb8Jr+jfUsn98EZZsCFVmmd5zluQNlFafVDv
         qz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUsv9lLV87y8Jc+WxRiT977Cv06zKT6369DMp240Xs8=;
        b=ENa8nVOY5HiwWiF/0RoRLvMv6TdSAW773WL0QtgIptUaepfITRFk28scBvnjamuSZH
         jCFri/yGpq8UtBGRTjgZSKnH71N9ZsCF/89+ZKlxuUWYsUCeMfZw9Kl2I0YDXZ6bhZGW
         jRF+doONQGzhBY7oSPuVOkZJ6mTfaPvpuphwYhyKdKPm3iiDi1ZdTG9XZQQzCXN05eG9
         BUZalp7xSx8McUwgXpoNzyxpyyYe2DZcmVJF4ZW3KnCmcVu6DwFbL5P3bcwilZ0DNaG6
         wfCtCWmB2URS/1+aCn6BGIq9UsKW19DAAtH754kNdyW6uZ6qnt10nyFKPdyVKPD/vRBq
         9Euw==
X-Gm-Message-State: ACrzQf0KdTU9ThJnsz5bK2ReDnpgFQlamEUf7vylXgG8xL2r3mlLcF0g
        gF9vxJi4Wp13Ie21ZJpxzhaIqB8rqxnAEFt5BAk=
X-Google-Smtp-Source: AMsMyM7t8L3HrEcqldBAMJ4m/64poCAnAdWg+ND+9jX15QOd4XnduoRX7DplXu/Lv3r8flsTi5QZuPo3+0wyEwtNUJU=
X-Received: by 2002:a63:1455:0:b0:438:e26b:ab1f with SMTP id
 21-20020a631455000000b00438e26bab1fmr16326063pgu.183.1665405084349; Mon, 10
 Oct 2022 05:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <yq15zo86nvk.fsf@oracle.com> <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com> <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 10 Oct 2022 08:31:12 -0400
Message-ID: <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     =?UTF-8?Q?Christian_Gro=C3=9Fegger?= <christian@grossegger.com>,
        linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
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

On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Christian,
>
> > The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
> > repaired with Konstantin Khorenko (1):
> >
> >   scsi: aacraid: resurrect correct arc ctrl checks for Series-6
>
> It would be great to get this patch resubmitted by Konstantin and acked
> by Microchip.

Does the patch need to be rebased?

Based on this it looks like someone at microchip may have already reviewed:
v3 changes:
 * introduced another wrapper to check for devices except for Series 6
   controllers upon request from Sagar Biradar (Microchip)


>
> Thanks!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
