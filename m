Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B75E71BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiIWCIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIWCIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:08:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADC118DEF;
        Thu, 22 Sep 2022 19:08:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MMO0Of022476;
        Fri, 23 Sep 2022 02:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=brkU24HB5KBfJ6M1WC6MLDDyApjTGkKbN1BC1wtxTyc=;
 b=BoLS0K94Cd/kNt6W/ymHZIvT6mdICDWxZ0vDhOCgG/9UtF9DgMIvQew6TWGmFIR9Mrl+
 T2XydDotT+jU1FZIK6xEEvpLbfr46D9XXz5FmBbPM06+QedZYmEySLxWctA3SJmN2xHT
 PJH8tgtgOWAzr6riZtb+9E62jRBSSebG/XEfNwRHV+3C9xU08VAijoORhmj+P4TVLSfE
 5jWLfzBK/SSuRFfoUG48lhCH9qUM7tqdJegUezppSsTCVU5QN3uzn5JJsBEK4C6+WhUf
 LgLzsnkmQkdxTMKvsbNQtbLfVojkn1wF+F2ZujyoDMxTAiv8woFZ4KOFxp8Z7MIWXYxX MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688pp2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 02:07:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28N1h9CQ005608;
        Fri, 23 Sep 2022 02:07:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cr8etn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 02:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBZdJUsI1WwRgPdg0DYOyFiMOulFWbL6bmTMShDMUdyZJ7EvArGMvV2S32/18jpfcwwFHRBw8JsXlC6Dk3zCnUDv8Tu0I2YEpP0pTA/4AacjE9YZnvvngNL8C43yW5nEOY7evoBE5wyEYXNL8tQFYlhz+nt1rKqJun7dpHE7NYH6eVDRjeD+1hdp/nRkmaDt2Eijqr4OxiVyih3tH/25k7Jq9fHqGDS9CTGZGw+sk+HBHI017IrLX1JPcXpcyaS7xYlszzkGVd1lxG21l6DglRf3IQ3Em7KVm5im/trMC46KHr9kyzbZrboSYySqEYWjDnyYCkj0jRWWXANOur391g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brkU24HB5KBfJ6M1WC6MLDDyApjTGkKbN1BC1wtxTyc=;
 b=iR2W/o8n8f8kb3NrXhjiwR+JKiv0XxDL3nNNQyBe2Ge9v1wfMiUtIJdldns2dGPUv4a1iXfYRkMWfxXPEEXynkjNRcX2J1vlZEL2euVAfK1wuLXsxFxtdW/RRYOLOVPbZ4j4Ct/9HrPJHxRY76aDAYC5iFncAbOiRvwBLdlIuGJ9iSFLXir1UEeyNbpex0bAQKDE4gTiY3OaIUb3OKq8ZJIQ6vQICz0LgiwbN7SgbbZwkB2Vd7CfSxsK/h3fFNttz1ciNZFfrusQZ8hr04x8pvPkhfrgAkwt0sgKBd8a3ht+OREiVI6AWfE5vMJeQxD62LGYf6s4mep2ftUmSOT3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brkU24HB5KBfJ6M1WC6MLDDyApjTGkKbN1BC1wtxTyc=;
 b=jDfR99vczeCwKbyLWCaF2dj7aWA9mHjxI/+4H+AIKhGcNyLlAnvoVmeLcn///mI9i8LIjwQIwuwp3yjgekrWXjsFYVNnFRcNBV3pvNd6+D+tMM/ocpCgIRp3iB3PD8+JLL/IpY3jls815IDXPxC7VB6A0XoTEWCM/WgAkcePaAE=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 02:07:47 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65%7]) with mapi id 15.20.5654.017; Fri, 23 Sep 2022
 02:07:47 +0000
Date:   Thu, 22 Sep 2022 22:07:43 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     eadavis@sina.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220923020743.qnoe62uih5k4v72j@oracle.com>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
 <20220920014711.bvreurf4ex44w6oj@oracle.com>
 <20220920055443.GI2950045@gauss3.secunet.de>
 <20220920141057.cy54d5ukflrgay3a@oracle.com>
 <20220921073616.GZ2950045@gauss3.secunet.de>
 <20220921185138.c6chlv77ugfrsukj@oracle.com>
 <20220922105537.GI2950045@gauss3.secunet.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922105537.GI2950045@gauss3.secunet.de>
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SN4PR10MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2c28e6-3b25-4d38-058b-08da9d0868a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yy44NsFMZ+tOCpDRDw58IzCQa3cVsFU/NfAImY+bIMnx8waxjwpEZMedk4FfZsvjvIqSr+IYIKVPFhQhatqOSyOLGEurI6Cv7BZo7HsGCilFg70+SXp6ZjpjVzs2JOqbfObwmCNvNR6/KQc0cVqQJeeMnN5u8OoNzMbnsdyG+/B/iCBwwg8sV5pqhljqyE0QzAI2LnOThNJQllzw3B2TBLr9lJkrRdt9uIrBY7qKfS/feZJCKvNVcPDwDHqKog9vzhpn2kO4Sa45Q0T3blyiqvDBsqSuAaGUUr14rAejiXFTgxUuPJuQZeJ2JLMuIrMGloPM/pxfvttQmMpfWLAljPx0L6aq34Zl+bPgZ2yhKqThYwmFKU4xLanDOcOe4/S8eetZlXBpSjZtmrdDaj8FxOGJOGMu4493OZCuMRs/eteUbpHBFJJItlcT7kQu6kpHolXL8ggs7BtSN+CRQjMM2hAjip7SQZl1ad3L89WBcJ4CXYVn1pj0GdbbBjMRWdzQSUC7iQLmkTW6Qj76CU0aTTkGN9/RjFohO5Ijx5vS6lFTLW293NRR94nnLXWm4mUraTQRuW/2s8PW/JHAJsWUXd2QBR4HyKuE8WpW6PrkNx/9ZiE6R3xbaU76r6CbnAbzwXgv1yXMK+Gne5D1OnpeeliQ4dO/WA6Xx8wzy3VkhqTW/nXYdn7OJwaAdwKR4kuFiIoVmednZD7gwbmoCjN/oRBwLv9dktrJRu17ehsYNbb9ezIX3VO8Kwho2aWp3dSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(38350700002)(6666004)(38100700002)(6506007)(66476007)(26005)(6512007)(2616005)(52116002)(8676002)(66556008)(4326008)(6916009)(86362001)(8936002)(6486002)(186003)(478600001)(2906002)(36756003)(41300700001)(316002)(1076003)(66946007)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIv38eL8QAnBTCgXze84aJKxZq6Td2llc3wVWXlvjVRHpwO+drKTas6IVdeK?=
 =?us-ascii?Q?rkvnZYoE7nr8FP/NaNzfyI025S5UhqTMt9ztvhOK5yVgD44jzkxg7N182xiM?=
 =?us-ascii?Q?yAFcbQPGIbtZPd1YwaNuW2pR41L5HjAutrxotdE5/lboeuFQ5agLJKhrB6rT?=
 =?us-ascii?Q?Io9uxPxzxwz068UIZmbDflS2a7k52k7YeCbTV5qadetuM8D4/wuO0k7G0bGV?=
 =?us-ascii?Q?hGg1ozW++cnW2YGC+Y0PZ/bujtWr300e1Hjza3pjtNcR12u6GBE5O3c+MLfe?=
 =?us-ascii?Q?T9ox9eTba1U9J7MI6say1JJUTsM9NG6jzL3wMeKC50pD80eqy6Gh1S+7sbYh?=
 =?us-ascii?Q?w2nSUSJf+oFs+sE30eN3IuIL8evzqVlY+gWDuSfDh8Yk38jHluMnUx9Jm9hP?=
 =?us-ascii?Q?P7yz6VEr5SlbgVsCXv1Gqm/LALCiFTcUV0VKs3sElzFVxKj8obWse1KFkueA?=
 =?us-ascii?Q?sTVFrcSMAAm3YswmGMSdRP/sbSqiRHUpBuh8jcexi4RHi1+NzsNW8cMUB6Sk?=
 =?us-ascii?Q?dZyc8rN8s/nBY5pGGBZ5fKZNqM6+2xNZkWiP9sdGaOA7pCzfnq2QsqWfpn/E?=
 =?us-ascii?Q?AKvH21ad2t/j8KgTQ9EQdrWLWpg2XFS2SxIbWq0m5mRiJDwwspduW4VnzGv4?=
 =?us-ascii?Q?vDCfzz1J9ldta8xLfPcpXvIlG1ig6fsgC27z79/+FFiYMcvRYj07QKqsnPaL?=
 =?us-ascii?Q?RomRocrQPIgNhENQ9zok8t7UvmLoAlWs8opgloBSBIicfLr4MU54fIZFngzU?=
 =?us-ascii?Q?j5Bd3SEzX+Bky6N46APv8/5K6AUvJehL/Liq8kWXL5rmDmJtT9W0mP/cbU8a?=
 =?us-ascii?Q?xmk7Jl748D1fGVv1BwQJ4Ogmnurx28YnpKnQ5h4mji0urJByPXvNIz+NmrTU?=
 =?us-ascii?Q?PwiHR4cbTKSFFFbRuYrMN3JkId863SEj2tCftufLSrqM4q2aweV/REoJYIbb?=
 =?us-ascii?Q?AuZm3Osj9TJMMsRepWQeB+wvvtrReNQYS4CJ7yDgoaYKKYbqQB85KVxObs3t?=
 =?us-ascii?Q?wYIbfsQ6s/qcNyed3oLCum9cJRSAdTd6XSPXY1bbTffVJF10l2J0L0uLPvGC?=
 =?us-ascii?Q?mDFepK/f0fSgZv0AjPY9CYiPfUqsYXuxtb8ATkEz9sbvao+sIH6mPmdOJyfq?=
 =?us-ascii?Q?9sj9czvrmoMMD0Eq9BcQYMT56RuV3Q+q7C9cn5jhx5M13VxILe2uEO5cL80C?=
 =?us-ascii?Q?VKVTJ5/roo1UXChPO+t3BE2Db5ScJcqI5WpfaaH3VyutWCIIPIyynfPdkHm6?=
 =?us-ascii?Q?0pKXy/Jxh6A+jRT50Oq3kQtVMqvCZoWjb7TnPANZY0lrpj6UCXI2pywa8w0K?=
 =?us-ascii?Q?4G9hNdJu4KCJyu3ZadIQENqyIIIJwXSKWsrufmj7lFGL8KRmn1xjHyj2Zla3?=
 =?us-ascii?Q?teQ+oAYf3HtMD9Yk//nHSAnDZf6kx6k7wc1q5zwdERLF9lRYABT4Fuh01ziW?=
 =?us-ascii?Q?7hkfG8zyf1hGl8UDM22Kv0vFUsgk4ktG8bcI7u/pRV0QnHVBMkB0g8tpb3lB?=
 =?us-ascii?Q?oq0gRlb3Ig7oQZoghhY853vUSOvV614HXucYgGzWT5bT7dx8Q2u5yd+EuLgO?=
 =?us-ascii?Q?hXayeasS6W3YKYSKZfQhEMw1W1v6NRdv7yeub0EDQNG9wYTVaK+MVOMKyP47?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2c28e6-3b25-4d38-058b-08da9d0868a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 02:07:46.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeoOqPZ/FEhFpx7bgsOGJCH5KS+8sNlDqz5GQx0RXsGoTtPbA5VISPQU24k9sELZx9gKdLur0doTF1ngAkhv+OVMGCx9aJQSnxF8rqytSwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=848
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230011
X-Proofpoint-GUID: Di2od25YiBwU4ezPglMHqaH77IKRZBXP
X-Proofpoint-ORIG-GUID: Di2od25YiBwU4ezPglMHqaH77IKRZBXP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:55:37PM +0200, Steffen Klassert wrote:
> On Wed, Sep 21, 2022 at 02:51:38PM -0400, Daniel Jordan wrote:
> > On Wed, Sep 21, 2022 at 09:36:16AM +0200, Steffen Klassert wrote:
> > > On Tue, Sep 20, 2022 at 10:10:57AM -0400, Daniel Jordan wrote:
> > > > Yeah, padata_do_serial can be called with BHs off, like in the tipc
> > > > stack, but there are also cases where BHs can be on, like lockdep said
> > > > here:
> > > 
> > > padata_do_serial was designed to run with BHs off, it is a bug if it
> > > runs with BHs on. But I don't see a case where this can happen. The
> > > only user of padata_do_serial is pcrypt in its serialization callbacks
> > > (pcrypt_aead_enc, pcrypt_aead_dec) and the async crypto callback
> > > pcrypt_aead_done. pcrypt_aead_enc and pcrypt_aead_dec are issued via
> > > the padata_serial_worker with the padata->serial call. BHs are
> > > off here. The crypto callback also runs with BHs off.
> > > 
> > > What do I miss here?
> > 
> > Ugh.. this newer, buggy part of padata_do_parallel:
> > 
> >   /* Maximum works limit exceeded, run in the current task. */
> >   padata->parallel(padata);
> 
> Oh well...
> 
> > This skips the usual path in padata_parallel_worker, which disables BHs.
> > They should be left off in the above case too.
> > 
> > What about this?
> > 
> > ---8<---
> > 
> > Subject: [PATCH] padata: always leave BHs disabled when running ->parallel()
> > 
> > A deadlock can happen when an overloaded system runs ->parallel() in the
> > context of the current task:
> > 
> >     padata_do_parallel
> >       ->parallel()
> >         pcrypt_aead_enc/dec
> >           padata_do_serial
> >             spin_lock(&reorder->lock) // BHs still enabled
> >               <interrupt>
> >                 ...
> >                   __do_softirq
> >                     ...
> >                       padata_do_serial
> >                         spin_lock(&reorder->lock)
> > 
> > It's a bug for BHs to be on in _do_serial as Steffen points out, so
> > ensure they're off in the "current task" case like they are in
> > padata_parallel_worker to avoid this situation.
> > 
> > Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> > Fixes: 4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
> > Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> Yes, that makes sense.
> 
> Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

Thanks.

> But we also should look at the call to padata_find_next where BHs are
> on. padata_find_next takes the same lock as padata_do_serial, so this
> might be a candidate for a deadlock too.

Yeah, that seems broken, it's now on my list of things to fix.  Probably
worth staring at the rest of the locking for a bit too.
