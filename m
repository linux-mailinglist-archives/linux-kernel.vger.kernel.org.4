Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962C660E97F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiJZTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiJZTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:47:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42411CB57
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:46:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r14so30987681lfm.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFjZUwg9kkHrdeWfJ5ahCLFcRDkAGeHiMWgq9vVh9Ps=;
        b=PkYZcfy5WMquWospUQFh7cJpJo4V6wkPaXLJ+W6HivXj3w49ZeLEO8i24izYjxeJzG
         zRJ/RCfo8mUZzDqGtvoSKR9JZ9RKUY7AEh/cic+6wn7MtLZ7PzFTsJTz4KFzOI+rnz8B
         BjE8MjFSCSjl+Arttw6PQIqvVmdd0X2q+bNb7LjStezGyMy5ya9RCS1rJm5e5f1vt4hH
         l3hPWeD3i/dkNIaGPGCsVKuYAQWepXoaYL8QnKpGpEgWpwMoOmNdaq5XQGq4UjIv/zOR
         /ubN28kFhv9jFCj/bYUHXt4GiyEOS8sE7BVj8K/E5hohb+ch+uNU1PNfAMw4RRQ7mO+F
         A0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFjZUwg9kkHrdeWfJ5ahCLFcRDkAGeHiMWgq9vVh9Ps=;
        b=uh6lsSPRYg2gGlo/XUZJ8pGZERJoWc29Ayz0ekQrM9eJvPbt1x2auamLHlpD8cLFXS
         PQ6JHF5fjKxusECo5dopd2HD4fompAh/jgTxQ7twCpt1mkNXEVzcdgtmGN9YLcKGHCmX
         ymcbcFHMvqbJr4jMKUrKFjlcHniVUG46unucV61LmSHZ+0HPtLWygGT0J3j1uVg0Q/G8
         VA9nnpPLZZGFeZgLrPBvvSj+e6b2kTgGI6hY5i3k+9LB4NnWwYHzme5mhwB4sfRrJB1x
         Y4VpirAcg9chLKU1KzGnZt25Oz1o5n7T6Wu+bX2bA7dXhyt3F79fbs/9MkxkSkCxB1T1
         sM1A==
X-Gm-Message-State: ACrzQf2+6JzYnt4S0X4rEcNKyVeAkeQlYqyGWYhAKrxAD73Ph5PcNCbQ
        +1RQsVTJr2Fcvh/gt9X+pYoeQg==
X-Google-Smtp-Source: AMsMyM7Sc9bm+ICPknqGgF6givhaCtNofBIUTNotmKABmE9Zv5ip/cKuOpnhFd8xARGFACdSOJBk1Q==
X-Received: by 2002:a05:6512:3f8c:b0:4a1:8d5:d75b with SMTP id x12-20020a0565123f8c00b004a108d5d75bmr18369184lfa.670.1666813579744;
        Wed, 26 Oct 2022 12:46:19 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c048500b002770e531535sm1051653ljc.55.2022.10.26.12.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:46:19 -0700 (PDT)
Message-ID: <56a47a6c-29b9-b8f3-e39b-a5841ddf7394@linaro.org>
Date:   Wed, 26 Oct 2022 22:46:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 04/21] arm64: smccc: Include alternative-macros.h
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-5-quic_eberman@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221026185846.3983888-5-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/10/2022 21:58, Elliot Berman wrote:
> Fix build error when CONFIG_ARM64_SVE is selected and
> asm/alternative-macros.h wasn't implicitly included by another header.

Please include the build error into the commit message to help anybody 
looking for the solution for the same issue.

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   include/linux/arm-smccc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 220c8c60e021..6a627cdbbdec 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   
>   /* nVHE hypervisor doesn't have a current thread so needs separate checks */
>   #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
> +#include <asm/alternative-macros.h>
>   
>   #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
>   				    ARM64_SVE)

-- 
With best wishes
Dmitry

