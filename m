Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63950627D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiKNMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiKNMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:08:17 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A24CE2C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:08:16 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t10so12915392ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcgVzNNuvApB1tHFUDQ2YdnueyTykrC4lbR1LLNadUo=;
        b=Sv/Ijmsw3p5EPyzH21o4JoCbwhLqukVHHl52JjWYEMbnQCroLkF+xo4RTmyUi0HlV0
         fSTzYPiKy91DjCenKG/CBLbw7crgBOA/qCpn1agh4ACMe2MF92K8ozv1T2j2mhylToEQ
         WGBr3z+VMoThBd8Tal9GnyFkGK9DvIZDogd5GwEO3pd8rHm2aFTJQdz8lRN9n2N7/VDI
         b5isFpkPbjzj0J+uhDD+wmngMQOhdBLhUxIpehPR/jjy2S6e7oJK5035r7a2Bv/gz+eu
         Ga49PnJh+OzTA+4H1Tyf9dT96O8O8WsCKONajeq2Ghyzi4vx/0/rbRiLdrUdAf9MNeG9
         PCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcgVzNNuvApB1tHFUDQ2YdnueyTykrC4lbR1LLNadUo=;
        b=2rs1jpwKxYlckmvbIBqH9HY5SxdL6Sv0gHAE6MzTgjcBzk9acNwYWFubMzuUKojQzD
         Gd0oCFEBb2GKJXEtn+rR0WtnZQZEGauN2qa1Bf9mTnsTTHwtsgWj9vbADPdKo/JI1kiM
         rWI+5aXZ8tlH3wBVwL9oHDIVGHrPJAoVcN/d3pBoY3SHF9dqGdpUPhfNEUJjJPl13ZFH
         7XX0t3SCmAofa3PA5dVvUhMRpqFwOsT+IWz4twvVVSDZPvrt6TEbG+8kGiiYQBqe9AW6
         /VeZvCL2KnGxQZv9qHP2zV+yUbGUU/8Njs9IiluiN7Zp4sMMTuhCf2wscY1DjOsnupnc
         FXug==
X-Gm-Message-State: ANoB5pn/xofaccSNr5QUDsXij499HNuQDc1x/s/3sMg4t9qPir+Nt7cX
        wfPPsed0MCxS0oOIZc/VHc4niA==
X-Google-Smtp-Source: AA0mqf5FiVxTLlfr5dE+/I1zUYvRmbOurrtiYQu+QcrvL066NEuXUGiKTuuxZ62qyDsdFY2dHX6Ung==
X-Received: by 2002:a2e:3e05:0:b0:277:31c3:ca17 with SMTP id l5-20020a2e3e05000000b0027731c3ca17mr3885380lja.523.1668427694295;
        Mon, 14 Nov 2022 04:08:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004948b667d95sm1800206lfg.265.2022.11.14.04.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:08:13 -0800 (PST)
Message-ID: <cf3b8355-a9db-9a4b-e554-43e829e49a4a@linaro.org>
Date:   Mon, 14 Nov 2022 13:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/10] ASoC: dt-bindings: qcom,q6apm: Add SM8450 bedais
 node
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <20221111113547.100442-11-krzysztof.kozlowski@linaro.org>
 <cf66aa8f-4bf7-d9c0-e2ae-b6fced7e4948@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cf66aa8f-4bf7-d9c0-e2ae-b6fced7e4948@linaro.org>
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

On 14/11/2022 12:40, Srinivas Kandagatla wrote:
> 
> 
> On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
>> On SM8450 and SC8280XP, the Q6APM is a bit different:
> 
> This is not specific to SM8450 or SC8280XP its part of AudioReach apm 
> which deals with both backends and pcm.
> 
> In old Elite architecture we had a dedicated service AFE to deal with 
> Backend dais, now APM does all.

Sure, I'll add it to commit msg.

Best regards,
Krzysztof

