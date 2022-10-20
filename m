Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A160585D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJTHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJTHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:24:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1815D0BF;
        Thu, 20 Oct 2022 00:24:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K67Fjh032571;
        Thu, 20 Oct 2022 07:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=wNoSCwQrH6lNPRl+W0lMa9pt+zi83bO8wcdQ1V+6QCU=;
 b=YAnnuygEJY7CAijiWURfY+SwNQoKv6tsxLuSdzENRJBxxaLnxz+WQ+poiq9AptCNocPr
 0NOy2J+lfESi2k5ALyc3RnZOgxsLPNkpmOb5NkGMy20ju+ZWRnoTjAwpmEMXhVBLtwNB
 T0hhHWUy4mxFSXR+UhQCvq94lDCS4302ZGvcbbulnLZTy9dvu9h9ev5zJR0hF7+nGecg
 L8m0Hvck3D6ueOfdhkFIfOIc8nwkLDc8BqpKzUtvrNu1ZYojInuScCqkJ44kPmx7FRVD
 pBp0iqovtf0yzKPxDkjYZW13jwJm6kELu2PfLBefiDLMeABunk8yR+MojknY7sHSTMVk 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kayycbc5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:23:57 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29K6mfJM007644;
        Thu, 20 Oct 2022 07:23:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kayycbc4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:23:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K7KN2I027802;
        Thu, 20 Oct 2022 07:23:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3kajmrs5fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:23:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K7No3b61014278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:23:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B54E211C052;
        Thu, 20 Oct 2022 07:23:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 477C811C04A;
        Thu, 20 Oct 2022 07:23:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Oct 2022 07:23:50 +0000 (GMT)
Date:   Thu, 20 Oct 2022 09:23:49 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 rcu 08/11] arch/s390: Add
 ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Message-ID: <Y1D3hReCp/9C9gD3@osiris>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
 <20221019225846.2501109-8-paulmck@kernel.org>
 <b74752cc-5833-c1b5-3697-262c523e794b@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74752cc-5833-c1b5-3697-262c523e794b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rO82ET1BaHoOA7-0pjfvz8ISDIH6rwdF
X-Proofpoint-ORIG-GUID: 76d64ek7JBezBlBA92byhX1TOvBb9u8s
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 mlxlogscore=630 malwarescore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:16:44AM +0200, Christian Borntraeger wrote:
> 
> 
> Am 20.10.22 um 00:58 schrieb Paul E. McKenney:
> > The s390 architecture uses either a cmpxchg loop (old systems)
> > or the laa add-to-memory instruction (new systems) to implement
> > this_cpu_add(), both of which are NMI safe.  This means that the old
> > and more-efficient srcu_read_lock() may be used in NMI context, without
> > the need for srcu_read_lock_nmisafe().  Therefore, add the new Kconfig
> > option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/arm64/Kconfig, which will
> 						s390 ?
> > cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving the current
> > srcu_read_lock() behavior.
> > 
> > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > 
> > Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
...
> > ---
> >   arch/s390/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)

Not sure what Christian was trying to say with his empty reply :)
In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
