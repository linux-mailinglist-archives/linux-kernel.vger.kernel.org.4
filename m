Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816466BA920
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCOH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCOH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:28:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68C6BC10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:28:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z21so6433114edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678865304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoMNqIZg63BCmS5MP4kOVeZdeqcwuh/YDGzstKQSmrQ=;
        b=XFsMSjbf8JnzudeZBQm76WgQuJtuNS1r2N0ehayTQweCaWY61GWYn2No76NotVEs+z
         iszq/O6Nbd6sYU9vrIUidaPlEWsXcyclNxPsjmtv2S44DS/tcyDKBGTvDDcNTfnRcsGB
         KaS85B1NrZ3cgdkgVRWEA3hy8HGT5Ozc+I7qkKu9XSCfRJSKDmJ8EuZIz8Q65G8Np4fF
         l88d35vOqa7AndpUBJ5T/UyuyX0xtU5jRlVHtEbMNLpiIUv3N7lgiE+E6IPBK/MYOpSi
         XWmD976fwYJMLt1Ok41+ruO0Y4ElbYZ47cCH6++moYvSiaYZN1fmvOTdcR0YdWJE314h
         qzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoMNqIZg63BCmS5MP4kOVeZdeqcwuh/YDGzstKQSmrQ=;
        b=E/UQAkmrATpfbxpohRfvQpoTIO6+h5qRKenw/RSdwDQgV4SWnB+eNMSCssjntbOBTt
         sEQbNMEZu3cYj1ITug3QBHNXgHN9SKn/nmoruDBkpha95bL6vlUl3eYG1SqAzqMm1rix
         0qSEvD/rXHHuYdKAcpV69ZSlNRJNMBdlUqCmPGQSq0ie2xxg5kgjxzkqgVfU1nMGOvTI
         c62npnW9upSgt6doZ9+/FavCqOpF6ghS37S46nwh6POFJmVeUVVBup2eL2P8Dq59nm/W
         lZeco/2xDgQWQf4mhTfI12ugCg+XwuuJPFR+jwclJUAGeqe2a88Pj6cHpvxku3CxMRRf
         /Otg==
X-Gm-Message-State: AO0yUKXYdg1giwJ1hPAhBWrOzCpMEn2KCoQFY1RetVDintCF0tORfxpc
        EhPEmnJW5t8LZXbz6PsMxHM1Jw==
X-Google-Smtp-Source: AK7set9+Uknws+xpkvab29AOThYB7oAgGWZ9A+nlJDfcX4XdnlRPFieXpnbS8iQzNrIoqTvIFfjRag==
X-Received: by 2002:aa7:c850:0:b0:4f9:deb4:b97f with SMTP id g16-20020aa7c850000000b004f9deb4b97fmr1840625edt.13.1678865304160;
        Wed, 15 Mar 2023 00:28:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402280300b004d8287c775fsm1927194ede.8.2023.03.15.00.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:28:23 -0700 (PDT)
Message-ID: <40385a48-d37e-df47-14c7-727159417564@linaro.org>
Date:   Wed, 15 Mar 2023 08:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sm8550: Use the correct BWMON
 fallback compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-7-04db989db059@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-7-04db989db059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 12:41, Konrad Dybcio wrote:
> Use the correct fallback compatible for the BWMONv4 with merged global and
> monitor register spaces.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

