Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297366E4ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDQRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDQRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:09:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7B4C37
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:09:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz19so8980470ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681751349; x=1684343349;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XweE64Zl/46f6L2SuHt55NuqLtzHxIBbAUN9fGMnwCU=;
        b=KfEfP6epKCNhsWeM5eKs9iD6bkpUo1BSxuZC+CKvIeza0OlGKaF7OnY3PBbuz/sX8Q
         u+gilEKj77/DKTYii79bgOYkEZYvqyAYql/jj8868J1mwZmY+xphtUz+f+PJkz736T1o
         UEbo/poM0QW2pk8cdRYJEk5CWl7PLv7eVYE1HN5SEjUIxBAgRBLxLngvyU3Zo9czhMhT
         7AJnnO8IGsk+TZoDSb9aByg7upUi3lCxGNpSAkUSZNujxqq3s3NNwSW0gYhitn2+CjNI
         FEOn/N6+g8JMN3kitx9dCy9/RGguuhQv3Fpoo0GRjkC4trVl6fO2B/5PTVsVPMihOQRY
         7Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751349; x=1684343349;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XweE64Zl/46f6L2SuHt55NuqLtzHxIBbAUN9fGMnwCU=;
        b=QcbgFmiQ7kJLpKvsOnZk6+uaQjiyVMwnteHEkNTHzSDhL+2jjp89HkWif/IenF5eRc
         YuMusZl56+l3jLpg6yHkZnGXuRUodtVz0Cr5LoFmo/IdTFvDq9O/TfN+XcddvNAjfVHY
         C5rvlHWivnnNE6j+94rxR5zQxjDKApn1xij6SJqrvbRj93UWnowo5OrDvPqLkXmzv2Bw
         2JI32SUFUdPktGp7mK15tCOtK4Wm5RQgiiWwbclJK8nK4lJUUKWLQWmL2OWSuWujpKX3
         iQwCtNsHrSodza2IFGBjy0ODqMscnW3pBQ3AtfLkZPI3cnlp6gkH+wMZKivsli5wECbA
         pYVQ==
X-Gm-Message-State: AAQBX9eqYRCw7xV5fNgFTJ/V+zE9cGk3f8pG91wlk4g21Vn8WO8S+4Q/
        Kc5f9KSR8ws+ztn/3Me8QoHNMg==
X-Google-Smtp-Source: AKy350aQzFoq6KoINmUM6LrdMkGW6Nc0TbczRW3/dDZKPyEEcBkKaQAVRBwqW0dh68VrWD3e3s8s6A==
X-Received: by 2002:a17:906:a93:b0:94f:9cd:464b with SMTP id y19-20020a1709060a9300b0094f09cd464bmr7931157ejf.15.1681751348992;
        Mon, 17 Apr 2023 10:09:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id xg12-20020a170907320c00b0094ee99eeb01sm5177994ejb.150.2023.04.17.10.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:09:08 -0700 (PDT)
Message-ID: <56a72d99-46fc-67c5-e754-4148c4984f2f@linaro.org>
Date:   Mon, 17 Apr 2023 19:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
 <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
In-Reply-To: <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 13:17, Krzysztof Kozlowski wrote:
> On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The renaming is due to the fact that it is now supporting SoCs other
>> than Hi3798CV200.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Eh, as Rob pointed out, this was not tested, so un-reviewed.

Best regards,
Krzysztof

