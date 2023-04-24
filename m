Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7D6E0808
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDMHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDMHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D328A60
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:45:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x34so977197ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681371921; x=1683963921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROFpaYIgq26cLIkNVEnMozH6cn/rivsqCvSc2ZNZaHk=;
        b=sT853BPAZjADMB9yC1BBJjhv8Np0nLG5ajZbEGvtw4KTKxOss+bTxAD5nVx8fCi8Ci
         z9oPYYEnhQUeMs2XBLUrgcIYiNN51pVQDIcPmPB35/UTbaKUBA38w4xLXnXynxBwmnAq
         lstVjTbzbdxgncTPnZnmg4c87lNxe9TFwDzFh7dXjZr6CWV7R+twSkH9YpDg5aHFeRkw
         GJPR/eGbVRloIzOw12kaXJ1tHGHY5XkcpGza0CaoI4BfrBzDh2J244DyfgP7XstgVB5u
         lqDKaVfeRJsk8UFYK79xNDxwL1SCQWPylh5Eq1PYiCmv9kE4K2II5sep9vreUUTUmxrY
         vQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371921; x=1683963921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROFpaYIgq26cLIkNVEnMozH6cn/rivsqCvSc2ZNZaHk=;
        b=NzQI96mKjeaynTI4BnqnOHzNYorHRkf37uVVbiMX1GnQ6m7sg8k07bGR4R5NooUbIe
         vP/CgPNJVGwuNfgwW56W6UUxJCCov4q+vnaG3YA1+ePmpEOvFK6xdRqsreNBbJqolI8a
         E4i1a2DEbnX/J8whf4t8VJPWZ4Vuk7Q6Uf4Yu3alqzE3DdYfexO0+MV/o83bI83y+lZ2
         SjPl8pOWR4L3gfLymCvkGKi2koOadaa9T4jQLKIXITsV1ha63j5kkWJXh/D7mhmLIKoE
         xwn52sJNhJP0s/u+7sIrV/gL6R6tFF7GWJ2BLL8rTsfDVuPVm5CvauYM6i0XbTQw8/F8
         4jiA==
X-Gm-Message-State: AAQBX9eDj2evcW1H6Pf5PoL7KyLILumpOSRruw4mPq3t9mPBjHoFBqib
        zawh0Tp2ikJKxtfMFg/unyteDwrzvRU7l82fjPKglA==
X-Google-Smtp-Source: AKy350bBI4Fp6Ci7UvqsEgEgFGoHSlyFUIgJYynKIcaXzkcGlGr+epkjYXP55Xf+Eq2cFiXHMyEbSrHk6Xv25XlDpwY=
X-Received: by 2002:a2e:808d:0:b0:2a7:9f4c:ce94 with SMTP id
 i13-20020a2e808d000000b002a79f4cce94mr424287ljg.8.1681371921665; Thu, 13 Apr
 2023 00:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230324195029.2410503-1-viktor@daynix.com> <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230404141501-mutt-send-email-mst@kernel.org> <AM0PR04MB4723AB600C87D77AB486D035D4989@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4723AB600C87D77AB486D035D4989@AM0PR04MB4723.eurprd04.prod.outlook.com>
From:   Viktor Prutyanov <viktor@daynix.com>
Date:   Thu, 13 Apr 2023 10:45:10 +0300
Message-ID: <CAPv0NP7gms2FMOaysnphYSK=4qgo3GVKPd7pUMxsPS1C6bTj4g@mail.gmail.com>
Subject: Re: [PATCH v6] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yan@daynix.com" <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:40=E2=80=AFAM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> > Hmm.  So it seems we need to first apply yours then this patch,
> > is that right? Or the other way around? What is the right way to make i=
t not break bisect?
> > Do you mind including this patch with yours in a patchset
> > in the correct order?
>
> Ok, I'll create a patchset.

Thank you!
