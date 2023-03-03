Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AE6A9365
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCCJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:10:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B9196AA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:10:43 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3238cIpW032270;
        Fri, 3 Mar 2023 09:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Te9klQBS+kCAEC6hYv2BB9GzSiQA75m/Yl9D5zyV7XQ=;
 b=U+AlU00oGQg+4VDcAggZoMHtQOzY7zUXqKXxv9jddS7sOJpTHlEpLjZ2E14kKtCeSj8u
 uXeKXA3+SytZEjnidwWPr5nacUrn9adKtiSMbapg8WUC7F339wqgafufRDyhzY+f1X52
 TF7gM2PvZSIHZDbMccvieCw8EoT9F4z456xBB5LpYU34hbgryTTooaa+VriDBe3KzbXF
 QWAEDcFM/UwnXRZFgisImsnJRJCuX1DdFJ7zScDBaxrxf2U4R58yWrH4CRDTUNxSokfz
 BjekTAcwdvHmy1AoO7q2cGcSnOoJ2TRVP2Sm5cB/lOF/YDAYLES+Q5Ui241B73wkrr7u TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3cqvt19n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:10:30 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3238e9sa011021;
        Fri, 3 Mar 2023 09:10:30 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3cqvt18q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:10:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 322NEcUw010210;
        Fri, 3 Mar 2023 09:10:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nybbdn56j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:10:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3239APvM61210974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 09:10:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4351420049;
        Fri,  3 Mar 2023 09:10:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8246E20043;
        Fri,  3 Mar 2023 09:10:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.42.36])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Mar 2023 09:10:24 +0000 (GMT)
Date:   Fri, 3 Mar 2023 11:10:22 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, Hugh Dickins <hughd@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Message-ID: <ZAG5fvRl4Z+3vGfS@linux.ibm.com>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
 <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8wHVh8GK_cWTSeQM9JYKCJnnYeyWu13d
X-Proofpoint-GUID: 8-BF8Lm2MJqOgwachMFQu6yIgqUY7XVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=548
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Mar 01, 2023 at 07:51:43PM -0800, Andy Lutomirski wrote:
> On Thu, Jun 3, 2021, at 11:01 AM, tip-bot2 for Mike Rapoport wrote:
> >
> > x86/setup: Always reserve the first 1M of RAM
> >

...

> +       /*
> +        * Unconditionally reserve the entire fisrt 1M, see comment in
> +        * setup_arch().
> +        */
> +       memblock_reserve(0, SZ_1M);
> 
> 
> But this runs even if we just failed to allocate a trampoline on the
> first try, again dooming the kernel to panic.
> 
> I real the commit message and the linked bug, and I'm having trouble
> finding evidence of anything actually fixed by this patch.  Can we just
> revert it?  If not, it would be nice to get a fixup patch that genuinely
> cleans this up -- the whole structure of the code (first, try to allocate
> trampoline, then free boot services, then try again) isn't really
> conducive to a model where we *don't* free boot services < 1M.
 
Currently, the second attempt to set_real_mode_mem() in
efi_free_boot_services() does not allocate from memblock anyway but reuses
memory freed from EFI services. Could be that failure to boot caused by
another failing reservation?
 
> Discovered by my delightful laptop, which does not boot with this patch applied.

Do you have early_printk() visible? 
 
> --Andy

-- 
Sincerely yours,
Mike.
