Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543DA690AED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBINzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBINy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:54:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4238A6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:54:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h3so2175861eda.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zniVv2S4UvTl9S4r8Pw4LFfVImEUqJM9devi4IDHcY=;
        b=CcPWCKZUBUexm6pe/qDYFmtoSsAtsDr/UgWHK9QB1eE6wLk71s5STBmiPGG7VI+Vsr
         yh07JTQXbpzWHdjt43SHnsfHhUOojFqlwtfDrCcv1jKU7xuiK962SAaQZhZUica65Qpv
         iw2Eue+/1jE6x4ZO3p532xp9yV9SepmOtZpc5Bx9imqobd6cQzMYhnp7aynN6g1tQ/Tk
         nhlO0OJCYvguenOPcWa7GPGd7ZzHSRqzEcF29E2HHUXu/xGwZYZuP5LaZ4iov0SE4k73
         CeN97mW0Art+RaYz3P8vmWIJkSFFe9By2+ztvf6SUhHxTUGWCROA1kuzn2VcyxMj5nGq
         w0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zniVv2S4UvTl9S4r8Pw4LFfVImEUqJM9devi4IDHcY=;
        b=yJa/ATTg+HL2ZxDp3Qfs7U+Z5ZxXN8ibhv10rNkfTsbDLoXbASONImRG8CsKDErWMH
         vKACB/7PLKDXL2I5Alf7O0oBPomCOz6avFfvX5NVgRnkY0xjGBtjKsvecigFPGiJzjME
         dlg3TrRyCcosNZUQLBn8HcK4w92Aez+/yt1MJP8D4z+8jLcWwtPgg4j8b7JnfB8n995I
         +iJnxlB1e0lIBsAgm77Sq1Z7PHKU+cHs2Ev/LMYSmZU1XU6HCTbo7E4fJtKxB2wJ4RpE
         k3lMzztQJ1UazCH9pGfaH5N0Ri94+b9SJZ99COty2Wbhx7WmwtiN+YxAOaAR22CE4CWU
         jzDg==
X-Gm-Message-State: AO0yUKVsIRY8ygQ3d43TmE5tA8HT7OmHamqpSyRLZ0mSkOETOsV7HgGr
        27ZMiH+R1Y2irN8i1xr9jk9Nc2U+HEP9snf5
X-Google-Smtp-Source: AK7set8TNilu2XAjEiupey83kpcRjHP7zJSpXkVnUnyK91cl3pYySa3DB2BPn9OBaSa770JjP19XAQ==
X-Received: by 2002:a50:ccd1:0:b0:486:ecd3:15f8 with SMTP id b17-20020a50ccd1000000b00486ecd315f8mr12188454edj.6.1675950895639;
        Thu, 09 Feb 2023 05:54:55 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7ca49000000b0045ce419ecffsm780531edt.58.2023.02.09.05.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:54:54 -0800 (PST)
Message-ID: <dfcc8baa-c0a3-c554-a8cf-75702a1c4cad@linaro.org>
Date:   Thu, 9 Feb 2023 15:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
 <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
 <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
 <ed737e67-eabc-6f29-b734-f4698767ca8e@linaro.org>
 <fa2e0db7-5b27-5a41-920b-b786dc4e521c@linaro.org>
 <027268b7-4b04-f52e-06a8-9d924dc6efe4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <027268b7-4b04-f52e-06a8-9d924dc6efe4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:22, Bryan O'Donoghue wrote:
> On 09/02/2023 12:11, Bryan O'Donoghue wrote:
>>> If the bootloader splash is enabled then this memory is used until the
>>> DPU driver instructs MDP5 pipes to suck data from a newly assigned 
>>> address,
>>> so there's a short window where it is.
>>
>> It seems a shame to reserve 30 something megabytes of memory for 
>> continuous splash unless we are actually using it is my point.
>>
>> If I'm running headless its just wasted memory.
> 
> Couldn't we
> 
> 1. Find reserved continuous splash memory
> 2. Fee it in the MDP when we make the transition

Qualcomm has investigated freeing the MDP/DPU cont_splash memory, but I 
fear that the end result was that it is not _that_ easy to free it. It 
is marked as reserved/no-map, so the kernel doesn't think about it as a 
memory region. Adding it back required hacking around that.

-- 
With best wishes
Dmitry

