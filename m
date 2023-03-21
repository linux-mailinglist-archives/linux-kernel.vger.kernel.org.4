Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BA6C340D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCUOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCUOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:23:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853F4D638
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i5so13466906eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRCSg+R0bkZMqBCG6ai/0Zi6fZ3CLTzfV1tQkRbtKgA=;
        b=f07iv4dJFhE9h97mSyMMvkea/5OGIqY2+QCSgpALifKdYUw6anyNhfBfCTXBT+RXXr
         sVQQGi4ww4zIf7i/PBUrubjN4re+7nXbzG9FfIMXehWU8YBdtrbY3B3t81Tlz/qU9Ae3
         ZXpvxvZ9k8Qv1EWiTTOoRUJnfheXNCZniiaJJ3f6uQqCQ8fPgQVENcev/LTQETyTnZxm
         gZaGGwDMS3UiiLQtr12h2bR9ldvGLkbZPWvBhdD6eyhlAiUEDka9j4jvWeN/fBXrGJ9e
         SZgtm9WtwisXggKPOviOOIRkYo0Cd0kYZrBHAmmMlCKnjPUCndSyovnzSnb2aO8oEhJF
         mn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRCSg+R0bkZMqBCG6ai/0Zi6fZ3CLTzfV1tQkRbtKgA=;
        b=cPwe7rBCMOzmpBEyTQeaxt4c5JAfmuiUMdVe0h+fuf1GA+EMNCv6SgKm3oyhEj3GUA
         FRxi26C0A9SGJjW7ketAQU861HscGaQmBTgm5xsqaf5nW2z2aTh4312qQD2zqEppGCKT
         kSYtbd1RtlC7dFwBVZ38aQ9Z9dQQGVpokmQEEn7rGMXGH0H7JTNYgg/SCYGmmS86ywnX
         Svp1hF0oEXRCjq8PEgvPdVMDkPPz0LQCPlm7paIm8gyEPOdSU5PeBuGgP0RUHx19PJ4l
         IELM05AtgPLOmtbgrO1pgrrxyIbNl+Ncq1tA2dJd4P+yeI7fQtOaJP9A1s2csh25M4bN
         +42g==
X-Gm-Message-State: AO0yUKV5ER0Cq72Uyumiy3cIAAG0yq7LEckvQthpReRHyFEnlATS5vfM
        hUTD1U6Yrg+Wq+gZndjrPut7Ww==
X-Google-Smtp-Source: AK7set+HDYmInM2tTfFuLUtoD16H+0exnZ60s0DP4733eMIvnNlS8+AlnGR1EkJ3KPoJ9W9ThVkWTw==
X-Received: by 2002:a17:906:a104:b0:926:c7ac:51fd with SMTP id t4-20020a170906a10400b00926c7ac51fdmr3332433ejy.44.1679408590876;
        Tue, 21 Mar 2023 07:23:10 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id mm24-20020a170906cc5800b009336687cf77sm3492117ejb.85.2023.03.21.07.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:23:10 -0700 (PDT)
Message-ID: <f2dcfb13-23c2-4394-a23a-4ba5d1a02016@linaro.org>
Date:   Tue, 21 Mar 2023 14:23:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 03/26] gunyah: Common types and error codes for Gunyah
 hypercalls
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-4-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230304010632.2127470-4-quic_eberman@quicinc.com>
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



On 04/03/2023 01:06, Elliot Berman wrote:
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   include/linux/gunyah.h | 83 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>   create mode 100644 include/linux/gunyah.h
> 
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> new file mode 100644
> index 000000000000..54b4be71caf7
> --- /dev/null
> +++ b/include/linux/gunyah.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _LINUX_GUNYAH_H
> +#define _LINUX_GUNYAH_H
> +
> +#include <linux/errno.h>
> +#include <linux/limits.h>
> +
> +/******************************************************************************/
> +/* Common arch-independent definitions for Gunyah hypercalls                  */
> +#define GH_CAPID_INVAL	U64_MAX
> +#define GH_VMID_ROOT_VM	0xff
> +
> +enum gh_error {
> +	GH_ERROR_OK			= 0,
> +	GH_ERROR_UNIMPLEMENTED		= -1,
> +	GH_ERROR_RETRY			= -2,
> +
> +	GH_ERROR_ARG_INVAL		= 1,
> +	GH_ERROR_ARG_SIZE		= 2,
> +	GH_ERROR_ARG_ALIGN		= 3,
> +
> +	GH_ERROR_NOMEM			= 10,
> +
> +	GH_ERROR_ADDR_OVFL		= 20,
> +	GH_ERROR_ADDR_UNFL		= 21,
> +	GH_ERROR_ADDR_INVAL		= 22,
> +
> +	GH_ERROR_DENIED			= 30,
> +	GH_ERROR_BUSY			= 31,
> +	GH_ERROR_IDLE			= 32,
> +
> +	GH_ERROR_IRQ_BOUND		= 40,
> +	GH_ERROR_IRQ_UNBOUND		= 41,
> +
> +	GH_ERROR_CSPACE_CAP_NULL	= 50,
> +	GH_ERROR_CSPACE_CAP_REVOKED	= 51,
> +	GH_ERROR_CSPACE_WRONG_OBJ_TYPE	= 52,
> +	GH_ERROR_CSPACE_INSUF_RIGHTS	= 53,
> +	GH_ERROR_CSPACE_FULL		= 54,
> +
> +	GH_ERROR_MSGQUEUE_EMPTY		= 60,
> +	GH_ERROR_MSGQUEUE_FULL		= 61,
> +};
> +
> +/**
> + * gh_remap_error() - Remap Gunyah hypervisor errors into a Linux error code
> + * @gh_error: Gunyah hypercall return value
> + */
> +static inline int gh_remap_error(enum gh_error gh_error)
> +{
> +	switch (gh_error) {
> +	case GH_ERROR_OK:
> +		return 0;
> +	case GH_ERROR_NOMEM:
> +		return -ENOMEM;
> +	case GH_ERROR_DENIED:
> +	case GH_ERROR_CSPACE_CAP_NULL:
> +	case GH_ERROR_CSPACE_CAP_REVOKED:
> +	case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
> +	case GH_ERROR_CSPACE_INSUF_RIGHTS:
> +	case GH_ERROR_CSPACE_FULL:
> +		return -EACCES;
> +	case GH_ERROR_BUSY:
> +	case GH_ERROR_IDLE:
> +		return -EBUSY;
> +	case GH_ERROR_IRQ_BOUND:
> +	case GH_ERROR_IRQ_UNBOUND:
> +	case GH_ERROR_MSGQUEUE_FULL:
> +	case GH_ERROR_MSGQUEUE_EMPTY:
> +		return -EIO;
> +	case GH_ERROR_UNIMPLEMENTED:
> +	case GH_ERROR_RETRY:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#endif
