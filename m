Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03FF714F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjE2Sgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjE2Sgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:36:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714ED2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:36:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4d6aee530so3742686e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685385389; x=1687977389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3ozesbe+mSNz95y12LI1uVitfrg5g7D4Ki7IAE/tYk=;
        b=kyKAFSjY987yHXaGsuiqDYW8Jkn6gLhGEDhvO4jpA/k2/Y30WwMN/32qddtqYgAKcb
         A92EGA58yEHfh2UpxikHWTnIjzwO6mp+snFNq1ay6517+gaH7auhTxvvK626eowRhP8+
         QVmyyfVo+cHFdKQXTFMuiQxwS0Gy0xQ2NjvMC1wf+FEHCCi6EOQXdD5q3T4w6EGfuryX
         Rr55Bs+qS5JqISCn2x6XFok08rTnrU7NIIZdwN3Gl8IJ6EkzSXQ1km8yhMP6p6/Hwg+U
         7mN+kUQXbRW5QwS9xJ1wiuqKlrvRQtjtFad6KiExsOpmkhigLIRIp8r7+ljEsJLpDg0B
         o8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685385389; x=1687977389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ozesbe+mSNz95y12LI1uVitfrg5g7D4Ki7IAE/tYk=;
        b=Uc02iE2aNNl/lKRd4CwMMWUsyR/MmsnJSEujgrJYgAmpgvgeX3T/u+Uj4KZ2so5aLE
         E/nFIhksWbZFwbSWwoPtUGYH+z3OlZGoKh6woDqtAT5DIgRQaQSRKFxdhwgHgujYsH9R
         EMxq/+nb64bbiR/ucOdjkgl1lAC1WbcGQ8/J0VqDfM0m7ww/oe1pAr16im9QTiefhXZe
         GdBOgyWMvzzDFPk4o0EmnMbj9w7cDCrZIHgTBIsU6Y0m4trkjPPfaZtEvpUi9p8o6VQ5
         EuqdpMgRgrC7ziOHoIrpevIejNvutLZ7z6lmxC36tjDPTHd3zSXAHlIjzaWzsLMKTWIQ
         kRMA==
X-Gm-Message-State: AC+VfDyLvWVV925tk6h9wiYK/mlR8ntEgF3bGz78pDjDBfI2GHkSN/bF
        Auqi42ddsNZltLPCx1j77bJhSg==
X-Google-Smtp-Source: ACHHUZ6dn47QBusaXpkxE0E5EKJjRxwpIGLwNnUgxmrCRciC1SFZdzeIITChD9ljPFiOeMyeOiEqhw==
X-Received: by 2002:ac2:514c:0:b0:4f3:a69e:1d80 with SMTP id q12-20020ac2514c000000b004f3a69e1d80mr3114138lfd.0.1685385389404;
        Mon, 29 May 2023 11:36:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id l19-20020a19c213000000b004f37a541f0csm74832lfc.270.2023.05.29.11.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 11:36:28 -0700 (PDT)
Message-ID: <ec745998-8b07-c5a5-5220-b2e21528eac1@linaro.org>
Date:   Mon, 29 May 2023 20:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.05.2023 20:16, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
> 
> Switch the code to use of_reserved_mem_lookup(). There is no functional
> difference for static reserved memory allocations.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> See e.g. [1] for an example of dynamically allocated reserved memory.
> (This patch does *not* depend on [1] and is useful without as well...)
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

>  drivers/media/platform/qcom/venus/firmware.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
[...]

> -	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
> +	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region: %pR\n", &r);
> +		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
Nit : I'm not sure which is more useful, but many mapping functions
seem to prefer printing

start, start+size-1

instead of 

start, size

on failure.

Konrad
>  		ret = -ENOMEM;
>  		goto err_release_fw;
>  	}
> @@ -138,8 +142,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	memunmap(mem_va);
>  err_release_fw:
>  	release_firmware(mdt);
> -err_put_node:
> -	of_node_put(node);
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
> change-id: 20230529-venus-of-rmem-f649885114fd
> 
> Best regards,
