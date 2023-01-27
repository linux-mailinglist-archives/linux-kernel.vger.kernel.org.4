Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24067E02D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjA0JbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjA0Ja4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:30:56 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094F783C2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:30:33 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vw16so11962828ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddIglQ3Jwzr9SyGrXRAQv1XGZ7Y5W5u0f7HJlnzWnyc=;
        b=pEc7557r0nHqzprP8MQvFt2+14o/RMoy2W3gNxUomjvvTXcTh5REmautBTnKrVn7Tz
         VskXvpH808WMyThsMzPNDFV26+dTpFRHpCq8xOmntyoQfmu5vILOnbeQOzXxZ38J/oiq
         NSr8vvx4IdR/jDHK62fyh2PK4CqZxQ9Ki8Q37IyR89hu1xLUJ6jqahP1I2hv0dyTF9iT
         CH0OzRiCdtkFlUg2+lXutCxntiRWqvEWkVbwQZtTo2Csfk0s6jliy7U6VkfkYvs+6kax
         1yP4y/EPhq/LIMgi2brZ/2Ut6IkaoSw/BIRbFTgH5cMpOnpHhVi9fxwLys+jWMTQIVGR
         ZSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddIglQ3Jwzr9SyGrXRAQv1XGZ7Y5W5u0f7HJlnzWnyc=;
        b=eKMieiqnUqxQ2WF+PfaL2NpzbnZqYu7sPsMLPbF9WWg57yhfs1vzrrpKWcFATcvAcu
         Zo5MsDsMIUMZlop5eC6H4SbM5PfoVSUHxvU3eiGQGnBXtEuJf3FEin8hMbtKOawA3n2j
         QkhGxcQ7qq7a3Fc/F4T/wVho7JPGfkcCL7IaHxw9V6LFp74dbdtop5DCd8oJK1hQLUCb
         5o+ZbQj3aFFWLEn/XMK6thujN+d8bn3LUHep61GIsQdCbazw7tjyfmAgOSxlkDt7d3cR
         cBlqo2YKWfPBlG6vMjApKyk6274wDEYk6dID8eT5CPuUqIpLwKwJM0JexDe2oACR6t9X
         g9Bg==
X-Gm-Message-State: AO0yUKU3ZcDoRmgLPRuQHoH8MnI4miOpoM4ffH5zsRGwFlvS6SlDhQD7
        AGR0TJiC4ck+lScXIQcfZ8A31w==
X-Google-Smtp-Source: AK7set8S9+sq1cUZjx70l1fPJ0EL4uakwMyZlWYQu4wUn6leC24whLjK/Vmp2ZWkrgqUaaqCKPaZyg==
X-Received: by 2002:a17:906:5d0c:b0:879:9c05:f5e8 with SMTP id g12-20020a1709065d0c00b008799c05f5e8mr3327477ejt.62.1674811832121;
        Fri, 27 Jan 2023 01:30:32 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h13-20020a1709063b4d00b008787becf3a8sm1510062ejf.79.2023.01.27.01.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:30:31 -0800 (PST)
Message-ID: <5f0990c3-ac7c-419c-2ca6-81a93d7f6f25@linaro.org>
Date:   Fri, 27 Jan 2023 09:30:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] nvmem: qcom-spmi-sdam: fix module autoloading
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230126133034.27491-1-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230126133034.27491-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2023 13:30, Johan Hovold wrote:
> The Qualcomm SDAM nvme driver did not have a module device table, which
> prevents userspace from autoloading the driver when built as a module.
> 
> The driver was also being registered at subsys init time when built in
> despite the fact that it can also be built as a module, which makes
> little sense. There are currently no in-tree users of this driver and
> there's no reason why we can't just let driver core sort out the probe
> order.
> 
> Note that this driver will be used to implement support for the PMIC RTC
> on Qualcomm platforms where the time registers are read-only (sic).
> 
> Johan
> 


Applied thanks,

--srin

> 
> Johan Hovold (2):
>    nvmem: qcom-spmi-sdam: fix module autoloading
>    nvmem: qcom-spmi-sdam: register at device init time
> 
>   drivers/nvmem/qcom-spmi-sdam.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
