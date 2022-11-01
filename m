Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B51614D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKAO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiKAO5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:57:17 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D276436
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:56:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e15so10437537qvo.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91Pi1sgd0zTVujDHIVVyfFUD/3uaMubrRUnbeHfYyeI=;
        b=fRDx55YIuvo3rjltGc0Bfuid1YLiG8Aj2v7JiRiqgJzNtqOigagNjxgTi21qsG60da
         31/WYflyGGBailfSZhPkcKHnpIxsjqw2a3iGIpSm4W+/bbNxaUb2YWfRLLkdgGr809Xb
         02CzHgVQhrhe+wgCBDBoERD+OQgg4VS+9yiPcOkDKlbDQxMP22ISAOLDWfj2frFbw0ug
         INy4keqNqMCS8mZfnmfKOTKER42HQHw4XM78vqIScoO5ynaqm0jlTxosKb3A1tEyVQj8
         +D5Wg9WyaCTZRPxRBhBfDjhx62EDu+OGdh+qSj6AIQ97SwpFMX/bM63fFGWsLr7xPPSe
         NUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91Pi1sgd0zTVujDHIVVyfFUD/3uaMubrRUnbeHfYyeI=;
        b=W9kVZ4vLKn6tx8yuxZUMteAhP4XfDAHOLVxxjflgtf6+L87IGLolgZCGH9Sdyhj3//
         AKiScIyJ3l9mCFU2RGn4E1cp8rj50rfP57SaYhWb+7sZtIBx4o12S05BxvNK25IWaY9P
         UW8cfZTZhNNPkL6Kym3G1ywOrRkG4MsMgTSpDFiejAPFkfkdtiG2dQAx1V5u5WP14y6h
         gvBvmPJqJOvIe+p8N6GShQAB0yJPdnwr6AHAOVl+3IjQv0/yB8gz3U0JOHAXzy/LL44V
         vKQFYRVCAejIQOwOAUdfNosbwA5FoE1u/Oz88Gy73i9RNwxPZIK6cnI7tNjFAWOyezjA
         fGiA==
X-Gm-Message-State: ACrzQf22UtAsWUv449663CkmzLP+eozjNqe9KMCbf2KA8JnniTZJWVNL
        JaEch0x9eN3i20/tLu1w9pJ4W8cHjfmkjQB5C00=
X-Google-Smtp-Source: AMsMyM5+VC0MbPsIUuv66pB203xFny42zcAiRVPVoqdEHirqq+IojKHlO94SZEMMAfcULWsc73j3D3FjHaoi+Gs/A4w=
X-Received: by 2002:ad4:5bac:0:b0:4bb:db4d:b60f with SMTP id
 12-20020ad45bac000000b004bbdb4db60fmr13176764qvq.105.1667314565724; Tue, 01
 Nov 2022 07:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667305446.git.tanjubrunostar0@gmail.com>
 <ea25c687d28f5cf40c315b8191d98fa0608f8a76.1667305446.git.tanjubrunostar0@gmail.com>
 <ea1476128e2f21956ad99e52b01f0c99f46e70ba.camel@perches.com>
In-Reply-To: <ea1476128e2f21956ad99e52b01f0c99f46e70ba.camel@perches.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Tue, 1 Nov 2022 15:55:54 +0100
Message-ID: <CAHJEyKXhEGnFRfdv5xSQeEp4bTS4FsvU9oU=hfeuUdYVaovWHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] change the function name s_vFillRTSHead
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
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

On Tue, Nov 1, 2022 at 2:32 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2022-11-01 at 12:37 +0000, Tanjuate Brunostar wrote:
> > Remove the use of Hungarian notation, which is not used in the Linux
> > kernel. Reported by checkpatch
> []
> > diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> []
> > @@ -23,7 +23,7 @@
> >   *      s_uGetTxRsvTime- get frame reserved time
> >   *      s_vFillCTSHead- fulfill CTS ctl header
> >   *      s_vFillFragParameter- Set fragment ctl parameter.
> > - *      s_vFillRTSHead- fulfill RTS ctl header
> > + *      fill_rts_head- fulfill RTS ctl header
>
> Perhaps use header as head is conventionally used in lists.
>
>         fill_rts_header
>
OK, thanks
