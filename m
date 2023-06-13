Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC97272ED66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjFMUzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbjFMUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:55:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F51701;
        Tue, 13 Jun 2023 13:55:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DKk3NR007039;
        Tue, 13 Jun 2023 20:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7vW4zG8JSCB2WNlc2fX3cDVKDrFJjDxEa3RoWZwm5Ek=;
 b=hphMxkdfnxuypI5EnqJEpbqDOHqBgCjzqVcnLEyxQINuIXUE7kTb34YyuWhe51Hdyvia
 Kjp2id8ticuhM2qPq0s6x/MnBVCkPriaTUZ7gBUQSXZMOnTWJluywLkmIR99SOareCEz
 /Oo+FQiQ9wdARGDPTs7Rpqaz0x1xJ0pR38HGdUC+1dGLS/W1/swP0q9RMqwfJkN16L85
 MuAmTYp2ENY+alLcXSVpSPpzjge9nwJGUcVrzdMWMlHGgyaJDmHu1OhS/PKQ9wjaQ9XX
 WkDsI35dTCxMI5Se4ixCZgCdPlp5maVPF7iqBpY6m1iGahiGRKgy37FVwufcFb7GroJB HQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6vx80bxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 20:54:53 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DKsqgm031570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 20:54:52 GMT
Received: from [10.71.108.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 13:54:52 -0700
Message-ID: <4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com>
Date:   Tue, 13 Jun 2023 13:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] dt: psci: Add arm,psci-sys-reset2-vendor-param
 property
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Prasad Sodagudi (QUIC)" <quic_psodagud@quicinc.com>,
        <quic_collinsd@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <1583435129-31356-1-git-send-email-eberman@codeaurora.org>
 <1583435129-31356-2-git-send-email-eberman@codeaurora.org>
 <20200320120105.GA36658@C02TD0UTHF1T.local>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20200320120105.GA36658@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H1b4b_H2sBbsevGQ70Xal5AvNHzqRj9X
X-Proofpoint-GUID: H1b4b_H2sBbsevGQ70Xal5AvNHzqRj9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130183
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviving this very old thread. In case folks don't have in their 
mailbox, here is archive link:

https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/

On 3/20/2020 5:01 AM, Mark Rutland wrote:
> Hi Elliot,
> 
> On Thu, Mar 05, 2020 at 11:05:27AM -0800, Elliot Berman wrote:
>> Some implementors of PSCI may wish to use a different reset type than
>> SYSTEM_WARM_RESET. For instance, Qualcomm SoCs support an alternate
>> reset_type which may be used in more warm reboot scenarios than
>> SYSTEM_WARM_RESET permits (e.g. to reboot into recovery mode).
> 
> To be honest, I'm still confused by this series, and I think that these
> patches indicate a larger problem that we cannot solve generally (e.g.
> on other platofrms and/or with ACPI).
> 
> I think the underlying issue is whether the semantics for:
> 
> a) Linux's RESET_WARM and RESET_SOFT
> b) PSCI's SYSTEM_RESET2 SYSTEM_WARM_RESET
> 
> ... actually align in practice, which this series suggests is not the
> case.
> 
> If those don't align, then I think that commit:
> 
>    4302e381a870aafb ("firmware/psci: add support for SYSTEM_RESET2")
> 
> ... is not actually reliable, and not something we can support by
> default, and we should rethink the code introduce in that commit.
> 
> If (a) and (b) are supposed to align, and the behaviour on your platform
> is an erratum, then I think we should treat it as such rather than
> adding a property that is open to abuse.
> 
> Thoughts?
> 
I think it's ok for (a) and (b) to align (that invalidates this series). 
PSCI SYSTEM_RESET2 supports vendor-specific reset types and the PSCI 
driver doesn't have any way for these vendor-specific resets to happen.

Would a better way be to export a psci_system_reset2 function? I can 
implement a reboot-mode driver for PSCI system_reset2 for DT-based 
platforms.

Thanks,
Elliot

> Thanks,
> Mark.
> 
>>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/arm/psci.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
>> index 8ef8542..1a9d2dd 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
>> @@ -102,6 +102,13 @@ properties:
>>         [1] Kernel documentation - ARM idle states bindings
>>           Documentation/devicetree/bindings/arm/idle-states.txt
>>   
>> +  arm,psci-sys-reset2-vendor-param:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +        Vendor-specific reset type parameter to use for SYSTEM_RESET2 during
>> +        a warm or soft reboot. If no value is provided, then architectural
>> +        reset type SYSTEM_WARM_RESET is used.
>> +
>>     "#power-domain-cells":
>>       description:
>>         The number of cells in a PM domain specifier as per binding in [3].
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
> 
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <SRS0=iAha=5F=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> X-Spam-Level:
> X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
> 	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
> 	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
> 	version=3.4.0
> Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
> 	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C9C43333
> 	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:01:17 +0000 (UTC)
> Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by mail.kernel.org (Postfix) with ESMTPS id 1C65120732
> 	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:01:16 +0000 (UTC)
> Authentication-Results: mail.kernel.org;
> 	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoWzGqG2"
> DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C65120732
> Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
> Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> 	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
> 	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
> 	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
> 	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
> 	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
> 	List-Owner; bh=15BYqh1L1ALv71IjF7NXoGOSeeS0sbsBf/ahe6hUVYY=; b=AoWzGqG2lL+PnT
> 	eHgf22G62sLTs4kKNimymlbuMng5lx29kBuft3E15X+B1hWZr4smk8/XlIARAMD2tVef89z6wBHTq
> 	Uj3FBiZzghCEKhiW+yJA2h/DxfBmBWBDmS2iPBQlehFOpftLMApK6uSGvHKbh4CjuYVS1FFjzli2g
> 	10leZnncASBmeyiZl/17d3H286+dalis6nDW6GfOYMzg/zhlZJi630/CPEsmlt/4TkIr6SQYPsfpI
> 	DtjiDGeQYCZEqNvtu22etrtCleRfqtsoLyLYBSD1zn2haDJTzhhDQgoZ8+8xr2dzNR9lnhfONmyHC
> 	8Q65eWvNSwTvJlb55XxQ==;
> Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
> 	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
> 	id 1jFGKy-0004HY-Gg; Fri, 20 Mar 2020 12:01:16 +0000
> Received: from foss.arm.com ([217.140.110.172])
>   by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
>   id 1jFGKt-0004Gl-QZ
>   for linux-arm-kernel@lists.infradead.org; Fri, 20 Mar 2020 12:01:14 +0000
> Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
>   by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA5D31B;
>   Fri, 20 Mar 2020 05:01:10 -0700 (PDT)
> Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com
>   [10.121.207.14])
>   by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E89A3F85E;
>   Fri, 20 Mar 2020 05:01:07 -0700 (PDT)
> Date: Fri, 20 Mar 2020 12:01:05 +0000
> From: Mark Rutland <mark.rutland@arm.com>
> To: Elliot Berman <eberman@codeaurora.org>
> Subject: Re: [PATCH v3 1/3] dt: psci: Add arm,psci-sys-reset2-vendor-param
>   property
> Message-ID: <20200320120105.GA36658@C02TD0UTHF1T.local>
> References: <1583435129-31356-1-git-send-email-eberman@codeaurora.org>
>   <1583435129-31356-2-git-send-email-eberman@codeaurora.org>
> MIME-Version: 1.0
> Content-Disposition: inline
> In-Reply-To: <1583435129-31356-2-git-send-email-eberman@codeaurora.org>
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3
> X-CRM114-CacheID: sfid-20200320_050112_965539_E60DC8A3
> X-CRM114-Status: GOOD (  19.35  )
> X-BeenThere: linux-arm-kernel@lists.infradead.org
> X-Mailman-Version: 2.1.29
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
>   <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
>   <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Cc: Trilok Soni <tsoni@codeaurora.org>,
>   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
>   David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
>   linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
>   Sudeep Holla <sudeep.holla@arm.com>, Prasad Sodagudi <psodagud@codeaurora.org>,
>   linux-arm-kernel@lists.infradead.org
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
> 
> Hi Elliot,
> 
> On Thu, Mar 05, 2020 at 11:05:27AM -0800, Elliot Berman wrote:
>> Some implementors of PSCI may wish to use a different reset type than
>> SYSTEM_WARM_RESET. For instance, Qualcomm SoCs support an alternate
>> reset_type which may be used in more warm reboot scenarios than
>> SYSTEM_WARM_RESET permits (e.g. to reboot into recovery mode).
> 
> To be honest, I'm still confused by this series, and I think that these
> patches indicate a larger problem that we cannot solve generally (e.g.
> on other platofrms and/or with ACPI).
> 
> I think the underlying issue is whether the semantics for:
> 
> a) Linux's RESET_WARM and RESET_SOFT
> b) PSCI's SYSTEM_RESET2 SYSTEM_WARM_RESET
> 
> ... actually align in practice, which this series suggests is not the
> case.
> 
> If those don't align, then I think that commit:
> 
>    4302e381a870aafb ("firmware/psci: add support for SYSTEM_RESET2")
> 
> ... is not actually reliable, and not something we can support by
> default, and we should rethink the code introduce in that commit.
> 
> If (a) and (b) are supposed to align, and the behaviour on your platform
> is an erratum, then I think we should treat it as such rather than
> adding a property that is open to abuse.
> 
> Thoughts?
> 
> Thanks,
> Mark.
> 
>>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/arm/psci.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
>> index 8ef8542..1a9d2dd 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
>> @@ -102,6 +102,13 @@ properties:
>>         [1] Kernel documentation - ARM idle states bindings
>>           Documentation/devicetree/bindings/arm/idle-states.txt
>>   
>> +  arm,psci-sys-reset2-vendor-param:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +        Vendor-specific reset type parameter to use for SYSTEM_RESET2 during
>> +        a warm or soft reboot. If no value is provided, then architectural
>> +        reset type SYSTEM_WARM_RESET is used.
>> +
>>     "#power-domain-cells":
>>       description:
>>         The number of cells in a PM domain specifier as per binding in [3].
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
