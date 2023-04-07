Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6996DB518
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDGURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDGURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:17:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300BC66C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:17:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id br6so55683883lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898640;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1Dozau9Cfq9VYaMqEkVJAHlGg5EPFMV8ybCE21m3s4=;
        b=UolUM2z0Wpfky7Un5OucPfkBEOdsVm1Ssn36f5GawY6zPNERQejvKqaz6qgAipqlAa
         ot0uvIKN+3DbX643XKOk3diLo9BDHlUV8ssCmM8hkWRC3maxIH72tY5T/fdR4ti8We8/
         +adignQsho73jcfInhXv3Y1XLJS3xyN8pnY2ZEiHuoqqS4cyeHOyj93d7pqVpjdvxyop
         mI3T0Jt3WCeHTUrO08x7rO2/DFJ6MAPvYNfq5ICcmeHyh8k9EvWLK2tASVjXreNnITHj
         ZwsQZVxyPwmm34EjJbiiBoJS1aj77pSBSO3ZhkaFkRh+u1AEYQSXMxQ0vG2GBW4LITp2
         hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898640;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Dozau9Cfq9VYaMqEkVJAHlGg5EPFMV8ybCE21m3s4=;
        b=m9+R1+b9xmjgpWMNh4a5vz344Jvnaxy5D3QyRR4pVM/OrBLqCK9iWqLfhEl7pMZ4K/
         K4dXwEGjNvGtwWUV1fdX1k+rLfRlRaCx/3jQ+SM1P6Nn4eAJ2wPesZDOhop64MIfX4xX
         TR2iEXFxD44EtjV1Q4h4z52XEpFuXXcDVJKCsOT931sEZ2SbbbyLFIkROjnloRb5OMYe
         8r5YKhYPK8rUeLQR+htyRz3N3ten6Ihxg+Bz9YwMNssG2pHnWHEmNdebZ0mz1HeJad6S
         NWlA+WKKEskJlAz+W14pSqOZxKnXEMdG6T+jSs6QfRGkkB5FCyenvLBwriQr1J6V3uMk
         OyPQ==
X-Gm-Message-State: AAQBX9fOKQYQU8taX4qjZxH21DDDo75ibNScZFGSxRF/xmDN2YHPDk3r
        RI0no+Y2s/3oA5BqL2ZVLkMfDA==
X-Google-Smtp-Source: AKy350Z2JIekhTaqs1ClXrFa4SIlxWK9pWuzvd4Kdy8PeMZb0+IMYtMfKBSGlsY6ENxMpNpmx3raUg==
X-Received: by 2002:a19:7418:0:b0:4db:3a92:2c85 with SMTP id v24-20020a197418000000b004db3a922c85mr761822lfe.67.1680898640661;
        Fri, 07 Apr 2023 13:17:20 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w1-20020ac24421000000b004eb51cf49d0sm854624lfl.306.2023.04.07.13.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 13:17:20 -0700 (PDT)
Message-ID: <422abc8b-5c01-238b-7793-212597dbffc8@linaro.org>
Date:   Fri, 7 Apr 2023 22:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to
 enable unused clock cleanup
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
 <20230316225803.GA4036689-robh@kernel.org>
 <62533d5a-f39a-0806-b4d9-932e2af6beef@linaro.org>
 <5601e0edc19dc03d0fc516f9ffe4d1aa.sboyd@kernel.org>
 <2a379401-fe87-9e30-5449-513dd23c52f5@linaro.org>
In-Reply-To: <2a379401-fe87-9e30-5449-513dd23c52f5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 16:44, Konrad Dybcio wrote:
> 
> 
> On 17.03.2023 19:20, Stephen Boyd wrote:
>> Quoting Konrad Dybcio (2023-03-16 17:31:34)
>>>
>>> On 16.03.2023 23:58, Rob Herring wrote:
>>>> On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
>>>>>  
>>>>> +  qcom,clk-disable-unused:
>>>>> +    type: boolean
>>>>> +    description:
>>>>> +      Indicates whether unused RPM clocks can be shut down with the common
>>>>> +      unused clock cleanup. Requires a functional interconnect driver.
>>>>
>>>> I don't think this should be QCom specific. Come up with something 
>>>> common (which will probably have some debate). 
>>> Generally the opposite (ignoring unused clocks during the cleanup) is
>>> the thing you need to opt into.
>>>
>>> I can however see how (especially with the focus on not breaking things
>>> for older DTs) somebody else may also decide to only allow them to be
>>> cleaned up conditionally (by marking the clocks that were enabled earlier
>>> as enabled in Linux OR not addding clk.flags |= CLK_IGNORE_UNUSED) as we
>>> do here.
>>>
>>> Stephen, Rob, would `clk-disable-unused` be a fitting generic property
>>> name for that? Should we also think about `clk-ignore-unused` as a
>>> clock-controller-specific alternative to the CCF-wide clk_ignore_unused
>>> cmdline?
>>>
>>
>> There are multiple threads on the list about disabling unused clks.
>> Moving the decision to disable unused clks to a DT property is yet
>> another approach. I'd rather not do that, because it really isn't
>> describing the hardware configuration. If anything, I'd expect the
>> property to be describing which clks are enabled by the firmware and
>> then leave the decision to disable them because they're unused up to the
>> software.
> After some more thinking, I realized that this could be made opt-in
> simply with driver_data..
> 
> WDYT?
..on a re-evaluation, obviously not a great idea.. Old DTBs will not
be happy about that.

Konrad
> 
> Konrad
