Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2216727C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjARTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjARTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:02:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DC5D903
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:01:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so25723945wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2SXL+4FwJ1DXO3od+MaJWYSMQf4KAe8OpgLTFr+uMs=;
        b=LHJjUqB1gLa7nctUv1iQSwqLrejhk3r2SuuwhR9BEASCQgqKQTRML48nkyLX8qsN12
         XxK/4sC/sdzBO49fOM5eganFJPNXZ6y5Pk2jHSWHM2a3unIMdd5n/lAsUQO2eMW6kyt6
         nYN19YsaVhP9eQVkhS019LDlQgrP/WahI9z2IyS8KzmaIXINBv+f3Bw43rcWPbRh3rLm
         9sJlrbqb7vMBkB5fz2o8BsHCO1g+mCWGxa72BoVi3zYfIDcyTQtx4w6gOYvGmMq+8ClU
         nZZIXJlUq7+jTwe2UWFoCg5ebKg1Fw6X62HcltT1Owfa5JccyiU8WbNJJA9F4Y/U4afO
         ucoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2SXL+4FwJ1DXO3od+MaJWYSMQf4KAe8OpgLTFr+uMs=;
        b=guKdkJ7JAO9BWwRpLo+Utc4deAoB/FiEFxg5MdYnc5+WvASQjP8t/bbshBAzvEZcM0
         lXQnTVctV72pi8ee0rUzQZZ9dXt2QYUaS0ydMnxGMUca7Udh5Gs98jVDQWSMRrDekpIx
         X6eprVTIa0W1b3w06mQDO9w56D1NpcKrMoJa2omE3+z3g8J35X5nOGi+O1knFXSU+Tv/
         wc411rw1vld/mcHRNb31195SE+tROMuNqFb2lDHScWt8acPT2bjQtLrrImFMw8eHW9Yb
         BHkZW1TirJTozSkgYI6yasSvsNp2gKT3CpO/pJ262V+6yBDpE3WonNsEykf1Q2u3mQcM
         o2qQ==
X-Gm-Message-State: AFqh2kqWDX1wXnxP7lE2UJxB2sIJPD49HqDQu9r9cQyNU7t0SX9SLrkL
        ruHthfkBT/2OL2iBNJZ4EqPmYA==
X-Google-Smtp-Source: AMrXdXtAOA36jijzEE2xZF6Nq4/g5rngFFR7/3x1aM3HFccu7glvjmRbgOehS0Tj20HRkek+ncNmbw==
X-Received: by 2002:a05:6000:1b85:b0:2be:f21:6af6 with SMTP id r5-20020a0560001b8500b002be0f216af6mr7064295wru.23.1674068485007;
        Wed, 18 Jan 2023 11:01:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002426d0a4048sm32726226wrn.49.2023.01.18.11.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:01:24 -0800 (PST)
Message-ID: <6dd3e0ed-bda2-ac01-c995-20bb06fc5296@linaro.org>
Date:   Wed, 18 Jan 2023 20:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom-labibb: Allow
 regulator-common properties
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230118181810.119922-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118181810.119922-1-konrad.dybcio@linaro.org>
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

On 18/01/2023 19:18, Konrad Dybcio wrote:
> Allow regulator-common properties on lab/ibb regulators, such as
> regulator-always-on, etc.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

