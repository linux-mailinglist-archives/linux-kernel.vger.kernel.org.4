Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7675E6E70
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIVVeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVVd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:33:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8110E5DC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:33:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s14so15546265wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Q5fUsS2POKT7bY911VJ/Wt7tGJ/YQWRogJHUZto//1w=;
        b=ppkT1rg43HrQIGR2J8hEUzy243BynZG/T6ZH/A9oNF2F3w+ZecfPOeR/b8OKBS7JNY
         nYP6RPiag2fGPqpWZsRc6yHlcnLkVnEv1GbDw4ITO1pIRSQjC/YymHdLvtwOn33R0W6O
         G/R6K0mDMY5zrYxv2WgK4vmgiyhhjsczeWJaCumH3LKfrQgqOIFDNY/9GWZtG3I203I8
         jPy/eTqmxqT5JiG/wYmGnjh5YpxtSbPEyl7dNcPUEzOBZUGCOMZaAsKGMmU279usZd9R
         X2haXG4OVXVikQBrKtQOw1E7Wb+qmO2xPr9Sl/F1+xaBTCvR00cdAVVuBrXB1/Ge9SME
         /nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Q5fUsS2POKT7bY911VJ/Wt7tGJ/YQWRogJHUZto//1w=;
        b=qTIsi+OoNSmFy0+Tn77EmQsebakL7QTGsDl/R43I2hhluLC5iDmcPsFD5P7/+8iyUC
         krnuN2YhHJTDhhvCONxcjbxPogqYCFlL4vly569ULwmRgJNGUmOpvhxTXfkgv/vL3z64
         NR5uqZCl4hZXEt0k+ipsU0sxjwX9K4J6J26zAusiBJ1PksjpIHVGkRI/cs8RGMzOvJrf
         OxdraREjzMF5iwBrIbNgN29jrkCG4Iqk9Ya43sLga9PRQ7WVk5E1Kbe+AgzYQqcQCwxV
         1Pcd2sDqxj/5ajLnvq2aHAJD9WHHb32CsECmwB4cU+nxGZwhxBIq0c+ajlyDnbyXpld5
         DCpQ==
X-Gm-Message-State: ACrzQf2C58o1y0FQWCct777YGqnDwvzinwxnKQi9MvR83dcCPdfpJufy
        TYd4sRBkEf3ztoqHMDEKWDRVNg==
X-Google-Smtp-Source: AMsMyM5bjEWUOxUwWDcPsPc1rZbKgkAK8krSoC+qREwuhDJE/gYfi4ZAJbSJG7oHlZerhd3k3YFjhw==
X-Received: by 2002:a5d:528a:0:b0:225:4a8e:221e with SMTP id c10-20020a5d528a000000b002254a8e221emr3139358wrv.145.1663882434431;
        Thu, 22 Sep 2022 14:33:54 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r21-20020a05600c425500b003b47e8a5d22sm583576wmm.23.2022.09.22.14.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 14:33:53 -0700 (PDT)
Message-ID: <d1d07787-129d-e363-12d4-17f7858ab255@linaro.org>
Date:   Thu, 22 Sep 2022 22:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Exposing nvmem cells to userspace?
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20220922122347.1866f758@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220922122347.1866f758@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2022 11:23, Miquel Raynal wrote:
> Hello Srinivas,
> 
> I am currently looking at the Open Compute Project ONIE Tlv tables in
> modern networking hardware. Thanks to the specification being available
> for many years and rather easy to implement, those tables are already
> present in many switches. Manufacturers just have to provide a small
> storage medium exposing factory-related information (manufacturer, date,
> serial#, mac addresses, etc) in Type-Length-Value fields, as well
> as their own extensions if they want. These tables are common, but
> there is currently no shared decoding logic, each provider maintaining
> its own internally.
> 
> I am currently looking for upstreaming an nvmem layout driver for
> exposing the standard nvmem cells. This way, Ethernet drivers might eg.
> take the base MAC address from there. But I feel like there is
> something missing, because the vendor name, the device version, the
> serial number or any other information available in these tables might
> also very well be used by the userspace rather than the kernel drivers
> only.

Could you explain the userspace side use-case?

> 
> Thus, I was wondering if there was some ongoing work to make these
> cells available to userspace (in /sys maybe?) or if this had already
> been discussed somewhere. Otherwise, would you be open to such a

we had this discussed this in many instances and this is some thing we 
would desire to have but we never got it moving forward.

> contribution? I guess it would also be a useful debug tool anyway (and
> might very well be moved somewhere else than in /sys).

getting sysfs working correctly in sync with userspace might be tricky 
in this particular case as we will be creating cells after the provider 
driver is created.

debugfs on the other hand is more doable.

--srini
> 
> Thanks for your time,
> Miquèl
