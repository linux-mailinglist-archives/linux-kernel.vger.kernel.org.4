Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6817616633
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKBPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKBPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:31:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C82C67D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:30:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l2so6835228qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAaNeYtIE9F0QZElZY6MMMzf/k79uGm8TBc9K2sR8Wk=;
        b=vuosTVMmmwcG1J2BRW4nrC+4OXNBIDiN9/tRTAC7tQPjiHq6uWPTuUlzmNfZet6yV3
         TcjNW37nn45+prgcA0Mc4KKbb7/ZRK9qKq3KPzmQGDVCtSIHZvAjwmtKol/BpW9O3x0U
         a4Ic456oeZNXO5Ua2OI7lwIBeG+dqRIu9N/COesN1aRfL0jXZWvsgOIjhtRQQDFLhAIh
         r/q5XtdT8ohSY0nOMRaNsdSKAbOx2xu4FYNoC9hrrkUdg/a7MBzcXt7QNrfomsLxG3fW
         fI+NcKjcztFJ8ui2rVw3gDUUR8hXmHHAu8s082e/3XqPPott3Vtr8HSM8XEH5Xwollv0
         KnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAaNeYtIE9F0QZElZY6MMMzf/k79uGm8TBc9K2sR8Wk=;
        b=373wtoNOBnGbRU+HR5BQXTO6pbItNTvCHc8oIam8w8Zk+LWvmOzlyF325QBjeO7Vsy
         G8OPDWm5ylyYVwR0/DD7HBIylgvhrcUoO9y4KfH5qSIxne4KlqM1W4KRiTPyw3rNN+kw
         2Q+qMrNpp8Vo0B7qIZh2ilH5pehkaCaqmrJU6XM+L8SFAk1VGk/isoDL59T1fBNeBmRZ
         pKIO00FV8IoSQRb8GRwSLz+opqw5mYDKaMFkBqmpBeoYX0DegzQiCF6Ap1PrMcP7DrWK
         /AWRRIIAaTaAiJ7vBPCdOsQrnp+xZy2k8hkIxf4IWbHCGcRY5aA99Bkg39Wk/wZro/ap
         GcVA==
X-Gm-Message-State: ACrzQf1rxW3ENwld5YwXiiaCPGAuSMrkp76ty+CQ2AVfxZKr/YSiJtn6
        7PlbtyTatq/NqstmCeB05VLm1Q==
X-Google-Smtp-Source: AMsMyM69BMjOyTlyjAH1Asg2OhIG7ZGYclnIc7HwK2Wz2y3w9kvGB7H1VQqv5CxwWV2fQhrr1v2ppg==
X-Received: by 2002:ac8:7d8c:0:b0:39c:f4b6:f02f with SMTP id c12-20020ac87d8c000000b0039cf4b6f02fmr19764674qtd.252.1667403052090;
        Wed, 02 Nov 2022 08:30:52 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006cbcdc6efedsm8794176qkp.41.2022.11.02.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 08:30:51 -0700 (PDT)
Message-ID: <d7f245d9-2b4c-089e-44cf-a97f8b2d5769@linaro.org>
Date:   Wed, 2 Nov 2022 11:30:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: cpufreq: ti-cpufreq: Enable AM625 CPUFreq
Content-Language: en-US
To:     Vibhore Vardhan <vibhore@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221101171022.133322-1-vibhore@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221101171022.133322-1-vibhore@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 13:10, Vibhore Vardhan wrote:
> Hi,
> This series enables CPUFreq for AM625. This version is a fixup and 
> rebase of the patch series by Dave Gerlach on v6.1-rc3 [1].
> 

Use subject prefixes matching the subsystem - missing PATCH. Tools are
doing it automatically. You kind of break people's filters...

Best regards,
Krzysztof

