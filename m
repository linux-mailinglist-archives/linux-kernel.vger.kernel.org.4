Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFD66DBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjAQKzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbjAQKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:55:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921430B37
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:55:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k8so15650351wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/3tpm+1tTz3Wh67+zjCvzmePmhVXCLhDHdQOJyGVPE=;
        b=RmSvhLBW46xXKn0DhfEzkoOeiRODIUgVjrFTKFDo6pY1PuYtC6OKZVRO2S4+SvnwZA
         V3yRJI+dRkP4jYn6VPcm0YZtwbV4aqngFngFD9kqJ3w9RkWDiyML4qJp4i2blD0vn1on
         PzLJyO271ipllUjipKNLXaodF59RAc9B4+nDlqkH4/Mjky5GzZDepIPRxfBUy86hFJ9J
         /EWNFllVfu3BhR6RNCFZPUe6zsCdXWH3wL3+xRKNfLJpAvlndZBxBcdtQvMW2A99VVdg
         wCM1u2cAVlq89AOsqq47S6H4y9TMRbRkzTJJ72OqqtK5Q/BMY/5HIHMn8tkLaQDH3Y+S
         Pnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/3tpm+1tTz3Wh67+zjCvzmePmhVXCLhDHdQOJyGVPE=;
        b=UftzRVmK9M+Cs1C4nswVH0lqW12MFjpok9AufXzPuIDyl04GwdadjfZ0gCCqGRRLoY
         oDWw6TtZB6GGyJdh2Km3HLDm6mmc4A8OVJ3VSWVDbxCHiFTfD1TBmJTYCIH0H4Mo6/bA
         ShybWo1ImpPlYAm51FiFRWhV5+f6KHFO4oHah4zI6uq89cv0dNQiKt28T+A1vCe7ASui
         YaO2nNpR2h8ziImCSOuMO+DqMiStptPIRKMHxQhtp6OclDZNg5UfskKjGXpG1jnxt371
         ET8DYwwSpGYjqlC22v5HrUotdWh9k5mQTuobgKnpWiUCbir36Pub8bIJqPSIRs9uvIAa
         Mnjw==
X-Gm-Message-State: AFqh2koN1asQU+pdbnuEg3p8g8YvY+EsK3t6NOHjCOofE49F2hZMOgXc
        I4seEwMh6gXVVuIQrGUudRt0Mg==
X-Google-Smtp-Source: AMrXdXu4tk82cLPBxHMf8rC7EwZnWgP0nSZzLSHlYPURhCAOh1o8JhR1C8N5GSKivz0MUPMUjD313g==
X-Received: by 2002:a5d:5190:0:b0:2bd:fde4:885c with SMTP id k16-20020a5d5190000000b002bdfde4885cmr2318679wrv.63.1673952944756;
        Tue, 17 Jan 2023 02:55:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm7631755wrm.66.2023.01.17.02.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:55:44 -0800 (PST)
Message-ID: <1b42fe97-16fa-d004-539f-54e2cfecd38f@linaro.org>
Date:   Tue, 17 Jan 2023 11:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] dt-bindings: power: Add starfive,jh7110-pmu
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230116074259.22874-1-walker.chen@starfivetech.com>
 <20230116074259.22874-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116074259.22874-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 08:42, Walker Chen wrote:
> Add bindings for the Power Management Unit on the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml   | 45 +++++++++++++++++++
>  .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
>  create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

