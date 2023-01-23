Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C7678B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAWW4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAWW4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:56:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B81F12F2A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:56:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z5so12253954wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W+0DXre6rZ4jn5MnUCPTafW1zYtqDVUfo0frThxGJI=;
        b=O2HhYC1rTVbYOZ7PoNNUZZ36xXkdnWZOQsgEw5fBUoBSy2E6sWtQEisTJUFGLImL9N
         R3ppqyZBWPejxOldb9C8+aWzkzKUrzfvWn4g74XAtQKbkoKIU6zb4/idCUIQOHa2lnvM
         hFUcoBW+8QcReGMysn+qE07DprC0nDcFp8h51vSLmmwNF4MJq3zWLCYxLKP7Grh+AcSR
         /1vWcPLL6VZ+CbbQHTUOvtm5SbDXib1VFwqaxs/di1yXpge33Mlv8CgAs2jsmV418Mpv
         CtG0EBR7CGcace4itUags5Y9USmnlNVJtx2Qhkuid/iHDnE2+yMu8GrBPS8aPGoD/bZo
         4BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W+0DXre6rZ4jn5MnUCPTafW1zYtqDVUfo0frThxGJI=;
        b=SrCVVR+4geWVM9B94XJO3XQalghLcpheKckLwaC8tK25PwU8se7SrRUuKOEKz8R2V4
         Kp//tD1UGnDFf37Qf8/Y0uy3dLL+kumYKztEYIPXne2hk58FuyxFzjI1GN9Yli5AAscQ
         V91qLOtaVfbkhek7TiWVY8R0O0GcYn+HTRm8OUQ4b03WjYJrfqrOQEz2+5CWDFMJISFx
         kfB4h0n7ziGQ4dpW/UhHtJTnSET4smYGXg215sTxjshdxkVKPnIZWSLBgJAReYZPMpnN
         K1bYHTfVVkEl60yWeatYpLBCp2zcYAL9VfOsi6UEDR2XxXlOaxGfsBjVcxcaAZDH4Zz6
         PwIQ==
X-Gm-Message-State: AFqh2kpwpXZiO7H9P8cb9ydj4W8qqI/hWxFPkaD3oHMimCKZa07xvQDb
        aaJ1Je8upOpag/3BOy2BbQzRxA==
X-Google-Smtp-Source: AMrXdXum3Sw/1CdPtfFpHOadHQfkpx8OzHVcYJdkSYOIDRvuSWiMWs4DPfb3KPfNmNB3h+EZIGSnyw==
X-Received: by 2002:a5d:5e85:0:b0:2bd:d782:c2b8 with SMTP id ck5-20020a5d5e85000000b002bdd782c2b8mr25039739wrb.29.1674514580987;
        Mon, 23 Jan 2023 14:56:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h17-20020a5d4311000000b002bdfcd8c77csm407542wrq.101.2023.01.23.14.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 14:56:20 -0800 (PST)
Message-ID: <1dbd4e5b-f5e0-8f06-24b3-67daaf3e2af9@linaro.org>
Date:   Mon, 23 Jan 2023 23:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] thermal: Fail object registration if thermal class is
 not registered
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5660360.DvuYhMxLoT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5660360.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 21:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If thermal_class is not registered with the driver core, there is no way
> to expose the interfaces used by the thermal control framework, so
> prevent thermal zones and cooling devices from being registered in
> that case by returning an error from object registration functions.
> 
> For this purpose, use a thermal_class pointer that will be NULL if the
> class is not registered.  To avoid wasting memory in that case, allocate
> the thermal class object dynamically and if it fails to register, free
> it and clear the thermal_class pointer to NULL.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

