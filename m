Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8316CA633
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjC0Nnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjC0Nnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:43:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5F3C0D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:43:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so36506901edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679924626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVpM/+7Dqiy+vcCqXdsvsTbRAQPu2fpRGgl27SREyCQ=;
        b=MBsoGskqFs2CLRMALPpkCC6lBtzsOuDn6tGXk+Dbc9y0XsAa5hWt2ZiJ3wZieBxbpm
         8LUaPs9BrJ07w2PIdTO5rddkNplCsBpaZwFmyS3fNrZNYww4OS0ZsrX4xOzDvLHJ14NJ
         WOFGnpCNPUo7f74PmCzhdoXxggcfnywrv8T/Bn/QLLIRYsxzPy+LtgfgmB0QAMkF97eH
         gtqRmtp8+Nq06bshGt7aVvMMf4rE4XTjrSjiB2iGgEr994ehWX9mthcU3AfkYQE5LUoz
         Z986Abo8bZjRjFuJZXY6kZDCuFnyDHPN6YTmBLWdIAqiOmmrQ6oznF3eav94wqaBZYd7
         Ps+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679924626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVpM/+7Dqiy+vcCqXdsvsTbRAQPu2fpRGgl27SREyCQ=;
        b=myuGTkbDsbsaH/gFc51kHvsFfTwu2h4bgwo0+mbtmk2NaTcUA9Mdz71PXFmELGZ2rt
         LQcs1tRl5wgLzsYB9h5KPNtsuTwxCScS2KQzhGiWmctIwC4DC+PFB/gb4wXgexwAmbVT
         fNMPEedojspQQBR6d0mDh90lm/B3fNlw+4O4F/VZxasaOqYJo5L+baZP1xsPnuV/gDmV
         LknzWj8bq5ZcKbHFnw1cJqfO2pOP/yjd8vIR5G0hGWLbWJi0eIP3EOwbm8F0Kx2Fo7uj
         21E/f/3km+TKjjqWH2WD7xxtRpy7Iee76coIDpwlnesYhhw/VRIkb/nK6j/zVLA7jN5H
         EQWA==
X-Gm-Message-State: AAQBX9cIVg+ewbsdkiD1Naw4UcgTEnvQkOuFVR4Rov+sK/EpUtjrLKYB
        UPhgs9TrlabRwAT15SxQ7O2V3A==
X-Google-Smtp-Source: AKy350YSOK2odLZluNVqm912wxYfsfYAPWlO0d613Jp/2bgR9V4wQSPhJOjPDtdGi2tEghrqah38Og==
X-Received: by 2002:a17:906:fc5:b0:928:de2a:8a3f with SMTP id c5-20020a1709060fc500b00928de2a8a3fmr12469435ejk.31.1679924625821;
        Mon, 27 Mar 2023 06:43:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id 8-20020a508e08000000b004fa012332ecsm10483643edw.1.2023.03.27.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:43:45 -0700 (PDT)
Message-ID: <e3cfa966-5b9d-8b81-c2aa-78e01e618e4e@linaro.org>
Date:   Mon, 27 Mar 2023 15:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/13] mailbox/arm64/ qcom: rework compatibles for
 fallback
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <c35fd641-12ff-beba-341c-4d0305bcaa40@linaro.org>
 <290b9b19-a320-38a1-4426-51f5725dd54f@linaro.org>
 <59a6ef88-758f-4ec4-f663-47e4caa552c5@linaro.org>
 <CAA8EJprqXVrXdBD6eBHoDGhvST2hViZUbMgdaeKEBohpv5_V3w@mail.gmail.com>
 <554dd2ca-0514-dc1e-9add-d49a711bc1f2@linaro.org>
 <CAA8EJpoj1OUtQv38CY6YWUjSLEXjRWNtuza7gWM5X=eEnd5XtQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoj1OUtQv38CY6YWUjSLEXjRWNtuza7gWM5X=eEnd5XtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 10:44, Dmitry Baryshkov wrote:
> On Thu, 23 Mar 2023 at 08:33, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/03/2023 23:28, Dmitry Baryshkov wrote:
>>> On Wed, 22 Mar 2023 at 19:37, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 16/03/2023 07:52, Krzysztof Kozlowski wrote:
>>>>> On 14/03/2023 13:16, Dmitry Baryshkov wrote:
>>>>>> On 14/03/2023 10:09, Krzysztof Kozlowski wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Changes since v1
>>>>>>> ================
>>>>>>> 1. Rebase
>>>>>>> 2. Make msm8994 fallback for several variants, not msm8953, because the latter
>>>>>>>     actually might take some clocks.
>>>>>>
>>>>>> Although the approach looks correct, I think that in some cases it tries
>>>>>> to mark devices compatible judging from the current driver, not from the
>>>>>> hardware itself.
>>>>>
>>>>> Which is what compatibility is about...
>>>
>>> Well, I was trying to say that once we update the driver, the devices
>>> will not be compatible. But probably our definitions of being
>>> compatible differ.
>>
>> What do you want to update in the driver? What's going to happen with
>> it? What is missing?
> 
> Some of these platforms do not have CPUfreq support, which will most
> likely require programming of cluster and L2/L3 clocks being part of
> this region.
> 
> For the reference, I think that sc7180/sm8150/other new platforms are
> proper examples of 'compatible' devices, so the patchset itself has a
> correct/good idea beneath. It's just that additional research might be
> required for the older platforms.

I'll split the series so the sc7180/so on bits can go in and we'll
figure out compatibility for the rest later...

Best regards,
Krzysztof

