Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3C68DA69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjBGOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBGOUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:20:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFB35267
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:19:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee13so9104096edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncddaZZzsCJCjKrAiWzC5f6YjHdCJZJ4++SOQQ4JbMo=;
        b=oQbzvmK0cLGzJH5QVQnHx+5mc3P4weM+Unh0JOo3FPep2+qVVVRF48gdNUfALDg7PD
         SEV/Y6mGiEnMysUaB/eiudjd5i5WJZvGi7xk2JiPRQSYvjINQfmKu2PVh1kyQcV46qBo
         oF9vu0XqUT9hT4rDkmxURs6G6RKsJfBYkms0BlLNw28WHk2XPFYHK7o3ePkMH05V8q5k
         OFu9WeumQqfA80v903ZqampsI5jUomJKVu5eCJV+dLrWxxbQ4XW21V+mYi63Jg2vP/6W
         N8pH1oZZkwQD0ucjFFFUuR4rCffowbHb2B1v8IFwenGj8API65NSCetlIqVLYSPLe83g
         uxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncddaZZzsCJCjKrAiWzC5f6YjHdCJZJ4++SOQQ4JbMo=;
        b=4CUnOo52p84CJk4dGFfSYPuWV997QoDQNVsvxWOkfgcp0/qdDqrsksxk5M1irhkANJ
         6BK6rdq2U0A8BxZoo1pg6q+77TyuXn+lBfA+Gi996i9AhmVOQ/5XIPVJAPK0kzEeixXp
         GzLtMN9oI/cRerB7FTKnAuHtJpCMQKjnGgwjnPt1s1BvbzXBvLCJTAsoqc9pHQ+hriy1
         6ZjY5mo3TodmC8h8QnhItntUWhCFmpdf5d9F9KG3YIHp2Vb4MOLkxsVppfiFA7gQKQgw
         iJj/6edsDm6AO+deqiGOKiM0A0IUPN974Y/3tHBuAo8Nnb2hUUllYU2WtfjNOyCOlIp+
         d91A==
X-Gm-Message-State: AO0yUKV0iIB/xnQn9ouy60W2u27mjCYW+EA5lvcv6+FmSpZQi8/5WMVM
        FAc5ZLOwYgIH/7dQe6RXeSGjWA==
X-Google-Smtp-Source: AK7set946nsuL321n2/lGqU9eRrqJ9mkSYOuw4VJXij8dCzC+Yqa8ZC2PRnYkxlJF2tt1ThwIoShxQ==
X-Received: by 2002:a50:d741:0:b0:4a2:3d2e:6502 with SMTP id i1-20020a50d741000000b004a23d2e6502mr3970815edj.4.1675779597008;
        Tue, 07 Feb 2023 06:19:57 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id fd8-20020a056402388800b004a245350e0fsm6526428edb.36.2023.02.07.06.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:19:56 -0800 (PST)
Message-ID: <73ab93b9-be0b-2fc0-81ee-49b4f5780e3e@linaro.org>
Date:   Tue, 7 Feb 2023 14:19:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 27/27] virt: gunyah: Add ioeventfd
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-28-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-28-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
> Allow userspace to attach an ioeventfd to an mmio address within the guest.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/vm-manager.rst |  21 +++++
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_ioeventfd.c   | 109 +++++++++++++++++++++++
>   include/uapi/linux/gunyah.h              |  10 +++
>   5 files changed, 150 insertions(+)
>   create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c

> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index a947f0317ca9..3cc387f0831a 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -65,11 +65,21 @@ struct gh_fn_irqfd_arg {
>   	__u32 flags;
>   };
>   
> +struct gh_fn_ioeventfd_arg {
> +	__u64 datamatch;
> +	__u64 addr;        /* legal mmio address */
> +	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
> +	__s32 fd;
> +#define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
> +	__u32 flags;

This is not naturally aligned, consider adding a reserved __u32 field to 
be able to make this compatible with both 32 and 64 bit machines.

I see few other uapi structures that suffer exact same issue.

--srini

> +};
> +
>   struct gh_vm_function {
>   	char name[GUNYAH_FUNCTION_NAME_SIZE];
>   	union {
>   		struct gh_fn_vcpu_arg vcpu;
>   		struct gh_fn_irqfd_arg irqfd;
> +		struct gh_fn_ioeventfd_arg ioeventfd;
>   		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
>   	};
>   };
