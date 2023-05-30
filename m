Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9B716B67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjE3RpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3RpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:45:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53101B2;
        Tue, 30 May 2023 10:45:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256797b5664so1676754a91.2;
        Tue, 30 May 2023 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468700; x=1688060700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j94aGplfWMWnGkDbJHhE7nVaNFJFqF4WYHNvsj+rgEo=;
        b=YJArRZNFf+RSZO4eguHpQ17S708oTlO2GHgqc2Er11eeFBXH1nanH2JOU/HL6gfj+M
         aKro0+ZdCJWt21QXdpCmtX3znlG5UiyOCRoc0stGDaQRMtDl1bHDXW3ey6go9xtOuw5d
         ebtbFFZwqA07eDGkw58RqVDjbnLXMBz6I/Xnsrl94mLMBimArWA1QO4nYcRlQOaYmkuH
         CCxdiBZnwdNX6uoy5Z1dz2WBDe9tXaLBwIEQSYPw8eqpMb1znQ+ojg//hjWUmkx/SsZS
         13UiMDhr2AFprvKSRPo8kQV/dX6tkU7fDGRNZCkpPVUU43YgqTt5lpKixu+wotoPohyZ
         cEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468700; x=1688060700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j94aGplfWMWnGkDbJHhE7nVaNFJFqF4WYHNvsj+rgEo=;
        b=DbiwIv8uBMW2pBP7+Kc5FsA7rZB+sNnJcNTFwxuGI7E+CHgT1PTwR6y8md8mfNLI4n
         ZAp9BXuNeqTkCcioSxSOzPcC/ZoXZ8Gtu6MJVp6Gnl7wcZBs3aZFdYCXptk9ytkBpfdg
         PhI3ODGbjmAmH9Pl/JSlozsZSkf75aJodQZLlF0ql6hO1LYooCGYvFt7juAqz9ysJiAO
         2evsWyZZisM9eSyHR5LxTjunb4BWCrwoOMlniWgALtNA9oKMd35P+KLPLsQCCk8spCMY
         zl3lQS86hmP4rJ0BJnBTFyrkgrgTIGWnDJyI2eIbov3CM9H0/D0pCDmX3kCFZ28CjIkJ
         LCEw==
X-Gm-Message-State: AC+VfDw/suDQ/6sj1UZnoHwhvQoxGBhssqqNe8GLrp+oxzLYwoJZZhAL
        Fou9CMGwYgyzoJ06BUBNsfk=
X-Google-Smtp-Source: ACHHUZ5ybmzpjjvmXl3VzRqDUllxyO//rJaSr3NFWUJGddhGQMcPonWwzMNL0AlMHyvXEbj9ggYvEA==
X-Received: by 2002:a17:90a:c217:b0:256:4b34:8bdf with SMTP id e23-20020a17090ac21700b002564b348bdfmr3157550pjt.39.1685468699682;
        Tue, 30 May 2023 10:44:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g4-20020a17090a128400b0024e026444b6sm6535430pja.2.2023.05.30.10.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:44:59 -0700 (PDT)
Message-ID: <7bfcd9d3-38bf-26f7-ef1f-51c9a0104e17@gmail.com>
Date:   Tue, 30 May 2023 10:44:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 000/161] 5.4.244-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190837.051205996@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 12:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.244 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.244-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

