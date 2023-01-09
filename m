Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD166331D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbjAIVgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbjAIVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:34:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08F1D0C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:24 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id g2so5551141ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iiohs4OX9XBKS+GKVydSssXpcN8+3z5dH6Af2xFixnI=;
        b=F2JUTas3O84KCd9N1b8rW6yhXOOcRlUIS4pLSWHuNpgDqG67+dxFz3PT/9Ro3uMjsh
         Ku6VfEHkLueFZ4ZqFMJxN6oeh9fJtkPDltSlRIPrXXxmQwYprfq8RqYb8SDE+sZHw6v0
         sWGcWwv+GIcwcMVfCN/QIctvIVy7CC5AKVhiuAuv7CLSLDF5sgBjeG4+CQhMFalZtqzf
         lBsgbo3zFbkJSaWfcMq1oPzDPKJQS7hpCLW2F2/VAwxOy+vJ8xcTvqAkvEDVvsAz+8kM
         8yQ3o3j2giPqAuT0Xm1TNdHVQMNL6peijLxJ6u1cXRsC4PAZKmsSUIqYQgPm2R5H9zBf
         NLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iiohs4OX9XBKS+GKVydSssXpcN8+3z5dH6Af2xFixnI=;
        b=MARKq0BtXC7uNhUfcHWemTXIKFI4PEVFIOrH1kPTR6L+Q4tBl1/xVqLc0PqK/xpaDG
         sH93eVg6kvbS7WphvfsitbEVPLNo/Gq7McBgOjp07rNzQHrsX4ZEpX1Fevb0WrmHp1ri
         hMnEWlSadwd/9cx4pMis3kzani8xhZ2z63ve+iIOfwyl5m2nxs3c39cVukvDARiJ7Izc
         T/XplA/snBdHeM50stWU89TOOPfOFEnoFtMuJgWhqqgwBRXJK7d7VFeXdbVR/viTDWfM
         8BPNYIo6eifQXrNNiauxRlSMcnaj8UDThdhyTGvwkq8jjN92npYa77manb2ObAyBtLpv
         Dpxw==
X-Gm-Message-State: AFqh2kosr7eWiBLVnfSFkCEriQ0woYMxrDyTQlPDMxvstHhwdXBHJ53Z
        wkO17uIE+dvITmncd+YOfMEPcA==
X-Google-Smtp-Source: AMrXdXtKrvQeuV+vRfi5+eIyZeEbd5Fdn8g+g5p661EdI40Q/KmLoIeZI8enRyg6WqGfCWqFP8IYUQ==
X-Received: by 2002:a92:d111:0:b0:30c:d9f:fe00 with SMTP id a17-20020a92d111000000b0030c0d9ffe00mr42357769ilb.23.1673300063797;
        Mon, 09 Jan 2023 13:34:23 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id w8-20020a056e0213e800b0030c2667fe17sm3045972ilj.80.2023.01.09.13.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:23 -0800 (PST)
Message-ID: <f6bf5577-9a3a-e949-62b8-53f5fcdd3fa4@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 04/28] arm64: smccc: Include alternative-macros.h
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-5-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-5-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Fix build error when CONFIG_ARM64_SVE is selected and
> asm/alternative-macros.h wasn't implicitly included by another header.
> 
> In file included from arch/arm64/gunyah/gunyah_hypercall.c:6:
> arch/arm64/gunyah/gunyah_hypercall.c: In function `gh_hypercall_msgq_send':
> ./include/linux/arm-smccc.h:387:25: error: expected string literal before `ALTERNATIVE'
>    387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

If this is correct (and I presume it is), I think this patch should
be posted separate from (and before) the rest of the series.

					-Alex

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

