Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0116E6F7F94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjEEJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEEJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:09:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FAE2D66
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:09:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9536df4b907so280308566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683277745; x=1685869745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/P/1J+YKpAP6PsQU3/RV6Z5u9zgqS7VWe/XXNeZKraY=;
        b=QDNzE94mR8227V0fyrhVFP22OZVayw56p+85g0kTEx0A3jEskH9J5KycWG7m5q/F79
         WwzQKnhymUxu4kH6GBAqjeCjH8St2aG9s81tB5SJqgTrIpBY1jzeOtu5NDs1MRvP0v6m
         cWgUXyDUg2crfhrM9FXL3pDPrKOxp5jkiIigLux7PWN/Ml8UCqByeXYctIFuRK9ELaQJ
         g1GoTBCZUscg8S3HWuDq5dd9LANw/tL1xOvgD7svrMDkujDXGVdQ/OFRcrxd2I0/j8q7
         SU3R18gU0Gf1Q72TqCMaqIB/CyFbmESEZhjVbjxm5YG018xF1YKJCRyByy5s4p8pTeXy
         17aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683277745; x=1685869745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/P/1J+YKpAP6PsQU3/RV6Z5u9zgqS7VWe/XXNeZKraY=;
        b=T8Tx7MxrtjUma9X+6zGtpdHZrCoxN8MixKGUDNTjDQ0OB0zw2yf3KAGJPDLleQoWvL
         lR8NgvqOPf2saxqPPUO8zSH0lFvMAxjFMMROzV25goZuB1cH8DWrfcUQ34AN1D28gj2v
         +y/Atj5+kyjDrHsKqYVVlSPbXMKk5o5rYAZcienKXxRaxh5cA2nmi3YUw9PG7COPkUTR
         WVSGh4TYAE0ab7csSrATV1qs0GET2hoUYTpK2GYJYJj9YDFrtCyD8u7Db4ZsG5JhTMhc
         8m7RSnGCOEqw8HTzgIkp9/lEve8Rl84MOu5zju7MlbWIhnPShqYSZPR0nNHKqyC6f6rg
         sK9w==
X-Gm-Message-State: AC+VfDyZGp2mDhQOEZgIn6jkIL5Nm0FotOOzpDNsaXHvQL7Fps+A6sXw
        da/wJfi7JUmCOb1bXnHHQf4DuQ==
X-Google-Smtp-Source: ACHHUZ6u+cmxtNpoEtgcnrYTh1VUp+XpQfdoooHy6hKndX5YZB49OQURIUXMyRdZ860MCwcrwKIX8Q==
X-Received: by 2002:a17:907:36c1:b0:94e:e082:15b2 with SMTP id bj1-20020a17090736c100b0094ee08215b2mr517708ejc.55.1683277744704;
        Fri, 05 May 2023 02:09:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b0094e62aa8bcesm690412ejc.29.2023.05.05.02.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 02:09:04 -0700 (PDT)
Message-ID: <fe00b340-ae27-1599-a457-3eca46dc01c8@linaro.org>
Date:   Fri, 5 May 2023 11:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] spi: s3c64xx: change polling mode to optional
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
 <CGME20230502065025epcas2p4143c8ff3d44b7676ea8667c14618f2cd@epcas2p4.samsung.com>
 <20230502062813.112434-2-jaewon02.kim@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502062813.112434-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 08:28, Jaewon Kim wrote:
> Previously, Polling mode was supported as quirk for SOC without DMA.
> To provide more flexible support for polling mode, it changed to polling
> mode when the 'dmas' property is not present in the devicetree, rather than
> using a quirk.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

