Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505F730F84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjFOGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbjFOGio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:38:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F426A2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:38:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so1348530276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686811098; x=1689403098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN4dZI7gKG4P+u+i7PgTDiFGmRqA+JQ2PDHkjFHkniQ=;
        b=VENEmsbEHPy5l8GsWeLe2Q9EnYmn09I4/q6g/pVmXbC0YTv0qI97omWcJk+ortDlgp
         DbezUpnrTs1pjg6U1GGgQnozX3mXDGFh/GCAA09AoONXPT0k6W6Rj3Y3iQiERFL0/7SO
         qvUTEDlQ2H8m619DGeUaCuqQrT3M73x7YL2+I8aNXnEn9xXK9qkCdFrhEOpV2yt3s0Vo
         XpafVdzUySnnUWLNO8SBXFiA2y8XGl5nUaQ5pwbQ5ys+0QFRoGhdxrre17k93VaAjlyb
         LR6+k58sx0KF85FL6Na8MDFA6/bKHsw1j9qw0pKGlAUtHlCvHfdQURIeQbM3tJIT1oGZ
         PaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686811098; x=1689403098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN4dZI7gKG4P+u+i7PgTDiFGmRqA+JQ2PDHkjFHkniQ=;
        b=Sbjz/fQJqdHCnrg6HLpC0wRArg3Jtes9w0hLcTWhSLiUBaeZOeSbd2fLSsVt4cwvGC
         V7C7cD8EuAt1u87jl1HeL1g79z1EMHTQnpr2W4eK8Kxyt1e1SOsK4llfMPHTNiidYs8w
         fNTWhwjcqnO020j+K1Y1eLGrCC6lijJ5GF12wpHlLZykuMFiooRvJmjV2Z9k92nYxcoc
         8eW0OWxo865IhB/gL/jAFAJarEQXrXvqiFhm4u+MwXbAP/x1WRZn6KRrFbfOq1kLGU9J
         DoRjmyo11BCj9Nfwgpy6qeGsrx+imv2elLgLDSvfF8Dm+gj4ugLnXv5vyq57HFNkrapi
         VhBw==
X-Gm-Message-State: AC+VfDx7Q1O2UT1JEHpVhPWvYuGkbP27EnwQX/z2UqKJc/LkUFrXakYt
        cJ6vIKjYgfPBgB2k0htAHrG1xivXZgs59yNiLWsZlf9lUIwe0edce2o=
X-Google-Smtp-Source: ACHHUZ5K0UZnEQWW7Hly0IWBgrCPksLQ7kI4IcQAAFkmDSCPLEUYOsO8XaLv3JOtIIy6xC7LMFjLMq9z7PkiugajbW8=
X-Received: by 2002:a25:80c3:0:b0:bc5:affa:fedb with SMTP id
 c3-20020a2580c3000000b00bc5affafedbmr3645121ybm.41.1686811098412; Wed, 14 Jun
 2023 23:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-5-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 08:38:07 +0200
Message-ID: <CACRpkdYXE2v+esitZoasczcij-EEBtd=50vFHHeEUWy_T4_1HQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gpio: delay: Remove duplicative functionality
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Now that GPIO aggregator supports a delay line, drop the duplicative
> functionality, i.e. the entire gpio-delay driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is the most pleasing technical solution for sure.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
