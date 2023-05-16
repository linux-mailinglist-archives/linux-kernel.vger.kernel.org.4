Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB47046B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjEPHmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjEPHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:42:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B778448E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:42:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso25383877a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684222944; x=1686814944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wT9vEBARYlzoyqav/Bfp/YFl2e8W1BObF8CGOiHOKy4=;
        b=WwT2BjMphUwRKOeT/+eYUURK9gwn8xK8AUtWRCkrqwtYVDg3Hk/XYgoIGamnkdyC9a
         3yaCKXgBz1CysMMfqaZ1WN32/bqMB7I10Smig+KJ4ienRpRendk21bhy1xaiW11ih7kx
         GRLjp+U/llS+WxU0/VSZDLnEbzLex4otbJne6+iivUYTSVAPwPEyUBkCHW5Y8q67IJrv
         z/IfQ1cR+jUIxOSIQcKa5kVbZRuZllT8GsEAwbh+zmVK6rDRC9vuIRy3Y9e/OVWXy6pH
         Jm+ZSkNf0OcpUuwWQkzBFZR5o8Fuuc955fJYEn/zN5TfedMVHt3hKCWA859lXpa/uuV1
         NMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222944; x=1686814944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT9vEBARYlzoyqav/Bfp/YFl2e8W1BObF8CGOiHOKy4=;
        b=NPJMUKGiYdHFRnbR1BB/90pwdSnCdoMbYMdzJrkDVZJ8KHDewoOon5b7JTfxVA0kEy
         Zy27jwu8RI5FPWLXM3XBngmNLzAI7bDj7KTNdSfVniki5bjSWT8I6DiYLCciIColCqWW
         WCk9wz9lOxqd8cFCaf5Azt9+/l0/z6FwbfTxxMOfIY5/go5M1gCJdiCTfMsnlPWjio3p
         N5vqgG3QFh+TAAdzUUYNk45MG+6R2OLaf5f6zESKaYG3TAcUMxsZUXSizZw8fqG7MQp/
         zWGgZ97g2shlq36tzHT/GWsRbFmK7xQrzMjuGVlcF1XgLIpAUQp+PzFy5jUri0B3bEu1
         jQBA==
X-Gm-Message-State: AC+VfDypmH2QF1/PAtmATZJs5xXS8nKxAOCSYRP43YEHxY5t+q1LWF2Y
        4dET7OTYd0+MpVW+FBPzOWdxqA==
X-Google-Smtp-Source: ACHHUZ41rZpwyAv2MXNX+Q4IKTyHWkRMEdgRFD5tGwCM3R6jjHDCnCwfn1963nWD8p6xkzC0uniNqw==
X-Received: by 2002:a17:907:701:b0:94a:82ca:12e5 with SMTP id xb1-20020a170907070100b0094a82ca12e5mr34345044ejb.45.1684222944059;
        Tue, 16 May 2023 00:42:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b00965cd15c9bbsm10623606ejy.62.2023.05.16.00.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:42:23 -0700 (PDT)
Message-ID: <226964d1-4c98-73a5-ccd1-6b718897fcc8@linaro.org>
Date:   Tue, 16 May 2023 09:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v8 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230511173211.9127-1-sumitg@nvidia.com>
 <20230511173211.9127-2-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511173211.9127-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 19:32, Sumit Gupta wrote:
> Add Interconnect framework support to dynamically set the DRAM
> bandwidth from different clients. Both the MC and EMC drivers are
> added as ICC providers. The path for any request is:
>  MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
> MC client's request for bandwidth will go to the MC driver which
> passes the client request info like BPMP Client ID, Client type
> and the Bandwidth to the BPMP-FW. The final DRAM freq to achieve
> the requested bandwidth is set by the BPMP-FW based on the passed
> parameters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c           |   5 +
>  drivers/memory/tegra/tegra186-emc.c | 133 +++++++++++++++++++++++++++
>  drivers/memory/tegra/tegra234.c     | 138 +++++++++++++++++++++++++++-
>  include/linux/tegra-icc.h           |  65 +++++++++++++
>  include/soc/tegra/mc.h              |   7 ++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

