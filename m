Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC16A1271
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBWV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBWV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:59:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDA1FFA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:59:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ky4so15880008plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4Mr/rCIfznjMH6ZhmV4S/R+2E0ra9anHB7zT/P7eKw=;
        b=fmoe7GqEAskBDcDzNZHbQZoj09JyGfUXYYKF5nEbfxEGliwyTZ78C8xVaf1Q5X8HJl
         c2294rdMFOUVcTOP8Y2gbuHZY3Cn3197Pqoy1qcFdlpbO1ErMVeuKjjdUDlW6kICPt8K
         xqzuhbgC6VvbLXb440TXkCn/hApWyobxQqgZ9OEY5ZkGor1G468/XaI1YePz/7mFn6/3
         yke+cSm08fEsWLdvWGmGAHsQ50X+yxHCklgX/YHAuKNIgH3k/mxNjkZqPXZTlxYm6nsT
         /O9jAsS/553PM2fsIgDltac4CNriIRC0nrWJzVfzkkJxNLd3kuK5NL7enclap6D/Djqk
         5Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4Mr/rCIfznjMH6ZhmV4S/R+2E0ra9anHB7zT/P7eKw=;
        b=BoukdHT4ezRv298x8H1wPyIYoLABlotLvE7ko19TO6oaRpF5tkvZnk8nB0Xj57hxiT
         VcWKV3wmqFEfPevlJQwBf7c2rqiY5P5aDHIjIR77gmtVTxssSycvc3R/NFeFapyH32AJ
         aR7OG62Z4F259GoGMjCj/KoYtBbTqse20CrmKPHRud9dJg6igL5RYbtL1Dwd4W3YWjt3
         HtPrFTEmh1AGPuOb8vl7HMcEO5R4e9/IoSwj3OG8YQXamCISDudx8dfIsLzaHI76gJMy
         l5/Ivrd0XpFs4ZvYu188jHNTNUvnoIkTl52E3S99oNfzRMfIHTxmeP9AcTu2Y6F3+rHt
         p0SA==
X-Gm-Message-State: AO0yUKXXgjXO/EH8S4WolLP6O47z/WbUqLzOYntk7g/Z7sY++JbfoGWW
        DbxOm4Nt60uTcG2j4h28T7jgvg==
X-Google-Smtp-Source: AK7set+IuofcGG5Kuc+wgMaj11Z8DA++Rd/x/pbYLU/+F/IK9///eNtuG5BrHiJykcQjod2gP5rnrA==
X-Received: by 2002:a05:6a21:33a4:b0:cc:59b7:79e6 with SMTP id yy36-20020a056a2133a400b000cc59b779e6mr1112752pzb.24.1677189540582;
        Thu, 23 Feb 2023 13:59:00 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b00502ecb91940sm3043520pgp.55.2023.02.23.13.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:59:00 -0800 (PST)
Message-ID: <5d67ee67-e63f-1393-1455-bfb6b2ddaeb5@linaro.org>
Date:   Thu, 23 Feb 2023 15:58:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 03/26] gunyah: Common types and error codes for Gunyah
 hypercalls
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-4-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214211229.3239350-4-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:12 PM, Elliot Berman wrote:
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   include/linux/gunyah.h | 82 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>   create mode 100644 include/linux/gunyah.h
> 
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> new file mode 100644
> index 000000000000..59ef4c735ae8
> --- /dev/null
> +++ b/include/linux/gunyah.h
> @@ -0,0 +1,82 @@
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

Do you expect this type to have a particular size?
Since you specify negative values, it matters, and
it's possible that this forces it to be a 4-byte value
(though I'm not sure what the rules are).  In other
words, UNIMPLEMENTED could conceivably have value 0xff
or 0xffffffff.  I'm not even sure you can tell whether
an enum is interpreted as signed or unsigned.

It's not usually a good thing to do, but this *could*
be a case where you do a typedef to represent this as
a signed value of a certain bit width.  (But don't do
that unless someone else says that's worth doing.)

					-Alex

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
> +	case GH_ERROR_IRQ_BOUND:
> +	case GH_ERROR_IRQ_UNBOUND:
> +	case GH_ERROR_MSGQUEUE_FULL:
> +	case GH_ERROR_MSGQUEUE_EMPTY:

Is an empty message queue really busy?

> +		return -EBUSY;
> +	case GH_ERROR_UNIMPLEMENTED:
> +	case GH_ERROR_RETRY:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#endif

