Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A964B0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiLMIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiLMIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:10:46 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6517881
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:10:44 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z26so3643033lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngP6KFAyVOKzK+3E0gEeMUxmzS5AboYYNyPmbfhWDPo=;
        b=mnEUKTrYOg4f5a19BkYRim4NFQND3oHmrTnyfVaHX9TY1chrPh3TB9fsj0l7ojWVsy
         kCvaZP3s/c5sjJeRxcs89oBmF1EFHjeOrUpMJVBXEuWPvw8i9ybCFftHw7alis4J1qrW
         m98bqWRIovxzxgdO4KlOgPB1JRK+GFU97SO/SsOv3UORS+2GjgAoVuIOrnQy93QcF9uS
         BJ7wM+txhtnMa9o3PlKymssEHE/4SduvaNQac1IcZMkiaBg+jr3dprNlNxXF78/ZwW33
         yvRfUl4NOtMbu8a3vBQBqo29xQOrgezlXKuB3DBFZzC96SfJlUDvM0OAyOc5NDI/ZCRC
         7scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngP6KFAyVOKzK+3E0gEeMUxmzS5AboYYNyPmbfhWDPo=;
        b=P+D0ZrGIjH/tscsNMzcq1b01lpY6hfVh2P4E98h3tyZ7fIsZU1o406IUHMQ9J3r/Xn
         AtL1jsm7vTxsEN0Iz/gXtOGFK/CFHh5pGYtN5LnwpbMA7YMi/m0ywMdtxyEPmf2PuCy4
         pmf1WtAj+km262uYu73eoNfO2gvpA089tPt9/pSCPYxGI3BljXKnJjg2AS2fn8p5oVco
         X7Eoyx6hp2OkyTXJaH45fVru8FYmog0AHDc7Ky0WZIb7Q8dmXY6S0mtOssI++tddgAj+
         ikoEA56ajJIEx6FToiT2VKqyBmKsaiE+YMw02w6/vMtQ4Z8oi2yN9yWBmce1TWiSYhKX
         0FEA==
X-Gm-Message-State: ANoB5pk8UoYzsIAF7RHhnQnLQ7AMQED/0mOrmwqsOcNAHG7EdbO8WjmO
        bw22rVe7V4WlXBRCVMzDmvSv5A==
X-Google-Smtp-Source: AA0mqf6IyhG9UPqLf+uuvW/OUq5YPM6GivLxxOEuHnk5ozfFtWnNjuHl2owEFbAXnr9BNwtjUTXCGg==
X-Received: by 2002:ac2:59c7:0:b0:4b5:850e:6f4a with SMTP id x7-20020ac259c7000000b004b5850e6f4amr4888236lfn.69.1670919042818;
        Tue, 13 Dec 2022 00:10:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j6-20020ac25506000000b004b53eb60e3csm259904lfk.256.2022.12.13.00.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 00:10:42 -0800 (PST)
Message-ID: <81265853-6705-861b-2ee5-32adf3c05341@linaro.org>
Date:   Tue, 13 Dec 2022 09:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        johan@kernel.org
Cc:     bmasney@redhat.com, kernel test robot <lkp@intel.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213051109.8685-1-quic_shazhuss@quicinc.com>
 <f4102715-45b7-1196-878e-e0adce0d8c96@linaro.org>
 <09fbf4af-f1c6-828f-3ca6-3f06ff83b5ce@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <09fbf4af-f1c6-828f-3ca6-3f06ff83b5ce@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 09:05, Shazad Hussain wrote:
> 
> 
> On 12/13/2022 1:31 PM, Krzysztof Kozlowski wrote:
>> On 13/12/2022 06:11, Shazad Hussain wrote:
>>> Add the pcie2a, pcie2a_phy, and respective tlmm
>>> nodes that are needed to get pcie 2a controller
>>> enabled on Qdrive3.
>>>
>>> This patch enables 4GB 64bit memory space for
>>> PCIE_2A to have BAR allocations of 64bit pref mem
>>> needed on this Qdrive3 platform with dual SoCs
>>> for root port and switch NT-EP. Hence this ranges
>>> property is overridden in sa8540p-ride.dts only.
>>>
>>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>>> Reviewed-by: Brian Masney <bmasney@redhat.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Drop, robot did not report this patch.
>>
> 
> You mean I should keep only Kernel test as Reported by ?

No, I mean entire line should be removed. This robot did not report
missing feature/bug thus there is no credit for him for creating this patch.

> 
>>> ---
>>> Changes since v3:
>>> - Fix syntax error and add Reported-by (Kernel test robot)
>>
>> So the previous patch was not even build... thus 100% not tested. Is
>> this one at least built?
>>
> 
> I built that, but after running checkpatch with --fix, I think it 
> dropped the closing brace of tlmm. My bad :|

Please do not send patches with checkpatch --fix, without prior testing
the patch. Not the code, but the patch. By testing patch I mean checking
different mainline branch, applying the mbox/patch (git am) and
comparing with git diff.

Best regards,
Krzysztof

