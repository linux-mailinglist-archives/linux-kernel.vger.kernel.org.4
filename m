Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAD60EA37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiJZUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiJZUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:24:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9D147D37;
        Wed, 26 Oct 2022 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666815839; x=1698351839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LwkDZOgEZeGHP4946I7RP41bt8AfxxyPqB9zldhTP9Q=;
  b=nNm+ivx4LSWPvQ14scDD4wHaFdEcbnaelWOMryWv/QWFU7N9spF73Wbf
   KKsxQZ6XDZrFL/JdgIxIPaDHwtDm5JyXmAiVKXF987kKASFnWALBIAMU6
   bGAtvD9Gx06t/DM6JOsNi6UaPtzEVdgHp88QXn0anWSYW85WCHqkm4e6Y
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Oct 2022 13:23:59 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:23:59 -0700
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 13:23:57 -0700
Message-ID: <e79513b9-3bbb-851c-6e46-92c043c8d1e7@quicinc.com>
Date:   Wed, 26 Oct 2022 13:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 04/21] arm64: smccc: Include alternative-macros.h
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-5-quic_eberman@quicinc.com>
 <56a47a6c-29b9-b8f3-e39b-a5841ddf7394@linaro.org>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <56a47a6c-29b9-b8f3-e39b-a5841ddf7394@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/2022 12:46 PM, Dmitry Baryshkov wrote:
> On 26/10/2022 21:58, Elliot Berman wrote:
>> Fix build error when CONFIG_ARM64_SVE is selected and
>> asm/alternative-macros.h wasn't implicitly included by another header.
> 
> Please include the build error into the commit message to help anybody 
> looking for the solution for the same issue.
> 

Now that the gunyah_hypercall implementation has been moved to its own 
module, this change isn't needed because asm/alternative-macros.h got 
implicitly included now. I can drop this, although not sure if we think 
it's still correct to have it?

After I got rid of the other header files, for reference:

In file included from arch/arm64/gunyah/gunyah_hypercall.c:6:
arch/arm64/gunyah/gunyah_hypercall.c: In function ‘gh_hypercall_msgq_send’:
./include/linux/arm-smccc.h:387:25: error: expected string literal 
before ‘ALTERNATIVE’
   387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl 
__arm_smccc_sve_check \n", \

>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   include/linux/arm-smccc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index 220c8c60e021..6a627cdbbdec 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, 
>> unsigned long a1,
>>   /* nVHE hypervisor doesn't have a current thread so needs separate 
>> checks */
>>   #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
>> +#include <asm/alternative-macros.h>
>>   #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl 
>> __arm_smccc_sve_check \n", \
>>                       ARM64_SVE)
> 
