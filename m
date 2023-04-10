Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020256DC990
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDJQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDJQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:53:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EBB1BEF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:53:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m18so5088541plx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681145623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUs8qvDtaf7ZBDlIEwUt44wmVnmA5oBf//qowI3Zbts=;
        b=ehDwR1yk4HEmKtfgwHQXOLy7/7qx60vBX/9yiQ7/hI11NetSEzOI6BUxbfkgMwT197
         d9/ojWTSGpJ9/s6jl6sqe/IpvmrOuF9qEovlHp/7ImZuTvlK4LdY/kDLIisBF5mO7kUg
         nJiNF4cGWMzAY126ffQobrfzV9DFyvgaF1C32JmGj++FvPun+lS2s3v7HM6yN8ucBUnb
         lyiYRSrTpuzC41ijnBhj7kDdLUKLQIh4IOXCJCIkHo3VsGiIgOmxovJdBPpMjXtErAMr
         9Fvb2JFObJZnXV4I/qx8CetcXrK/AkJOtX1KjVdZ4VzNRazRQ0/nBZqOdbUSa2TsTYd+
         fTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUs8qvDtaf7ZBDlIEwUt44wmVnmA5oBf//qowI3Zbts=;
        b=iPpRrDUC2/PXPwuMstZZkJuB4a3TRqrGoGVqscDk4V69nRQdFZUqsLxfZQig+CN5VS
         eZIc/MJK6mPNy2lYIp8yYm/VWq5fvpXTFuOOIYdzDVp2WpoIrBXq6L5hjepWAJcaRK5z
         Dp3ETbnkVX8jNbUs4I5E6XCIsud+sXzVYm+Rko0He/yyV2yYWFQJjAGN6KipdKrnnYKu
         /z2nmw7b0LUdOebyYd2hF9wwB/s1KM/dKjIRy7JnqRIUgrR8o4oU47xPx9WMQe2QjRj6
         bfkIKocCAMuwrudFsUggdYF4zz9ZvGUceXI4eayzIKmueItYOs2t9/bLjJaaed9xj012
         ykmA==
X-Gm-Message-State: AAQBX9fDfkxBEN9+4yrx/MUZ0rfxOpeO2jp459B8ILOQG1WlRWTgCgd3
        Ym1Uhx9uc8E5fz0c+I40f+4nlwB4g7Ls0MvsSiA=
X-Google-Smtp-Source: AKy350beelFxzYJXCGxplXPyrEZkuiNOkyIyeUW8MVkQe/6A4BwDve1be2LzuhrhOiGC23kS1va4/Q==
X-Received: by 2002:a17:902:e803:b0:1a0:6a47:184e with SMTP id u3-20020a170902e80300b001a06a47184emr14588984plg.42.1681145623328;
        Mon, 10 Apr 2023 09:53:43 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:6a11:8ba1:beba:def7:a4ae? ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id bj12-20020a170902850c00b0019f2a7f4d16sm8063831plb.39.2023.04.10.09.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:53:42 -0700 (PDT)
Message-ID: <75f14a71-9d2f-f9f1-43db-472d7bbc317c@linaro.org>
Date:   Mon, 10 Apr 2023 22:23:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
References: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
 <20230315210145.2221116-3-bhupesh.sharma@linaro.org>
 <20230315223604.ofy7vm3bpccf5aul@ripper>
 <79731f2a-83e5-1e35-d450-456492cc5df2@linaro.org>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <79731f2a-83e5-1e35-d450-456492cc5df2@linaro.org>
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



On 3/16/23 5:22 AM, Konrad Dybcio wrote:
> 
> 
> On 15.03.2023 23:36, Bjorn Andersson wrote:
>> On Thu, Mar 16, 2023 at 02:31:45AM +0530, Bhupesh Sharma wrote:
>>> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
>>>
>>> This adds debug uart, emmc, uSD and tlmm support along with
>>> regulators found on this board.
>>>
>>> Also defines the 'xo_board' and 'sleep_clk' frequencies for
>>> this board.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
> [...]
> 
>>> +	vmmc-supply = <&vreg_l24a_2p96>;
>>
>> Is there any reason why this platform doesn't require the vmmc supply to
>> be driven to HPM? This has traditionally been coming back biting us
>> through some stability issues later.
> Do we even support HPM/LPM on SMD RPM?

I couldn't find any relevant documentation to say the same (HPM/LPM 
support on SMD RPM?).
So, I would suggest that we stick to the approach used in this patch for 
now.

@Bjorn, please let me know in case of any concerns.

Thanks,
Bhupesh
