Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8CB723067
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjFETvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjFETvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:51:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA521B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:50:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-777ac4344f9so45118639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994633; x=1688586633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWux2zN8aBm4AOKOzL2QZg5moSP9cBqza5x96VmFFH0=;
        b=gb72ZjOG2T702JUBTjXQJ9M8dsR7IB11iT/qMvGwCr5aWKIZizAkkPbHfIK1swW0RK
         NlqdcWs+K3nHISF6/Ejna0au5d/9swKxDbEnalNGbGz5U4YkhYtUlyaMJGrkXOv/k+4o
         MaffWmHh+lTfNVqM3KyLaUAx7+IGE7FEYxyGt9zHkw4wFXvJRVNmKbFrNCH/25Etn6w2
         a4zGjilqkFAzUj4tTqUPC0LorwmzfnqnAHOhDyJxDPUcizI37jqh6H728mVQbKbn+ik7
         KmkVhuMuQg7NYX2JxmtlRhAIoE8XsCzto2efDbhRbPxG9EXR6TjhT4nV7+EzTq3/ej/x
         XOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994633; x=1688586633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWux2zN8aBm4AOKOzL2QZg5moSP9cBqza5x96VmFFH0=;
        b=fMKC4t8PUuoyNJ7NIIKFgHAjcY3qZOXIeQJ0kSuUHvjAC9yJB2CLKApKht61Aa5WLM
         AtqQv3wDHIN9N5WTstJ+lntgXcEXZY4MVL6ZlvH0t3iRu4KPE5xERQ7FFw1jvXzXvk3b
         /VhAWyN6QBXRlpcnVm66FTyFkGqiewxLnzUgh80wKwkYpq3jGKxojAh8/06MKSJpYnzd
         b7rjXzSIJ1p26K70syKB17VDql9+UNTvqbC7FSUImvh3ieaIVLGhv+7gh9c/25qq/fGy
         ek7p6hzgnS+EwAuhU4nTKg/pS2kSDh+uabkWH4j+rBQ5lYu9V0KvYVs8jZDyCcGX/fnZ
         ZFTQ==
X-Gm-Message-State: AC+VfDx8J28wVH3b/vgSLjrWgFcBjd1p32E9dqda+r61qwQfqnB5g2sp
        1HoRplcAvUI7QUocYT/QtS/qNw==
X-Google-Smtp-Source: ACHHUZ79gpJfC3/JN7fry1AODi9w0klUZaKa8fmJlnNw5Wdoe/QxZtf4v4+bIbEII1SP0JleX9WuGQ==
X-Received: by 2002:a6b:6f15:0:b0:776:feaf:8cec with SMTP id k21-20020a6b6f15000000b00776feaf8cecmr243634ioc.3.1685994633721;
        Mon, 05 Jun 2023 12:50:33 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i13-20020a6bf40d000000b00776a991d35asm2642558iog.14.2023.06.05.12.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:50:33 -0700 (PDT)
Message-ID: <1c386f4e-e2dd-eb79-9117-9b19877f2ccc@linaro.org>
Date:   Mon, 5 Jun 2023 14:50:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 22/24] virt: gunyah: Add irqfd interface
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-23-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-23-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Enable support for creating irqfds which can raise an interrupt on a
> Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
> function with the name "irqfd". If the VM devicetree is not configured
> to create a doorbell with the corresponding label, userspace will still
> be able to assert the eventfd but no interrupt will be raised on the
> guest.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have a minor suggestion.  I think I'd like to look at this
again, so:

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/virt/gunyah/vm-manager.rst |   2 +-
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_irqfd.c       | 180 +++++++++++++++++++++++
>   include/uapi/linux/gunyah.h              |  35 +++++
>   5 files changed, 226 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
> 

. . .

> @@ -99,6 +102,38 @@ struct gh_fn_vcpu_arg {
>   	__u32 id;
>   };
>   
> +/**
> + * enum gh_irqfd_flags - flags for use in gh_fn_irqfd_arg
> + * @GH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level triggered
> + *                        interrupt on guest side. Triggering IRQFD before
> + *                        guest handles the interrupt causes interrupt to
> + *                        stay asserted.
> + */
> +enum gh_irqfd_flags {
> +	GH_IRQFD_FLAGS_LEVEL		= 1UL << 0,

	BIT(0),			/* ? */

> +};
> +
> +/**
> + * struct gh_fn_irqfd_arg - Arguments to create an irqfd function.
> + *
> + * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IRQFD.
> + *
> + * Allows setting an eventfd to directly trigger a guest interrupt.
> + * irqfd.fd specifies the file descriptor to use as the eventfd.
> + * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
> + *
> + * @fd: an eventfd which when written to will raise a doorbell
> + * @label: Label of the doorbell created on the guest VM
> + * @flags: see &enum gh_irqfd_flags
> + * @padding: padding bytes
> + */
> +struct gh_fn_irqfd_arg {
> +	__u32 fd;
> +	__u32 label;
> +	__u32 flags;
> +	__u32 padding;
> +};
> +
>   /**
>    * struct gh_fn_desc - Arguments to create a VM function
>    * @type: Type of the function. See &enum gh_fn_type.

