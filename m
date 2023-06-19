Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AF735390
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFSKqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjFSKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:45:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0318C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:45:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988b75d8b28so99839766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687171530; x=1689763530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxYCS4JJ9IgQFdHGsth7t+l+2RJN3WF5jRAxfODWYv4=;
        b=K+v5zIA5/U+xbfsxeBhQVdDIqC28YZuYXp0K+Hgfa9AYSx/7Shgj4c+/W5Y8Iv7TTG
         +C88bfUwVwdjtPX2kKU5HqYPZRMfdZnYOb4mavhZhyf+73caLkCbY1d7/mi9m846PSyI
         5DwVjK8EJjr2WpKMJqbiZ2ME+nu+51g1Y/i9gw3OYYxaGsZGP97Pe5GfMRtydKYaeCuK
         od8hcvNvzfhU6Dtvrl0q27blQfWauzurOeYzIqemT2rz9r8LSIO+SOqwsJZPJdW+hi3g
         QFA2BABY0sqtTugaJHT/Msd+iDeSuYlw3uk1rd+raCZxbDr287NUsPgMTmVU4Hfjj566
         0uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687171530; x=1689763530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYCS4JJ9IgQFdHGsth7t+l+2RJN3WF5jRAxfODWYv4=;
        b=HVO0ZQA0I9scghKcsaKi3pGdzWfmM0Oa8x+Bfs1XuXJDCaTjuykTv3aMV5CXWDzm7o
         aQ9Vvtt2NsMviMIIypWg47VJgSVpwE1Bv8B7V4/KQIebuqsI6VWzIteN7bCQeyZdet3w
         1rslL9RMU0GAudLmRTBpHKSKS1WCmEv7WjiQ4wm4ivg8Xr/U/VqBUlwEv7p+j2IFrJ1p
         biPjYs0eLZBhRM3Knlj1K9Z3cVzkN9LSaY4ySkge+647JRR9lvDOOX+XKfngcQbfV2Q1
         kk5I7haCVgzf9uEDOQfWI5DF/O8wJ4Ebur7qBNTVthUNA0OoRrGEakkD65N7Q7uYqV0x
         iRZg==
X-Gm-Message-State: AC+VfDyRgCjG3Ill1jMNYHK6tReOVsMDAsA6w25U2uaYWVYYLqJTCHPe
        snMO/CmgwSuNcxVo/KkiGiOYcQ==
X-Google-Smtp-Source: ACHHUZ5yolAv+qr7X9d2vYXDV5q+9qqRZkbO7OT2vwONBgoLt6ajmFHDy/7+O+x0p90CH6B3fh/MMQ==
X-Received: by 2002:a17:907:7f12:b0:988:66d9:438 with SMTP id qf18-20020a1709077f1200b0098866d90438mr3532185ejc.51.1687171529962;
        Mon, 19 Jun 2023 03:45:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709062f8f00b009534211cc97sm14395289eji.159.2023.06.19.03.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:45:29 -0700 (PDT)
Message-ID: <938c32c2-1130-4813-cb72-d7c5c7c59ea4@linaro.org>
Date:   Mon, 19 Jun 2023 12:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 6/6] arm64: dts: qcom: sm8550-qrd: add pmic glink
 port/endpoints
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v5-6-9221cd300903@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-6-9221cd300903@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 10:07, Neil Armstrong wrote:
> Add nodes to support Type-C USB/DP functionality.
> 
> On this platform, a Type-C redriver is added to the
> SuperSpeed graph.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

