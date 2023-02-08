Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687468E97D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjBHIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjBHIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:00:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF638E90
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:00:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so779676wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T8GlSOWUMkvXqolRXEwWkOi+uALwWqOltz+lIT3MrA=;
        b=rV9fjM7Fvf6/2NSCz6hBbGN3LvJDUFpThIKPOJ5R2pfd7MSbm0MCyIX+yUTrmM/RVu
         8EDaOHut9D5nwON30SrMxEI4A0cB1xrt8LVjXGPZS/AgrlwrOY8WKLCDmkHFO6sUfroC
         3FoNxua0b0/tslQbrCqS5UxU2xAVV9L8R0OIxIXyT9OeMkemMMEUlAQOxPN7ey06LKiy
         WfBxvojKJqhSg3j52ICKZQO7W1dS52Na+0Dc45LSDHIV5a6mWqpDh5AKfH3E0R2Vv2ay
         CPepOxzUCI/E3eLWMXTvU0VHSM2DclQXYMN0OxPlXhggKQui0/ynWPm1IWO5MXSihdWj
         FIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T8GlSOWUMkvXqolRXEwWkOi+uALwWqOltz+lIT3MrA=;
        b=CdAXZPLhSVZa2uAyv/uvILnX2R7CwsCewYMSFUPTDBilbEbjDUmlPXvh+OECtTTdx/
         D+HqZ1kAvp16AqN+ySTzzUBjcx9NOrEmbG4Fp3IyeYjwGPWUonDy/vRmU5OIcscDP4bu
         66dtBn5CpPblPiABNdrUCRB04+KCfOJN87d+yV9kQUp/93BS9xLYHp9r6yGx18enthze
         6YGMuJWmKFMN7KIiFOYoa6A1YxtT95XfHl+1VdFL0kqbb5cDFAUf0cf2jm7zkRwEGWMn
         YY87Lpjjzbuc5QfjKknXlQ0iqldHLYlrIOaeDd97xQSgYtGkdcuPwFy8QqZHfqajZVJ9
         NzaA==
X-Gm-Message-State: AO0yUKVGUHIQZB92EVkXDbf4hXg206r0C0jMsvI3+GOGpJ4HBrmGW06u
        y2BeQOtZ4qN8IF/PdJ2+hFTOGA==
X-Google-Smtp-Source: AK7set822co0BaF2eGyw9WPSx/f1VlCycWqRGJtFjmZazwUIiofCt104vI3x8urd8BRk1Rgu7r96FQ==
X-Received: by 2002:a1c:7417:0:b0:3dd:62fe:9914 with SMTP id p23-20020a1c7417000000b003dd62fe9914mr5607876wmc.18.1675843241047;
        Wed, 08 Feb 2023 00:00:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003d9fba3c7a4sm1093383wmi.16.2023.02.08.00.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:00:40 -0800 (PST)
Message-ID: <614486df-c792-c349-d383-c8d9910ead16@linaro.org>
Date:   Wed, 8 Feb 2023 09:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3] arm64: defconfig: Enable scm download mode config for
 IPQ Targets
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-5-quic_poovendh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208053332.16537-5-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 06:33, Poovendhan Selvaraj wrote:
> Enabling the download mode config by default as the IPQ Targets use

Freescale IPQ?

> crashdump feature extensively to debug crashes.

That's still not enough. Only few targets use it, but all 99% others
don't yet you want to enable it by default. That's not a justification
for me, especially that I do not see problem with enabling it during
runtime.

Best regards,
Krzysztof

