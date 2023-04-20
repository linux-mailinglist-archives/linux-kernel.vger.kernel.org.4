Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396D6E98CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjDTPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDTPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:54:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E90A7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:54:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy21so7388826ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682006047; x=1684598047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRADTVdMf038RUtmLUrTdNQgEB/Pts//XGZF2FideHg=;
        b=elPnFYLrMgd7ANxjO5QiB+95Xsn+6rCrQjnsZkjOdxN2XTxvQfHwutdWG9Xuv7dSOX
         jJwnS4unJwGCayk97rAyqd8v7X7dvEefbChH/6+ZFeJrJ2E6Qd30XCvFwZ8x4OkbMAri
         KyJ4KIqkQJ4EdYdHb426hMPFPZPoBB2OMbCXSukBCy54zec5ogCfZCRohAoqhzZMQKi5
         iGeUBAztW5xDYZ8f1djcaOU1TvjOHdHN8PP7cmvDhnGnj844bTdAkjj070sfX01SMR5k
         GCTiuoLd41ozzpM0hVRQOiNfW0HfaCAstqwbc6pOXXhU0iPryazNOSghhGa/4wu7v1tQ
         gzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006047; x=1684598047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRADTVdMf038RUtmLUrTdNQgEB/Pts//XGZF2FideHg=;
        b=NEEDuXirR5vT75oXYAGpHCpiq636hj1UbDTdyEDJYcQnScBFkBaFwGOi2yMoFr6QJG
         ySPZOasFabINZBnTa+pkOCjJxK5rCXWjH1q2y0IuQ6SatFCrEGXwpnAadbCzo7Wo5BH4
         MKI2djOv2tSWgl+Y37KFxt0amM5ph/LWiHrqAvmW9F57lGM3PYR9/vf9m7EC9YZuAYkn
         kngOw3Mirhs+OygF3PMm86Si5yIfDVitv6tGP9qrfOS45m9FGRcy1pn1gpQly9qofVG6
         g10BuCNzuE5H9i19qL0BSpgBGJzF8q917N3svmF8IBiKQReQ0xlCtYWFXyRrV5Ut1ClF
         ttEQ==
X-Gm-Message-State: AAQBX9c5mnGtdsSxWFyswrJSICaJLLhLb0oORzRzg3h980PP6kN8lSjZ
        IfikGf7P8hQtMNVPIvyV+NLdgA==
X-Google-Smtp-Source: AKy350ZydiiFFVqHq5xXCdVmtWQyNeU3Amyj+OLiWJ01CcMe40w12xEHakcsPkg2i5Dyb93yj3c/7g==
X-Received: by 2002:a17:906:a51:b0:953:43a1:1988 with SMTP id x17-20020a1709060a5100b0095343a11988mr1720288ejf.46.1682006047291;
        Thu, 20 Apr 2023 08:54:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906348d00b0095337c5da35sm903769ejb.15.2023.04.20.08.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:54:06 -0700 (PDT)
Message-ID: <1af930f6-51ae-c986-3eeb-556b2fa34047@linaro.org>
Date:   Thu, 20 Apr 2023 17:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v13 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230221095355.9799-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221095355.9799-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 10:53, Yinbo Zhu wrote:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors, each sensor contains a sampling
> register and a control register. The sampling register is used to obtain
> the temperature in real time, the control register GATE field is used to
> set the threshold of high or low temperature, when the input temperature
> is higher than the high temperature threshold or lower than the low
> temperature threshold, an interrupt will occur.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v13:
> 		1. Add a description about that how works the sensor.
> 		2. Drop the COMPILE_TEST.

Why? We want to compile test. We really, really want.

Best regards,
Krzysztof

