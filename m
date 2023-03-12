Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABC6B6859
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCLQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCLQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:43:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A25A2331E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:43:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s22so12808167lfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678639423;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKTinlG5kM8KUglYqEy7kn40PH2Oa+0TdD9V1KN73Hg=;
        b=p3h0lAmkS7wOqJQv9E8w9VngaoxkqouLv6PMux/89kuFBkzpekN1JUHuY0/ZP8LF71
         D/gXga9gSYI3N3/dASNE15A6m58R40v+1tsF/jflfS77Ai6vOp8FTaL/GkUk43BZ5CG5
         asTKw4wmUgAvpQ2geNpZCaYPxJw2ZQq0O+QJcwAXhU8cjNXyiWA2ERyQ4IG4UWV5m6t9
         GY9izDgrWZ3u/JanKT0cu0akEEnDpfgxm3XHKmThF7a6kMV3Rw44CFE8NjSQtGoB/s11
         4kWEpvALZJlM2btO/ySQ66nQJbyPPSiwxoOF7eu71RbbqMpiaTi4590GER3z+qHAubA/
         QbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678639423;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKTinlG5kM8KUglYqEy7kn40PH2Oa+0TdD9V1KN73Hg=;
        b=i6wKqSCjEZypYcgGzm2lHWV2HTk0KvzN+eYqpSrV0i7dC07qbcy541lpHiGp788G14
         R5/Ftn0LjklKYFs9d0kw/VtiLTJdzaphIJXm+FK3VI6MOWIUkdwBJqKbVNXHbUIWx8d7
         4+ECLHQwW8eYlUALNYxmWZ9G0ViTogQcFKYmTa5qIZlIHzqB0aVX7hnSgNHHTg1mz8BD
         6y8d0HD+DLH9MV35FE6sT9R4alBLa3rlHS0yqCbfUPRXLVtLWhl9zUbnXlQHEOgYu2nE
         q2jZNk9l+u8wvUflQ2QE3V4Qd7iTw+0Z0M7BGZ/kNXOGsui3asU2zU6QG+0qpbGpYuww
         VOLA==
X-Gm-Message-State: AO0yUKXD9wGsYO/d0Nn4hnhSTf2SvJDjcJx0StNabU4QgDdaLRrZGnBZ
        lRG0BNaZBzagSFBwB3BLlRh+7jMeLQD8H6wY
X-Google-Smtp-Source: AK7set+v+IsLPG/5ejVJ1EHmcpPpEQ6n3/Y2wnMJwAPEK+pjHmEIHE9pHbCNT488gN035DcWIoYiqA==
X-Received: by 2002:a19:f512:0:b0:4dd:9931:c510 with SMTP id j18-20020a19f512000000b004dd9931c510mr8856273lfb.51.1678639423624;
        Sun, 12 Mar 2023 09:43:43 -0700 (PDT)
Received: from letter6.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25105000000b00497a32e2576sm700473lfb.32.2023.03.12.09.43.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 09:43:43 -0700 (PDT)
Message-ID: <640e013f.c20a0220.5d2c5.1904@mx.google.com>
Date:   Sun, 12 Mar 2023 09:43:43 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c9f8d89e-7420-a049-907c-60e3fa551548@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Bindings and DTS (and driver) are always separate.

Okay, will split the patch.

> Compatibles must be specific.

No, this way you'd have tons of identical compatibles that only differ in
the exynosXXXX digits, and are functionally equivalent.

> That's non-bisectable change (also breaking other users of DTS), so you
> need to explain in commit msg rationale - devices were never compatible
> and using exynos7 does not work in certain cases.

Valid point.

