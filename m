Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405564CD29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiLNPhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiLNPhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:37:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F520F4A;
        Wed, 14 Dec 2022 07:37:02 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEETXOg032294;
        Wed, 14 Dec 2022 15:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K34UEmoqbP0hWiVBhYRS7Hke1YifchYcU0nimLAPkjA=;
 b=N+OcPXCzcbOAtDBEozHDEsEMlE10THeXOePL9ZeUE4i45KMNyWXjZ9wfsZMqBo2IYTa0
 CRUqeedDNfGTWdYGtnuqto+6sloMHJ55mgYe7qWO/C9KQfBhUIWZtBVvoq6D4YvIxRmx
 hAiE1X/TK9knov7dYK7aOyH0TSMyAEEKR52ZRAKvPEZRYbP/QDk9lvvV6nZqUZ2POzq3
 AQtNZnWY6QXcqxen8wzzQNu5MqbtXgVSL0rsRIliVKYkKSJtLoGpxpoLDRvnpi5NOrfx
 slYBFT68A8yPAEdkA5mlTifl38gj0CFdqdahRgICOvo2ZSdTmqiGkhSjo7TUQDQR4Ybm RQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6re9jyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 15:36:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEFattS008841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 15:36:55 GMT
Received: from [10.216.38.200] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 07:36:51 -0800
Message-ID: <6ab9171e-127b-12f3-cfe6-0fbf2b37080c@quicinc.com>
Date:   Wed, 14 Dec 2022 21:06:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ahalaney@redhat.com>,
        <echanude@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
 <309b3fad-933c-6c45-5cd7-4e082da62c15@linaro.org> <Y5nB1epKN4nbk3ma@x1>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <Y5nB1epKN4nbk3ma@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PFH_am0EmoDmQGnZn6Wm7Mwmuoc0x-av
X-Proofpoint-ORIG-GUID: PFH_am0EmoDmQGnZn6Wm7Mwmuoc0x-av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2022 6:00 PM, Brian Masney wrote:
> On Tue, Dec 13, 2022 at 03:48:27PM +0100, Konrad Dybcio wrote:
>>> +	qup1_i2c15_default: qup1-i2c15-state {
>>> +		mux-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			function = "qup15";
>>> +		};
>>> +
>>> +		config-pins {
>>> +			pins = "gpio36", "gpio37";
>>> +			drive-strength = <0x02>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>
>> You can drop mux/config-pins and have the pin properties live directly
>> under the qup1-i2cN-state node.
> 
> Hi Konrad (and Shazad below),
> 
> I need to enable 5 i2c buses (0, 1, 12, 15, 18) on this board. I tried
> the following combinations with the pin mapping configuration and the
> only one that seems to work reliably for me is what I originally had.
> 
> With the following, only 2 out of the 5 buses are detected. There's no
> i2c mesages in dmesg.
> 
>      i2c0_default: i2c0-default-state {
>          pins = "gpio135", "gpio136";
>          function = "qup15";
>      };
> 
> Next, I added a drive-strength and bias-pull-up. All 5 buses are
> detected. One bus throws read errors when I probe it with i2cdetect, two
> others 'i2cdetect -a -y $BUSNUM' takes ~5 seconds to run, and the

This I have also observed on downstream as well, where scanning all 
addresses takes some amount of time near to 5-6 seconds.

> remaining two are fast.
> 
>      i2c0_default: i2c0-default-state {
>          pins = "gpio135", "gpio136";
>          function = "qup15";
>          drive-strength = <2>;
>          bias-pull-up;
>      };
> 

This is the default config we should use.

> This is the style where i2cdetect seems to be happy for all 5 buses and
> is fast:
> 
>      i2c0_default: i2c0-default-state {
>          mux-pins {
>              pins = "gpio135", "gpio136";
>              function = "qup0";
>          };
> 
>          config-pins {
>              pins = "gpio135", "gpio136";
>              drive-strength = <2>;
>              bias-pull-up;
>          };
>      };
> 
> 
> Shazad: 'i2cdetect -a -y $BUSNUM) shows that all 5 buses have the same
> addresses listening. Is that expected? That seems a bit odd to me.
> 

Brian, even I haven't checked with all enabled, let me check this on 
other projects and with downstream as well and get back to you.

-Shazad

> [root@localhost ~]# i2cdetect -a -y 0
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:
> 10:
> 20:
> 30: -- -- -- -- -- -- -- --
> 40:
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60:
> 70:
> 
> I triple checked that I have the QUP pins defined correctly for the 5
> buses. I checked them against what's in the downstream kernel and I also
> checked them against what's in upstream's
> drivers/pinctrl/qcom/pinctrl-sc8280xp.c. This is the pin mapping that I
> have:
> 
>      i2c0: gpio135, gpio136
>      i2c1: gpio158, gpio159
>      i2c12: gpio0, gpio1
>      i2c15: gpio36, gpio37
>      i2c18: gpio66, gpio67
> 
> Brian
> 
