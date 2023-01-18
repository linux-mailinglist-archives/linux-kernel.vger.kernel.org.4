Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B28672670
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjARSOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjARSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:14:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638D11EAD;
        Wed, 18 Jan 2023 10:14:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v10-20020a17090abb8a00b00229c517a6eeso3228121pjr.5;
        Wed, 18 Jan 2023 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUf1WL4DC62jNFpHWgbiIiXy8vmrGW1Cknk5CUVOTQM=;
        b=E/Xv8DeU001hXlW5CXebfhCmsWS0iKO5rnPPon78D3gGy9lIgeQGxPbg0qdlIHy4hL
         gVgnlXDLCQikYpRNPdXzTKVntGZHDVy9eVeYOQDxzKCqxrrjELKGIdiR2TNxU9sDWqoO
         qfxaKHjYFS2uEdHX4wIwXgEs1sQO+9QLsF9NdySDU89Xa5aMiepolF/Q8t/9h1RBLZX+
         N/CPQs/MRiNPZtYW9Ch/airdT1bbt6V/vkyL9+6jfhF+ZsZKjto4Qoaz/+jIs+5pBPnW
         w1qlUbfIhBP/gt7EyQz0pgWV279fqYSPLTukVinld76uGh9Gt9WjdL8zRZ5+KjtoI0xv
         ljjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUf1WL4DC62jNFpHWgbiIiXy8vmrGW1Cknk5CUVOTQM=;
        b=qk1TrU2QsxCtzx9rRMMJRBpFJxudZo8f2IYh3a06ZuWwhg0fMvZw94GriLcKgumZ0r
         uyx+1mkeU+Y/f/HmqN8BQsFDEDr5VgbWuele7KTE5w9p9/b/Q8ENivxtOjWC+7TxBjYa
         Wdv+P+yED8sVW3Z/A1CS6q26B8bsq5R/FTWliyLD5+X0NVy5Wq1ewqImtfc+tbY6QuTF
         1u4PpjC9bqbdNSDzTEjQH2Fy0bz6O7zKDfqhr46jLmlR48EWSO807grs0Rrs6Ve222hY
         hy4dckeGFk7M8L1lokMCNxv4ww1KJDmBv9fmGgdfOGgK21QvUMBQa36fnIlGrt2O+3YH
         R4jw==
X-Gm-Message-State: AFqh2kpiAkgnkEZ2MtxqvviPyo8dQPCfQlsdbkLLPcBzRI+BEsdTMjhC
        Fvq9p+EI0j/TztegRbq9rE0gD4X+/l4=
X-Google-Smtp-Source: AMrXdXuU8fvKII6vjhHAoRukMLOv3minz7sQV7qP3GFKNNWp8kr88B9p2pmsbT67uqvYQUKneVht6w==
X-Received: by 2002:a17:90a:604e:b0:223:4bfe:f215 with SMTP id h14-20020a17090a604e00b002234bfef215mr8554692pjm.15.1674065652118;
        Wed, 18 Jan 2023 10:14:12 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i13-20020a17090a2a0d00b00219186abd7csm1655732pjd.16.2023.01.18.10.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:14:11 -0800 (PST)
Message-ID: <ed6b3d7a-f117-6cf4-9cd1-0e6802ded227@gmail.com>
Date:   Wed, 18 Jan 2023 10:13:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/bcm2835=3a_Use=c2=a0dev?=
 =?UTF-8?Q?m=5fplatform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202301181636223863583@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202301181636223863583@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 00:36, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

