Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7A6E5D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDRJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDRJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:10:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB610E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:10:26 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fa9da5e5bso248723087b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681809026; x=1684401026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIdLuh0YsEXFhwNIbAtHDqpsY5fap9VloDpWQIFGF4U=;
        b=HosxURX3ChbwZKNn4YKQtISwq82SPHNlHvU8+KQZ1TEkHlYSdwkEaq5scPHbCl4xfi
         Bn9K+Aq8rHGOFtRfFAX/W/jNlA4OEbM3RcKWpfeQg49Tz04TjDhfAAagcTbiN+7QbE12
         axNbUDmR2CwEh2pfVHCZQOC5/sIrtY5ksZBXHQR6EXNAdOAE2jENQNQs2Nfg4u/QCLBf
         DV3HRBDBozCNC6QdYCLkYPYNkIm23y7gtAivT3NTsN50XOwrR+dWwGY9guId5dwq7gWx
         M75rPtPkAmpBcGdTABTXYhOzWmb3V/ic1+DCAo0lrFzBgv3XDlIqoLHtxpL9C6jIImma
         izPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809026; x=1684401026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIdLuh0YsEXFhwNIbAtHDqpsY5fap9VloDpWQIFGF4U=;
        b=XMZ0+d7KRtA0ILJwyY0CrWj538yIYRvlP+Fep9A6hp/umq90dX5O3v5dVxCEX2M0HI
         6XimZs8QvK9xfh25c3S4c+6YUhkevvPs2rnDtn+AfQPmL7VL3HnaXZT9Zi4f33GxAs20
         OuabaUuiXcBn5jw5URmf8HbLz4V8ZZGl5hvkVYOw10eM09QF6TyGfHeity7bIw5nXWeA
         w7KwMK34rDj8CQgZgJrnU5UnHmFmj9GSNOV/Kb29NocLDNGAC26blATqsJVqUYHi2hNc
         yTOf6S//MYgJmBQXfYacPf0OMj/VHUn+s26R2SO/SSZ899XqROMYOesKe5xJUt+v0dlC
         +y0Q==
X-Gm-Message-State: AAQBX9f0fxo0TgEztejsBvkDv3KLFetGPZDrCNHHvrKUDGeayHm8YwcO
        J47UoYDN8zK4eP6rTV76KGm5BGeaw8YRPhOZI5k4FA==
X-Google-Smtp-Source: AKy350baYiQUbT4k6ozDbpWs1GqPpRg4luYmX8oNyF2aGUcFzmagNtslM3QDJSesiOtxgceK3fvS/HN1TDH2ygSBaB8=
X-Received: by 2002:a81:4f09:0:b0:541:66e8:d4da with SMTP id
 d9-20020a814f09000000b0054166e8d4damr16184276ywb.29.1681809026050; Tue, 18
 Apr 2023 02:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
 <CAA8EJpoc4nn+Wr131-o=YQoDeL0t7aj9hC=8NNnJa3SeHwgJ-w@mail.gmail.com>
 <934c32ef9427464a9d0b898b843df6ab@quicinc.com> <CAA8EJpqz9o9CtAnXRE86kw-cfL=_d-c5BDAXwQLSJAyZRy_fEg@mail.gmail.com>
 <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
In-Reply-To: <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Apr 2023 12:10:15 +0300
Message-ID: <CAA8EJprztGdP0yqV=O6P2tn4i0+iQ4rfBVY2x-3_93o3C0c-Nw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 at 12:07, Tim Jiang (QUIC) <quic_tjiang@quicinc.com> wrote:
>
> Hi Dmitry:
>
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Tuesday, April 18, 2023 5:03 PM
> To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; linux-arm-msm@vger.kernel.org; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
> Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
>
> On Tue, 18 Apr 2023 at 04:02, Tim Jiang (QUIC) <quic_tjiang@quicinc.com> wrote:
> >
> > Hi Dmitry:
> >
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Saturday, April 15, 2023 5:03 AM
> > To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
> > Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org;
> > linux-bluetooth@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> > Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; Hemant
> > Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
> > Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump
> > support
> >
> > On Thu, 13 Apr 2023 at 09:44, Tim Jiang <quic_tjiang@quicinc.com> wrote:
> > >
> > > WCN6855 will report memdump via ACL data or HCI event when it get
> > > crashed, so we collect memdump to debug firmware.
> >
> > Is it applicable only to wcn6855 or to some of earlier chips too?
> >  [Tim]  Also applicable to earlier chips , but currently google only
> > require us to support wcn6855
>
> Since upstream is not a google kernel, please enable this feature for all relevant chipsets.
> [Tim] agreed , but the title of this gerrit unchanged,  I raise a new gerrit for other relevant chipsets , is OK?

There is no gerrit here.

Also, is there any chance you can fix your email client to stop
putting old headers at the top of the email?

>
> >
> > >
> > > Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> > > ---
> > >  drivers/bluetooth/btusb.c | 222
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 222 insertions(+)
>
>
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry
