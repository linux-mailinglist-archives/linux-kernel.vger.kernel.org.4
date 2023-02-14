Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5A69586F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjBNFUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBNFUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:20:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50F271D;
        Mon, 13 Feb 2023 21:20:06 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E5HlYT006974;
        Tue, 14 Feb 2023 05:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=on/G+7xydrT612HiE9+iKfuHNvPuUmqw1zf4SLBWcm0=;
 b=Ddf+SX016z+OY+svfB5UhuyzyWyFCKz62U+PzeZfpNx73/+72O/7J420rp0npmVBUq+5
 0rJUA1cGeeCEx/yZmj63ym5NJoegwYm9J+KzZnur9aWuxj1DY9xfSLGy7Bkw1f7DTYHK
 PsmMHE8q5zG8DF36X2WakD5pwkNI6QGEuOu3/m4AmUr+P4XQCD3ze1DYz1W79/AZIld5
 DJEMh+2ufJLMPR1oo+b4pBVrg4rxf4jzEGwBI5UKulOZyConQO4EfQdnqdjDC/h2Xkks
 sjrQzRDK2BXzj29bYmtL4H22+UonDwpIkHIIjJmc7NQBgIiYQ/dBtzOcxxXRmSpcSLQD +Q== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nr41e00kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:19:45 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E1BSFv020028;
        Tue, 14 Feb 2023 05:19:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3np2n6x2ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:19:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31E5Jhrv37683604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 05:19:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3D535805B;
        Tue, 14 Feb 2023 05:19:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C0B858058;
        Tue, 14 Feb 2023 05:19:43 +0000 (GMT)
Received: from localhost (unknown [9.211.96.43])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 05:19:43 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: qemu boot log difference today
In-Reply-To: <20230214143150.7c7fdd05@canb.auug.org.au>
References: <20230214143150.7c7fdd05@canb.auug.org.au>
Date:   Mon, 13 Feb 2023 23:19:43 -0600
Message-ID: <878rh0aknk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s3pa4hTPdjUeE41BhGsKVamhkK-zeFZ2
X-Proofpoint-GUID: s3pa4hTPdjUeE41BhGsKVamhkK-zeFZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_03,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
>
> Today's qemu boot log shows 256k extra in reserved memory:
>
> - Memory: 2046080K/2097152K available (14720K kernel code, 2944K rwdata, 18048K rodata, 5184K init, 1431K bss, 51072K reserved, 0K cma-reserved)
> + Memory: 2045824K/2097152K available (14720K kernel code, 2944K rwdata, 18048K rodata, 5184K init, 1439K bss, 51328K reserved, 0K cma-reserved)
>
> I don't know what has caused this.

Assuming it's pseries, it's the RTAS work area allocator reserving the
memory.

43033bc62d34 powerpc/pseries: add RTAS work area allocator
