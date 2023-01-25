Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70BA67BEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjAYVfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAYVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:35:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CEF1BE5;
        Wed, 25 Jan 2023 13:35:48 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLjvk023936;
        Wed, 25 Jan 2023 21:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nIAdRzdPQwyEunmAkOeASKJClLogOZczMRviDVn2RMo=;
 b=GMovTnMgZV2EPS93QyOzU18ECv940x7ZBEdPeHDGMd2fNd7P39vNm3fnq5OBKQykgMml
 FtTX6J8iN+2W2sjwWygaTvhODcTSNKPYEEtj4L/4CllMUF8/ojiH9eij+S11Nzj2fWlV
 ltuxjJrAVLU/difuW2SXlOf1yTWUP06tBBh9RyzOpBkmslFgK2yWBOrsMvkBt4clNfpe
 jdvudSvrU89Cl2CRs8nIgsW+9uLzgz0PPsFti6IhHyvugqwaiMunsAB1tZ/O0+2TQ+2k
 c4Kp79RMolYE3vUQX6+V3YsnfmrqT0XBYNG4sQAo4jogjTC0XgN0Tb3UGJ+ksyQLXZnP hw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb7pp82mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:35:34 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKOjEH003198;
        Wed, 25 Jan 2023 21:35:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7a38b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:35:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLZX1o46531252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:35:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AB1458052;
        Wed, 25 Jan 2023 21:35:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CD095804C;
        Wed, 25 Jan 2023 21:35:32 +0000 (GMT)
Received: from [9.77.150.21] (unknown [9.77.150.21])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:35:32 +0000 (GMT)
Message-ID: <2fd38f3d-e26b-6888-10b7-8da06f94bfac@linux.ibm.com>
Date:   Wed, 25 Jan 2023 15:35:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: fsi: Document the IBM I2C Responder
 virtual FSI master
Content-Language: en-US
To:     Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
 <20230119174714.1486042-2-eajames@linux.ibm.com>
 <a8be2b47-b0e9-4a28-8c32-81b9af81299e@app.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <a8be2b47-b0e9-4a28-8c32-81b9af81299e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Vwcc3qQou6PqT_R7YtfyD5pzZ9GgfMb
X-Proofpoint-GUID: 2Vwcc3qQou6PqT_R7YtfyD5pzZ9GgfMb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250193
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/23 18:22, Andrew Jeffery wrote:
>
> On Fri, 20 Jan 2023, at 04:17, Eddie James wrote:
>> The I2C Responder translates I2C commands to CFAM or SCOM operations,
>> effectively implementing an FSI master.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/fsi/ibm,i2cr.yaml     | 42 +++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
>> b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
>> new file mode 100644
>> index 000000000000..929ca10988f9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/ibm,i2cr.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM I2C Responder virtual FSI master
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description: |
>> +  This binding describes an I2C device called the I2C Responder
>> (I2CR). The
>> +  I2CR translates commands sent over I2C bus to FSI CFAM reads and
>> writes or
>> +  SCOM operations. The CFAM access means that the I2CR can act as an
>> FSI
>> +  master.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,i2cr
>
> I think this should be a bit more descriptive and at least mention that
> it's FSI-related, e.g. `ibm,fsi-i2cr`? Thoughts?


Yea that probably makes sense.

Thanks for the suggestion!

Eddie


>
>> +
>> +   reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> + - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      i2cr@20 {
>> +        compatible = "ibm,i2cr";
> Change this in accordance with the above.
>
> Andrew
