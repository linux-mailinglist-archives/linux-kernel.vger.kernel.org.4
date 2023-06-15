Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C783732018
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjFOSca convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFOScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:32:12 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6D30FA;
        Thu, 15 Jun 2023 11:31:26 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso13394565e9.0;
        Thu, 15 Jun 2023 11:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853850; x=1689445850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAR77uCR3RfSeCcsLv+JshB75DeenlCwr/hoeEaHGRY=;
        b=JC20Q4KyZfxKiUMPhQhDHFsD93EPRiHhuUlBLP8PnJtfvMSY8dSXaVP8PfJpPfqarK
         1TTmQujdERUTc071b9ZgMRMuIkEH4UhsUywKL7KfV0v2gJC4mW/u68vj7tTvXxt+ETzB
         3mYJeNqQ+vBd/xRs1cTbAjP1p+TkOx6K4ejF3hjc48jM5h10i3eu1uvP67DtWIN6b1XD
         fZ/ZBPl765bCrdwlCIQYU2zJh/OmaUyFlB9QlFLqwS2r2Y2m293DGWG1Rlm5W2Cd2HzQ
         mmvTbv964EDm+Gl2Dw6Z+Do8fY3Bbb5jQh2wB9d4ZkV9DvBHo4w6XiHcqqp6PpoQwYO/
         1MtA==
X-Gm-Message-State: AC+VfDwo8g31x1turHtPav8WKI3waAOcWjRFg2B4qyXk8LmVJVVvme1z
        o7GuJi7S/uf98HtQGjOV5wYpO6rn9y4nvgIn8Qo8sn1W
X-Google-Smtp-Source: ACHHUZ7m2I05085f7+xOSKFukB7wosRy09WA8BAIVoZdk3G+aEC9ZSzvB0qJYZfyJUiyiypLtuk337KxslNev9Od354=
X-Received: by 2002:ac2:554e:0:b0:4f6:1a99:3b05 with SMTP id
 l14-20020ac2554e000000b004f61a993b05mr8738003lfk.2.1686853829653; Thu, 15 Jun
 2023 11:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230612113615.205353-1-wyes.karny@amd.com> <20230612113615.205353-2-wyes.karny@amd.com>
 <CAJZ5v0gfqGj9X=3bdf6X4HqQDxg+gCJN10DXLruYD5p3kZ59Uw@mail.gmail.com> <ZItQmjQHe/I9CXJh@BLR-5CG13462PL.amd.com>
In-Reply-To: <ZItQmjQHe/I9CXJh@BLR-5CG13462PL.amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Jun 2023 20:30:18 +0200
Message-ID: <CAJZ5v0iKokaEo6ANPO1cHUzM2UL3guf3WcWoVbRH0iNo8D_kDQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name hyphenated
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, ray.huang@amd.com,
        viresh.kumar@linaro.org, trenn@suse.com, shuah@kernel.org,
        gautham.shenoy@amd.com, Mario.Limonciello@amd.com,
        Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 7:55 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> Hi Rafael,
>
> On 15 Jun 19:31, Rafael J. Wysocki wrote:
> > On Mon, Jun 12, 2023 at 1:37 PM Wyes Karny <wyes.karny@amd.com> wrote:
> > >
> > > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > > mode driver consistent with that rename "amd_pstate_epp" to
> > > "amd-pstate-epp".
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > How much does the rest of the series depend on this patch?
>
> The rest of the series is independent of this patch.

So it should have been posted separately as an individual fix.

Please resend the rest of the series without it to avoid confusion and
I'll apply it for 6.5 tomorrow.
