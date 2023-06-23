Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5DA73B520
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFWKVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjFWKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:20:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C51992
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:20:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b46f5d236dso8131861fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515641; x=1690107641;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWp1zxtH+buOdb032YdtigRP7aafNTMfo7Ltr/ZhNzI=;
        b=oeuI9YPTtN1lYkYab32hud10Qcnzf9q7grzOdIBQhL3pRJ7iE2FTa7XuOVBVMnNpm6
         0vxUJxDkJMkxI/bId/yrL+ojK+8nznwDFSYItE2m4YAWoE7SvHbxX+iW5TCPxhbihxYh
         FSAuL7gAwju84x2tzu2a2loYi6yMf5qBeghCa7d6UlDRbS3v+9bvWzFifeAFukYJMDd4
         OcuQF/R+buNVSpo+xqdQaPDsEgQ6lE1mavIv+eEf6cIzrNKq/6RnWMX3zctIoziPMJXp
         EWS1OSWd1YSoDKgdV2QRRvc975Sgtvicdl407chMFjqztgTY6xLgs6QL3pPn2CfX8fO8
         dzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515641; x=1690107641;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWp1zxtH+buOdb032YdtigRP7aafNTMfo7Ltr/ZhNzI=;
        b=Y3GT5S0inotw4R4HIgijmt2Ga1SLGYzKcleVW22B7LQOBp5xEHN5bJtv/itApxvsjC
         vuhGf/MvkGIrjxvORmZ7LnAZfLNbA8Qo9H/wIki5ReW2W6/ar85yw6NLla3C3RmQPsZB
         9qF7lkaWc3uHJBVMm3Hhg1hkSnieW5riaLJP7CMI9Je9hS1ylQhwp67Q7ZWgr/zw6QbJ
         So1pvRIkuGwHPWQpeW6zih6iKT2+wI+RpsJsSA2CfSf2vVAYCfYfcx20CPiKOkDZIQtt
         dkFmfkYO411VLPsDQ7pRv9rptSro46Gt1m/HJDH6rZPYjxisvYMkedbPyQkYIJql94GA
         NKFg==
X-Gm-Message-State: AC+VfDygUhg9JiKRt9IQ0ri9Pg0zfkuCiN7WyOUsptW5YSf9xhqx8SB6
        meNcZnW7CYRSQQztYRhS17JLsT3Dkedz95n1bQ8=
X-Google-Smtp-Source: ACHHUZ5OJnHDk+ZWi6FaII3fB/i3ouoFr+Y5PEToST4GasncqvwzhDalEHGcKLWNgujrxpcZQXtxsQ==
X-Received: by 2002:a2e:834b:0:b0:2af:25cf:92ae with SMTP id l11-20020a2e834b000000b002af25cf92aemr13558846ljh.22.1687515641475;
        Fri, 23 Jun 2023 03:20:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402165400b0051a4c1dc813sm4959397edx.82.2023.06.23.03.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:20:40 -0700 (PDT)
Message-ID: <bd4946d9-a768-bee3-71a3-3339efa6643e@linaro.org>
Date:   Fri, 23 Jun 2023 12:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] dts: Reserve memory region for NSS and TZ
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        mani@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
 <20230623094403.3978838-5-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623094403.3978838-5-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 11:44, Sricharan Ramabadhran wrote:
> Add reserved memory region for NSS and fix the name
> for tz region explicitly.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

