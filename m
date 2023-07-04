Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6823774699E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGDGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGDGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:24:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A97E76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:24:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso1401011fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688451879; x=1691043879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysKLbkMaHd7CpfuuBq5QAfneGIJ3MozjrzSbJoSmczI=;
        b=eI8VYpyuiGr0qMDlEmx1ltrgQvuvAZRiMDT0uGrTY9bZ9Y/lheAl9bi98scqkp9Ma4
         kO3R9ja8M6XxiVeK8ytEeFCl10KkGmfkbqlV0prg4b4XFdBlWFSs20MWOC7TvNLi+cLl
         lmtpNlN3aOPk1fVA9iZW8e6nfJUha2aWnpjxmJAWpYw8bqAeSqyGfDDTpkbL5iGy4ymb
         gCpmoTLr7e0hbsFBhFioU/iAKlPRLimDhHnBkLaKGgm9+YDv/jwsxTZ3pvrjSM3ITwUP
         YXX7f5ZuBnvl43tz31lZzO2XpHw5iB5VyrF8AMw5B8QM5H7k1hTnA6OlNLejo/Dcv/wh
         7cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451879; x=1691043879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysKLbkMaHd7CpfuuBq5QAfneGIJ3MozjrzSbJoSmczI=;
        b=iCW06Z8NM7Lv0IVx5mJujF8DKm6LyESWT7npfc9qfpwwG95ZSGSX2Pv4r02a2C4C5Q
         qDOG8PYGDP7z3ChpJVIhDcaLrahWbv7E91QSQxT+MIM7/NfSzo6AhbHVsgSTXQnpDNGA
         3B0BxwQE1q0CcBYh/d8/lqltOFEE5jiInbyz7KMcIo1hBoZST9eWd5bNcyzmhbsuK107
         EtznITmzqJhh0Rk4X96EWJ9F8h/EBWTJPGhCySY9Jj3p8XNeUwO5D2dab7CoLmsWCwbZ
         Qvq0/luK6QIRo0MCWQbTEf5MsphJ8c/P16GAI0F0EZOhJtcngARfytPt7MWW1euYhyVz
         X8FQ==
X-Gm-Message-State: ABy/qLbfpzkcEyD7ltW1+3py5IFABh5JJgGT3jHcX5xOtddQaKXfti3V
        dd8WL2y79m2ovPp4zV+yzJTZ4w==
X-Google-Smtp-Source: APBJJlF/0l/YqwsvPnGxXuOFVUW0cZuozXQg708kW3EfkPPhVbUWN2ZDvzl8SGrP6DYv0SrmD8YrYQ==
X-Received: by 2002:a2e:a41a:0:b0:2b1:a89a:5f2b with SMTP id p26-20020a2ea41a000000b002b1a89a5f2bmr8227690ljn.2.1688451879621;
        Mon, 03 Jul 2023 23:24:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w19-20020aa7dcd3000000b0050bc4eb9846sm11459983edu.1.2023.07.03.23.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 23:24:39 -0700 (PDT)
Message-ID: <d23ec6d4-b011-87e9-2ecb-9af86cab3270@linaro.org>
Date:   Tue, 4 Jul 2023 08:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/10] dt-bindings: mfd: Add compatible for pmx75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688395346-3126-6-git-send-email-quic_rohiagar@quicinc.com>
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

On 03/07/2023 16:42, Rohit Agarwal wrote:
> Add compatible for pmic pmx75 used in Snapdragon series.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

