Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3CB663314
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjAIVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbjAIVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:34:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DFB16582
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e129so5241523iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgKqcAZtTPAWpAPXzq52W1m4zeeDN2d547UDbCE4Yak=;
        b=DQM04VXj/zxsii0d9hiGcYkmhj9XQ7VtFP6+QXxo1IQPEAxcWItpbBs0CvzcHfTclX
         m38CLCKrOaHwOjQY6FZ3YURiIDrhJV1XH77ohCzCdxDq7PMRmpvJVCbcrIxxDucJitnt
         8kJsamnk563ShbWaYmN4siIcnCZ/Tvmv5G3mkKN8kp/YVBK7+3eMn69104kv7CVFhs+M
         kvyNbknS2Y6H03P8urjDRDdp/wdQz99knCaSOj3TTIML5OmVVmfUyghZXwXzLDaCOaBI
         zFAeVzbx/oaPJcUjdfFE2Nz9xjUVLhtPR0WfKkUj+G+bQlU07Nbhw5/AtCDTtTUADi6D
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgKqcAZtTPAWpAPXzq52W1m4zeeDN2d547UDbCE4Yak=;
        b=p85xWm+D+MIRiyykJxs1OZSvJDg/wtOuKO03jYRHmiJ+NYdcieZDBYttir3mOmJ9cB
         b6xkzBsEykxU0ftxlg7j9S6bMR85b65ufuLZhieXiEZTSqhmqtwgwOpcuUa9NPgsOjwi
         QQLnUoXjwRPpH8xGCShGg1kHK0CjN3NOL3KhVN2JezMRhH2sz1+U+OxrL1zz30moMvUp
         vleHxqNgvX0zB5Ng+9WU5pDwMVcJkhEvJOkNf5TWnvExtD9Z8ezDQQy7lfZjU1G5DpmM
         /Ac0FFPognK4P+V08jory6FAsqPBuP5vgGeCqPdldH22Wf2OZHbBu1rL9L+haD7shJBs
         9ydg==
X-Gm-Message-State: AFqh2kpqwmduST7KX3Xb0hWNLzjVHMvxISPQlKtKeYEpT/YSeqGcJfhw
        SLLpXD2AwNmm5AzGnhdfol32hg==
X-Google-Smtp-Source: AMrXdXtYGtRAxGls2gGKrjWvkzPPJp94p4qpoNrderYEp6UAEo+HikmjAK7gxeFOEpO7lh19ufhrOw==
X-Received: by 2002:a5e:c809:0:b0:6e0:10d4:6ac7 with SMTP id y9-20020a5ec809000000b006e010d46ac7mr57436217iol.7.1673300059572;
        Mon, 09 Jan 2023 13:34:19 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056638228400b0038a416931edsm3111165jas.91.2023.01.09.13.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:19 -0800 (PST)
Message-ID: <14eba2db-6f35-8b29-2b5e-6f1937b4e318@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 03/28] gunyah: Common types and error codes for Gunyah
 hypercalls
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-4-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-4-quic_eberman@quicinc.com>
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
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   MAINTAINERS            |  1 +
>   include/linux/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 include/linux/gunyah.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f32320a9efa4..74e76e0ab14d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8941,6 +8941,7 @@ L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
> +F:	include/linux/gunyah.h
>   
>   HABANALABS PCI DRIVER
>   M:	Oded Gabbay <ogabbay@kernel.org>
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> new file mode 100644
> index 000000000000..824e20a11d27
> --- /dev/null
> +++ b/include/linux/gunyah.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GUNYAH_H

Maybe use _LINUX_GUNYAH_H?

> +#define _GUNYAH_H
> +
> +#include <linux/types.h>

Why is types.h included?

U64_MAX is defined in <linux/limits.h> (in case that's why).

Otherwise this just defines a fixed API exposed by Gunyah
so there's not much more for me to comment on.

					-Alex

> +#include <linux/errno.h>
> +
> +/* Common Gunyah macros */
> +#define GH_CAPID_INVAL	U64_MAX
> +#define GH_VMID_ROOT_VM	0xff
> +
> +#define GH_ERROR_OK			0
> +
> +#define GH_ERROR_UNIMPLEMENTED		-1
> +#define GH_ERROR_RETRY			-2
> +
> +#define GH_ERROR_ARG_INVAL		1
> +#define GH_ERROR_ARG_SIZE		2
> +#define GH_ERROR_ARG_ALIGN		3
> +
> +#define GH_ERROR_NOMEM			10
> +
> +#define GH_ERROR_ADDR_OVFL		20
> +#define GH_ERROR_ADDR_UNFL		21
> +#define GH_ERROR_ADDR_INVAL		22
> +
> +#define GH_ERROR_DENIED			30
> +#define GH_ERROR_BUSY			31
> +#define GH_ERROR_IDLE			32
> +
> +#define GH_ERROR_IRQ_BOUND		40
> +#define GH_ERROR_IRQ_UNBOUND		41
> +
> +#define GH_ERROR_CSPACE_CAP_NULL	50
> +#define GH_ERROR_CSPACE_CAP_REVOKED	51
> +#define GH_ERROR_CSPACE_WRONG_OBJ_TYPE	52
> +#define GH_ERROR_CSPACE_INSUF_RIGHTS	53
> +#define GH_ERROR_CSPACE_FULL		54
> +
> +#define GH_ERROR_MSGQUEUE_EMPTY		60
> +#define GH_ERROR_MSGQUEUE_FULL		61
> +
> +static inline int gh_remap_error(int gh_error)
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
> +		return -EPERM;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#endif

