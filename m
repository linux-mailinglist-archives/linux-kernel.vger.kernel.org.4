Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A664DDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLOPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiLOPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:44:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6E2CE30
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:44:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r83-20020a1c4456000000b003d1e906ca23so1380861wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zijsSUVaIUpTN7Np0PCJl6J2whtZWz6/1MPijX4eR38=;
        b=SPG19721mTbMi7Eqvdu5ZSY6gUCCQ80sW6GTjfKBhf/10/KOS/xyYzWnWXU8WAjYSM
         RKsVI6KSb48Ybo5NGD52xr8VArHuPVyGFI11HBZOvhCCpDFlKaTTw47Adh5JbLfturIO
         6gkhZ3aOjHEcEkIU6TBIkbFk/7zX3opP5B7ad4FE6YM+XLhn873N32P0T9lGxnf30Mpv
         42XsTKZIcP/SCT6Qe1g6cP04LRIF2AMOdMcDjVf7hJ1pFb8SqyM1DNtGsTOIvCd4tfQ7
         VbtdOLZMDkNCxbznpD5UHKncTS+L5jHZVSt+fbHT0dfPJFhtF6pdgTStDkPEvC2g23sV
         s3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zijsSUVaIUpTN7Np0PCJl6J2whtZWz6/1MPijX4eR38=;
        b=apuiE4KorZbWJJMi9DaPVxMaYrYTUTJu/jiiU/ih7mHFYd9dl3QhoSf8qqdl/33Y3t
         u3UIqv6eAGRTezWjdxwnLLkQi52f0fyfHWLCn/MckQnk4W4y5w+LKJ+sao7hQPCFXwxd
         Ch9Tp7jjhGTT4voczVFIGUDwQu/15K98Ep/CYcotjfLqJNKlgFdGVDDwk3tu8vPMl9+R
         +FT7kf2BtX5JaenT4c1ZqyXRjPr8dmv/7lmuUgeN3NZgZ3ndF1r4vJqSCCrlZwRGBDBd
         ZctsiI9ThhKtDvufhpNhAbAj/eYHARaGEZBpQN630WqPpx7uHEtPJDBSxxo+2ss0kckA
         XiLw==
X-Gm-Message-State: AFqh2korkVRTn7bsZ5hjmGLZvwxjhCW/MPoCtSqLHC9AyNwJRm3CvXO/
        ETOAFEJu0KMt1AvPOqVBEMvPtmNzXWB06BXnrYrpPA==
X-Google-Smtp-Source: AMrXdXt7SQhwiWv6vRkZCYXtns42GT8BBahf2dxB+IvRUFqX0QrIGIZ5l0Gfwj01LMgROb+UbBYHXugrav0tep/fj/A=
X-Received: by 2002:a05:600c:3ace:b0:3cf:88c3:d010 with SMTP id
 d14-20020a05600c3ace00b003cf88c3d010mr137029wms.180.1671119076344; Thu, 15
 Dec 2022 07:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20221130140547.295859-1-mpfj@newflow.co.uk> <CAAbcLfgUmiM=6eTQRRdkgLSEQZEcZwnzq0=Ov58S_osru-_V2Q@mail.gmail.com>
 <c7cb3be5-150b-a912-8801-670db63bd4ca@linaro.org>
In-Reply-To: <c7cb3be5-150b-a912-8801-670db63bd4ca@linaro.org>
From:   Mark Jackson <mpfj@newflow.co.uk>
Date:   Thu, 15 Dec 2022 15:44:25 +0000
Message-ID: <CAAbcLfikQtFrVAsQgs9dYrXGx5-tFv4Mv-GZonNkbBQyNmFQ3A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 0/5] ARM: dts: nanobone: Fix missing/incorrect features
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 16:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/12/2022 14:35, Mark Jackson wrote:
> > On Wed, 30 Nov 2022 at 14:06, Mark Jackson <mpfj@newflow.co.uk> wrote:
> >>
> >> This patch series updates the NanoBone DTS file to address various missing or
> >> incorrect features.
> >>

<snip>

> >
> > Any update on this patch ?
> > Did it ever get through ?
> > Do I need to re-submit for some reason ?
>
> It's a merge window and you sent it just before it started.

Ah, okay.
So will it be picked up automatically next time round or do I need to
re-submit ?

Cheers
Mark J.
