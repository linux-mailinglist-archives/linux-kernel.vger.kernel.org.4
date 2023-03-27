Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDE6CA7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC0OoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjC0OoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:44:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0B2113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:44:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so37128602edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679928259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcJ5LgW5ER1wwy6sFz6CbRHRnCtmdb/eU7GUYh8dJzM=;
        b=SMZBCI18dJcH5FkMFF/JEYx5uPb0wcks3YbmaiaE/ROusQSn14F2yKDbWwfvscCw7/
         uGMwLlPn5pMUUSl6SxvxrytszAMHihPPBHMJi4j17JMLXpzB9jaIFm3+4FnCEoW8SD46
         xg5Hsrt9kpR8yjbsuDwx9TgRaEEp5Kzd7/EcbK+q+VxVXVbwMiapmIqKTPHheZkjUekA
         VN7t9VtiTCBmoVpJ1TWeWK/t4bz9bV96sn5wvQGEzmkoBMbtH3d/dkBUMFOFUx8kVVuO
         hvflyd8eEBO07Eox/3ldUiLnaiNfTzs5fxZVZFQ4rXDjnBEElYD/Jv/jbrGvs8b9Hvv0
         7S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcJ5LgW5ER1wwy6sFz6CbRHRnCtmdb/eU7GUYh8dJzM=;
        b=o6lPlXxVBQpMkrSPWzqHCA0JE3ba1yV17FOeMFspAc5qSsUmE4hyMA02d4lMmbl+HT
         qIp7NpYaYjS1WQbj/0Ojyol+LP98ZsA9rGlEr7mO3rF2nhrJRp5rOBfQgRrnnL+oWpIj
         EkgUDl7ypKtoEBdcbrP/KxFqDWHIbaxIM78nRU3kKIKu4WkYO32Ztcn3c9G4Gj8tnLYH
         VIEmgQqq11H/90nK9F6mhz3p0bWhQ07s4WrnQCwQHw93tPF3rktr15N731bUQKtzo2gR
         OYJ0bV9ODrNehUMp6IfSfnYNawQoA3DIRmIkOpPT9rdAWorh/wumvNAk2lr7ecGcDU5Q
         ZupQ==
X-Gm-Message-State: AO0yUKU1qATn4Yjjb8pI6K+jSoddK/Q+/LqQveRxkWzFqDQpQbXqA4h5
        dM64JHMOYJRXsWNJPwrAQiyHzw==
X-Google-Smtp-Source: AK7set+1ksES0ZIaPZjVsuA2WTUy9q1CM0Ewm895xcCulrtSusV/Tks9feJ8wt5cD8cXAM2gepOpiQ==
X-Received: by 2002:a17:906:ddb:b0:925:6bcb:4796 with SMTP id p27-20020a1709060ddb00b009256bcb4796mr18618407eji.38.1679928259316;
        Mon, 27 Mar 2023 07:44:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b0093137b1f23fsm14111235ejz.37.2023.03.27.07.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:44:18 -0700 (PDT)
Message-ID: <ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org>
Date:   Mon, 27 Mar 2023 16:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: sdhci-msm: Add ICE phandle
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327134734.3256974-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 15:47, Abel Vesa wrote:
> Starting with SM8550, the ICE will have its own devicetree node
> so add the qcom,ice property to reference it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

