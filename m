Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBA64064D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiLBMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiLBMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:02:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA921AE4DC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:02:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6294986wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpJJe85twj+DqYyXL/s0dzOOxqTpU+8HJZNbE6nNAm4=;
        b=TbYqREFfKDudPtNNaQlBTIjpk3g1IQekqJ6OTobHF73WAJj2lgZYDazNHNpW5/lJTc
         K7HsdUExWrBtTiQZWZMbRA8gNeMmIhRBniPH26QtWveLG2Ry5RMKjsIaEeFytRq9MzTJ
         VVwkhFLy6xdgYxgUrDesxVU+bci/W/N6YZ8T3iJ1w6Q2BIZA3Vb03Hq7xISXOVGQJv+j
         L6NSqFgrSKhAScdvJsFapiCq6D3HfnHC3hxkNTJiXVmw+fb1pd7iisaXYPsg/OGIHqWo
         vM73UQiFfmjmzgJ8go3uUe2lDz/uibbBisez+HrGybwfBNQwffXdJ4CKGUGoD6fqFSqQ
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpJJe85twj+DqYyXL/s0dzOOxqTpU+8HJZNbE6nNAm4=;
        b=tMsDJ1D8Ycw8jjfGQrlHmoxvIG1bukyK/3P0QkUANLwat77Ebr6nqPdnCrpVnzuwSm
         /I2xBEMiafpThy8WF4vJYdgPLycueSica30hxzLa4t6Ys8mDA7Wfwgm9QmQtImkRLj4W
         EWJsUPznBASvyhgK4pMrQHVqPRsyZpGjXL8vhUxPPfDksboKNz+wJ1pLPfdcWs9AvDcc
         DFMTLr5j9GsjSgHZuOhqwBno12fdueerflf+aUXAsHk2ctPZFVGPWDJk/Ap6cuYI1EbJ
         5Y27WG+GxIiYCj+6GQYQfVYtOdhd347xAK7nt/xJNVFcB8eKfQUTeZPsNY3GfHnkPqxC
         eY1Q==
X-Gm-Message-State: ANoB5pkRUGKcgQjro1Hc82Ft/k8QLN7UrV8d5JnXL6qjDGQpAmMekY1C
        zirUjTw7quPoDhADcN1e0X/Z5Q==
X-Google-Smtp-Source: AA0mqf7uZ5EqVr2msuRIYwr+5h/ZK1uNqMYUI8ptWdTfMCCaWEAJwNXATh/9uyhoxowtKP2kxb/oIg==
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id l18-20020a05600c4f1200b003cfe7bd303amr40210209wmq.151.1669982543107;
        Fri, 02 Dec 2022 04:02:23 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n3-20020a05600c3b8300b003cfbbd54178sm14256059wms.2.2022.12.02.04.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:02:22 -0800 (PST)
Message-ID: <9d0211d8-eefe-9464-940f-ac113ddbb0a7@linaro.org>
Date:   Fri, 2 Dec 2022 13:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Revert "clocksource/drivers/riscv: Events are stopped
 during CPU suspend"
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, tglx@linutronix.de
Cc:     Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
References: <20221023185444.678573-1-conor@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221023185444.678573-1-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 20:54, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
> If an AXI read to the PCIe controller on PolarFire SoC times out, the
> system will stall, 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

