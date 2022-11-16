Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554862BCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiKPMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiKPMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:04:08 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96D10FCB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:55:49 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id r3so20668162yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=byF2+Tj62wDalcappyVw3we/rO7K0IiOk2124Sv3CF0=;
        b=r66bTb1RCHST+3zrWTUustJKhgJSaKPg5iVAZPPPbTZ1qyirLfz9Un8+CFUXS/+ArD
         qm00oiMppTuy0A6LIbb1tifX6qtKsbdtHLGmbrMVb/msE3ZAIg6YHjd6bWX5atxMLHRN
         8d2aU9UECUvMdS6AO1GIgTjnF3V2C8tqla82XE01VuweMGWIa/r8USkec991DkjHuzFk
         TVHiD6kgORVG8juLNhZFKszdAzUtZQvWwVuAxMgHMzjJ93P/oVCBTjA0xSVGpcIWH/LP
         A35zDcnw4/qBAR0xxlXkKSTDrKQLP6nBZk18k+uqS42ZdopKjTi0GEEMXXpIZ73hInHZ
         AbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byF2+Tj62wDalcappyVw3we/rO7K0IiOk2124Sv3CF0=;
        b=ndVTT/71vQrZpXGVmBvHxwDmkmC7G7h05drWLczO3PR2JPzWclWjYqv5VEDmC9Faw3
         APW2P9JeZJxmM0/e8IrOgYlMbRkYVfHqprUzzI/VzWJ9Eltr93ZGYnasndhVRvsv+s+M
         p6Td2nJju1JyJYLFPWBtysQKt5wJzasy4qZqNDYFtKQRFBZtev8G7eofwROhQ/ggrCcO
         2WgCFXXHZcvxM9FxDXo1dZhB3JoTKcjqv4O++ZeqnqkspUCTwE59fmzwHdHfsEiUUM2E
         JyI4U5AM9JqVNj8A0JV3ejhUrNhS88XHFQOAvy62QTC82TZZEUfXZCHG5DW9Ui8G6Wm5
         3w3A==
X-Gm-Message-State: ANoB5plGumc6PTPzqCuXVBJuP/2ma0qfTknUJnQnBdGZuGDV11dlGWQo
        a7E0VPlyFM1hHO0m4Kt+2ZahptuMifO9N4OhsvD2YQW4W2xRPQ==
X-Google-Smtp-Source: AA0mqf57T6ji4QtbiOm7ozKwHq1RNm06sjZlw/ML2pOJl4pPYi14seoPYMw3CVqOZBdAj1BAod6ROMH+MBuFQQsSW2U=
X-Received: by 2002:a25:bb93:0:b0:6e4:c5c4:a62b with SMTP id
 y19-20020a25bb93000000b006e4c5c4a62bmr4766854ybg.560.1668599748753; Wed, 16
 Nov 2022 03:55:48 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Nov 2022 17:25:37 +0530
Message-ID: <CA+G9fYu8grBstgXDsC_g5tmEg0nVwaQ+p0d6vD+mN7UsTvMCSQ@mail.gmail.com>
Subject: selftests: arm64: sve-ptrace # TIMEOUT 45 seconds
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing selftests: arm64 tests validations following test failed
due to shorter
timeout value.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

not ok 28 selftests: arm64: sve-ptrace # TIMEOUT 45 seconds
not ok 35 selftests: arm64: check_gcr_el1_cswitch # TIMEOUT 45 seconds
not ok 40 selftests: arm64: check_user_mem # TIMEOUT 45 seconds

Test log link,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.78-131-g0963ae7afcba/testrun/13014345/suite/kselftest-arm64/test/arm64.check_user_mem/log

and
https://lkft.validation.linaro.org/scheduler/job/5847406


--
Linaro LKFT
https://lkft.linaro.org
