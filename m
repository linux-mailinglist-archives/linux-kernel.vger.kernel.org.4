Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD9664597
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjAJQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjAJQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:06:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDA574EE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:06:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so12293279wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQ2bOfW8TwdZtJkIzZz6BgKS4zXaqYZ81vAmO4Llwmw=;
        b=Znk5jzP/QxFgGtvfwHgZUEcMSNUToiJgmkO1P+SzqbrHB7F+0cfJfOSm8ovr9u90GX
         VzJuBNKMaXhVoTBSvxTKflC9Frf1B5G18csiliG34mX9N0X7LfLX4dvAdwQqq+VxHHuL
         rNmuxUQmh0DfgVJAEDRQ6rvhMZnAnl9cAQ7nLh+KYg+QMj0sdy8TwEug86ZwPHRxDkvn
         B2z/SL4//9XQPqF3BAgO4/DcBnxav7io5FzkX1iPHOK9X48Wm1ZE3n7+1eq72ZdXukTI
         0gW1+gPcmqVkIIQO13/urjjLESP+dKumE5OQawv6tuNR7izVOCh861z3jZOtYEAI0iak
         +7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ2bOfW8TwdZtJkIzZz6BgKS4zXaqYZ81vAmO4Llwmw=;
        b=PGKQOkIjPkZxX6MRcbM1H1r04U0KyDEcLI8Yo6qH/4LJySbLmmcsEKP2NW69+xw0Q+
         pyXQP946MqHhsJkb6ZPz+H1Ri2XNqgolRLLnaxcoldEnCZ2pm0IUKjlwHMuN0/rauJu0
         uVh6Ldg4CYFpzbpApErkKfOqr+fxKRqVBrPK1dfEFltVJep9+3rSF3N6e6L7zHqHNaWn
         Cz6ER0kvLZy/VyC2oxs/Vb6dIq6/1glWHUTLGy/CRMcCyC3z92OyHdeo6qYy5K2/gcbI
         eGZyP/hQKK6m9KBOAhBIYOSe9WzGkBzak2UfT8o6ViMwJapCY58vUMBLKqSA88AQ1R02
         TfOw==
X-Gm-Message-State: AFqh2kpN3TJPrSfyLIUgDUyTqrFVc7iSMH1lMJu0XOIM4mK5dGDYtFeK
        5M+UDz+YFhZ986KaRFy7E268HUStdF/Bk8RvoIM=
X-Google-Smtp-Source: AMrXdXv+sKbV7lPaPgzUWKe8koG/GX8+Lld6oWxB7p3G4xDB/NWOJevZviXrE8Xp6U/wn5x1i9sj1A==
X-Received: by 2002:a05:600c:4f12:b0:3d9:f9ef:3d23 with SMTP id l18-20020a05600c4f1200b003d9f9ef3d23mr1864350wmq.23.1673366780530;
        Tue, 10 Jan 2023 08:06:20 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o21-20020a1c7515000000b003d995a704fdsm15298234wmc.33.2023.01.10.08.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 08:06:20 -0800 (PST)
Message-ID: <ed326137-aa0b-6f48-01be-8e50f92a4f34@linaro.org>
Date:   Tue, 10 Jan 2023 16:06:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
 <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
 <cf5e9339-2511-1135-71da-a8342b264414@linaro.org>
 <205fb221-f7ad-8f03-2c16-54dcbf5ecaf9@wetzel-home.de>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <205fb221-f7ad-8f03-2c16-54dcbf5ecaf9@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 15:23, Alexander Wetzel wrote:
> 
> No, they should not.
> 
> My take is, that this is a bug in mac80211. I submitted patches to 
> fixing that, they have just been accepted:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> 
> and
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230106223141.98696-1-alexander@wetzel-home.de/
> 
> 
> Can you test if these also help here?

np
