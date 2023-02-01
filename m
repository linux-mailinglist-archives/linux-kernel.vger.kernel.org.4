Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA150687135
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBAWqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjBAWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:46:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CB3EC7E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:46:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so63455wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zcsaJFGJKJdeP1nR9ZOc0Yct8YSI4VsrAEOxvHTU70o=;
        b=Oa32+ACmANnddowY432rxyyltPYJWH7wLodQGwYqykk5icNOdqOWVdCyzd8fAbpCLi
         PY2TB7P1emumDKp4KoJ7UtdudRMuIKOvHZ30w+Exea6UYqsZE1fhXqZnM+u5alUsW1yc
         aFr6T03r2Zm5PjAGfGVlDJI/omKcwtfnxYMADFjAcrcNrSWXaAzQsBzlSIkk+vtTsIm6
         /jUm2In5Yw6LkA7EY8Dncw2fTdiQMNLFwh331Wk2WOEPo1D+3Rsa1hNtJUB06HCfjO/K
         7uxeQsCMMWSJZ5hSIjqYNJz2X2hV/2YfU1HjMnGOr+vmO/ZZdTNG967IOCC/qXna4zul
         P+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcsaJFGJKJdeP1nR9ZOc0Yct8YSI4VsrAEOxvHTU70o=;
        b=NEQLZlaSndBb4LySsAzjXUpr2ATjDJbxmEB86kwJQkcJ5dC+FLB6dCfPwygwLr4bZ1
         EcHX8YeMCGFEsKSwQleFkgf6ft4qpAcKj0cSOK6xtQpHt8OO50hgEJSNshEVgQPbI9Nr
         Zzm/5fpQ+iEFEHmqrLhwZj91HnIT5l1DFIWO9CSi7WmzQtVqgR6VFaTxOvv0O2FxmZDH
         e3lgxNME+ny9KWQeO55HUGJDrXtPi09Mv7SSwwTgLzIZvAR6RZbhVqY8ycSBJtdzWgFC
         nfI3PrHl7lpIYi3r8snG2cLxnah1JSfBFOBw8/faJKxgBjroSsOf08Bv1/C0LykEbPKZ
         aiIA==
X-Gm-Message-State: AO0yUKUMFYfKZN9uO3ZhRMInRXAz194NXajbdUxl3HySvTEd2uFe8cwD
        hh3I/CjNlRoPOihhQzCaomwVFCD5V79VlMGba7nx7w==
X-Google-Smtp-Source: AK7set+xMonyfyazL44BXxl6mZgx29LYm3dnxNejYBRbFGBaPnrMzbphkQoM4VjWmsysB+ojKxeAty73exHq+UgiziM=
X-Received: by 2002:a05:600c:511e:b0:3de:c457:2443 with SMTP id
 o30-20020a05600c511e00b003dec4572443mr34874wms.112.1675291581418; Wed, 01 Feb
 2023 14:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20230201150011.200613-1-brgl@bgdev.pl>
In-Reply-To: <20230201150011.200613-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Feb 2023 23:46:09 +0100
Message-ID: <CACRpkdYEQkxEJ23Xt4hjwu3Jxct-QXZktdzze5Pf6SBNYj80Fg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: qcom: add dt-bindings and driver for sa8775p-tlmm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 4:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This series contains the device-tree bindings and the pinctrl driver for the
> SA8775P platforms.
>
> v2 -> v3 (Changes in DT bindings only)
> - fix the gpio pattern property (platform has 148 GPIOs)
> - add blank lines for better readability

v3 patch set applied, fixing the 149->148 number in the example
in patch 1!

Yours,
Linus Walleij
