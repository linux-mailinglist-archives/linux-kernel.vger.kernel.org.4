Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC46C3541
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCUPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCUPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:12:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4175497EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so20597947pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679411550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs4XFwzBiFDPJVtjZUl2RJ7HBOI+ISFL0yNCGHw0rSA=;
        b=tJKHCyJ/Hv9A0HcGjoENtasddCDP8doXKYrApaYjfyB9N2jR01Bc29nNSbzs0GhWNZ
         N9HydBPC5bpfRPeZlnFr/R5Uh5NsIkJfR9MdXXQcFONRrt0sCmCv5SSjIa9n2CWqV5JG
         Ryu28+GuOBbBKqbfNszWmj09a/Q+l3cpN8eD35vq6VITJEdie53JhujxBkZk7vDPA8FX
         BHk/GPxlv9L0gCv+1Kr9034zYWNcMLfB6JyOHQbal4UmI73WIlZYhDy39tmpAMgYk4ux
         y7VXZXOrtw5Vv0I5vt/O3qQx2Hfc8wNb3u7Vs4DBNr1Ub5sKTfaPct/l5yGAdr7YbA3W
         hJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs4XFwzBiFDPJVtjZUl2RJ7HBOI+ISFL0yNCGHw0rSA=;
        b=ITqHm05hV01SOwoHZwNqx67QbB28vrlFiLY6ORE4nXa63L11qow2aIfJlB4joryGrY
         XMmRwfvGkJKzKywfW9M5oE+IzrG77JjC4/9r+iQf4wwIbFQwzz+GO/IKzRYBTqHyQ+Ug
         BIktqfHcKVzfvnczmByd4/ync4KlM1NkcjfDLjPDW0dhKGXfkfJFXikcaxt+XbEDF/iM
         Age+p8Rf5S2F9wOPtmANeBNYoqGkUFLnPIGgtHT7a7yOZLGJh3/XWjgiPPp//h6v7HWE
         34BpFcpXOCkVXRMvDeFZLN1OQO+u2Y3uCtSS/CikkCHa6g7oLT7gWgn+v4KfkzVTpEvy
         pnDg==
X-Gm-Message-State: AO0yUKXMrUOnsCWJbh+kHRjUugC5zMlM4SoOTCCyVJT8+z5JR5dpYdxq
        /wS8Q4O61kPGYb38zkA3tlFMLw3bWM5viknjw2TpWg==
X-Google-Smtp-Source: AK7set+7NATc/gnBj6qhjbfZFraYpPP7a3Pu2kRkbVv5e5w8hvR6nzB7NpNHM3F/10npE3swntljcxoIpDUF1PmfXnY=
X-Received: by 2002:a17:902:fac3:b0:1a1:ba37:d079 with SMTP id
 ld3-20020a170902fac300b001a1ba37d079mr3780735plb.3.1679411550138; Tue, 21 Mar
 2023 08:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-2-james.clark@arm.com>
 <b16a31ab-907c-1478-3a07-44d588318768@arm.com>
In-Reply-To: <b16a31ab-907c-1478-3a07-44d588318768@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 15:12:18 +0000
Message-ID: <CAJ9a7ViOgz7xHGN6H2s+4TgAuswKfhQamRHQZZif0zNCv--uMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] coresight: Use enum type for cs_mode wherever possible
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 16:47, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 10/03/2023 16:06, James Clark wrote:
> > mode is stored as a local_t, but it is also passed around a lot as a
> > plain u32, so use the correct type wherever local_t isn't currently
> > used. This helps a little bit with readability.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c       |  7 ++++---
> >   drivers/hwtracing/coresight/coresight-etb10.c      |  3 ++-
> >   drivers/hwtracing/coresight/coresight-etm3x-core.c |  6 +++---
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +++---
> >   drivers/hwtracing/coresight/coresight-priv.h       |  9 ++-------
> >   drivers/hwtracing/coresight/coresight-stm.c        |  6 +++---
> >   drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +-
> >   drivers/hwtracing/coresight/coresight-tmc-etr.c    |  7 +++----
> >   drivers/hwtracing/coresight/coresight-tpdm.c       |  4 ++--
> >   drivers/hwtracing/coresight/coresight-tpiu.c       |  3 ++-
> >   drivers/hwtracing/coresight/coresight-trbe.c       |  3 ++-
> >   drivers/hwtracing/coresight/ultrasoc-smb.c         |  3 ++-
> >   drivers/hwtracing/coresight/ultrasoc-smb.h         |  2 +-
> >   include/linux/coresight.h                          | 13 ++++++++++---
> >   14 files changed, 40 insertions(+), 34 deletions(-)
> >
>
> Looks good to me.
>
> Suzuki
>
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
