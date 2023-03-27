Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36776CA85F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjC0PBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjC0PBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D2359D;
        Mon, 27 Mar 2023 08:01:07 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RE5RbN001033;
        Mon, 27 Mar 2023 15:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eDLb29xSf73bZBzipAr6An1DqcWspOCRIVa5y5+44Fk=;
 b=RQJal0g/v8msy8uE0bDGf0ZM7Ly4kPeT4pQDMv5IRkMV+Z/nXQk9AKTPfDmGQ0pT/7+V
 1RN502PiQkQiwOZY3ZQLcxccMuZoBWi12Xu93KrKfcn0BKAB5hAfR578BXkZp/Dr7/gh
 B/Weff4DaFd4DiI+5S0xiO6sS8lzwZ8u4vr08X0CeZ3KfKmI3OQWWFiN2v7FZP5ctIQ2
 vFg4ecfQh2z3fZev4e9d/9xesUxsWWIysqSZQjykT2X2cmobSYSA8MQI5baPf+twLjvP
 uSoeRM5pdSP+JHWnIbOg1cdAkaY/xg1k7/XKgiTT5zOeiuJ31BT1ZZn6CXJGbgWyD7+w VQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjaw33wpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 15:00:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32RD4XN4019636;
        Mon, 27 Mar 2023 15:00:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3phrk7en1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 15:00:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32RF0UWT61735360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 15:00:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D055805D;
        Mon, 27 Mar 2023 15:00:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C502258061;
        Mon, 27 Mar 2023 15:00:28 +0000 (GMT)
Received: from [9.65.211.237] (unknown [9.65.211.237])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Mar 2023 15:00:28 +0000 (GMT)
Message-ID: <ad59ac18-caf9-c62d-e905-f19b27f67956@linux.ibm.com>
Date:   Mon, 27 Mar 2023 10:00:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
To:     Joel Stanley <joel@jms.id.au>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
 <20230321190914.2266216-6-lakshmiy@us.ibm.com>
 <CACPK8Xd70HABKrSRXKM5vA57YUCckykKOZV1ECuJc1=g70k--Q@mail.gmail.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xd70HABKrSRXKM5vA57YUCckykKOZV1ECuJc1=g70k--Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h-dpPlb2BvOwZ741u871PVoFMVcNxWkt
X-Proofpoint-ORIG-GUID: h-dpPlb2BvOwZ741u871PVoFMVcNxWkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270115
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/23 19:47, Joel Stanley wrote:
> On Tue, 21 Mar 2023 at 19:09, Lakshmi Yadlapati <lakshmiy@us.ibm.com> wrote:
>> Bonnell system supports new ACBEL FSG032 power supply on
>> I2C addresses 5A and 5B. Update the device tree with new
>> power supply information and device addresses.
>>
>> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> Eddie, can I get you to review?
>
> I will take this through the aspeed tree.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
>> ---
>>   arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
>> index a5be0ee048ec..4f959a4f8b58 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
>> @@ -552,14 +552,14 @@ ucd90160@64 {
>>   &i2c3 {
>>          status = "okay";
>>
>> -       power-supply@58 {
>> -               compatible = "ibm,cffps";
>> -               reg = <0x58>;
>> +       power-supply@5a {
>> +               compatible = "acbel,fsg032";
>> +               reg = <0x5a>;
>>          };
>>
>> -       power-supply@59 {
>> -               compatible = "ibm,cffps";
>> -               reg = <0x59>;
>> +       power-supply@5b {
>> +               compatible = "acbel,fsg032";
>> +               reg = <0x5b>;
>>          };
>>   };
>>
>> --
>> 2.37.2
>>
