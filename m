Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33967640687
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiLBMPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiLBMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:15:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D43D292C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:15:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id h4-20020a1c2104000000b003d0760654d3so4921104wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLJHQPjamDL27wduKFuQu6Tat6NkRXHcc8EKAf/7bjo=;
        b=zqzk4cWnOT349WQSBXHpmaWCyctN5lEXHKz+80VGXDeWCINu57E1Ml3nRl7P/rDcPu
         qQ2bqeoyiE7P83Ml2GhHuwCaydOy/SgAoLdoxD8ayKvHG77tZ0j7X+WIjOr00Z6xAhu5
         Le4z8tWVYAk98TK8udYkfCjxWxIJZCGo9h56VG5GvLRpmetrS8hEbZIu16Nx5WcbqRLI
         51JHeb1PVYX/KOyB/kRHnebCpPL4GB97o7wVYhO7seX6XPgYdmzkRRGyO307JCeD4hny
         WBcyJUekuiCG2jOXnad5pEdrBs+BZT3lrvv+9SiwsdjKwJc5WEKj4QiekJZATrDE/lnc
         akeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLJHQPjamDL27wduKFuQu6Tat6NkRXHcc8EKAf/7bjo=;
        b=cGPnT4UmJ3QrhmJaFVwIqsOilYNWft1G14pfGRWzU5dBJ0LF8M8yzIkmJn2m3C3QI3
         +YhNUeY0ucaFHbVPAwVtv8SUba8DcHNDeuFU0+zu8sFPErziRNdz42oEi6oVs/+xntEG
         4Khau9Kc0umf4adICJ7oBQ0/tDLLFwbgp6AuamxVC1oe0TDD/PyvFp6G1uK5GtLhTCZv
         Vo8unUt/eQp8wISekpwHg++l2O2vmVyZjwWC+Wga1Gh1Ao9+LFV74qaHk64WeXhWj0QL
         9F6xyBV035ZYZ97Vgs7VXS6PDzRakKrhkyXFAyNvMBMOPvZAwwpRuExI7HBwuRhqHhRN
         WSXA==
X-Gm-Message-State: ANoB5pnEJOkNCtNUSePX2pS3Os9aNo5dtRLlrsehpPgINpqpMSq3PClc
        q2pX/Ct6vlEEHSlApl4Msf7niw==
X-Google-Smtp-Source: AA0mqf4CysiOFh04+gXlHx3kv/Js467iK9kPm1nvc2vhmMlmpvRnbl48wu/hPk1TPJs4tVw7rtya2w==
X-Received: by 2002:a05:600c:5127:b0:3cf:a4c4:777e with SMTP id o39-20020a05600c512700b003cfa4c4777emr45731137wms.72.1669983307502;
        Fri, 02 Dec 2022 04:15:07 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h34-20020a05600c49a200b003d0701ade2asm8858766wmp.7.2022.12.02.04.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:15:07 -0800 (PST)
Message-ID: <0a7abc7c-9a02-c4c5-4864-ad7662b3f06f@linaro.org>
Date:   Fri, 2 Dec 2022 13:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Revert "clocksource/drivers/riscv: Events are stopped
 during CPU suspend"
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     tglx@linutronix.de, Conor Dooley <conor.dooley@microchip.com>,
        samuel@sholland.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        dmitriy@oss-tech.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
References: <20221023185444.678573-1-conor@kernel.org>
 <9d0211d8-eefe-9464-940f-ac113ddbb0a7@linaro.org> <Y4nqHl8mjbsRj7On@spud>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y4nqHl8mjbsRj7On@spud>
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

On 02/12/2022 13:05, Conor Dooley wrote:
> On Fri, Dec 02, 2022 at 01:02:20PM +0100, Daniel Lezcano wrote:
>> On 23/10/2022 20:54, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
>>> If an AXI read to the PCIe controller on PolarFire SoC times out, the
>>> system will stall,
>>
>> Applied, thanks
> 
> Hey Daniel,
> 
> Looks like Thomas already took the v2 of this patch:
> https://lore.kernel.org/all/166989319052.4906.3934360150862233210.tip-bot2@tip-bot2/

Ok, thanks for pointing this out. I'll drop it

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

