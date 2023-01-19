Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11F56736BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjASL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjASLZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:25:54 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88375729
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:25:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k16so1258831wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmKi1oAjzk2UoiS3XxEne1iZp6kL62ZaC7XNjem7ZyE=;
        b=N/xho0qcpDEmFFgXmvBj7m8iR8lzd7yK+i7KT3LyMV8eEBpSbhP8HXmGMTqkn/XZFY
         vLB75nsoubJBG+vy+zaNLi+0ZPW3V2qITa5OJIDZWp5MBdttCmCwtPc+L50pkNcmG4uu
         k7N5bPjH5neARwRMno2ZUew2pssc/xWHKrqbB/wwophcXXn13gLi8SEq2mSDL0IeEfBB
         SSCg9Q4cg+sWFZPeB+zbh/MMjc36kK5R9jud70O2Ixcb5gtUiyUQN6hPr5rbOn7dRFHT
         UZS9y4vEeSyCrHIqlKsxLQ6BV4eFZUfhjoYvfly8N6Rj9AzTtDpyzeFT2f6OARUfyr8K
         HOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmKi1oAjzk2UoiS3XxEne1iZp6kL62ZaC7XNjem7ZyE=;
        b=merC1plh4HpCd+PMemKzyPyE4TOkETsZ5ieZ1rGWmD0RA+GSQKao5iFF6WPIv1r6tN
         I66lMqR0IWXoM0PC/RkLP3McXw+8yLUt6Z333ubZFX8+UQ7AytnshWdi9vNCaxsBHBQh
         t5IKJoLXaU9gHhaKzqd/wBynK4UmcUOZaaYmd3W6yMMp8uy8K7Qq9A/LoTNIue1MsJ+r
         lcWfVApP5G7fuCFwSNtv8oLzDG4PA5SQY8eDZZIRrNgrxTh/uTiy02A4QVzDqvf3PMY4
         QlmMUAF5TxtP8e9O1neX2xMnehOmffSEDbgCA34RUFK/4d/MKF9bsUjmmA2BXzU8dkb0
         TCmg==
X-Gm-Message-State: AFqh2krTkXUHUstdjxGnAgYT4ffXQeGPrlFExXQlNV7dRsYpaB1x2lJ/
        F2pwf508tPgkWsxv871HIUFwEg==
X-Google-Smtp-Source: AMrXdXsK8OnHUHfr4gUmTrcjA7sXT3BthqBt8VyH5nY6m7WGnBIk3lWIC/CHBb2WzVRBsfptquLByA==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr6001967wmb.36.1674127532463;
        Thu, 19 Jan 2023 03:25:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm4850496wmq.19.2023.01.19.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:25:32 -0800 (PST)
Message-ID: <5e280ada-7088-3a0f-5889-03f3cbf37a40@linaro.org>
Date:   Thu, 19 Jan 2023 12:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 2/6] dt-bindings: clock: lpassaudiocc-sc7280: Add
 binding headers for lpasscc
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1674120444-23706-1-git-send-email-quic_srivasam@quicinc.com>
 <1674120444-23706-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674120444-23706-3-git-send-email-quic_srivasam@quicinc.com>
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

On 19/01/2023 10:27, Srinivasa Rao Mandadapu wrote:
> Add binding headers for lpasscc clocks to merge lpasscc clocks into
> lpass_aon clk_regmap structure.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

I now wonder how one tests a header...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

