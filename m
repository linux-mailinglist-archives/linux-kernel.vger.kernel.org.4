Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CD6A9666
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCCLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCCLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:33:58 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC35D8A6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:33:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so3139378lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaCOUZHIfMpUPNTtMFud2sShga7wjjtpSaExiapnm7s=;
        b=OTIAJiEXM/fgoi+H9Hvi0ekr7PYmwGKc12hMZtTNo4/H1Pwu+cZ3TWSa/m9lL2d3D+
         CHGqGAt+Xz49m9BWsLqdktgIgZXFyXHIwaZT6rkcWZ5j46CZp91ljkTjOsa9PTWeK6nz
         YWymvTTNJYJdJGIfg+oo2Jq9HeV/EU+zpw2oKz5rwa2QE71GEU2/mnICe80oudBeSpQF
         56IHwKfVwZ6EHrDXLBUt4FpWfgAEXIJbYSCEPiEOpCc5GzCPRnzR7DkBbj5/eQZ9K72f
         VRNBvKu27Z88k/+KgNIIydpjzsUadkyC+8KyLS+8gWgG5JWQyvBzhbfcTaZsfzfQDBzF
         y35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCOUZHIfMpUPNTtMFud2sShga7wjjtpSaExiapnm7s=;
        b=N+nMf2eOeDW0XfXhf+HttrDB/Kjh4Nv2fxm4T0V9vgI7x6OMUaw8qxDVTlq2jcz4ZD
         fV3MZBNk1TbExlr6XFWw825+Nbrc6f8FRWvhvHM1LVfSV3B3aZa+h4adMlLi4XybkY/u
         OXjJY1nsMvjxsD47MY51cK9ncEZ8fvHpkjGNOAzk3Y8p/KMwjrvXmntUak2oRjK4kaeP
         ugXMEGfLq6UkPeEJhy4Q0qbBwRcUyTafNP0+eBpjvzKyQdH1rux5QInjty92h2jqHUR+
         RBuAe86Mys8YZBGcMRCUDF0nW4G1IqM8MXLtxyOBN1SLSMLADj0oVeyqVgvGhemjeEUb
         vN5w==
X-Gm-Message-State: AO0yUKXNXNRKwKItw/dUv+uO0ajZ8zKQxhr7cklGQyMZnAdPXUn7PKzC
        WB9jCmFMSKY+8oPJ7SpPQcFAlQ==
X-Google-Smtp-Source: AK7set8hXXirB0isLDImTu5dRNgvf1huWUY6/R5h2expxFmgL41yHmy7trmA10X2ePFJPjMS4r10ow==
X-Received: by 2002:a05:6512:4c9:b0:4dd:a785:83aa with SMTP id w9-20020a05651204c900b004dda78583aamr482313lfq.31.1677843197488;
        Fri, 03 Mar 2023 03:33:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id d5-20020ac25ec5000000b004db4ec844c2sm354259lfq.254.2023.03.03.03.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:33:17 -0800 (PST)
Message-ID: <29513b9e-8561-7f7e-370e-7515116c7ee6@linaro.org>
Date:   Fri, 3 Mar 2023 12:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
 <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.03.2023 12:32, Bryan O'Donoghue wrote:
> On 03/03/2023 02:35, Konrad Dybcio wrote:
>> Currently, when sync_state calls set(n, n) all the paths for setting
>> parameters on an icc node are called twice. Avoid that.
>>
>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> RFC comes from the fact that I *believe* this should be correct, but I'm
>> not entirely sure about it..
>>
>>
>>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index a6e0de03f46b..d35db1af9b08 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>       ret = __qcom_icc_set(src, src_qn, sum_bw);
>>       if (ret)
>>           return ret;
>> -    if (dst_qn) {
>> +    if (dst_qn && src_qn != dst_qn) {
>>           ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>           if (ret)
>>               return ret;
> 
> Is it possible for src_qn == dst_qn ?
As the commit message says, sync_state calls set(n, n) in
drivers/interconnect/core.c : icc_sync_state(struct device *dev)

Konrad
> 
> Iff you confirm that experimentally - add my
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
