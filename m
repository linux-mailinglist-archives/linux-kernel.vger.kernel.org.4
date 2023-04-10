Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7B6DC6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDJMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:44:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332434EC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:44:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so8385294wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681130680; x=1683722680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeQWpKy8+NJXDpJHdtsTgj9dRfzdRMrlkZK72BPPZGE=;
        b=poutZvt8NTIlxL4QYU+98F+kPPH3SiSQFVjddaHqftnTeaP7lx/j/MtR58NQdf1tQp
         etB7RxBCwiKFOIkyurJjhEyuljvWf1ROFCTY2nIwcXI3aJ0VlYh2a5wkE7hFjL8I+Z3Q
         7tlEKrChfdPjU3gy72qSjEqR2swie2NVAv4j222XIiyP20cEeQUtdnHL797QsCmHhPnd
         oCzOkmqy6vbZEb5H4HsgMZSpyTXKejPu6Z3rDaY748dSSfGyl2BLmA+l3zyQ0Q/zB+y7
         ETjx8xuRyCNYPCaGOuvU3WXV7YCwb4qUevlVs598RwNuBAWvhFfG8d8OsndmUAI4hhXJ
         iG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681130680; x=1683722680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeQWpKy8+NJXDpJHdtsTgj9dRfzdRMrlkZK72BPPZGE=;
        b=sKVN/cszpA7u11Rif74g1vaiQZoU/YYo5BAnG1+HVXGEIr9gjF0qR2P1u4yB26ejAI
         4B22E0LpJMlcVAQofv7TPpTzUY3Fc7GvIGQIXJUk11RaeqtTNfJ+A2HTGfjhTw0aw6SY
         WQUklgJJ3/vUa7KryqqSRPYMhKwjLUbiqALiF2F/3EpaTCIBSdQr8LCEXUjq4IExiEBw
         Qsne6VqLc0M3qekwSmHOAfI/ZTVyBfuO87xAoJ7jIyWk3Z6KdWjq5W3JiFT9Fe6FQfDd
         Fl5c4awaVnuSCkcsyv/hclKvoOjkePdThhBnRPfr6mUHp/XTqXimiKOVaJNakhCgvTau
         nwZw==
X-Gm-Message-State: AAQBX9egCCMkxs0JuwIHtBmafZw3VZcykIkl/ZQqioNcCuzSmxT/kmAJ
        aQZD69Yx2MuEN0JzRLIdPGr0WA==
X-Google-Smtp-Source: AKy350bP2iMtSjzqZsBNOo+UEpuonp4bSfFS0XjcHtZlhUd3xlVhrfsH/nOuGeK6A4ysjF2R9W1gPg==
X-Received: by 2002:adf:f887:0:b0:2cf:e74f:2957 with SMTP id u7-20020adff887000000b002cfe74f2957mr7219231wrp.33.1681130680673;
        Mon, 10 Apr 2023 05:44:40 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11054966wrs.16.2023.04.10.05.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 05:44:40 -0700 (PDT)
Message-ID: <e10f7b87-0bc7-5e13-1757-bbf74c9cac86@linaro.org>
Date:   Mon, 10 Apr 2023 13:44:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <CAMi1Hd2xfH-=htvHFQRktdgtDwiXKKvFo+9hook4HCJCPY6ydA@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAMi1Hd2xfH-=htvHFQRktdgtDwiXKKvFo+9hook4HCJCPY6ydA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 09:54, Amit Pundir wrote:
> On Thu, 9 Feb 2023 at 16:33, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 09/02/2023 09:05, Amit Pundir wrote:
>>> Hi, So what is the verdict on this patch?
>>>
>>> I submitted this fix to make sure UFS don't map and crash on it, which
>>> I have seen happening occassionaly on db845c and Caleb reported
>>> similar issues on his sdm845 device iirc. I should have probably put
>>> that in my commit message as well.
>>>
>>> Regards,
>>> Amit Pundir
>>
>> So the memory _is_ being used by ... continuous splash on an Android
>> image, i.e. your Android ? limited to Android - image continues on with
>> the splash but other blocks erroneously reuse the memory then, UFS as an
>> example ?
> 
> Hi Bryan,
> 
> Yes UFS (reported only on v5.10) tries to map this reserved memory and
> system crash and reboot. Plan is to backport this patch to v5.10.y.
> 
> Regards,
> Amit Pundir
> 
>>
>> ---
>> bod

Personally I'm fine with this patch on the proviso we somehow associate 
it the memory MDP - even if its just a comment in the dts with the MDP.

i.e. if we run headless we want to be able to use that RAM for something.

A dts comment would do

---
bod
