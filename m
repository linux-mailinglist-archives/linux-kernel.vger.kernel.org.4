Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3245F0D49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiI3OTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiI3OT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:19:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE981A10BE;
        Fri, 30 Sep 2022 07:19:18 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UD1kOB007622;
        Fri, 30 Sep 2022 16:18:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5mh9M8v3SuC/0m2KMYvd313TI/M6UNxK38tIpJ8zt9Q=;
 b=qzQn5b0mQpen6qtcWKXX2p4z7MI51MyO3BMke9Pe1HhZheyHC7Th3DcVdSVFsY7AXH8Z
 evtFJqofwNW1wZyRjxjS5ALXedqk6dSIyO9dJpt0kjUmTCKP3hZeBv+oMJ1NhhWroWB0
 zSPhIWkj8VdcqHqDmA0adZONxDAGeLsi+q2G1Op/zZsEMr3zuWbrPR7+BIuan2oNzJ7G
 21Yy6eHnrGgfx3+Nr0OuT++9Jf4piXmOkr9TzlHHFHZLCyVORYEjXiGVGRWGBMcvnk9Z
 PJ4pMm79ffAspHlcJNZqri0HhNeu6R6P6S2Ob1p4AJRS7+V+NUdXxxLOGrAZErBYST4V QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jwxefhdqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 16:18:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BC5310002A;
        Fri, 30 Sep 2022 16:18:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3852D2309E6;
        Fri, 30 Sep 2022 16:18:56 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.50) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 16:18:55 +0200
Message-ID: <990c5782-2206-c012-d770-966887fd4515@foss.st.com>
Date:   Fri, 30 Sep 2022 16:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] usb: dwc3: st: Rely on child's compatible instead of
 name
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Audu <jerome.audu@st.com>,
        Felipe Balbi <felipe@balbi.sh>
References: <20220930072707.516270-1-patrice.chotard@foss.st.com>
 <YzbXkDZnBqgbks1Z@kroah.com>
 <8a6122f8-6432-d160-5937-fa7df029c928@foss.st.com>
In-Reply-To: <8a6122f8-6432-d160-5937-fa7df029c928@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/22 16:16, Patrice CHOTARD wrote:
> 
> 
> On 9/30/22 13:48, Greg Kroah-Hartman wrote:
>> On Fri, Sep 30, 2022 at 09:27:07AM +0200, patrice.chotard@foss.st.com wrote:
>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>
>>> To ensure that child node is found, don't rely on child's node name
>>> which can take different value, but on child's compatible name.
>>>
>>> Fixes: f5c5936d6b4d ("usb: dwc3: st: Fix node's child name")
>>>
>>> Cc: Jerome Audu <jerome.audu@st.com>
>>> Reported-by: Felipe Balbi <felipe@balbi.sh>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
>>> index 166b5bde45cb..fea5290de83f 100644
>>> --- a/drivers/usb/dwc3/dwc3-st.c
>>> +++ b/drivers/usb/dwc3/dwc3-st.c
>>> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>>>  	/* Manage SoftReset */
>>>  	reset_control_deassert(dwc3_data->rstc_rst);
>>>  
>>> -	child = of_get_child_by_name(node, "dwc3");
>>> +	child = of_get_compatible_child(node, "snps,dwc3");
>>>  	if (!child) {
>>>  		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
>>>  		ret = -ENODEV;
>>> -- 
>>> 2.25.1
>>>
>>
>> This commit doesn't even apply to my tree.  What branch is it against?
>>
>> confused,
> 
> Sorry... a v3 will be send, rebased on correct branch.
> 
> Patrice
> 
>>
>> greg k-h
