Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E16DB5E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDGVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDGVr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:47:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CCC178
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:47:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q14so44612324ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680904044;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKr1VFdANaH910gTqIuF+QQoeNNCvbMtK24RJzAeJ1s=;
        b=BERlpGeiqyFM0KnKvmiUU8mdGnHlblFPFC9arB92MIKu/seqPM4ZnZ+MjWIffcIQ70
         6nPyThcFs0Y78oeP9UgGSbD2pf7HcmqNZsT/SdCz5Ye+azz5dajvX/5PxgoJCBPCtu3v
         G+EIWBDM5fL18cgxwDPF6NQRIZQNPX68rprMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904044;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKr1VFdANaH910gTqIuF+QQoeNNCvbMtK24RJzAeJ1s=;
        b=b57ar188/3w8IqkkaRK06dG8AFhEtdKoDGyaaMS/zPvHhbYyYDiM83X8j8dKH4z5Ds
         nZA2K5wVkFG6mA2RaUsIUhkhasNqz/Gn/bWEZ7RYVm3IuwGO7vNolTfCN8RbXQ+I/4H3
         kovq5trrMp7ChkHe5SwA07nJWydnqU8A+Gc8Mu19sDy/NfOaPY6xkEjs3a75TuZF8JET
         iDAXm1sdH2SjW+aEPbslCzgrmqTexTX/9gWAJahjj/c0SqQGaKTsaLC37Z8adl4yEz+i
         1zEzVH21WpGaRiuoR0IAS21ytRoHzDwqqLXHsLzy3rULYD0s+Gc5JMpLN4SSs63AHFEu
         WFSA==
X-Gm-Message-State: AAQBX9e0vegdSKWmEOCUWPBh2dK09bMQ3Cl4B7p+w9Hlp7Bca4dyRW2h
        Il/ZJ9/r4neNX98gNupdS7odAmzOfdqWAKW7h9umQQ==
X-Google-Smtp-Source: AKy350ZkmDyMUF2lwovyh7fmUX0Xqi/7P8gpx4vAUkL98n181sdNQCjwfzR/32ySpWV+vBM0DQ4nXhrXJTY5+W6hCOQ=
X-Received: by 2002:a2e:be9d:0:b0:298:b378:961f with SMTP id
 a29-20020a2ebe9d000000b00298b378961fmr1072284ljr.0.1680904044665; Fri, 07 Apr
 2023 14:47:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Apr 2023 14:47:24 -0700
MIME-Version: 1.0
In-Reply-To: <20230407142859.1.Ia5d70e320b60d6707c6182879097708e49b8b519@changeid>
References: <20230407142859.1.Ia5d70e320b60d6707c6182879097708e49b8b519@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 7 Apr 2023 14:47:24 -0700
Message-ID: <CAE-0n534cJ-=WdE81oDfGHS=6i5CsW5M8UgYZKrUxLeuO3a9aQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add "and" to PIN_CONFIG_INPUT_ENABLE comment
To:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-04-07 14:29:14)
> The comment recently added talking about PIN_CONFIG_INPUT_ENABLE is
> clearly missing the word "and". Comments live forever, so let's fix
> it.
>
> Fixes: e49eabe3e13f ("pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/4409769/comment/9a1d5def_e1e71db7/
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
