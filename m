Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34786BA4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCOBrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:47:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0984AFE5;
        Tue, 14 Mar 2023 18:47:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn21so39510479edb.0;
        Tue, 14 Mar 2023 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678844846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPkef2qPh9L+/tKP15uMpMtWmMf4T6qBdUSEfTqaSOc=;
        b=IW+4qLE4DVk6vWwMD0+N+ugJa0SLTsL7hTPwwGiqbqj8ONJl34QGWDfo8H+5wEsbMi
         D66ZwJDPefozpZgB+tBLnBYep/nV3/Xl2BypdaWG6xDqZTLIONi4ufz8N0xBWHzZtAnQ
         9sG7lRk0tfrPg+aPDfizXAp+8xMgqpSyBFucGOGCsvstUeG3+LK1AHWc7ow/dfI11OWQ
         HcZy22xq5Y2JE0KjxEEd3EeYeUK5edy1tv7OKl9uu+m5eta/oo8u98l3aoPps02pm4oi
         5OXortsqah4vnqlhXw1GKLUGGrgwXXMlZsAxnjeVy21LokpPonb8lvrMmr7pbmGz4aCC
         hrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678844846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPkef2qPh9L+/tKP15uMpMtWmMf4T6qBdUSEfTqaSOc=;
        b=gAFOi3z6y5lyf7OvMPjOmX6yAWjNpMP1WIJmB4pRHzZbvPzGT5n4W01AqXHwQhllTT
         nBw3Es4XbmHPIPOsE5jMJpfWm6aVDe+eDVoZ6O8doyuFJR46CggjUWD6IUgfTLPClTE9
         oGf5QZ+vy71v1ZvVf5zRcxndV8z1xfUM2Er9Oy4R54yqe5ZpyXPnJ21nRWFlHJBBtBMF
         ZVe3rWnNNLr08NsxPwxqxJag6FtKbrAB6guHvX8B6Aqmgef1acfflPCJYm9pZbwf5LqY
         0ULFw8rDipG+X6l9YvoUx6hGHBGPmCX9x2sP0LTWjm/6KZBe8/DqdyTr+42zABMldi8o
         tOFw==
X-Gm-Message-State: AO0yUKWFJZFZWWr4ZLcAiRt18m1uG9ZNe+nf/6OzFz066Do3YyrQsM1a
        RbV6b7dlu+Z5j+uxoUYrWQ2gR3FMOeIVbTWFi/rD29Gv2Ls=
X-Google-Smtp-Source: AK7set/tr+3LL0mHM76BvBK8MhYyJJWjmHNeWVpu3ecmA/2/g3GjaLgPpdEixitD2QMOHgcJglrxJKlBpSBEZiG/P00=
X-Received: by 2002:a17:906:753:b0:8d8:4578:18e0 with SMTP id
 z19-20020a170906075300b008d8457818e0mr2343300ejb.10.1678844846542; Tue, 14
 Mar 2023 18:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230222183445.3127324-1-carlos.bilbao@amd.com>
 <a577b165-1e18-e689-7580-cac3f37317f8@amd.com> <87jzzjqhym.fsf@meer.lwn.net>
In-Reply-To: <87jzzjqhym.fsf@meer.lwn.net>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Wed, 15 Mar 2023 07:17:08 +0530
Message-ID: <CAPDLWs8oE05j4=eAmWYT8pXLjN511p3gk2DrK6FTSeqJVMEUmQ@mail.gmail.com>
Subject: Re: [PATCH v3] docs: Add relevant kernel publications to list of books
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, rlove@rlove.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:27=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
> > For the list of kernel published books, include publication covering ke=
rnel
> > debugging from August, 2022 (ISBN 978-1801075039) and one from March, 2=
021
> > on the topic of char device drivers and kernel synchronization (ISBN
> > 978-1801079518). Also add foundational book from Robert Love (ISBN
> > 978-1449339531) and remove extra spaces.
> >
> > Co-developed-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> >
> > ---
> > Changes since v2:
> >   - Fix SoB chain.
>
> So this showed up approximately 4.23=C2=B5s after I applied v2 ... I went
> back in and tweaked the signoffs to match this version.
:-D
Thanks Jon, Carlos !

Regards,
Kaiwan.
>
> Thanks,
>
> jon
