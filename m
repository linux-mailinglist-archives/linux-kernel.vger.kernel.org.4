Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA506293B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKOI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiKOI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:58:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A27641A;
        Tue, 15 Nov 2022 00:58:37 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8Yntt002802;
        Tue, 15 Nov 2022 08:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=y93H31PDnGNeHGJxuwKYXAQVout/WdMDytfWdJ6ezoA=;
 b=HQpnLNnZllwnX+hl4ZYEzsnShG3HyGEFm/wa2AENztf46ImuKFu/6gdZqx0JQJ5SABiw
 slsTuKXUHOrJVlfT4Mps2TO0gOqZeWmORu65p7shyg9dN2fORjOHu2BZkguE3PqS4Clx
 DngSLmhsy+3Z4tjNMMu5fXadMSMnXrN9WITJxpwoGalt5MM2R5PbfSV34S7h/jJUajz6
 zic8IFDaJNcSQ6Pwzko2ndqCrqfG9Fz6HeD2cB213M9NslxMjZDGB4MxXxFbWThMK5Ie
 lJG5FjBg9LdXF/yXaAhSnm3pwM4W6tHEsTodNz6xq9JkUg6agBdoropFlb/NvruYRD9P YA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv7cj8kuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:58:28 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF8q5mC009305;
        Tue, 15 Nov 2022 08:58:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3ktbd9jmxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:58:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AF8wNsq32703074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 08:58:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DBEC5204E;
        Tue, 15 Nov 2022 08:58:23 +0000 (GMT)
Received: from [9.171.35.73] (unknown [9.171.35.73])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BDE3552051;
        Tue, 15 Nov 2022 08:58:22 +0000 (GMT)
Message-ID: <c1f8de28-1948-85b1-cd85-5bbd301e22bc@linux.ibm.com>
Date:   Tue, 15 Nov 2022 09:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] perf list: Add PMU pai_ext event description for IBM
 z16
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ingo Molnar <mingo@kernel.org>
References: <20221111135402.858623-1-tmricht@linux.ibm.com>
 <Y3JnjmxPX+m7G9HL@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Y3JnjmxPX+m7G9HL@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gLbghLxiKMVzY1OztwL0O3L8r9wUWTcp
X-Proofpoint-GUID: gLbghLxiKMVzY1OztwL0O3L8r9wUWTcp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_04,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 17:06, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 11, 2022 at 02:54:02PM +0100, Thomas Richter escreveu:
>> Add the event description for the IBM z16 pai_ext PMU released with
>> commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA counters")
>>
>> The document SA22-7832-13 "z/Architecture Principles of Operation",
>> published May, 2022, contains the description of the
>> Processor Activity Instrumentation Facility and the NNPA counter
>> set., See Pages 5-113 to 5-116.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 198 ++++++++++++++++++
>>  tools/perf/pmu-events/jevents.py              |   1 +
>>  2 files changed, 199 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
>>
>> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
>> new file mode 100644
>> index 000000000000..8bee481f05d5
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
>> @@ -0,0 +1,198 @@
>> +[
>> +	{
>> +		"Unit": "PAI-EXT",
>> +		"EventCode": "6144",
>> +		"EventName": "NNPA_ALL",
>> +		"BriefDescription": "NNPA ALL",
>> +		"PublicDescription": "Sum of all non zero NNPA counters"
>> +	},
> 
> Since the Brief description mentions NNPA, shouldn't the Public
> Description expand on this "NNPA" acronym?, something like:
> 
> Oops, can't expand on that since there isn't a link to that SA22-7832-13
> document.
> 
> Googling for it...
> 
> https://www-40.ibm.com/servers/resourcelink/svc03100.nsf/pages/zResourceLinkUrl?OpenDocument&url=http://www.ibm.com/servers/resourcelink/lib03010.nsf/0/B9DE5F05A9D57819852571C500428F9A/$file/SA22-7832-13.pdf
> 
> Ok, requires registration.
> 
> I wonder what is the value of these descriptions then :-\
> 
> I miss Ingo jumping into these discussions :-)
> 
> - Arnaldo

I added Andreas Krebbel to the discussion, he knows more than I on this counters.

NNPA stands for Neural Networks Processing Assist. This is a new feature in 
the IBM z16. Here is a quote from Document SG2489-51 IBM z16 (3931) Technical Guide:

<START-OF-QUOTE>
  "The new IBM z16 microprocessor chip, also called the IBM Telum processor, integrates a
   new AI accelerator. This innovation brings incredible value to applications and workloads that
   are running on IBM Z platform.
   Customers can benefit from the integrated AI accelerator by adding AI operations that are
   used to perform fraud prevention and fraud detection, customer behavior predictions, and
   supply chain operations. All of these operations are done in real time and fully integrated in
   transactional workloads. As a result, valuable insights are gained from their data instantly.

   ...
   The AI accelerator is driven by the new Neural Networks Processing Assist (NNPA)
   instruction.
   NNPA is a new nonprivileged Complex Instruction Set Computer (CISC) memory-to-memory
   instruction that operates on tensor objects that are in user program’s memory. AI functions
   and macros are abstracted by NNPA."
<END-OF-QUOTE>

This intension of this patch is to give a small hint on what these NNPA counters are
supposed to count and operate on. A full explanation is given in the document
SA22-7832-13 "z/Architecture Principles of Operation", Chapter 26, pp 26-1 to 26-115.

If you think this small description is not worth it, then we can drop the patch.

Thanks for you help and directions.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

