Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E65F35FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJCS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJCS5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:57:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D531D0FA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:57:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qx23so6090237ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TC+pHMV1HCDu2K8ju3lln4difJwCLYwNsc8jznPs2wc=;
        b=Fl24iU1DKzubOlAHqax3lecBZDt018smBQkqCbMZGoaPFMGq0qiXYayZUXpfLeIlUl
         EuPMpdhEZV4llPENJVwg8jKqo5MurVTefe/VVQePameVEoeqDiAvgzSKh042IhTptK49
         nRQHJ6TN32Rp+lb8VRBh2vROE0kjdRpU6ucmVH69/0+1wS0wz5mxUwyVXwa4i87ZU4Y6
         rKD9NGidF0DnzjLRmoODJR0gwtdE9sSMzuDkY4hkiqZv+ejD+llijlO0ZSNxxq1jmki6
         WQCNZEhrosBii9PYkD9FIMzgoKDRj2gnjsI+2YKlskblr81VqwNaAdoBQ6fW1LawT/MC
         SqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TC+pHMV1HCDu2K8ju3lln4difJwCLYwNsc8jznPs2wc=;
        b=Um+tI4IOhSdGxcxWUwjiaG21gsl1N9L3izP8sg7FUUhk830izJJVKayICQbIZD6r5h
         cOcB6jJvENBAWd87C8rUv8rPLC+D2IGYLFZRJ7v5r6+jV8wJkm6RFl1hbJbN11cC7MmN
         /4/opWV0aIsK4qdjBuKH1oxZ5EA0DaHx6B41PT28eb7yZCgOoeWM9I6dGIF4CdjGrNh4
         OxvX5AmFExLUj0XREqLu2GK/08uEiz7M5ZYeyMB2KuezcZL95Sz7A5xBCfCttPto5/5j
         PgyO98br3qlsPNwWnIOjqbJ0CirK9XKkFR+MSsDUAKD0Ty5yHPovxtqSduGZH9ty22u3
         XfOA==
X-Gm-Message-State: ACrzQf3K2GwDNtIcxwdukWMaNhVX7gNeGEu2G95Dzs07kwVJjzuDiYi3
        8+VgFxh+NWeKZw9MaC90TM55p1MixRq5QITuBAPopQ==
X-Google-Smtp-Source: AMsMyM7iZ+IV2KNHk1Oa22FwFLHmM7i+dJoYsaKpBJqhFJECdNz3CnPXETmuwfAJTJY53oDj+8FLIawzEWB9kABrqqI=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr16122295ejc.440.1664823461226; Mon, 03
 Oct 2022 11:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220929181505.1100260-1-f.fainelli@gmail.com>
In-Reply-To: <20220929181505.1100260-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 20:57:30 +0200
Message-ID: <CACRpkdbu+E-Go4dEBFHb3Rwp3StNJGoctSDEkusL9r8kM1p_qg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update TI bandgap and Davinci GPIO entries
To:     Florian Fainelli <f.fainelli@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 8:15 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> The email j-keerthy@ti.com is bouncing.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

...but Keerthy sent mail just a few days ago?

https://lore.kernel.org/linux-arm-kernel/20220922072950.9157-1-j-keerthy@ti.com/

Yours,
Linus Walleij
