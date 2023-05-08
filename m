Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599606FBA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEHVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjEHVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:54:24 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4659C4;
        Mon,  8 May 2023 14:54:11 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b60d0c5b8so24106466d6.0;
        Mon, 08 May 2023 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683582851; x=1686174851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtAzQzES9I7yNwBqIfwbZWRv7FD60/LkD0fvdz+X1d8=;
        b=CIf1JSnYYmsFIJlhk4/NzzeglTtB+d0mZwmuhQC6ECCTliVYouVKf+YTOlkvvIP0Wr
         Zob9QA43bAD+lk1jJaxYx5Bgl6s730KfkuL9qUqBH2sk1ppZ9bf4EdiyzbqMy5KSpjAp
         lKsB0EpaVBtFs9iISSEm4p2CnpQG3tfP7wFKQxYyLspN72+gO2XbDJLovNZq7YoMXHw3
         YyrQFLmrnh42UJ5lXjFNc403wWR2gyPh6pWgvD20ZEgB10oiAvTjDyAW+9ZKepL6Ut3S
         g68jGhDYWiRVBwlKp4mDqDDwh017bLBPa5Byi5QMcAgp3Q2dDImxDTWAjqS9E4kiXNUQ
         JkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683582851; x=1686174851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtAzQzES9I7yNwBqIfwbZWRv7FD60/LkD0fvdz+X1d8=;
        b=IF4fG86KulWw0GDQRu3Ksm4lCsB4kxQmPXzxcigxzCiezDF/nEUiYIZ/9fci0o+L4b
         Y7BqstgRx+10TkVOdiILxgF5wF4Uf78PZv5NVO2G9ya4IOYaqSEhrAmxjS9Lzjm59Nbq
         Hwzlr32qN74MdFg4zMxmGOxBXNKkZJojsvlFvEWI1Un7Y3TGvt9Tp9aoydzxHxg8h1Ox
         j3cqmJUmJybsUCB66C+WQ5EejOBhkFahcBtOPTEeMf0SLrTx9BjTSYI7z6XBxLYudJd8
         9HaNkdX5To0O0tc2yGGk4AJDASuktnzAmthUoYVXgEZFtucjcQq4QefzGNx+lJy9FQdo
         PIpQ==
X-Gm-Message-State: AC+VfDwk8cW3w7GaWwurgqzAkL37pfwd8umH5OtKrtqvymKuNQUCmXM0
        rLXXmPlINhOiksdLpWR/jA4=
X-Google-Smtp-Source: ACHHUZ5ybom6RrSpzq1VYoTnDCdZYCzJWdBq24QpSo2V4yvKhHbc0LizO4RGX3O4ncfCrXa24q9GPQ==
X-Received: by 2002:a05:6214:4011:b0:61e:800b:4fcc with SMTP id kd17-20020a056214401100b0061e800b4fccmr18449504qvb.25.1683582850910;
        Mon, 08 May 2023 14:54:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n7-20020a056214008700b005ef5f8dc89esm284571qvr.88.2023.05.08.14.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:54:10 -0700 (PDT)
Message-ID: <7f899e9b-5a3d-7150-9b47-aef6280ab3c4@gmail.com>
Date:   Mon, 8 May 2023 14:54:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230508094421.513073170@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 02:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

