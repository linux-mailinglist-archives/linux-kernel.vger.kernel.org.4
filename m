Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88F6B5238
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCJUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCJUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2FE13130A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:54:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec29so25645680edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678481659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pV+3K/l4NW0KqVodGPo/7yZhA2AMdyGxW2HfljJshZg=;
        b=HMcer2mG2SfSU0FZPwL6ALRBf1ua3QSr3S8MjIqFS5QMVkJzNCW5m++NnQVmu8+KU2
         yda+Ju2Y1hKNd2HdwQ5ycymSqzWefcXZNJLI1ilJN8Uf8LtAlJhlpEgcyd3qOac6sfc7
         QXvW+TOFIv66GlxPA59bbFt0VI9u7AoGvk6vZbepPKjCF9cZUT3gaSM6kdbiM66BchgH
         NHxpBLmMMjQT6AhvV0o6WZa1hIL6cGi6jtL/AoOJXnhM0O1BGO4S6IG2uEfek0YwgxvE
         sw4ttgw27H8h9yX0spEQBqCN+v0YZaUtKduF3wvq4wKwFl1TWdb0H4XSKtdxhck7kj5L
         eRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV+3K/l4NW0KqVodGPo/7yZhA2AMdyGxW2HfljJshZg=;
        b=1me2QidNODp0JQ2XNwecQao3RfmzeYwmmL0NXGSrdgZlLDimTHh9pRdJxogTS3i775
         8xeVdOmV1vYW9mbJ3KqKubnf9wLMq4/xleroCDSHVN+nOblIHlBDeFybgketbuw0GKFn
         DNITIDgwVnh/yt6wb0WYJ5Ir+nXU9uDDDiRMxY5BMUNL9aje3WKLzKVX4Wsdjzyy0pv3
         nb+1r1zukfwvgUQW9s7L2S3xhhpEpolekzte5OYNMRUTTURJ49V1vGAJYml1IpRWjLKf
         tHI/fC6i8vwoUR8fUYzGwGPtBxtIsgIVYFz6beYKzVdjtB7P0vGxE/1JH0A9yKrOhjQb
         L2Rw==
X-Gm-Message-State: AO0yUKXyzYVBZ9ED+sOKGTv+Wm4II1jLSUoNRsSUpUxx3nIeesq/gwtC
        AwgGolE6DKAlrcN8/S4jqqDn1w==
X-Google-Smtp-Source: AK7set+OskZI0FGLKRYk9/mBRZWSKmHBniUWPM1QIHJQYeZ1yGlN50SFxMnUaSpFBMyaPh27Fq4LXA==
X-Received: by 2002:a17:907:8686:b0:8f7:5038:9896 with SMTP id qa6-20020a170907868600b008f750389896mr33940161ejc.70.1678481659688;
        Fri, 10 Mar 2023 12:54:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:34:52e3:a77e:cac5? ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906359400b008cae50b0115sm288002ejb.87.2023.03.10.12.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 12:54:19 -0800 (PST)
Message-ID: <e5a6a775-19be-5e75-a4de-922fb4f0f8e8@linaro.org>
Date:   Fri, 10 Mar 2023 21:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
 <20230310204811.sjfl3lzlmijzeatf@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310204811.sjfl3lzlmijzeatf@SoMainline.org>
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

On 10/03/2023 21:48, Marijn Suijten wrote:
> On 2023-03-10 21:06:52, Krzysztof Kozlowski wrote:
>> The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
>> on OF thus the driver is OF-only.  It's of_device_id table is built
> 
> Its*
> 
>> unconditionally, thus of_match_ptr() for ID table does not make sense.
> 
> Agreed.  Searching for of_match_ptr on any *qcom* file yields 25 results
> on a few-weeks-old tree, are you planning on assessing those too?
> 

There are just few incorrect usages, I'll fix these. Rest has proper
maybe_unused or ifdef.

Best regards,
Krzysztof

