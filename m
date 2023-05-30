Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC27161F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjE3Nb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjE3Nbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:31:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7AC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:31:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so30742575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685453511; x=1688045511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4TkSxjrXFcrtwILbeS9FwTTUMwJjznUHF2WZNJpwBU=;
        b=KZxGd9Leab3vyVTua670SESofGfH/vNC8uJ9Ks4PZVINHELyk+1/3H7CokcsEJWai/
         9Pk6jGg+MoBlyGzKk2cYHyzHY2usokRuZtaVj27zNrSF6d+LqEVqXFiksGqE7FQWj2Yk
         7EImtBRAy/Gxp7F5BhhqJ4VgGrp5aiuIpJYqlm5R6eEhL8YEeAkR1WkloBdQMofcx4fB
         euoMJhMNT+8KnCjB8gTzLxnm1JhlydhO7KOXi5Ij5vftg+PTRlTy/psHV2lr7TAq2Nd2
         aLz8LxSVU/u4SNwRoCRnbz8R07xeDGKtW7dhVXQMo7Cqjn4bAks58xI5vZjWF456vqsk
         7S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453511; x=1688045511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4TkSxjrXFcrtwILbeS9FwTTUMwJjznUHF2WZNJpwBU=;
        b=MqRzoCy+2OEY3lGZZPXGWaH1OrQiBOd+JiFb7B+/3ACfvggQzGiSVeGFJdZ+56VXu+
         mj6zHre9aZjhoWPwDciDLHJmghjTxQ8yjOt5z5bl88oaOisYQdYfIKq0bMCf2k/B6XPt
         cvc89iE4/cVEtS1spVjQ5eOWo/JgjiNseD4ruNJWnVzXxsbxOAUw3OwIRm3r5Yi9+8ld
         b4O8nge99TIuFCOQrHA8SBlLpJUuxaesiKBzN+sIohnM+1wcBAXebrigd9eWc0t0kbzW
         gShMboAlp/5rOmsWMUK+C99b1A155rFOM9VG2j+lNKPqbVavAVcPTRhgaFdUcOEUkeCD
         euDg==
X-Gm-Message-State: AC+VfDw1Qw/rU0+Nfg2072EYfL1Bogik+mxwY4wZfTAM9uignYlQ4WST
        9Qx+Ss+gdgSvhhzmClGyygEydQ==
X-Google-Smtp-Source: ACHHUZ4S7Q0TZkKc2h+WlslbMqi6X7Va2BSFmmk0dtePu/I7yooYlXUSA/kGWkN7npTrb2BeQm95Lw==
X-Received: by 2002:a1c:7206:0:b0:3f6:50e:315f with SMTP id n6-20020a1c7206000000b003f6050e315fmr1442827wmc.41.1685453510780;
        Tue, 30 May 2023 06:31:50 -0700 (PDT)
Received: from [192.168.0.84] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f1958eeadcsm20906694wml.17.2023.05.30.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:31:50 -0700 (PDT)
Message-ID: <44ec7cce-cd7d-27a3-149b-49fda6308777@linaro.org>
Date:   Tue, 30 May 2023 14:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] misc: fastrpc: support complete DMA pool access to
 the DSP
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dylan Van Assche <me@dylanvanassche.be>,
        amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        dan.carpenter@linaro.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
References: <20230511141146.30465-1-me@dylanvanassche.be>
 <20230511141146.30465-2-me@dylanvanassche.be>
 <e0365591-0f03-ab3d-61b4-c016541f2157@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <e0365591-0f03-ab3d-61b4-c016541f2157@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 11:52, Srinivas Kandagatla wrote:
> On 11/05/2023 15:11, Dylan Van Assche wrote:
>> To support FastRPC Context Banks which aren't mapped via the SMMU,
>> make the whole reserved memory region available to the DSP to allow
>> access to coherent buffers.
> 
> Mapping the whole region sounds very inefficient, and also possibly
> making the cma region not usable by others.

Probably I'm missing something obvious here... The downstream driver
maps the whole region, what are the advantages to doing it on a
per-allocation basis?

What are the other users?
> 
>>
> 
> AFAIU SDM845 does not have any context banks for SDSP. All new SoCs
> after 865 have moved to having a context bank.
> 
> For such cases (w/o cb) we can make fastrpc_session_alloc use channel
> context device instead of session ctx device. As this is going to be an
> issue when we try to allocate buffers dynamically for that cb.

Right.. This is what patch 2 does, but presumably the ALLOC_DMA_BUF,
MMAP, etc ioctls won't work with the current iteration?

> 
> In the newer platforms (from 865) there is support for iommu and context
> banks on SDSP, so the existing code flow is identical for both ADSP and
> SDSP.
> 
> 
> We should be careful not to break newer platfroms while adding support
> to this.
> 
> Both myself and Ekansh thought about this and see that the better way to
> add support to this is by
> 
> 1. extend fastrpc_session_alloc() to support zero context banks.
> 
> 2. add flags to mark this and allocate meta data using secure allocation
> when its required based on this flag.
> 
> 3.  buffer allocation can either go with 2 or with a new flag coming
> from userspace.

This sounds pretty good to me!
> 
> 
> 
>> This is performed by assigning the memory to the DSP via a hypervisor
>> call to set the correct permissions for the Virtual Machines on the DSP.
>> This is only necessary when a memory region is provided for SLPI DSPs
>> so guard this with a domain ID check.
>>
>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/misc/fastrpc.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index f48466960f1b..1ced553ae959 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -2231,6 +2231,8 @@ static int fastrpc_rpmsg_probe(struct
>> rpmsg_device *rpdev)
>>       int i, err, domain_id = -1, vmcount;
>>       const char *domain;
>>       bool secure_dsp;
>> +    struct device_node *rmem_node;
>> +    struct reserved_mem *rmem;
>>       unsigned int vmids[FASTRPC_MAX_VMIDS];
>>         err = of_property_read_string(rdev->of_node, "label", &domain);
>> @@ -2274,6 +2276,19 @@ static int fastrpc_rpmsg_probe(struct
>> rpmsg_device *rpdev)
>>           }
>>       }
>>   +    rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
>> +    if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
>> +        rmem = of_reserved_mem_lookup(rmem_node);
>> +        if (!rmem) {
>> +            err = -EINVAL;
>> +            goto fdev_error;
>> +        }
>> +
>> +        qcom_scm_assign_mem(rmem->base, rmem->size, &data->perms,
>> +                    data->vmperms, data->vmcount);
> 
> vmperms need to be a bit field.
> 
>> +
>> +    }
>> +
>>       secure_dsp = !(of_property_read_bool(rdev->of_node,
>> "qcom,non-secure-domain"));
>>       data->secure = secure_dsp;
>>   
> 
> --srini

-- 
// Caleb (they/them)
