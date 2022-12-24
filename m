Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7544655B62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiLXVqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiLXVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:46:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDBBE1A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:46:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c9so427571pfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3UxsimBVOhEDuKfSuQBk+/BzoqRkKBz/Nr1j/ZryG8=;
        b=pvsrtHUzIjjg31V+IH/mGznvfjfwaNZDh0KiqTKR+D9Qp0tWJs97bpm4mhN5kW3pQt
         OkRylP6veOvbgsdOaq3/x/m4d4dTH9ZDPaMWkmmnK02OoF7Xzpp+wtyerfdn9ClqqG/9
         U9rpKaLAWkrv5ZFoUPjFw+3Gy91H5HOaJuwMmV7DvjkSyJ1SLqub9OaDLBSWcr18YZH5
         46p0CwJ/hDRTUUvu3BY03NQwjNEAL5uNZsg1P75CIC/cQlgdAezkZyduQXl6f75R1m8B
         WA/2IHud3doEE+gz3Okydd2VATvQEiJJ/O/Wf8Q8LGepTE0YHxR/LGVG1FqGkHEhNd7A
         42YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3UxsimBVOhEDuKfSuQBk+/BzoqRkKBz/Nr1j/ZryG8=;
        b=dbiXoJaFOaZjv4mZ0W5o3RA7xkoYzsVX9N9xCWKbtg/V24EN7oZH1SUtwSJk364IH2
         Toe3vM45vSjovXRbfmSBZTdsjT8JM3IIVdjTLImHhBYaOsij30udEL8FlwBss+j5Jak/
         5+5D/VCgdkfDTp+Oq/yfPSWOlKgWOgh72ewCTlac0r77BubJrb8pIy6b14et/4fS35fX
         QoGUo/Aw4vtdD4ksDQEuK3fb9+64m4zZqVU8GZvINT7iiRK72h1CoEAZczlr8ctQNk++
         Ad6Wm1iE748tobUuQTHhaQAlWN2ZIxUyQtDAvPnMFJWEOoGkBny3NTaIK3xCcqY8o+CO
         qRMg==
X-Gm-Message-State: AFqh2kpgt7A0P81HihBodGyBpWBI3q0kBiak02gE7WEQ30ljS+/8KlwN
        mMQb9Dg1kSc1H8X1wE8BISTYLn/8NM0OsryKmI98c7JiHRMskvu1OqM=
X-Google-Smtp-Source: AMrXdXt0YkaBTrpFdunDUREJLDj9yvlHL4xI+4nHdNaNW/k6tF7R0vqMBDOeqky0agrYPB5X5UyL0/+Wjr719wDOP8c=
X-Received: by 2002:a63:5b15:0:b0:479:3bf5:df35 with SMTP id
 p21-20020a635b15000000b004793bf5df35mr586451pgb.572.1671918406048; Sat, 24
 Dec 2022 13:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20221224101139.sgvhr2n3pbrs4agm@pali> <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali> <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali> <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali> <Y6cma26FKzBQD8AN@zn.tnic>
 <20221224163602.6bqr32tkf2ulx6po@pali> <Y6dsWVspi9tGNid5@kbusch-mbp.dhcp.thefacebook.com>
 <20221224213646.zyosaq7hnlsaje4b@pali>
In-Reply-To: <20221224213646.zyosaq7hnlsaje4b@pali>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 24 Dec 2022 16:46:35 -0500
Message-ID: <CA+pv=HPUgxxJjOJBki1jDjR+Abk3W9=SZ3RxSsB-YYucKBFdaQ@mail.gmail.com>
Subject: Re: [PATCH] pktcdvd: remove driver.
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 4:39 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> And based on my experience, users (including me) are using distributions
> LTS kernels in production. So do not forget that it takes lot of time
> until some distributions switch from one LTS version to another LTS
> version and so it would take lot of time until deprecation warning is
> visible to user. (Maybe deprecation information could be "backported" to
> LTS kernels?)

Yeah, my main server (which I don't use for dev work) is on an LTS
kernel, same with my primary workstation, so I'm also using LTS
kernels in prod.

Would definitely appreciate it if those deprecation warnings are
visible (and maybe even backported?) if added... would certainly help
make transitioning from one LTS to the next easier.

>
> In any case I would prefer some documented webpage with all deprecation
> information. Like there is releases webpage which says exact day when
> particular LTS version is EOL: https://kernel.org/category/releases.html

I would as well, maybe it could go somewhere in Documentation? Not
sure, that's way beyond me.

-- Slade
