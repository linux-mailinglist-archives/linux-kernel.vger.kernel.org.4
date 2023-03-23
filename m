Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402916C6416
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCWJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:52:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B02687F;
        Thu, 23 Mar 2023 02:51:26 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8JMfo000484;
        Thu, 23 Mar 2023 09:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fpu/aGQe/6rf5hwrLvGz3kiD/UAiRN2pQ/Vd9SJ0fHs=;
 b=so/mUCe4oGq3qlqx54cMBDmAvJlD8cjTjPlx+t1rC823f3mKb9IXN8VV+yaZYy+tbAnt
 YLQRaSab96TjMJAy5rLMXdaz/6sCg71MsGYtAOa0eUJ6dyeXGDkAjhDyxvvesz82QkwO
 St9UZ1NXERDJ+kPrwYqifCJPI2xcjBVxMsVdbo8DIFrtyRMnCGSHym4BloRi52x1OuZQ
 0vHOR10eLoKMY0YEfo+l07HdtMySs8ch7PLxuH5mW9SjgHiN6lmen44r38Q0SAqwagFq
 Sd4c0ReWUEUwUhiYVFHzsPTFPWYpexbpM7lRkYifpO1ubfplAOXwVGO36KvS4Z80nsXK bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pggdmdxaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:51:23 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32N9AUR7029515;
        Thu, 23 Mar 2023 09:51:23 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pggdmdx9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:51:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N0ljZO001990;
        Thu, 23 Mar 2023 09:51:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6e17n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:51:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32N9pHDr27263614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:51:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC7420049;
        Thu, 23 Mar 2023 09:51:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F75220043;
        Thu, 23 Mar 2023 09:51:16 +0000 (GMT)
Received: from [9.171.44.204] (unknown [9.171.44.204])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 09:51:16 +0000 (GMT)
Message-ID: <9632bc6c-276e-d0d6-b6d9-efe91fe3a1e2@linux.ibm.com>
Date:   Thu, 23 Mar 2023 10:51:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org>
 <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
 <CAP-5=fUtJsvAtrhe4xESoQc8U15WJ8BWREbH51OKoA218uJLzw@mail.gmail.com>
 <ZBDo2GiuUTrHhd2L@kernel.org> <ZBtsNTt6Fbp1Lg3t@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZBtsNTt6Fbp1Lg3t@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lyDSte1bk8pa_dmsOBjdYJFC06R-LdwR
X-Proofpoint-ORIG-GUID: uHWipVPCyhMSLSsABRgimI0v3iJzSRWE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230071
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 21:59, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 14, 2023 at 06:36:24PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Mar 14, 2023 at 09:34:46AM -0700, Ian Rogers escreveu:
>>> On Tue, Mar 14, 2023 at 1:20 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>
>>>> On 3/13/23 19:33, Arnaldo Carvalho de Melo wrote:
>>>>> Em Mon, Mar 13, 2023 at 08:22:44AM -0700, Ian Rogers escreveu:
>>>>>> On Mon, Mar 13, 2023 at 1:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>>>>
>>>>>>> Add metrics for s390 z16
>>>>>>> - Percentage sourced from Level 2 cache
>>>>>>> - Percentage sourced from Level 3 on same chip cache
>>>>>>> - Percentage sourced from Level 4 Local cache on same book
>>>>>>> - Percentage sourced from Level 4 Remote cache on different book
>>>>>>> - Percentage sourced from memory
>>>>>>>
>>>>>>> For details about the formulas see this documentation:
>>>>>>> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf
>>>>>>>
>>>>>>> Outpuf after:
>>>>>>>  # ./perf stat -M l4rp -- dd if=/dev/zero of=/dev/null bs=10M count=10K
>>>>>>>  .... dd output deleted
>>>>>>>
>>>>>>>  Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=10M count=10K':
>>>>>>>
>>>>>>>                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
>>>>>>>            431,866      L1I_DIR_WRITES
>>>>>>>              2,395      IDCW_OFF_DRAWER_IV
>>>>>>>                  0      ICW_OFF_DRAWER
>>>>>>>                  0      IDCW_OFF_DRAWER_DRAWER_HIT
>>>>>>>              1,437      DCW_OFF_DRAWER
>>>>>>>        425,960,793      L1D_DIR_WRITES
>>>>>>>
>>>>>>>       12.165030699 seconds time elapsed
>>>>>>>
>>>>>>>        0.001037000 seconds user
>>>>>>>       12.162140000 seconds sys
>>>>>>>
>>>>>>>  #
>>>>>>>
>>>>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>>>>> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
>>>>>>
>>>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>>>
>>>>> Thanks, applied the first two patches, please address the review
>>>>> suggestions for patches 3-6 and resubmit only those.
>>>>>
>>>>> The patches will be in the public perf-tools-next branch later today.
>>>>>
>>>>> - Arnaldo
>>>>>
>>>>
>>>> I would really prefer the current implementation without using "ScaleUnit": "100%"
>>>> The reason is that these formulars are given to me from the s390 Performance team.
>>>> They want to use the exact same formulars on all platforms running on s390
>>>> which includes z/OS and z/VM. This way they are sure to get the same numbers.
>>>>
>>>> Hope this background info helps.
>>>
>>> For the series:
>>> Acked-by: Ian Rogers <irogers@google.com>
>>
>> Thanks, applied.
>>
>> - Arnaldo
> 
> While trying to cross build to s390 on:
> 
> ubuntu:18.04
> 
> using python3
>  
> 
>    CC      /tmp/build/perf/tests/parse-events.o
> Exception processing pmu-events/arch/s390/cf_z16/extended.json
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 997, in <module>
>     main()
>   File "pmu-events/jevents.py", line 979, in main
>     ftw(arch_path, [], preprocess_one_file)
>   File "pmu-events/jevents.py", line 935, in ftw
>     ftw(item.path, parents + [item.name], action)
>   File "pmu-events/jevents.py", line 933, in ftw
>     action(parents, item)
>   File "pmu-events/jevents.py", line 514, in preprocess_one_file
>     for event in read_json_events(item.path, topic):
>   File "pmu-events/jevents.py", line 388, in read_json_events
>     events = json.load(open(path), object_hook=JsonEvent)
>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>     return loads(fp.read(),
>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 4271: ordinal not in range(128)
> 
>

Hmmm, this is very strange. After reading this mail I installed Ubuntu 18.04
on my s390 system. The build works fine, no errors at all.


# pmu-events/jevents.py s390 all pmu-events/arch pmu-events/pmu-events.c
# ll pmu-events/pmu-events.c
-rw-r--r-- 1 root root 317284 Mar 23 10:46 pmu-events/pmu-events.c
#

The file has the correct contents and the build works fine too.
# make 
....
Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ OFF ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]

  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
  LINK    perf
# ./perf list | grep -A 20 basic:
basic:
  CPU_CYCLES
       [Cycle Count. Unit: cpum_cf]
  INSTRUCTIONS
       [Instruction Count. Unit: cpum_cf]
  L1D_DIR_WRITES
       [Level-1 D-Cache Directory Write Count. Unit: cpum_cf]
  L1D_PENALTY_CYCLES
       [Level-1 D-Cache Penalty Cycle Count. Unit: cpum_cf]
  L1I_DIR_WRITES
       [Level-1 I-Cache Directory Write Count. Unit: cpum_cf]
  L1I_PENALTY_CYCLES
       [Level-1 I-Cache Penalty Cycle Count. Unit: cpum_cf]
  PROBLEM_STATE_CPU_CYCLES
       [Problem-State Cycle Count. Unit: cpum_cf]
  PROBLEM_STATE_INSTRUCTIONS
       [Problem-State Instruction Count. Unit: cpum_cf]


So everythings works as usual.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

