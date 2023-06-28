Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860477409DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjF1Hwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:52:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbjF1Hwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5pSFw008157;
        Wed, 28 Jun 2023 06:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qjhN1yHhVfB8bKKHksru9FAz/YSXpy2LrUUmQdoojY4=;
 b=k/+w0azOqOXyw1ZX/vUF2Pw2F2cnXhPrsHi+X1RI0iqGKhoUWKHfBD9oiyWsXL3V6j7v
 px7pn2La4x7zWbcHWky+NIO+xzhqBIx5UIxyjp2A0IUiWnV7qly9/MvLwtKXL30zzhgC
 aOeIPxttQ+jwUitgIrWa+ohywq/emWRgyFZych56UB0Hb16w0+tpyT7P8Exhf/DcsD6i
 1//ICCFx+OKioBJGg30M+wkUoULxf9xKqu4e/Pu9/JHRIFRXbud1V9Wp6nbb/+4zGJ2N
 xHzW5Gc1LSqb33L849Zbjs1rr5rSfHCDgzbMyzKIESYXbaf12Fv61uom/flxfq/ufmQp Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgf36ranx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 06:04:12 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S5pWGJ008285;
        Wed, 28 Jun 2023 06:04:11 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgf36ram3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 06:04:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S2jYJO030676;
        Wed, 28 Jun 2023 06:04:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr451ss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 06:04:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35S645P016908894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 06:04:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB0B20043;
        Wed, 28 Jun 2023 06:04:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4203C20040;
        Wed, 28 Jun 2023 06:04:05 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 06:04:05 +0000 (GMT)
Message-ID: <e5274fc1-7de4-2c63-8767-fc437c2b68b2@linux.ibm.com>
Date:   Wed, 28 Jun 2023 08:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] perf/test: perf test case Daemon operations dumps core
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, hca@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
References: <20230627092633.2135105-1-tmricht@linux.ibm.com>
 <CAM9d7cjmmx2GQ7QQj3wBe1KkqgVNzoYbMuLeasVUWuZeLWUE9A@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cjmmx2GQ7QQj3wBe1KkqgVNzoYbMuLeasVUWuZeLWUE9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJQoIT1Veq46xhr8OJ_IzaJ_5DYTmhkl
X-Proofpoint-ORIG-GUID: N3rKsWCN7AlhjlHo3O3mwpGnqZpQXBTw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 17:35, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 27, 2023 at 2:39 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> The perf test case Daemon operations dumps core all the time.
>> I narrowed it down to this invocation:
> 
> Jiri sent the same fix already.  I'll add your Reported-by, ok?
> 
> https://lore.kernel.org/all/20230626201606.2514679-1-jolsa@kernel.org/
> 
> Thanks,
> Namhyung
> 

sure, fine with me.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

