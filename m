Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2562E6F69D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEDLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjEDLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:23:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E544A8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:23:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so16215520a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683199429; x=1685791429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bob107kJR5IdsO7CGNgGuKJ33ZO9RYVaMCNnZGrzk2w=;
        b=H1bJrwvUWwl89Ha8tmDKWPT1t9oMzal0i7KNaes8/F8FeKOilrITk2ywpbaHrda43n
         1ncM19EuyyrqW17SxdGXc2QIFQB8WFMEUB/uYKHNh8zKBBUmdqhGSSDkg6tyjaZOd61m
         rdL/DJxshYEVpo5hHkBVvcLonBCrz21bgxGY5z6FIKYMJmdu+U00suIvKa2CkJyOqo6U
         gu0YpwURiaQKJ3jCG6e1kGwSJgKsM2eCBy+atmKAaNRQQDKJaccuw8h7W60VcZ744tcK
         GLU5f8CjCAr716dnj2B1vI6iCaG7VGL7m771r6lDndYifnQe8A/H59DVZZcAcjOe8UJC
         vE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683199429; x=1685791429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bob107kJR5IdsO7CGNgGuKJ33ZO9RYVaMCNnZGrzk2w=;
        b=fOt8LudMUHi/RL+ks5J+nqVvpLet8aqQZXgmEAc+cAjUuAi+DHEafF/XHcwFvFgxm9
         mdvGPDEARMOTsnjSg83nU9nXnSaP+j5So2J6trX2BvVOYtu/27wCAUfB6m5NIcQIsvox
         BKLJIin443UMw8WxOsIlmjRMnWOpmat0bJ4KvVR46X8GtXUIqLNUxCrlztfnWD/G3Qnz
         7dLCESFDQEFGwzsNximARIVRG/FHDXPXPGxFKkXKvJRZ63hcIj+50OQGXWGSC8A1fQT2
         PAf5ZnPkTRIjNuKP5nhuGce5La3guSU9x7phgDsoQlE6Dok+yW3SnthudbfSORaZzzSp
         Hkog==
X-Gm-Message-State: AC+VfDxnXlh0aiQ+oSRArGE9X2owHsOSqBK7B+92p1Z+tp5UzBBB7zUy
        bk2XM5xI1gL/sSrc4FC19tS2Zw==
X-Google-Smtp-Source: ACHHUZ5uM9zl610LV4XAjDqfmDLSlTnZVSOBWel//9dO+3tsqS3iV2+xYaXLBEkKvemCf/D4pHz9oA==
X-Received: by 2002:a17:907:96a8:b0:94a:643e:9e26 with SMTP id hd40-20020a17090796a800b0094a643e9e26mr4931794ejc.14.1683199428887;
        Thu, 04 May 2023 04:23:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906779500b0094eef800850sm18623659ejm.204.2023.05.04.04.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:23:48 -0700 (PDT)
Message-ID: <f8fdf967-a37e-423a-c6a0-ca0a2cf56bc7@linaro.org>
Date:   Thu, 4 May 2023 13:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 13/18] arm64: defconfig: Enable Qualcomm pstore
 minidump client driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-14-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-14-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> As we have enabled qualcomm minidump driver, so lets enable one client
> driver which captures the already existing ramoops region like record,
> console, ftrace, pmsg through qualcomm minidump infrastructure.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Squash with other change.

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 831c942..1ccae8b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1251,6 +1251,7 @@ CONFIG_QCOM_WCNSS_CTRL=m
>  CONFIG_QCOM_APR=m
>  CONFIG_QCOM_ICC_BWMON=m
>  CONFIG_QCOM_MINIDUMP=y
> +CONFIG_QCOM_PSTORE_MINIDUMP=y

This must be a module.

Best regards,
Krzysztof

