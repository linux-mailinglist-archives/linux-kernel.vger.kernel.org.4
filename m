Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A7680BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbjA3L1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjA3L1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:27:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901591B55F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:27:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k4so25272984eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlVSkC3h83pvwxentEZEDZ6ErBpK3r4Fa5mP7GzDuPI=;
        b=CF0oarnAUZUZlcT9Eyg+nITE9Ss2xi9wz7UJwENjdmmkgKiqYXuTjZmSah/kib07n5
         nSIe5Git30+8G7pADAJllLtg/m1qBIVtBJcsilvINgcRWuv/uVv9F9Pho2wJwN5F32Xs
         cU4vXei3FBO2Oy/OPAxrVOVVnfEhJboGUecFs9Zhl5jwK2bahoKAfdBQ0fl4j79SkmCl
         nqsw07lpngwHBmsEqdDXJCw7kQkU2hm77SEvCXdSKA5RohR0xuYxz1to711csdi0vkPV
         A+H5uiDuIcDJb5k44frM+Chnj0V7ZHj6XJr8ZOPKujL3m8+9PwsdGlYIgh9iMJ/rtzxe
         foMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlVSkC3h83pvwxentEZEDZ6ErBpK3r4Fa5mP7GzDuPI=;
        b=XgemyLbmYwhAlXWce1TzzwRgSDVg7uPkKr4o7DkcmpsHpv8HFGaQ457jVBQKFsnr5u
         PM7VJznBPd0Lve2W4iaZX8ZQnBhM3zYerWHlu1t5nL1tYrCu4xvU7eMvItKMYd6KzdrD
         rY3Rw4949kBeUL1ns8I+zIulLYDZ5/tiEdd697QiRnDz4WrC9mvfbf0B3v13kFY76Wjx
         0R8ZYuA6nPEI7ESpAUX9oxqmLAgZNexKb3WpK7arHbvh4W+quc/S1ttvxIpS1WUPo0F0
         rksqbSoeHaxXLxA7HkA50Ft/EZRiInDDkKqsaR0r4M4RyKgDAu8rz8PFScPtxX5Rr5PI
         brRg==
X-Gm-Message-State: AFqh2kpAwiNbiVbGlp6ru4JI0AejLlL4M4XWyXXI6Iy/9BrU95A436ok
        ZLFvRNzsOr0gyWWz679Dm87F6sZtGqqRBY+w
X-Google-Smtp-Source: AMrXdXs+yzTG9RvBec1P0R4o3O2nHL5MR94xIJTPwnbGU+Zud8TK8Sz89S8Cqpnrco2BAje1vj0F3Q==
X-Received: by 2002:a17:906:38c3:b0:872:82d3:4162 with SMTP id r3-20020a17090638c300b0087282d34162mr47302655ejd.44.1675078028132;
        Mon, 30 Jan 2023 03:27:08 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q18-20020a1709064c9200b0085ff3202ce7sm6735934eju.219.2023.01.30.03.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:27:07 -0800 (PST)
Message-ID: <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
Date:   Mon, 30 Jan 2023 11:27:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <Y9UmhI3hRVjLVWFp@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y9UmhI3hRVjLVWFp@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2023 13:43, Greg KH wrote:
> On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Here are some nvmem patches bit more than usual for 6.3 which includes
>>
>> - Adding support for nvmem layouts, thanks to Michael and Miquel for
>>    driving this effort.
>> - Add support to stm32 STM32MP15x OPTEE based nvmem provider
>> - Updated to qfprom bindings to include various Qualcomm SoCs.
>> - adding sl28vpd provider layout
>> - move imx provider to use new layout apis
>> - add ONIE provider layout.
>> - new helper eth_addr_add().
>> - few minor enhancements to core and providersdrivers.
>>
>> Can you please queue them up for 6.3.
> 
> This series does NOT apply to my char-misc-next branch, which is based
> on 6.2-rc5.  What did you generate it against?
> 
These were on top of nvmem-fixes based on 6.2-rc1.


> Can you rebase it and resend?

char-misc-next does not have nvmem-fixes yet, which branch should I 
rebase these on?

thanks,
srini

> 
> thanks,
> 
> greg k-h
