Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1838A69C73C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjBTJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjBTJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:04:06 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B57198
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:04:05 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536aa45367eso12802967b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgvDnaL1+3BWC5gc6oXKKiEeKgRXRRUwdoGUW4fyHSc=;
        b=IaurzHwU20Sl0Ocm6BljurNJLo4381RQcMZfezsUTYDkAOIRF5rNMn191Q192cuGZ2
         WkgDBf1a0lSPmxnUfXkDol1HWNT/EmCRm/BkMsk21MZtH1FSHtFYcRrIzpJAdVFM9W01
         Rtv5Xo5cfKLc6Kh1pBGg6+aeIVN3hAH5EEWnRIA4CREkeUs7hYpE1OK74inswAAXwhwu
         gsmYJOg1kYMn3/CQ9xKXiwO4f2WGRoyr9VWs/BKHzzxUMbeYOhMJngr/PfyC14RSAfzi
         dCdDuXWWdQs8pNHWrXr9tnbIsldAgi2k7Gcjj5Ri7wf7XmSOwWXrthzHiQ7tOSKo3CF/
         8o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgvDnaL1+3BWC5gc6oXKKiEeKgRXRRUwdoGUW4fyHSc=;
        b=LLhR0ryyE1wwKenMIOGMUiExHHJib/0tRyGmFTHsKLz2VQniHmRSoW4DPOI3np9Xqn
         tMgfNrjlTVlXZmRj7hi96ZCXX9FHij9MgA/Sphz5uS9S3+HMLX7+bGxvjDWMlwdQCQpE
         YwrA7pI6QFk4gAgo/LcRWyhIcNpG/Mya5A9wt/+ZKAHYNC4a4lAlFaOW1s2Npft2BBEr
         KH4l+KcMKsYx5P3AFmeKmqlLsYQ/MnbyHZO//JJm4RKmabKCPHD5ENJwo2vR+q/5vBur
         j4bobbk4dvFX0qtjl/s3zZHUFpxpt6l+bP6Bd9o9ICW8ynxEFTZB//5MWxcflT5sd3q8
         ZoEA==
X-Gm-Message-State: AO0yUKXdTmAsW17RkGGWsmGgTNMo9yUDhHjA8RgcPgKko5GCo/+mJDsJ
        YfvnkCivW2XjzZ3p3EItJBEgZ5wUup+Vy2ExNtrEA8zM72QMNg==
X-Google-Smtp-Source: AK7set/5rSVwl4bI5FUAjAzrA4hlcjFa1ZGyM/pLZ6w3G602+dDKp6FSLg10UYQ2D71dRG9o+5v225A8O+R75Mkom3w=
X-Received: by 2002:a81:bb41:0:b0:530:a598:e23a with SMTP id
 a1-20020a81bb41000000b00530a598e23amr510102ywl.360.1676883844350; Mon, 20 Feb
 2023 01:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20230220091338.1608ab57@canb.auug.org.au>
In-Reply-To: <20230220091338.1608ab57@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 20 Feb 2023 10:03:53 +0100
Message-ID: <CACMJSeviLF4BJXAsK-r2=metMugbhMP_DTGAgepRTOxTLaj-GQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the davinci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2023 at 23:13, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> The following commit is also in the arm-soc-fixes tree as a different
> commit (but the same patch):
>
>   eaafab7e8e26 ("MAINTAINERS: make me the maintainer of DaVinci platforms")
>
> This is commit
>
>   88941ddefc2a ("MAINTAINERS: make me the maintainer of DaVinci platforms")
>
> in the arm-soc-fixes tree.
>
> --
> Cheers,
> Stephen Rothwell

Now fixed.

Bart
