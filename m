Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4560E578
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiJZQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiJZQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:30:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5177E89
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:30:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h24so10289043qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEWQjBfFk/Zdt39bZHeZ/2md1LrkK3njfqHpxKjRhAc=;
        b=yqzLVshfBATMpUgpsZffV9q/DTVkozyc3MVPu0gQrxYNwaQoIlOBMP3undJwlntfQV
         iIUShn7/vowA/imGuvjeNBaZCF2nCVMXMmWTtWyz1HJvJQfhUJWhVluO63kXZA0fh0Z5
         zx9EWrtX07jf8kileGgS3lA/8HoUGRTUB6uSQilStct9QNe2YMn5rK0uX04qME2WX2wN
         0wAk9XMrfehHvMiT28xCEdrLelhIwsFc+e3VEKDsR5ygYdoZi0pA9YrSEaO+0S4goza/
         gWDz19FJ6OAvQTfc9CEP0M4YymLpPq3FOpPGjKOjluGq30VM7hx2UTUwmQ0YIQlOAbHm
         lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEWQjBfFk/Zdt39bZHeZ/2md1LrkK3njfqHpxKjRhAc=;
        b=zHSIR0QB2q+K5+t7CYdAVA/8zTsoyQ1gzcLW1pbtSGJpjA/OeEAzlzcbQBGDnylYti
         70Bchn0kqFY0lIjMWjxQoZCvDHmbiPJHZ5G56pt6kCbocsJcQq0tgwHCa6ZsS9SC/2zJ
         7H9huO2vupAy/75PPW3QeJnVfKi/d4+AXz8/qOJOE/RIy274DBsuml+FxRVfiVJYVysA
         TXlS+Y419DqaWE54+3ZSdtm5uEfOhZ/tXsnWS9AVOge6LgJh7NRUJ+Gh6y1EZ3IE/EN7
         hTd9aiWfdn5LTLM/NR4BI3zEEVfc91A7UDNVa4ZewKNs4JXW1nB8kvpWW11ZFEQvxq4c
         qdCg==
X-Gm-Message-State: ACrzQf2zwAupva4/prp1xngmBvPRN+37oYB156/qpMIoexRkKyhJnUOx
        z1FblfNEOkvARMZIEymFoYxBKg==
X-Google-Smtp-Source: AMsMyM4X5+5ss5R8dZPK0IxY6Megf9eWUoPQKvis6PymkL1smThD/yQ3JgibJaReN/eJFwt8FGLSwQ==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id o2-20020ac85a42000000b0039d136e8a43mr27254584qta.372.1666801837499;
        Wed, 26 Oct 2022 09:30:37 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id e10-20020a05622a110a00b0039cb9ef50b5sm3444073qty.26.2022.10.26.09.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:30:36 -0700 (PDT)
Message-ID: <3169d47b-35e4-7e49-875c-631a66350613@linaro.org>
Date:   Wed, 26 Oct 2022 12:30:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] slimbus: stream: add checks for invalid
 unprepare/disable usage
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 11:57, Krzysztof Kozlowski wrote:
> slim_disable_stream() and slim_stream_unprepare() are exported, so add
> sanity checks preventing unmatched/invalid calls.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/slimbus/stream.c | 6 ++++++


Hi Srini,

Any comments on these patches? Can they be picked up?

Best regards,
Krzysztof

