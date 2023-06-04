Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9A721666
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFDLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:38:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEEBDA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 04:38:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so5467127a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685878694; x=1688470694;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rusAMMBSsBeXYA05kondalVZp5FCvnTK7F71ZNyoHA=;
        b=Hx+hqVphtxbMNEM4q6MqwH6e5HM2MEZhOZsLz7RcZBQ1fTsrGHwlYhiVzKhx4GcQ5l
         aGKT8ihhXJjnhkn7f7BNZEUpyP+ac5oaanUG+3aJWLSQ0akF+LnG6W84LffssMXa4awX
         gXcw23gxi740htLd7MPcS+ke9QtDdLYBpyRXITdHrdRqFxbgAkxAVXlaOwmnO9LPkUr8
         b7z/Uj9BAjcAf1mdw5tLla90XRMqO2DmPGIb4wd633YqhHQf7QC4P0AAEHZxK+axYihU
         JVMTkO+ZJJVbWcIV+g3JMQ6CepjW80oT69k5KhDCgNvVOyTcrtt9HRVYDJ4FGSP+FSEO
         N5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685878694; x=1688470694;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rusAMMBSsBeXYA05kondalVZp5FCvnTK7F71ZNyoHA=;
        b=Nd55mWnGZeuu19jKTUihLLdw4ZKlLPN1D/6qxPFVGeP29Y87SjsOD777qFxGrh+QRE
         WIGnMv/R/JQb5lGn8ZwNsr+4Wkj0L+IoV9YXLPLWzQsQqzZkxnfiw814kbpA1rXynqMB
         RiqzgioHGAwVH7W2dpCXOrg9HMl8IN0BbwYaIZhjNMe4418fenkqDjBXFtJCfggsvoF2
         yrCS6TNphgo/qTk0hCc8s4ym/jtHuusVMVHJwJnjxcS1O8F1+p9wduv1IAICI01rDIGf
         +pjjrRN4JssWnU4nQgwL7kjGdi+hSaP8fBnTdaMGNLBRhMKMnrFPSCzciI5f+dWKqD90
         oWIA==
X-Gm-Message-State: AC+VfDzMEEpvNdkgBQel1tJxXj3QrET5VjCj6I6aCb0jhJivYpqAt0Gv
        qqiGnnZo0RcyFkpxJK0bVic3nQ==
X-Google-Smtp-Source: ACHHUZ4jFxPvDAEztjDERKQ4kdD7IgyPuWYCoXh2O0zZkoZdRwdA1z1k/JdpolPkyx0uECm1fBTKbQ==
X-Received: by 2002:a17:907:3f27:b0:94b:d57e:9d4b with SMTP id hq39-20020a1709073f2700b0094bd57e9d4bmr3848146ejc.2.1685878693835;
        Sun, 04 Jun 2023 04:38:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709063b0700b0097073f1ed84sm2947090ejf.4.2023.06.04.04.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 04:38:13 -0700 (PDT)
Message-ID: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
Date:   Sun, 4 Jun 2023 13:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

#regzbot introduced: 9551fbb64d09

Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
searching code") as first one where all hardware events are gone from
perf for ARMv7 Exynos5422 board.

Expected:
perf list | grep "Hardware event"
  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]


Result:
empty, no hardware events

1. Arch ARM Linux
2. exynos_defconfig
3. Board:
   - Odroid HC1
     ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
     Systemd: v239

4. perf version 6.1.0


Best regards,
Krzysztof
