Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A969E697
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBUR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjBUR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:58:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766412F783
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:58:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t13so5317868wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9iW/ZoFwA+vNVbz0hgRVCmhSYJ67As/r6GQ/C1MS14=;
        b=kkmL3bkoMHa3rpgJXIU9fm2m/Fc9fjZpTR1+czz9opAjVjbwio3hmu13RUzThMYSXr
         dAX9XP9ZETJTtBG/QfX7MLtnF0j7iNoZ+6VR48IL6eY1Uw/Rb2J3XMlPIbrCbU7JbcJm
         5sE1pZjBk+SnC1hEpL2huMoX5Okevrj7K/cC8lPGfxtmEFmCVIJDnloBCXlpxCBZPGQD
         eEyXAU8spQI6HN5l7w6WeCddUq9Hfo3j+p2R/paxWwsuumVe1yo+tgc+axra5TILoAEa
         z/nbx6Ycfgg1nU3Zd1TPZpREwMdRh1wGGq5ltq59Q/PgXdHcnvnLjZX2fUdWRvnsBDF9
         3iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9iW/ZoFwA+vNVbz0hgRVCmhSYJ67As/r6GQ/C1MS14=;
        b=XY/GE/cOgGf9icVSuob6bUhEc5CqljzabrgA3gVXVJqxjRnae4PKaaN+jKWdt4xzOz
         L6yVLyRuzIslowjI6Mr5/pqn7LxByz3TjLSBXTm+S09eFX7u988Hxn0AlUNjK7QIA6QM
         6vRCFy6pviqNtG1Dvif372soWxzJpqsoBdF/L2jdGoizmhJ/wfDXmW2B+3rTn8NEltLK
         NicskH5LYhUkD4l6aArb01T2gky5v14Jkb8EGO5rF3DhvTiLsyhb6uCoCAaq5EoM7nPI
         67rSPYDP4Nc7Qm0yCFMzcwpu8d00wXkzH2Jx+9cwIbkOS4U/S8gh9TjvoIQaL6a7qWSs
         YovA==
X-Gm-Message-State: AO0yUKXVlQiWEWBPVgK792YPZToMUbhE5UNDrksB/fHxY3EnJTIpJ7Jh
        4Hh+6hQPtRFiCcymb1OplDSOOQ==
X-Google-Smtp-Source: AK7set+2VYBIviYYpXRgHb6iWH4/F+lDyppvQ+R3fLX/zzCucj88ZsetqCFcBEokjGqacqiFHlxYlQ==
X-Received: by 2002:adf:d081:0:b0:2c5:9a0d:70a2 with SMTP id y1-20020adfd081000000b002c59a0d70a2mr4778164wrh.16.1677002313874;
        Tue, 21 Feb 2023 09:58:33 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z8-20020a056000110800b002c3dc4131f5sm6101436wrw.18.2023.02.21.09.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:58:33 -0800 (PST)
Message-ID: <51b57a36-a1e0-45c4-7300-6d2a85f30f6d@linaro.org>
Date:   Tue, 21 Feb 2023 17:58:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 19/26] gunyah: vm_mgr: Add framework to add VM
 Functions
Content-Language: en-US
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212531.3323284-1-quic_eberman@quicinc.com>
 <20230221130759.GD787573@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230221130759.GD787573@quicinc.com>
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



On 21/02/2023 13:07, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-02-14 13:25:30]:
> 
>> +int __must_check gh_vm_get(struct gh_vm *ghvm)
> 
> Minor comment:
> 
> get_gh_rm vs gh_vm_get -> can follow some consistent convention I think.
> 
> Perhaps get_gh_vm()?

it should be other way around

currently we have combinations of gh_vm and some other pattern, we 
should stick with one, in this case gh_vm_* or gh_rm_* makes more sense

here are all the exported symbols in gunyah.

./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_function_register);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_function_unregister);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_add_resource_ticket);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_remove_resource_ticket);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_mmio_write);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_add_io_handler);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_remove_io_handler);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_get);
./drivers/virt/gunyah/vm_mgr.c:EXPORT_SYMBOL_GPL(gh_vm_put);
./drivers/virt/gunyah/rsc_mgr.c:EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
./drivers/virt/gunyah/rsc_mgr.c:EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
./drivers/virt/gunyah/rsc_mgr.c:EXPORT_SYMBOL_GPL(get_gh_rm);
./drivers/virt/gunyah/rsc_mgr.c:EXPORT_SYMBOL_GPL(put_gh_rm);
./drivers/virt/gunyah/gunyah.c:EXPORT_SYMBOL_GPL(gh_api_version);
./drivers/virt/gunyah/gunyah.c:EXPORT_SYMBOL_GPL(gh_api_has_feature);
./drivers/virt/gunyah/rsc_mgr_rpc.c:EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
./drivers/virt/gunyah/gunyah_platform_hooks.c:EXPORT_SYMBOL_GPL(gh_rm_platform_pre_mem_share);
./drivers/virt/gunyah/gunyah_platform_hooks.c:EXPORT_SYMBOL_GPL(gh_rm_platform_post_mem_reclaim);
./drivers/virt/gunyah/gunyah_platform_hooks.c:EXPORT_SYMBOL_GPL(gh_rm_register_platform_ops);
./drivers/virt/gunyah/gunyah_platform_hooks.c:EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
./drivers/virt/gunyah/gunyah_platform_hooks.c:EXPORT_SYMBOL_GPL(devm_gh_rm_register_platform_ops);

> 
> 
>> +{
>> +	return kref_get_unless_zero(&ghvm->kref);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_get);
