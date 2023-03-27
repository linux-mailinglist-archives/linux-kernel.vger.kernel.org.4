Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2936CB0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjC0VbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC0VbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:31:05 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2AC19B3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:31:02 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536af432ee5so196085887b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679952662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmWC1eVyie5Yd9L3xoTIr177pdrcFqgDVTeu1P94+OM=;
        b=pVKD6LEJFp7WgyILxH4elBUH7BddDV0rnX5GeAOxhBgopm9E/nzk3MhCWpEh1c3yZV
         YW+ooglmkrhUTi7384C9A4k9F7sFyBMcYV+U1Zh4fE4oH4swk/h9RpExNy6eUCFNir7s
         zhCoJifC4d6TCGU+en3dp7TH6oZab1Suv+kksElkWJ/y64jyphwJM96xhWMoo5JrxURC
         bmNcZUTXTMKVmB0edURJOoKy0Ddt9eiUrJuATyim42dkPYWb99VxPt0FxN2A72XPNsQU
         Mbv+wTyIa7RqCdPkeJLkc1uv2BUVrFZzjWK5ngv0nZPoHKdEZGvm/pqewbZ1CfXfoKsJ
         F5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmWC1eVyie5Yd9L3xoTIr177pdrcFqgDVTeu1P94+OM=;
        b=5CW71fSJEsdKTun12EhaIOdONvLYvwd23iKq6ECPH7DnoGO2A1/5Pg4fVXyRSTBTqM
         v2+9cp/ipf8lquUm8dFymjmi0TwuwscN0snyVLjyfqn0pWD1dHa2DIFLN21WRUTk1Fbp
         ldNPCvOMLOXjCgTQP6ZPEUKr4EdGxrXEfXJ/8nJp3uZqR3ylUlzIFNwL1jDb1NkQ2WPw
         XnsYymZst9hA+ZtwKKDMEsz0GQxcdfb6rTJk5hnByqeYgvqkQFADWs8jGtg5IHQoSeRR
         kdFF2Gxqy5GFqRZeD88rGtduK0GqreaNNYLx9Ey8X0xJ2uPOJ/zeMdt/drMdgMS9Dk/y
         xGKQ==
X-Gm-Message-State: AAQBX9d/zAzoUiCgUAr+PALuObFL3fe6+oRSuFeM9Pp/+WrESS6FJC4m
        /M924qjksVSDOXPEPy1hVhxavI1zf4fmMWsC8lBQwQ==
X-Google-Smtp-Source: AKy350a4hxJBmWI3s3k33APAz6KOE7IC6my3ZU8xLd+GcwS8CRbKaqz6iujdIe4v7DlrVDyP9zFORE3kJZvLlhEs7Ao=
X-Received: by 2002:a81:d007:0:b0:546:81f:a89e with SMTP id
 v7-20020a81d007000000b00546081fa89emr521762ywi.9.1679952661937; Mon, 27 Mar
 2023 14:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230327170146.4104556-1-robh@kernel.org>
In-Reply-To: <20230327170146.4104556-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Mar 2023 23:30:50 +0200
Message-ID: <CACRpkdatY4U0cwXB-fRBat_E6JXpC+ihExUiDC2UZUxSqcS9gg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:01=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
