Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB65FDB57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJMNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJMNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:45:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC53F037C;
        Thu, 13 Oct 2022 06:45:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DDQfJQ007609;
        Thu, 13 Oct 2022 13:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9df1l835pqYKy+lXFefaact9uEcWxkSfavAdNlkiPYU=;
 b=Pdoruq1QEO/8uUCqmfX3l1WpPp1zw8ry5CKIgDjDvhSvRyIeuY6CzJ0QgDkrp/VPfRT8
 mH/ocUzsIPh9p5BeItxJDW1FsIaZIXn4H+9s62M9d7813OkhCdu2x5L6k7Vmmg4i0uEi
 KQITt+hcYwIkK3AE/q9gpcgRBuMqDX9k5fi9i4pps4q+n/VJKxJT/HYw68IJEZdYRTn4
 bzFHfTaqQFrvMlTCrrEHS7BI6urCuJ+J7oJBXpwu+RbXthQcTsAXIQHcWYknMbX/Rp7E
 gB3eaZ4SkaNoT91H0pCelrm9w0ZGFqBmPUhTQMiQBAbgDE5IXu+N15uLAdJYjK3PiA5E ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6kjk8qxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:45:38 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29DDSmui017837;
        Thu, 13 Oct 2022 13:45:37 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6kjk8qwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:45:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29DDZDwH023446;
        Thu, 13 Oct 2022 13:45:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3k30u9nsnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:45:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29DDjWno66978298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:45:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41425A405C;
        Thu, 13 Oct 2022 13:45:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 962A4A405F;
        Thu, 13 Oct 2022 13:45:31 +0000 (GMT)
Received: from [9.171.10.158] (unknown [9.171.10.158])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Oct 2022 13:45:31 +0000 (GMT)
Message-ID: <f1f8c436-68ce-b4cb-1347-62fb0638e35e@linux.ibm.com>
Date:   Thu, 13 Oct 2022 15:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: arm coresight txt triggers build warning: (was [PATCH] perf test: Fix
 test_arm_coresight.sh failures on Juno)
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        acme@kernel.org
Cc:     suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221005140508.1537277-1-james.clark@arm.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20221005140508.1537277-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t41qLAN63QaOK2vpJyK_wcnMYBaxOR2k
X-Proofpoint-GUID: BELpoLIXBxo6leKDxrtLSTu78vV0Nc7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=626 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210130081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably not related to this patch set, but tools/perf/Documentation/perf-arm-coresight.txt

results in
cd tools/perf/Documentation/
make man
   ASCIIDOC perf-arm-coresight.xml
asciidoc: ERROR: perf-arm-coresight.txt: line 2: malformed manpage title
asciidoc: ERROR: perf-arm-coresight.txt: line 3: name section expected
asciidoc: FAILED: perf-arm-coresight.txt: line 3: section title expected

in linux-next.

