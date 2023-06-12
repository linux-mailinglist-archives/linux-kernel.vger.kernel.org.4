Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABD72C1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjFLLAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjFLLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:00:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC1C422C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:47:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bc9782291f5so1275998276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686566834; x=1689158834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zK+5/FNj+k4ZWi43EQASjOkAHsMeL62PdJmxEoQuvdw=;
        b=Fsk6RWO9CMPW7FjB4nUCPNAWgR+seXUZUAMvPpSvNFJGojQyEf/Hm4Wx1154Hl5UDI
         UB2vYZLwjxghyCIoL+h5RTlVTXC2sF7IqxoFc42xayxgHdbjkHkfrL5Y7kHYjvIXf+Q0
         4p2Fnz8sNKAjbsxMNGOATxYr7yeRKMQoR0aBp1rxcEzsI1r1myHTdTi0VbJMuapBA+Z/
         LlJ2jCXgAJqcO2RFsxi7T5vMGGrdRIyf6VJBn6wWxowqb3RlkwFIbeX9t3n/jy+Y46fJ
         RtyASTqTFzyM4Et8Ky30meP05Rfnz72xlrdQFAcXUGuxrd4Nppt40K27YtRsVioKiAwV
         hVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686566834; x=1689158834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zK+5/FNj+k4ZWi43EQASjOkAHsMeL62PdJmxEoQuvdw=;
        b=Do2BHnBS7VZ9dRpmqcp/pc05IT5deVwtVtYE8nqPkFO1zZ5RM0w6msv5uQ9ICjuPNd
         o5R10u9gmqrftwIv2Lq97uHDq5lVv+RV9hRB/tXrXWAjIk3LQ8Ze4hTQiNcDZrx7BWnP
         pH9q+0zVffy+DtkaERwx+SOVy05gcdaWeNfMOG3buxKVsmKhbmxBjKA3z5/ecKYvyos7
         UUbLjbNy4HnG5HY3n9dAK0sKYn2WZ3e0k7Z3OlsMJOJJV3tL8cafrxmENFNWNcPlNaqK
         qLgD3A/rhAtSUn+0tj/F6lcyFcl6paLXR4KepS7TbwF2it9Rgszj8c8+sOB0EK0DZygc
         bG4w==
X-Gm-Message-State: AC+VfDy5DHjUIpcfCkVs0u5pa2xRa/q2x6sQtl1fZ45UaYPzZSBnMMYL
        FCdgAjerOHyRsvIMzDt1BxMhQ1rHZP96fakQEAOXDQ==
X-Google-Smtp-Source: ACHHUZ6B/OrlRtGQbF7+ZlmWNRQP3wH8yAKtLDhv0Y2cz/pnTQ56MIjj3LtTMrgBz1H2qPBaU5jC32UVg3A0NPJGElc=
X-Received: by 2002:a5b:d06:0:b0:bc7:47a:9861 with SMTP id y6-20020a5b0d06000000b00bc7047a9861mr4650391ybp.51.1686566834491;
 Mon, 12 Jun 2023 03:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
 <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com>
 <20230525024546.ug6nbrmkgx2alerc@ripper> <CAPDyKFrzHHz+c_y787TVKLGizA3vVfKvnu+uJ1JC+itgryfdSQ@mail.gmail.com>
 <20230529160848.ujthfuuj3zblkq4b@ripper> <CAPDyKFo1rsm5gk_eKESa_WMFn6bSicH1UV1vJ7CU_64jZ5Uj-Q@mail.gmail.com>
In-Reply-To: <CAPDyKFo1rsm5gk_eKESa_WMFn6bSicH1UV1vJ7CU_64jZ5Uj-Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 12:46:38 +0200
Message-ID: <CAPDyKFp0wHxMZYACX4TFzDr+vM=fT6dNGQooCGOip82w+3A28Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
To:     Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, dianders@chromium.org,
        swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > >
> > > > > Looks like this series has not been queued up yet. Note that patch1
> > > > > and patch2 are needed for stable kernels too. Moreover, patch3 (Qcom
> > > > > DTS change) is dependent on patch 1 and patch2.
> > > > >
> > > > > Therefore I suggest Bjorn to pick this up via the Qcom SoC tree.
> > > > > Bjorn, is that okay for you?
> > > > >
> > > >
> > > > Sorry, this fell between the chairs after you pointed me to it...
> > > >
> > > > I can certainly pick the 3 patches through my tree, but are they fixing
> > > > any current regressions, or is it just that we need the first two
> > > > patches to land before the 3rd patch?
> > >
> > > I am not aware of any current regressions.
> > >
> >
> > Okay, that confirms my understanding. So not -rc material.
> >
> > > >
> > > > I also presume the 3rd patch is only needed when paired with the new
> > > > ATF?
> > >
> > > Patch3 is beneficial to use with a new TF-A, but works with an old
> > > TF-A too. Anyway, forget what I said about patch3 earlier, as that was
> > > just not the complete information.
> > >
> > > The problem is that we can't be using a new TF-A (supporting both PSCI
> > > OSI and PC mode) without patch1 and patch2, unless we are using
> > > patch3.
> > >
> > > Thus, I strongly suggest we tag patch1 and patch2 for stable kernels,
> > > to avoid any potential conflicts of TF-A versions that may be used.
> > >
> >
> > So you're suggesting that I pick them for v6.5 and add a Cc: stable?
> >
> > An alternative would be that you take the cpuidle patches for v6.4-rc
> > and I pick the dt for v6.5 - given that the cpuidle patches actually
> > resolves a problem, while the dts just introduces "new functionality".
>
> Right, that's probably the best option. Although I don't have a tree
> to take these patches through, let's ask Rafael if he can help with
> this.
>
> Rafael, can you pick patch 1 and patch 2 from $subject series for
> v6.4-rc and tag them for stable? Then Bjorn can pick patch3 for v6.5.

Rafael, Bjorn, sorry for nagging about this series. Can you please
help to pick it up?

Kind regards
Uffe
