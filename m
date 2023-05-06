Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7026F9354
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjEFR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:27:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0E160B4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 10:27:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f37a36b713so30261005e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683394073; x=1685986073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVlxfK3vFWYI8LD3VoVtUvMrMTf1h6eea1g6keWggg8=;
        b=Ig/Zou6BcNAblJ2ANEVxgOVxIXtHvMqyVNXQonmbHbO+1Zimv8q2GDL+pZZiHX4qQZ
         vN8rRfzQsg33ezgbuj1OCrFI6URrg2O22t5311bxXmz/qpALoB52f0mzVL7ITCfSUVt9
         pF52hW6vxQ5DGXwPpmCsbv4jXhcgpu0gwaZlMFKPMMT6O2ItWEAg0HS3aMbifJvDtcIE
         srJgLa3ND1GQ3KMeLZCpf6hokZA8GhCUVt2/8X1GrcxvvTAhJPsjKaoraorSpm5TK22P
         fO/TJip/Z8519/tJ9d3pZQcWlheLdtVY0entZtE0G1hZW7ANJ9KfLnpXtRbOweRYaCX/
         uBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683394073; x=1685986073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVlxfK3vFWYI8LD3VoVtUvMrMTf1h6eea1g6keWggg8=;
        b=iaU0gFWVfV/ljFRksR/ob7lECHUfUSeuMotq7j9sqdbyPt4hdWVvwp2ueQrCnzQaAK
         xCkNrBnvNPfCEGmpPfipzOonDlVtpBLP1OgIHxeN8sB1vGosvFQWg06Pa9iNCz4qFmDa
         Byy9/Kex0WLrIGhYzukI+j5/8YbVRlmjbIjDT7egc8f/19NCBST6N0OMWjnNUL4pyVAp
         e26U1XJfZmvd4TCaa5VWHGp0+7npipbQnirTLQRQj2b/z8Fdw9R3omiuMJQwbyQOsGsi
         bsrlMQ5jQj5RPywNIkSLKWp+z0XKLxqei6QgVc7h0l4Ptdszqmp0cENz4ZB0R5DGsAad
         TY8g==
X-Gm-Message-State: AC+VfDzrZ2i9xN0uwH3J7Q/YsmP7cZR/vrbXD9jjYJwkcjBoIBP0SN84
        vACKhfFQgH7zSD6YSuO5vxETCQ==
X-Google-Smtp-Source: ACHHUZ7B0B+vS8nBKcwUo0AJcN5qTwpT/Q1EYfGG0DtKZTglEL+Es7rUr867cqGYj+7WP0W7y96JkA==
X-Received: by 2002:a7b:cb58:0:b0:3eb:39e0:3530 with SMTP id v24-20020a7bcb58000000b003eb39e03530mr3172709wmj.41.1683394073222;
        Sat, 06 May 2023 10:27:53 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id g8-20020adff3c8000000b003078354f774sm4245037wrp.36.2023.05.06.10.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 10:27:52 -0700 (PDT)
Message-ID: <6fd44dd0-db11-6592-6670-2364af6ffdc6@linaro.org>
Date:   Sat, 6 May 2023 18:27:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] misc: fastrpc: support complete DMA pool access to
 the DSP
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230327184204.498032-1-me@dylanvanassche.be>
 <20230327184204.498032-2-me@dylanvanassche.be>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230327184204.498032-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2023 19:42, Dylan Van Assche wrote:
> To support FastRPC Context Banks which aren't mapped via the SMMU,
> make the whole reserved memory region available to the DSP to allow
> access to coherent buffers.
> 
> This is performed by assigning the memory to the DSP via a hypervisor
> call to set the correct permissions for the Virtual Machines on the DSP.
> This is only necessary when a memory region is provided for SLPI DSPs
> so guard this with a domain ID check.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Hi Dylan!

Personally pretty excited to LGTM. Please drop the noisy debug prints.
With those fixed

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f48466960f1b..caf2ae556956 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2231,6 +2231,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	int i, err, domain_id = -1, vmcount;
>  	const char *domain;
>  	bool secure_dsp;
> +	struct device_node *rmem_node;
> +	struct reserved_mem *rmem;
>  	unsigned int vmids[FASTRPC_MAX_VMIDS];
>  
>  	err = of_property_read_string(rdev->of_node, "label", &domain);
> @@ -2274,6 +2276,20 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		}
>  	}
>  
> +	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
> +	dev_info(rdev, "ASSIGNING MEMORY\n");

				^^
> +	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
> +		rmem = of_reserved_mem_lookup(rmem_node);
> +		if (!rmem)
> +			return -EINVAL;
> +
> +		dev_info(rdev, "ASSIGNING MEMORY START\n");

				^^
> +		qcom_scm_assign_mem(rmem->base, rmem->size, &data->perms,
> +				    data->vmperms, data->vmcount);
> +
> +		dev_info(rdev, "ASSIGNING MEMORY END\n");

				^^
> +	}
> +
>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>  	data->secure = secure_dsp;
>  

-- 
Kind Regards,
Caleb (they/them)
