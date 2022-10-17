Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB0600843
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJQICC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:01:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44A5B525
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:01:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so23036216eja.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toYeRRrkY+OmurSRkJCHe148bI7k9Qw/KSYRDICfcAg=;
        b=aQMIZsOm5iLO3vkqKMiqfd6cmN7qcmgN/kzihPMT7r7jvaJVIq5LUJFfU36qjmEbqF
         cL014/KhVutl2iOQpPffae0iJqpLiAq/R//Sc+NMNagaaYrK9nDO/aUkPqcvlezPLW5i
         21tNdMokykd/9agT+CSh+xpqNzXpksP/jWD76d9pAZEQ50HITPjiZOo6hoZxYjV5Pd8Z
         AoU5HZ6fajwBLMfTzhEP/NTVu+cZPxI4Cz/N8b7x25w5JM9qkumGL18me/zACK9lELE3
         HppEwhg9pkl0nYbmht/Ursw3hlms9KjwJD8MM3RVnT43OD3GCwNhk0FxDwigaNH56c7V
         Yv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toYeRRrkY+OmurSRkJCHe148bI7k9Qw/KSYRDICfcAg=;
        b=IoEgGvoz24oI9rpn5erym3RE03yBKXiOMCsGzDNVmZ+EiA5wldb+l9zDf3PMjrDch/
         2KOP7mwqoxSSBcqz5/RkOMaJJK6rs+XeusQUGb7DZ9CXh3qFqxOkliToLbM83IDhMIvs
         HVL0GThuQRfdHAX0axQKWJhuQr3+ri0WSb3GExv4390dS4ubkqMkeUkMkDNS1CuhZkG0
         jt8qdLN5thxxn122JOZQcXgR6PyDwxsQ6vRhS1nylmPOgGPNCRy94rk2e18kSEsts9yF
         roSwTTuOBt5nch7U5itV49Zsg+2ilGJV5176myciceyptzwnfldicjkauKslQqNoL9v3
         IHmg==
X-Gm-Message-State: ACrzQf2IpjcBWJ5AfRVB8PEjXL4HH/KnkxQFORdNTMbJkyq6KXp6MKHo
        WGmyaz+JiJK63VTMlLntlsR6VULntRI6kNQGsPk=
X-Google-Smtp-Source: AMsMyM7s/PgKj15YGQd7W0kvmhh7+dg5jTxy7px2DvCcbLCm7ssMWwx/Xrw3H2BlMCqO16T73VupNGJjhtyTcZZgo3Y=
X-Received: by 2002:a17:907:75d5:b0:78d:ef76:da7d with SMTP id
 jl21-20020a17090775d500b0078def76da7dmr7701213ejc.476.1665993716618; Mon, 17
 Oct 2022 01:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
 <20221016080833.5503-1-user@am64> <CAPM=9txsBf5HJ97tAMOQ8PdiPciK-zqngERUm7hGJO8Zyyqb+w@mail.gmail.com>
 <C98B32CF-86B0-438D-BC8D-10FA255B3B4F@internode.on.net> <7c645fa8-bf29-4b30-bdc5-e61e6bb09927@amd.com>
 <f0110d36-a9c2-c1b9-b193-32da4f98a975@amd.com> <67e2904a-4b80-5173-2d8f-6a3d1f702fbb@amd.com>
In-Reply-To: <67e2904a-4b80-5173-2d8f-6a3d1f702fbb@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 17 Oct 2022 18:01:44 +1000
Message-ID: <CAPM=9tz8=iDye+vYai2NLLW-u3TfZ=DKdA_h2e+kk==ZO7q3PQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.1-rc1
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
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

On Mon, 17 Oct 2022 at 17:07, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Hi Arun,
>
> the hw generation doesn't matter. This error message here:
>
> amdgpu: Move buffer fallback to memcpy unavailable
>
> indicates that the detection of linear buffers still doesn't work as
> expected or that we have a bug somewhere else.
>
> Maybe the limiting when SDMA moves are not available isn't working
> correctly?

It is a CAPE_VERDE, so maybe something with the SI UVD memory limitations?

Dave.
