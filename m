Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8164A5FAD76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJKH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJKH2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:28:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6094489963;
        Tue, 11 Oct 2022 00:28:18 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B6erAX032210;
        Tue, 11 Oct 2022 07:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=oe5FAcjBBXzAtIsFSubOrh8NpLiHSjLQp/VSNXK1PxU=;
 b=ct6s3Z/IVA1838OQsF5i2yJb/w5LGKFZjRHmGKDSsFCvoEvPBJqt4NVgTCMSVUSPm+V5
 ZH1k9Oikfab32hpedIH33mZqfPDk8t9q0oPU+ubAQtP32bYNxk/8idrxGs9UjWBZvemi
 D9xP+xYJARvmphQWmakgfhQeZ2gw1/6ZMqe2hbh1W9x9GfS1Jvqs3e2LW9iVBb7h8DND
 jOBCVMtQpO0KsyPKpjjoWgZPXNSEMi7o2X3COmwo8H58s2+cQDPAE4yW7nfLwXuQvk1S
 eeuR3ZSnAGpWJkEJpxrrv7uicvWql+te1pfhrLzLdbjb14WXSx8SpYwgBUBsLqnjclkk Ag== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k4wya14kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:28:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29B7KsAr013459;
        Tue, 11 Oct 2022 07:28:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3k30fjbw05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:28:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29B7S0Pr33751692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 07:28:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437225204E;
        Tue, 11 Oct 2022 07:28:00 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id EB3DD52050;
        Tue, 11 Oct 2022 07:27:59 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH v9 13/13] perf test: Add relevant documentation about
 CoreSight testing
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
        <20220909152803.2317006-14-carsten.haitzler@foss.arm.com>
Date:   Tue, 11 Oct 2022 09:27:59 +0200
In-Reply-To: <20220909152803.2317006-14-carsten.haitzler@foss.arm.com>
        (carsten haitzler's message of "Fri, 9 Sep 2022 16:28:03 +0100")
Message-ID: <yt9dr0zex1j4.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kgAJlXA0J63wM6xiUMVB8xn0LK9HULjO
X-Proofpoint-ORIG-GUID: kgAJlXA0J63wM6xiUMVB8xn0LK9HULjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

carsten.haitzler@foss.arm.com writes:

> From: Carsten Haitzler <carsten.haitzler@arm.com>
>
> Add/improve documentation helping people get started with CoreSight and
> perf as well as describe the testing and how it works.
>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../trace/coresight/coresight-perf.rst        | 158 ++++++++++++++++++
>  .../perf/Documentation/perf-arm-coresight.txt |   5 +
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/trace/coresight/coresight-perf.rst
>  create mode 100644 tools/perf/Documentation/perf-arm-coresight.txt
>

Investigating a rpm build failure i see the following error with next-20221011:

% cd tools/perf/Documentation
% make O=/home/svens/linux-build/ man V=1
rm -f /home/svens/linux-build/perf-arm-coresight.xml+ /home/svens/linux-build/perf-arm-coresight.xml && \
asciidoc -b docbook -d manpage \
        --unsafe -f asciidoc.conf -aperf_version= \
        -aperf_date=2022-10-06 \
        -o /home/svens/linux-build/perf-arm-coresight.xml+ perf-arm-coresight.txt && \
mv /home/svens/linux-build/perf-arm-coresight.xml+ /home/svens/linux-build/perf-arm-coresight.xml
asciidoc: FAILED: manpage document title is mandatory
make: *** [Makefile:266: /home/svens/linux-build/perf-arm-coresight.xml] Error 1

Can you please fix this?

Thanks!
