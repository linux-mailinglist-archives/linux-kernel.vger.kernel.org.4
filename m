Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948C7237AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjFFG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFFG1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:27:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87B3E7A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:26:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so11742041a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032813; x=1688624813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wxrVFm3uxKrVhcM6cNylZEezUfkwf3bB/CCfQ7MBQA=;
        b=vHqFABLRlloYS2vYDirnyPAq9DT3msYXZfgn04oSVQKDzA/G2+KSJEMFhRPEXxqhZh
         LDhHS3uxyViq2v3U0+SxqYWUWNV/xPV5iLCu1sWqESJZn9ZAGuhZUgZXcJ3W1kiRb9ak
         DrpZtvbLnilDDGBZPiw8oMSbvqqUtv80iYbyRm697BXdyJWaJqjZDya1HXxVT1jZwjSn
         VAfR287yMEXL4lk/1xl/JCJqmQuIQQlaufgD9bFPkgf7NZiLWvI5phbLvhPhR3FFiaHr
         Yqtj/xsmcxXZRNlxIvSjJJx0s+GT+CKHf67oNOa+OYz0GbB81lpryNKOJttQz+lF5xBP
         2z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032813; x=1688624813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wxrVFm3uxKrVhcM6cNylZEezUfkwf3bB/CCfQ7MBQA=;
        b=NhCrog7Z3HlDqIVBSjmoefecbcxAZBEhLCnwy/z3Xx724GM+VXTdsTo6iF/DgGT6yB
         jSVx+QXs8sMjjdKfT17SNhYqS70R789lc7L2eWSJvJdNSdDmZALxlR1RG8yBrQ315cSX
         i2IuG+7j8/hiJhuVijwfQ5ppyoRhNuLOUUCPpOWuA1lKbH7cCDb7jOv4d79lsmpKb7m+
         yyREzINBK+3LSTjD5fq17pCF5ERNBLsObYq9MexREbeQ7r0f2wA+RN5dWbl8up3R2yBr
         70kP3TJIY6EZv9bjs62dETrcOjRhgqJac7yoUq782g1gG5tJMxQ7fBFmZ9K/hb5z1sKn
         aVHg==
X-Gm-Message-State: AC+VfDw4tC3NgyqKD1Jo3J4Iup5sGGuTHNBjbMUdPRaHhxm5+ig3sasF
        wEjM4InHSlZXzkFUMqeh84SB+Q==
X-Google-Smtp-Source: ACHHUZ6kCEzeZmDlhGZEmLGfSgWrh5RZJmf8M8N4Z05UgimwYxeV+elAHbvgXQm/smi+b6fpPHYfaQ==
X-Received: by 2002:a17:907:9405:b0:973:93c3:16a1 with SMTP id dk5-20020a170907940500b0097393c316a1mr7006513ejc.19.1686032813342;
        Mon, 05 Jun 2023 23:26:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l14-20020a1709060e0e00b009745eddf997sm5159120eji.198.2023.06.05.23.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:26:52 -0700 (PDT)
Message-ID: <a6df8c5a-cb7b-54a4-0b3b-6b97f16b7b70@linaro.org>
Date:   Tue, 6 Jun 2023 08:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 02/14] dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to
 qcom,smd-channels
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-2-e0a3b6de1f14@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-2-e0a3b6de1f14@gerhold.net>
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

On 05/06/2023 09:08, Stephan Gerhold wrote:
> MSM8909 is using qcom,smd-channels but is missing in the list, add it
> there as well.
> 
> Fixes: 709d473dd5e1 ("dt-bindings: soc: qcom: smd-rpm: Add MSM8909")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

