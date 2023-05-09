Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA86FCCEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjEIRmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEIRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:42:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5774222;
        Tue,  9 May 2023 10:42:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso44384726b3a.0;
        Tue, 09 May 2023 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654155; x=1686246155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVrRM6t63wczk3TNwqKqHozYg9+Yq707IC/VhQqlcDM=;
        b=FVIqwJD5INIUupnJgMP/w49DfVU3UW4lv8nZZeOoLApCRAgKZkuXq17x8JD72FIsFx
         MKMNVjOUPwmu/chZyNNBe3q8BkfwGfMQ9QwS3NOcoae/F8mQ8aIbFvLxE6AOEk70+VJX
         NEHeEXDG1OBsjks9YJcL39Ql8KSEdNQVNJ8BaB7VIWFkgDwKkPYj1t9+uk4KLUqfbxCI
         IEZUEld9cJ+oiooWHUlD8uYx46fPcIDfpfUKhP58pJ4gc2H/WUCt79Fa9URpOY4Gr8Q9
         e1b3fX+UrdoAhlqOgG6yy8sN3JYnYhpWqsWszJYkUCP58z9gxrnLRL5RpQ4dNQh6wVT6
         p/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654155; x=1686246155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVrRM6t63wczk3TNwqKqHozYg9+Yq707IC/VhQqlcDM=;
        b=Hvt6RUNDNIKH6xG8IOn5aS1hLG9R7BQuy8DaAftLH+BHsmFUSk/ydqlUJjsXKKnJJS
         6H1kPVUv2GP/ZEC10K16B1IW9FUEudEom7r/OS3jm6I6+sNvD3gWXOQe+mZU6TdNUqmd
         PSo15lDgwlv8m4f4uE7B6wt1KTT4cGdOp/TADIJ4SX9pPTdI6TJIYRa6Aovb2/Jo3NlT
         dwFCL5wGaUHMHnRsFW/VhcPSHoJNDOR0kaZSPNWtOUsplsAGF99Qeyy7nto1JCd7L7S2
         iwPQqZS0wu63pgp1rQ4y069eEcX8spQZ5+0F4feH2oNHcYR/fC0InTO8RFzIEhkMR0rQ
         b+Fg==
X-Gm-Message-State: AC+VfDxvfTSMsIsfINoVtOiSI3+VMGGacU252Js1PkxSdr2bmNlVccs7
        5XCm+jXenbWny4jInyp9LUgnRYzg2Mg=
X-Google-Smtp-Source: ACHHUZ7hW1T9SKfm2LfZZwC5xAIrgkt49N5GQM1NQm6WPyKlfNYq/Pce+GS+QQVN3NxdhGWMVlLrGA==
X-Received: by 2002:a17:902:db08:b0:1a6:7b71:e64b with SMTP id m8-20020a170902db0800b001a67b71e64bmr26249165plx.15.1683654154619;
        Tue, 09 May 2023 10:42:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g7-20020a170902868700b001aad4be4503sm1903387plo.2.2023.05.09.10.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:42:34 -0700 (PDT)
Message-ID: <3f5db313-496a-71f5-7970-be7a112b9959@gmail.com>
Date:   Tue, 9 May 2023 10:42:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230509030701.507375024@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 20:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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

