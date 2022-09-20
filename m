Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90845BE4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiITLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:40:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5C61D5D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:40:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y17so5439667ejo.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=IdlFGCXoJY/QZY2cE7K+3XDnlb/W4014NQvw+3M2OJ0=;
        b=BViyFnWN2nNt/PnYtTMLhjloklGbQaJk6h+DgSCH5tbS037vuL/znjRqh+T/QU9lOQ
         ziB85DTh5qQw0/hFLoC4hkub06WsFFsBsFoEQpVsp3D1QolFyMK2SbT4gX8+GPbCJ+wO
         GXkVDJbLKo8E6TW/c/CjTa0OXuM0ujWH1iUYTa3uWflE/RAwd/RwpP0EweEdyemmAmTA
         1S9ZxpzcOIhoMdLTMGCJe/1kZbxXy9ofu341OcsSxWiuBQbc6mJSlO89QPd7ekPr0dPL
         uyrcI3RK7dMukWKCuAjlAT5I6q7wCP7I48q4N7F0hyRt9Mrfv86r58l6jLp3msL4+I0O
         i3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=IdlFGCXoJY/QZY2cE7K+3XDnlb/W4014NQvw+3M2OJ0=;
        b=i1KtQBEzy8aSbtDUoVGiI28nxzIPmQUNOKp3TqhIFyhP7DXn9jbbao8Qm8G2MfN2pR
         bK2sZn1AGdIiqIfulSjVWgga0niHNXDaR3O7os7NhGeL+XH0dRnACqCd7goyi4+MBATp
         vvNlVOPmr3Q6TH5tri5PG6ri3prS+CQuSWXteHbM81ywscAtV8LULfWpanh4tYjsjRMI
         XcmGe2OwvNu8TR1eIsDrvVv6qmdtEYvFguk3Rso2AHRfbT8YUyVYS9FJvCTwhu1vAXwL
         AvQXHuj/z3R0djPj3b3KgBYB9x4iAtdjAh1h+u6U1X5qooew5+9hOX7t3JoqOEW7rXAb
         oxlA==
X-Gm-Message-State: ACrzQf0w8xqLpBTgknZ2pRB7sSsUgOqa1wetHbeEmzPMqdOjO4IBPH6N
        SLPDcmBLzKaqkCH8Xp0GzCA8C5/Ss0jBKo40IP5DSpVdjinFrg==
X-Google-Smtp-Source: AMsMyM49sXmpd6lWbrAupSenNeulqi/l78zyZ7dh7IhOh/g5e5W6RHynoFh+W3OVALJyEDHciG5xGr/PFIUVqxqoS2M=
X-Received: by 2002:a17:907:3188:b0:741:4bf7:ec1a with SMTP id
 xe8-20020a170907318800b007414bf7ec1amr17052253ejb.448.1663674007013; Tue, 20
 Sep 2022 04:40:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Sep 2022 17:09:55 +0530
Message-ID: <CA+G9fYtpNsjRzQdxFvLjVmG9XX95B6DtaviHq3oG6awGYTqGSw@mail.gmail.com>
Subject: coresight-etm4x-core.c:969:26: error: 'ID_AA64DFR0_TRACEVER_SHIFT' undeclared
To:     open list <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings / errors noticed while building arm64 coresight
on linux next-20220919 and next-20220920.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'

drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
'cpu_supports_sysreg_trace':
drivers/hwtracing/coresight/coresight-etm4x-core.c:969:26: error:
'ID_AA64DFR0_TRACEVER_SHIFT' undeclared (first use in this function);
did you mean 'ID_AA64DFR0_EL1_TraceVer_SHIFT'?
  969 |         return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                          ID_AA64DFR0_EL1_TraceVer_SHIFT
drivers/hwtracing/coresight/coresight-etm4x-core.c:969:26: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
'cpu_detect_trace_filtering':
drivers/hwtracing/coresight/coresight-etm4x-core.c:1057:57: error:
'ID_AA64DFR0_TRACE_FILT_SHIFT' undeclared (first use in this
function); did you mean 'ID_AA64PFR0_EL1_DIT_SHIFT'?
 1057 |         if (!cpuid_feature_extract_unsigned_field(dfr0,
ID_AA64DFR0_TRACE_FILT_SHIFT))
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |
ID_AA64PFR0_EL1_DIT_SHIFT
drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
'cpu_supports_sysreg_trace':
drivers/hwtracing/coresight/coresight-etm4x-core.c:970:1: error:
control reaches end of non-void function [-Werror=return-type]
  970 | }
      | ^
cc1: some warnings being treated as errors

Regressions found on arm64:
   - build-clang-13-lkftconfig
   - build-gcc-11-lkftconfig-devicetree
   - build-gcc-11-lkftconfig-kunit
   - build-gcc-11-lkftconfig-perf
   - build-gcc-11-lkftconfig-64k_page_size
   - build-gcc-11-lkftconfig-debug
   - build-gcc-11-lkftconfig-libgpiod
   - build-gcc-11-lkftconfig-debug-kmemleak
   - build-clang-14-lkftconfig
   - build-clang-nightly-lkftconfig
   - build-gcc-11-lkftconfig
   - build-gcc-11-lkftconfig-kasan
   - build-clang-12-lkftconfig
   - build-gcc-11-lkftconfig-kselftest-kernel
   - build-gcc-11-lkftconfig-rcutorture
   - build-gcc-11-lkftconfig-armv8_features
   - build-gcc-11-lkftconfig-kselftest

Build: https://builds.tuxbuild.com/2F1cW8NpQ0Z6l9h9rfkZT5AXzqg/
config: https://builds.tuxbuild.com/2F1cW8NpQ0Z6l9h9rfkZT5AXzqg/config


--
Linaro LKFT
https://lkft.linaro.org
