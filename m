Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F1624E63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKJXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKJXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:22:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D85F85A;
        Thu, 10 Nov 2022 15:22:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AANIgo3023219;
        Thu, 10 Nov 2022 23:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0oylBCU5beoYXhU0Xt9MXhccTYP9EToEJbhZ0JXcKag=;
 b=sXWBYJoV8jx9PvG6yjN2pV1MQHNDXaMjP8GxcPf8zbSy0/38+cA3w5v3JRGdb+W0uATw
 znzVSnAOaJ/QxQgo3x43JLWCaOb3TIQBhuD9XBzKgrTD6FXMXrRx+Z0lj8cryQd/duxL
 mAg0riYRgGOVmKwS0oQbxfWpb3mFQhcIWWZL2qI+zbRYeKIxvOvalQSLfGyFIW2WIHhZ
 CaUQMGg3vRmxh7tawqIsl0w6cBnn1Jzo7zdJi/KhPw10hoojBmTMolpBe776bblQ98ly
 7aKLsoNBcqeCB1CkUUIZYnw/jvlPiqh4LqdyzFJd2T/POaF5wNRjy/BL5CZxVoF0wDdR /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksauw809s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 23:22:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAMeh4G038089;
        Thu, 10 Nov 2022 23:22:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsh927u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 23:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iny3YU4YKzmLEAfs76ThPZrk13GuSyROWMyioSFy0J1fak6STLHf2aS6BB4/alu9HaK7029W+jNbkJfjQAnVy+UveMahUEHyHXPflwjR2dTdooKhn5rd1OU9fDvwUpGlLGHzBnNBGVTNBvaeHLHTVcFvxFDOLR/E/jHSBp8j/mZhmNuCNJuG9Kwh/VPRzm3Zl+xjh2TfdF3Ivq0UoIScPE9D1xEmf+ROw3x07TisjXIwWDoAcfQRebJrizAgYw712opwwLsqYUaV2aSwMJ7kKaAcMydAvVjZ9LMvZmQxjzx75mTfO3u85JDMSAQWvLb+SVj5GzTzL0WGg78wzHyw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oylBCU5beoYXhU0Xt9MXhccTYP9EToEJbhZ0JXcKag=;
 b=RlqY+kEDphsSJR/gI5bT2fwv0lmZHw1h0yac1TBDWOYzrPk9Ym1JNtlxKnwKA5q9W6AGbxl8QyJq3EpxSYSGqPaLf0SzrcZstxzEUgcwYnHlUlm3m4xipVWm7+3/tl0Y9JjagXlrp+N/RrV3/xAu1aonRL+oZNM1h9SYKfX6mphLBJLZu+ANNTkHmwkkTb/MvjNf6dvEIbiXexf2BtW4lTAko5iLXv+GPvZnet7jcpJPeggXeQ+/plQHv44Pv7WYYyUZyaSjdaqDuCrGwHWjyFVmk8PtOdIlBAn+qgwy6/EH++xPXuL0lI+ygEIOYO86bRrYUUXZi8iqqBV2tU07fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oylBCU5beoYXhU0Xt9MXhccTYP9EToEJbhZ0JXcKag=;
 b=GgvlfsosG2VNz0zJjLnPcKqQd5kBILXXvDK0dfiwKHnWUfHPjwgl7EiP+15K0j8eCdsmwtyy0CEoV2KnNXbOM8H5DqOuWIJ6PIsQr3zdPEdwROyzWG4nQBTgoPvprTKsnr9cwdw8BCR++CKJ6BBjv9IHd8ZMJap/nD0qriQ4x6E=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 23:22:09 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 23:22:09 +0000
Date:   Thu, 10 Nov 2022 18:22:06 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] padata: avoid potential UAFs to the padata_shell
 from padata_reorder()
Message-ID: <20221110232206.glzzqi34wtpmmlcy@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-6-nstange@suse.de>
 <20221028161402.rh2p6feok2kjbjuq@parnassus.localdomain>
 <87bkpgb7q6.fsf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkpgb7q6.fsf@suse.de>
X-ClientProxiedBy: BL1PR13CA0413.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::28) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ2PR10MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: c92ed328-c7cd-4b17-488d-08dac37263d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6LiNcJzDohWujXJALtIsyG1oPb9m/DSRtKk2mlq2B2Po9tztLAvytBKWEfKf8HPUToVXqccFAI8s23J+YSnxdDZ8hmzBhPPEzj7+ASfpM8LuRRqWuU/n8Xkh/gd7ZH1auk5l6t593MpIslKKoGMInXbj/GD5NYsRxWBlx2/WPFXnQ191tEFPRXJ/nI/nwBx25vGuA6IBV1nfogxFVus5JjrZ4DC1sAbNK/GUWAe3GEjsHuT0bekq5/LMw5kgKnI1qlI7tW8W2Zm7fzO+VzyYY2AWUoL4ZygZXUzFi+/yXIolSP+2ivuV/4K++1TnoNzLIOgMxGgmfb3yyLFUFvg+qh2+yRpUdoB+T18niGTILaic8aoXscUirU2kRBoHZgH8W5ZRaMYE4lpI2cC6GsZhQtmLHp0LUlMG/nvtatx4FmiYyKyiI78YqQW8oIIDsxvXrGLUMorwylHEBPOetqCh+GeVMZalFL2AJD8fO0mJpxfaJ+viGbh0+lSPzXvk5C6hZLodD2ldyGx3cgKgut9vjK8VsgpLUtfG9zEb2QWHWfcE4hp8rYrih/QHLx0HPiDcTNgeI1vd4JmrfOyYgZAIq4wPKt7fcQHQgcmtioexQpeLQ/LREEj+h4iJaNUBtUNGbD1PvixmvYKQovZIKw/4Bj4UjxpdgOmdxgbNIEszi0R1BVlNH6Ij3GmCytD2vkoydxlICeETkMer2pDtdPy8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(8936002)(5660300002)(9686003)(186003)(6512007)(6506007)(41300700001)(4326008)(26005)(8676002)(66476007)(38100700002)(66946007)(83380400001)(86362001)(66556008)(2906002)(1076003)(478600001)(316002)(6486002)(6666004)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9L37QEjyZML4jFrFJkN4LDuPLDKtTd/0a0gp3U1gPmZFT5Pa0CFA7/8GiEJ?=
 =?us-ascii?Q?X11mx6hfcELPkDrQ7spin2p9STGUQBoIK+7X3EuQHBNVMu8tbVX25d/0xeTH?=
 =?us-ascii?Q?Vrp0lP466iswmKAbGNqvUh6zq/NCBO/HTdxyNOnZ8ED3nEbdfDytftBE25qJ?=
 =?us-ascii?Q?miwQBXUEhwzVi0y3i8crIbxrL22c11wnP+LvvV3tujyZWC36F0FsufJ2C4K5?=
 =?us-ascii?Q?Ivh+MuZMwTbN2DwEB4f/QXLd9n1v8W1TqDXXdYRZf3DHItl/8VP12lElOJ9Y?=
 =?us-ascii?Q?D72DcKpCn85CcEubZMZBwZhbfg1iOOFQLfI8Orl0klsBNl7gQ/1a6FBF+hBb?=
 =?us-ascii?Q?WjpkCnYREj4Op/fPSxj3FvZyodznuj68fZVgE5fGUFJpj/DbwTrJokoVKxDn?=
 =?us-ascii?Q?TwPvW9CpRHBPwUWvVSNmvguN9ooH7X8AaOS8ecokH8zeaDWHp7qMNIcVpVG0?=
 =?us-ascii?Q?WWbKLaOpCyUcDQgf08T9lws5Yx/a8PnGkrg3eQ3RC37ZIuYYCmoh8eAw+eS/?=
 =?us-ascii?Q?m6EVYBGEGNQ/7v94ZlY6tlaoo+HBCY3g/hHYqums8qvzitSv/KFB5hV8emf8?=
 =?us-ascii?Q?6YACeEnauswboiVRxutjEiD7nFy4jIWxraK6g4ORE5IMq/4BkSsJMRi0+SgG?=
 =?us-ascii?Q?taUJ9nVhoKl/eSF/iS6KSaNmAwG+R8dpAbiRtQjpN7x3zX/9WJ7uxtLwOiUq?=
 =?us-ascii?Q?ROKFkHmPShebfYmkzru0I/0qBuXMFsXX9Jz2Xq15TRYUDBWc+U9Sa/wC9LQE?=
 =?us-ascii?Q?lH81YAShrmr4F2Bjut4967LVZQOwBcDbvrlOcHlDzs6wjA9lpSDCGeA92yaP?=
 =?us-ascii?Q?mz2OSU9DYBA66JNZsvjbwaktQzl5XPR55F603EnGS5R7WXcEInkwj6HJ9eqs?=
 =?us-ascii?Q?XgZ7tYrGykn5lsaxvIzH0Z2RIzyGm6NsWXIbortscdK1GRpf/uVkvYfGwDAh?=
 =?us-ascii?Q?N3wz/5adrLHQkVTdXTOpBfSqW4AzuFn9B9cqXDCSvZ7ams0/NBqczbHAgqS5?=
 =?us-ascii?Q?druXoVyUcShxOamapBB8U5BoTU60cjyncSNP1ojEpwOxF93UkfuNM8xEqMBC?=
 =?us-ascii?Q?cpwZ5HQR70426tD51kqSd6x8a3w8cUUcymGI1yPMZwStlcLs5lgtx+WGbJVO?=
 =?us-ascii?Q?BkYY++S4LrXitUb2dNqfhX4GhdFyKYyQEgG772O0ti7woCmB+uj/NpHu9KjN?=
 =?us-ascii?Q?HQtzzRcwKI0+iBXmAR+GYrnLEb9pK+kZlm/6snLQDh1Fojb9Rp6sW1V68vbM?=
 =?us-ascii?Q?+5NenZ7p3c71betWt9ELlbNquDgtQja2+7+c62qUYhQiJKpcEMXWiawOnPWO?=
 =?us-ascii?Q?jU0CG9spqxsGubg6FIj3gvY4TE6gUSshPa+WFAatW5+FxQvMnC7FSM6veGqb?=
 =?us-ascii?Q?goymT23ef3hA2aN+z6KHgKMq9abNdjUJe1t+X4GA8wRfGiWpB21kr04KPJxi?=
 =?us-ascii?Q?B7oQs2vihpJbmj/GDDn3GfcMf4b9W6njHDTZfFJ9sj9Z6dXPv/v6N9f/V8ua?=
 =?us-ascii?Q?JVCershnrLsZjb/sa07byQvR41j+i7wZRpkusMgxkMGtdIOLUgcZrqYDtQ+Y?=
 =?us-ascii?Q?Obxf2wDLCuHvizEQESZgXHBdNsNlaqNE78J3Lcgj0XkSbxpiqjdb02AcyqwZ?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ed328-c7cd-4b17-488d-08dac37263d3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 23:22:09.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUU4cdmULz9eKVi8HGMfdfdMSzysCemrai9mP+0P2jU58vCuHT9cnjUVSlkwM6bDpdq/Dl9CxKPfIypmynF0tNo31tZJy2hIl7sZ0Hz8J9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100164
X-Proofpoint-GUID: sEgqbsxHibR9hm3DyK3DMT5KBYoJWG8w
X-Proofpoint-ORIG-GUID: sEgqbsxHibR9hm3DyK3DMT5KBYoJWG8w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:03:29PM +0100, Nicolai Stange wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Wed, Oct 19, 2022 at 10:37:08AM +0200, Nicolai Stange wrote:
> >> Even though the parallel_data "pd" instance passed to padata_reorder() is
> >> guaranteed to exist as per the reference held by its callers, the same is
> >> not true for the associated padata_shell, pd->ps. More specifically, once
> >> the last padata_priv request has been completed, either at entry from
> >> padata_reorder() or concurrently to it, the padata API users are well
> >> within their right to free the padata_shell instance.
> >
> > The synchronize_rcu change seems to make padata_reorder safe from freed
> > ps's with the exception of a straggler reorder_work.  For that, I think
> > something like this hybrid of your code and mine is enough to plug the
> > hole.  It's on top of 1-2 and my hunk from 3.  It has to take an extra
> > ref on pd, but only in the rare case where the reorder work is used.
> > Thoughts?
> >
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index cd6740ae6629..f14c256a0ee3 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -277,7 +277,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
> >  
> >  static void padata_reorder(struct parallel_data *pd)
> >  {
> > -	struct padata_instance *pinst = pd->ps->pinst;
> > +	struct padata_instance *pinst;
> >  	int cb_cpu;
> >  	struct padata_priv *padata;
> >  	struct padata_serial_queue *squeue;
> > @@ -314,7 +314,7 @@ static void padata_reorder(struct parallel_data *pd)
> >  		list_add_tail(&padata->list, &squeue->serial.list);
> >  		spin_unlock(&squeue->serial.lock);
> >  
> > -		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
> > +		queue_work_on(cb_cpu, pd->ps->pinst->serial_wq, &squeue->work);
> >  	}
> >  
> >  	spin_unlock_bh(&pd->lock);
> > @@ -330,8 +330,10 @@ static void padata_reorder(struct parallel_data *pd)
> >  	smp_mb();
> >  
> >  	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
> > -	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
> > -		queue_work(pinst->serial_wq, &pd->reorder_work);
> > +	if (!list_empty(&reorder->list) && padata_find_next(pd, false)) {
> > +		if (queue_work(pd->ps->pinst->serial_wq, &pd->reorder_work))
> > +			padata_get_pd(pd);
> 
> As the reorder_work can start running immediately after having been
> submitted, wouldn't it be more correct to do something like
> 
> 		padata_get_pd(pd);
> 		if (!queue_work(pd->ps->pinst->serial_wq, &pd->reorder_work))
> 			padata_put_pd(pd);
> 
> ?

Yes, that's better, and all the above can go in your next version too.
