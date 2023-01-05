Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182A65E883
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjAEKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjAEKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:00:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DF574C6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:59:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so901365wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXmxGNXL5oLeBsrWe9bCLaiwtBToTgmJ7BtAF3C01bE=;
        b=iXlFlg0PEiv5maWvyNlBXW5EilxZlvmpOGWf0eLXmcyQ0s74Td3VxRnpYeP6j5Tqv4
         P8PNAznv37x75M4jyGTRBylx1VQ+9ueNFb1tjfb59MUFdx1EN9zoIoG1cpnZQSpSTNoQ
         oDRKyTYP7js35vNGnwRRrVV3J+0YGiuZ74AQZ8RDCyTBrg6sUWhJuk0RN0K+UtdK+R2z
         3pkChVfRBkzf38tdCQsjfzV/STYWjPDanJoAb9sDHGN6wvr7COLsBbIxdr5LUUC+FL/K
         fY/YaZYyuLH20dM33J0URtn6InprC5CkPZhyBAvmUcSfCXAeX6wePfdoX1eNconmW75Q
         brOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXmxGNXL5oLeBsrWe9bCLaiwtBToTgmJ7BtAF3C01bE=;
        b=IhieKXoOpC6rPxIh0T3t8pxArCqCakvpDv9oiGPu7J05ygfFtw/Jh0f8uXEpcybueL
         m4eigdlWsyf7UmQOXG5DKIofbOUwugg5VBcWxrpVdgEpVcMFsJaoAP6Ora3qdjnSCoAo
         S33E0IEvbZ1wgj4PeWQsMxaTkzFbj0QOV6DDtho4BqS+oMiWvGHlzkbIBcooMs8ekjGT
         mBooKRJ9KiW0RwjE5eBwdlONsR3TZ3ezE51i81e/+Wu4tfnwp+cWkqN4+QnsCpqYxRqD
         oxC2mC8lT7Rm6NRwFbscC3TiEIpjVp+hQwDSJ+v987aepqPueeRZiDuIXXb06GZrFoNg
         h3bQ==
X-Gm-Message-State: AFqh2ko9rUxyBGpO6lW1TeLIl4D76dHMn9HLgD/Et3W70OXCmEyqJAZZ
        e+Hp+HC1UlG7UYyq4M2o728DPw==
X-Google-Smtp-Source: AMrXdXszpAoLe1xi9TgGPqu4x/9Dcwvtc8bbHJKD/dYB/eYrXEHIUeTqbAJUzXKHrW9XfAA0oZTcPw==
X-Received: by 2002:a05:600c:4a90:b0:3d2:3ae8:886a with SMTP id b16-20020a05600c4a9000b003d23ae8886amr39553327wmp.17.1672912745149;
        Thu, 05 Jan 2023 01:59:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm1871775wmb.14.2023.01.05.01.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:59:04 -0800 (PST)
Message-ID: <0275b025-2029-0a78-1ef8-166bb58d742e@linaro.org>
Date:   Thu, 5 Jan 2023 10:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/2] thermal: Add generic device cooling support
Content-Language: en-US
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, aisheng.dong@nxp.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230105082234.16962-1-alice.guo@oss.nxp.com>
 <20230105082234.16962-2-alice.guo@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230105082234.16962-2-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 09:22, Alice Guo (OSS) wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> To compatible with previous implementation, add generic device
> cooling support, each thermal zone will register a cooling
> device, and when temperature exceed passive trip, the device
> cooling driver will send out a system wide notification, each
> device supporting cooling will need to register device cooling
> and takes action when passive trip is exceeded;

Can you explain the use case you want to solve with this solution and 
the limitations of the existing ones ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

