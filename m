Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F9716584
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjE3PAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjE3PAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:00:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D59D;
        Tue, 30 May 2023 08:00:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBxQBT017376;
        Tue, 30 May 2023 17:00:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OCnHecsp5UxiV8JTlQGc9ogoMM35ZUP0jx/iE9+z3bc=;
 b=Ndb076wsztMFwoq8SavyLWdQRMbY8O726wZJBmo1X81kXwQwblZigIgLj50d9sM8zkyt
 z+VM03fUpQZpkdkCX70mkuGYzgBuvRf1c09biBP7PLdo8YcrBdFAYkyZ/LQNZmeC/lGI
 bzaXyRQiWPvbYP6GRH8EwRRKJygwZbkL6x6ZUAWdGCEBVbqLi9ARQ2udozMGK9iykANC
 qIAVRrwOxS9RKOyF55xnKnSZFib6yFcRBPiT7A8wDk/awL2Co78s6hP3Bbw34lnDYzox
 MkKUAjjSjbaxvHegVPy6iiRTqnmxJkZ7/cHnwl7EM3ZXbGnZKgxIK3WHwpRQaD2r3cNh cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3quahy8uvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 17:00:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D94B10002A;
        Tue, 30 May 2023 17:00:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7641322D164;
        Tue, 30 May 2023 17:00:08 +0200 (CEST)
Received: from [10.252.5.129] (10.252.5.129) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 17:00:07 +0200
Message-ID: <d4a98500-5cb0-b3fd-7f40-8b56a2258619@foss.st.com>
Date:   Tue, 30 May 2023 17:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for
 TEE support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
 <1b4eba7e-2771-b0c8-ec23-2ed882374e5d@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1b4eba7e-2771-b0c8-ec23-2ed882374e5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.5.129]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 5/30/23 13:50, Krzysztof Kozlowski wrote:
> On 23/05/2023 11:13, Arnaud Pouliquen wrote:
>> Rework compatibility description according to the support of
>> the authenticated firmware relying on OP-TEE authentication.
>>
>> The expected behavior is:
>> - with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
>>   non-signed (ELF) firmware image,
>> - with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
>>   firmware image. In this case it calls TEE services to manage the firmware
>>   loading and the remoteproc life-cycle.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
>>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least DT list (maybe more), so this won't be tested.
> Please resend and include all necessary entries.
> 
> Because of above and RFC, I assume there is no need for review. Just to
> be clear - that's a no.

I did not add DT list and maintainers intentionally to avoid that you
review it.
As in a first step the associated OP-TEE pull request has to be reviewed.
And my plan was just to share the Linux implementation part until the
OP-TEE review cycle is finished.

Now regarding your mail (and very interesting feedback from Christoph Hellwig),
it was clearly not the good strategy.
So my apologize and next time whatever the objective of the series I will add
all peoples and lists in the loop.

Thanks,
Arnaud

> 
> Best regards,
> Krzysztof
> 
