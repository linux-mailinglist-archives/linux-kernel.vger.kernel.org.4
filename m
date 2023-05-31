Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DDD71794B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjEaH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjEaH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:40 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74ADE76
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:58:12 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5555a3266cbso2769158eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519892; x=1688111892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InhpvKQBhuZi3uizA3ONGCOh0jmtHn7qt+ZVuzjjuiM=;
        b=tZFMiYqPIJ9QsnTZJcGA5KXCQCUWewvMM43Y7tfBdI99FFxi2uHboFR+hz0rnURJZB
         95PrjmSLJGGkIDPf+IRCikfqpl43gHI9kLLwLtME4A7wROFwLuJk/BnMAG4/L2OYrDgx
         NgzYQrXI8j/ZIylhLq7sJoQnwJ29VxGfg1XUbjJUzqsMVkc0IYlfZyTfLv7v2WaU0amy
         1TkrfPAVkZkToPj/SYDbVyNxeEgzHyIkE8Lp1L9x1lO33UxMzyqQ+JzyA371s7rMeiAT
         P+1kaAVaYqmw1d2GwSjKAiDpBnmGcuUUo5Jw6jK5Hy5nOXQYWpSNShuJyOtnG42v15dV
         EXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519892; x=1688111892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InhpvKQBhuZi3uizA3ONGCOh0jmtHn7qt+ZVuzjjuiM=;
        b=YtObHujtz7cr1Klto+mNVc2aLA0VBM4J3Ocyt8sOEa1XoNWCVT/KufYdpYt6AOFYM0
         lhMV9awbSDSwzSd3McPhlofG4cU1IbGEGeNaQQAm+c+cGZsdoEqSVbtdmJtG91VRi3GO
         d8rkZATCkW12CinX8aNCipolrNJASzFB7jJYmy0bVS0rwuVzuzjWLNu6KVWqvmkkracw
         QssGOLJr+/5v7pBFmyfq2s7xrBWSQZ/Jx6AEwILsL4613WA4Jk+331tzktaAkpH0d1YZ
         fms2lfohAaX/w+0OgfKddoGe9vAR7DG4kGhMdPqi8dmNyZkKVmRHcxMeGQ9WtEz8hXgM
         PdhQ==
X-Gm-Message-State: AC+VfDyHy3UI0ctXokT+yoxf8+OFNoXr3xwvQbjwo+GNKM9Fw4sB6S6E
        YXR65RJ8+c1Ywe40egKy/V3pU3Mg9DAiDdks6Yx9zV/h6o980/F93Hs=
X-Google-Smtp-Source: ACHHUZ6KJVE5W4R+5NrNC41r5RT6N1KjMilZ2ar1Y08ZzVEnNcR+1sdvGuHh8D63nQ1jjTKO7GvQbO0SQnFt1dsMjUs=
X-Received: by 2002:aca:6155:0:b0:397:f86d:3024 with SMTP id
 v82-20020aca6155000000b00397f86d3024mr3019097oib.15.1685519892188; Wed, 31
 May 2023 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
 <ZHYOucvIYTBwnzOb@infradead.org> <20230530-angepackt-zahnpasta-3e24954150fc@brauner>
 <ZHbhEMxW2XjvAAju@infradead.org>
In-Reply-To: <ZHbhEMxW2XjvAAju@infradead.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 31 May 2023 09:57:36 +0200
Message-ID: <CAMZdPi_05osnDu=Bt7NYLR_+JLQpRc=dSrTSdR-46oX_nP9kpA@mail.gmail.com>
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, 31 May 2023 at 07:54, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 30, 2023 at 05:43:53PM +0200, Christian Brauner wrote:
> > On Tue, May 30, 2023 at 07:56:57AM -0700, Christoph Hellwig wrote:
> > > This clashes a bit with my big rework in this area in the
> > > "fix the name_to_dev_t mess" series. I need to resend that series
> > > anyway, should I just include a rebased version of this patch?
> >
> > Sure, if this makes things easier for you then definitely.
>
> I have missed you had more comments that need a respin.  So maybe
> Loic can just do the rebase and send it out with a note for the
> baseline?  I plan to resend my series later today.

Can do that if it helps, please CC me.

Loic
