Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B78698F24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBPI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:57:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869093B3E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:57:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id he5so1008410wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQRWAqkGFsJ+LjehBXgApan0WOe/BP1zPoLzYk+yFfw=;
        b=LPbn+cUHBfIQ3A6x4nCwl/Q7ROlaWzew+glz759Zno4q4wCuetuhzf8NO0F+jDOmjm
         c/2cHxB6wHc/GEwP7ZuT/O+K42TAFl+7la3vbmqRgBgRIC5lnUhIAV2egpfroWdo6NJD
         IPNw4pCmavYVo6DgZvDWPacyH3Uew6BWJtM563NkY6uYDXcYzS5e68BjFLWpWGPrThVQ
         GqPQ5mH0PxDePG10LURLXASHMHHN8gm2tswt02/iEQB3tiTZ/yjlaFJMPT8VxXkF5Fb7
         w4AZbPnsT182e7u+cWwxbyXn0tzJNEPPpJ3pNV5k95bjQyQyO6SQtPY03sn14hrW4qRr
         HDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQRWAqkGFsJ+LjehBXgApan0WOe/BP1zPoLzYk+yFfw=;
        b=YgYe1sye65Y04mWrDYTKB3CwvJXYqtZgvmDjwdk7E4K0MZ0fE4Z5giXCmYrjLDT7gr
         Ue+34aF9c0FQAJ0xHsq+2LKi9IkPxksIaI2zaxecTpvgEzTH9QFiplnOnZcTQgFUBCXc
         BpvFKl6T4I+KAY0ps242ZuUDr1WYP7Jv7Py21JLsJfI43G0O5m3j9Ef63IYbJQdCtrXB
         nPDsduVNERpYfdGMBTcXIlHIxnSF5rdx2WBKA/jbdRZdxhVefe/01gtALH+IGQKxTC3U
         5yTPy5L1y3iHYKbEq8MdytJcf4pWthUW2v3CJtZvfnTVrW9v3AIw2mEg8RBvcwJ8eMgN
         BUQw==
X-Gm-Message-State: AO0yUKXqhh331pWsD7qMtrlW7aupKOEMf7Ufm0An05BPlAuAJhYFV1Wo
        20cOl384XrvB9tuvzQ0UaAi8Gg==
X-Google-Smtp-Source: AK7set+ElThht+MPa1EVx9z7Aq77H/HCF1ng6TquZ+MT/Qlp8AQ0crLPrNdtONN/k1wDW2SiebROPw==
X-Received: by 2002:a05:600c:1e12:b0:3e2:9a2:a6b with SMTP id ay18-20020a05600c1e1200b003e209a20a6bmr1195490wmb.16.1676537864970;
        Thu, 16 Feb 2023 00:57:44 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j1-20020a05600c410100b003dec22de1b1sm998237wmi.10.2023.02.16.00.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:57:44 -0800 (PST)
Message-ID: <59c24c3d-eb1e-cdee-3d2e-aa1dda5a96fe@linaro.org>
Date:   Thu, 16 Feb 2023 09:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: acerhdf thermal question
To:     Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the polling interval is specified and modified via a kernel module 
parameter [1]

The value is used to change the polling interval of the thermal zone, 
implying that is accessing the thermal zone device structure internals 
directly [2]

In real use case, is the interval changed at runtime? Or just when the 
module is loaded? If the latter, the interval can be passed to the 
thermal zone at init time without doing a polling change rate after the 
thermal zone started. In this case, we can remove the 
polling_delay_jiffies change in the code and fix the structure leakage 
in this driver.

Otherwise, I can add accessors to this field but I would like to prevent 
adding them if they are not really necessary.

Thanks
   -- D.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/platform/x86/acerhdf.c?h=thermal/bleeding-edge#n792

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/platform/x86/acerhdf.c?h=thermal/bleeding-edge#n359

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
