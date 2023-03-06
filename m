Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F116ABA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCFJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCFJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:48:05 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A01BDDE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:48:03 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id l24so5966538uac.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678096083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8Rl9HyT7TpndADVzqj77QvMSEz2A6z3RnfLp60/OTA=;
        b=mMbeKf/dd3hiLv5nabQcmzL03ke8mho4TlYvtp6dZsNvOghcZX9aKJ9XRvnOTPRut/
         7e4rdPNtgcS2erMwo3lZIf1PRzs2Ca32C+Uob0eO0l+VtfWwYdV5pOYMroiy6s056M6e
         N0Iu6jX712QQ8KIdMJu+0ieGIgiqSJxx6rAnJeYCSLlj64wn8EhImXkbxxwfgyCA8OAH
         MdKA80HgQypjmvmPLrmHUmYYb0QhVNRhu6AdnXcHFx+rHV8Ve4Xyf30L2GetK6FxZWnr
         lrIZR3RNvi1Sf9IfgRK1+dikcKV4MZ8K3bG2+IVH85e4ie4o88QdGGMyughTrN6aXrK7
         q5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678096083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8Rl9HyT7TpndADVzqj77QvMSEz2A6z3RnfLp60/OTA=;
        b=dHiwkQr+aGDy9o1wekewoNkCuJQ1CxyIbG0Cku4hr+V3Xu0stDWpVIyj/sFO/kyuuz
         buF6fOVmMKmAu/HISYH8a+o58+FX74huLAbyFT5XUFVhhGB5oHuw2M/WarkcV/OXmI5I
         emph6i8Tsj1s0eUnwMS5QRSnVB0CY3d9SMyJRTagdg6iAjQ6Aj4frjL9PD9giTNMOJO7
         yGyCdAycn6YTJt9EpLTJ8z2Hlr1yEXh/p2WagxMiqmSMPDvDYfmngixQe2QNh6BsX/jk
         0B5YBReKFndABHUPBfMJJvpYUDUxgfHUv+tOd7jTMR8EdaKCftOclnrDbSfi+iO37jnm
         0/LQ==
X-Gm-Message-State: AO0yUKVhuJIEjTFs3zbbysW8ilT0wjgGtLbZFcDdfqh9WlPRQd2XkW2A
        bQXg7pDYUJi71IOw9jjsUawOlbEcnNrME2fb/Bs1Ww==
X-Google-Smtp-Source: AK7set/rBe1gA9kJJoLlrDhasNu5WdztZSp7EzW+PxAmySgwXg12yLzxkUiXD5ZHXa70uMMd/HTAsW/Yme3qGANR1i4=
X-Received: by 2002:a1f:38d6:0:b0:401:a4bf:210d with SMTP id
 f205-20020a1f38d6000000b00401a4bf210dmr6260158vka.1.1678096082971; Mon, 06
 Mar 2023 01:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-2-nick.alcock@oracle.com>
In-Reply-To: <20230224150811.80316-2-nick.alcock@oracle.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:47:52 +0100
Message-ID: <CAMRc=Mem2mra+4gUcGCvAhWoFpVwB8qBDZxmtgcfxkZ0-JcMiA@mail.gmail.com>
Subject: Re: [PATCH 01/27] gpio: remove MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:08=E2=80=AFPM Nick Alcock <nick.alcock@oracle.com=
> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied, thanks!

Bart
