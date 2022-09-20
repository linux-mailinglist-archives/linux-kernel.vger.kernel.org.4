Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE95BE857
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiITOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiITONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4032D99;
        Tue, 20 Sep 2022 07:11:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDXO1l031060;
        Tue, 20 Sep 2022 14:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=cDjJaoM5vlbcSCFfNVZEu2d87Hy7mazGCCWHTGkOfaI=;
 b=O/s/kYwkbWBaQvKgyuVdG9w/IpIG1xEutcGYB7OSY8rofXmrQBZFZa8ZOlteYse7FdUV
 Wmk6ZE3M4mBKp3SrOsQ28zM24T9NrI7yYiCTgIIJdVI9Q8ycgnoW9m/eSVn9zmY1VRn0
 UE9rx1yQ3tJKxGVFye4oswBvuqT6kr2Ynkmcx03ARqsDtjHmiJ1Ew4okw8SI5jvgkgTw
 aewt+47olmRs+fDu6a6aFUAMxC/Ww1QmBDrFGiK8eRfCs8vpr3c4EgO4YiyWL0PrPsvv
 TuYenfQAmyKVz9BPkqbwnbD8o5PjFcgryxfZHe61N6Vq83Mxv0HIZPu5vPFG3wK5gqlT vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kq3d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 14:11:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDco8K027858;
        Tue, 20 Sep 2022 14:11:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cnc47m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 14:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np/5foRdCjRvHeePThPuDm6qZFlyo8LI08JPIfkL9Gn/hP6pHAVfXuUXtR3jq3aP3eLpKs9eLA0MzAvHgbrXVLTkn0xp4/ExW4xhXUDwKyn7vC0pPUvKDzgOb7VBjiKX/Pyjryzx73I1YjPAo8MPSueLGfynHgC1X5r7l+TaMHSgsHeHigLn0CIAO+fnn6kJ+EgP5WCXAdIphrK/fKvXckJO5LzUdey79P9X5vO3ykGPuMbO5aAAqFNbWSLATdjL/D0HuvrHjsSKT/07RyaWq6nt2PKnyQBfrOIq1neCemWy27ztdrT52lk+wMd0cAM+hhxLo8KAyTjHkaFTVe8a1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDjJaoM5vlbcSCFfNVZEu2d87Hy7mazGCCWHTGkOfaI=;
 b=iOxrFyL/RLdbHMlntr+489cEQdvYqQBBCoSQLDz7WQUqngb1kjnJAUxivTdp4bA8CGObmxYPVF9d0/GWgxBviRBudRZVe7QBBpLr80UPYqoTXA1jBNfbjeoC98ggi1Qc2YyLixOuMcRjULJwa3pcwplkXj6p3WAIqnQnklKF35IHiIarh8YCHgekJVAob++Fyw9bhAc/ZnBu0FizeRINXBJSlIy5GTNc1myZGJ4QzhzVkpqm1eMshsp3vrmrv0lp3bI8h5mjIGtdG1tOuPA2YxrRRJ/2DhVX8MBqqUCKG/0i0Cv5i0Zr/y6wUcgMA5m7wRCEFXQ3dP1/IxfZWrVhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDjJaoM5vlbcSCFfNVZEu2d87Hy7mazGCCWHTGkOfaI=;
 b=x4jU/WmmFCRgI5TVUX0Ajxw8w6kfJIfj0r7Va3gOD+0fqNTUTbMftSjRpbQ1ZclXsGtSSGD3gw9V5Dwt0U4iDt/acJs7vv/3uVAyfCND+EO/1uU5ONEWCaKKtQmD6YVKddfKPMY+/hN96QlK2LENeiwaYRAzcPh4U8abGhUydK0=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 14:11:00 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:11:00 +0000
Date:   Tue, 20 Sep 2022 10:10:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     eadavis@sina.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220920141057.cy54d5ukflrgay3a@oracle.com>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
 <20220920014711.bvreurf4ex44w6oj@oracle.com>
 <20220920055443.GI2950045@gauss3.secunet.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920055443.GI2950045@gauss3.secunet.de>
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DM4PR10MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 380d20ba-cc64-40c7-939e-08da9b11f1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IytpeBaEBd/waT5kp4mHEPtb7azGICihx/iDXog/s+VS0tk36tk345q/xlJSS9MbLkH5LtF+uLIkwdzO+CKg88J8IyI6VUTPuI336/PccQJyWgrPlXjOZi22JycBH7wcQYLuexUEHi9XKxB7hV2hsioxwneScHWFQIRe1+PTFMlYGBW/+uFjButC+3yvt6TUOVGZhRie3RAA/UJUQeTFgzH+JXGEW3Iq8ZcEthsoh80h476c6pQvdyrVP6ldXnHGZh7Uytax5IXiebMQ5cJia4SD1YWfFXnP86Lg2DABC7qDxh8Pcz+uvyIwJbAWmesuMhWY87cv3rXBvfHLfFlpGJdrWBNmPwVL6zF4R6atkhwa3mBTV6HzB0gd5vYVp9xtH0zS6dLYnXwuCxLGwdcv9p925YQFxnzJV7VFDp/89uzjThoWfKm5QAiyCZHTtga3pGaAUAYobrIL6KMxe6qH+lUJJclyaRAlw/h9LC9uk/GLjJ2hxpZCMxMR7pAzbGMsGuvVh7smpnZ4y/Tap6FBBZytii/0YRGPSJkJnBH7/Vd15vswIpAIfp1QYrgYrlCd6oQNQR6lLM2mv8QsR4VZgr++IEQW8lfmcot1EzREL8907cK8l3SfDS+swucpEYRdsPNueSX3i+D+b7J095wmIVmqyvPk/y5fmkU2+Gz4RTaa7D+r7w+okwCPz13SwKZ46sJAfRt+p01Brw2GAaUuvB520rIQQveErwa+rcL9gpaUjU7Ovan4uyS5iRzP8v6c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(36756003)(2906002)(8676002)(6916009)(5660300002)(316002)(66946007)(4326008)(66476007)(66556008)(86362001)(478600001)(6486002)(6666004)(41300700001)(8936002)(6506007)(52116002)(2616005)(1076003)(186003)(26005)(6512007)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdMzYIvLMmf/40WOHXZnv4FOBpa68dXRJPGwXoipu68q9dkObm2XzisTet37?=
 =?us-ascii?Q?I7TykbmiRUoMhJ6s+okljaAY4Y8HHIwz181Rx59n2Mz87y0xksGNjm4gm3ea?=
 =?us-ascii?Q?sTKyAdhvKRn69ki6DJHiTt2cKGHjAdPucxMVejl0sKzM7idTVhR0k45Wm/vw?=
 =?us-ascii?Q?yjmXL4ppxCou9w/FzZPDN+WWi5Gqp/qQFd7ieZQIliS0ZbFx0i81EcIoeo0f?=
 =?us-ascii?Q?HTdxKp4V5hmCRqDRkZKYQ9/obmaeeVb04NONPkJCCO33DvLb6QQ0rAAyh8u7?=
 =?us-ascii?Q?bFQzY2QhOhheIcmFMiO3z2gz9zUyBT5aqdCrD2sCxwyuJxF9X6fdeUNKlezU?=
 =?us-ascii?Q?qQMzm8JGgWtHDEauP0p4KZKuXqG6etpJZMzgf8hasLeR7Y5dPjp8UiGjtZnm?=
 =?us-ascii?Q?bKbmw+7dIyKW/FqGZ3CojMqKrOwxbaYslo+liGtzAa08qXGJHGObYFkfqoM/?=
 =?us-ascii?Q?aLA/N2/+V9DLGQq0hgYO67Dauj33ndFJvPDw/Ojben07qSBY6JHi0PTGodpm?=
 =?us-ascii?Q?62ecHT+9r+9pxWvFs9xaXInq+iLi8pQKGSZdDFOi1pQMfRrf7BeVB8Pzkn/4?=
 =?us-ascii?Q?DU4mvHoLBsuMR/5xm8NPa/UCZo1r22FerRQJYjxyC1A1APpTDLV+aeMRqNXY?=
 =?us-ascii?Q?lbrFmSCWQGVK9T18QQBNLxlw3M5YJdywe79T/pfEvGWIk4pHFD4ZmMEpGjzu?=
 =?us-ascii?Q?1eUSwMBqNvigzq0Sb+FliXwdDQwtUzYA97086fLlXPzoDvp/6NE9lmbCONwT?=
 =?us-ascii?Q?yZPAYeQ/SfLgUYPosrNilC8UJRSur4onRdVRb/z7gBuVmN2ft29VG4KGMkpv?=
 =?us-ascii?Q?gyVFsUeejWFXsIumpVMBRLB4/Q93NEAv8ke9UIf35Yq7P3uZyKG2gtfOabHZ?=
 =?us-ascii?Q?4T4I4gwzvW2XsvIVwpqBCF9xDMnTW3hTkusSS0cBQl2gkY2hnQKg3Rw+okps?=
 =?us-ascii?Q?plUKp6qborz2ORIRfpzxfKSKaXObeaOWWra879hXimcqVYcQK2NiE1moly1L?=
 =?us-ascii?Q?pyf4A1uRXnh4fNazreeBm6Bl8zuKMMi5gE9lAFqkLl6WaQXXmEUdH2RyXOUz?=
 =?us-ascii?Q?3m4v8S/cQqLtUcZzdyP2tnn2617X548lbKeQJR91nxJc/qCmrO/qShZaJdTg?=
 =?us-ascii?Q?G6/3dOjIkq+yGk6egMgPJIdcYMIAxkR3m02aedfY07ILvzzJv7BY02Tl3k8O?=
 =?us-ascii?Q?4QrMvCfzdx+W8CJjdDd5mc9NGWsFNU2JspP8/YQxbly86QhCXLX2eWhGFh9T?=
 =?us-ascii?Q?cIEKJrRBP2kWt29LwuDJudFq99rBEiYgXd7FjjfVWRGVTCDOaNKw9y5hAzHM?=
 =?us-ascii?Q?gOLFTbTE9BWQeNC384HdW3Xm0ZUCxKO0LGzz/izZUD6EJTawAHByjkY9pIbX?=
 =?us-ascii?Q?W8S/N5lcXZ5dCvLBMUn/5AcqltKHpMEsNNVAN1yqTK77QHTRDaGn9Kty2Zf0?=
 =?us-ascii?Q?hAIOsxdkxohA9d0mVBRve7XZBGdkfoqRg4mRlUZTcKv6Hv/GDajhTBXABEQQ?=
 =?us-ascii?Q?RuqB6bRgu26QaDd7xAx309XsURrogUgFrsHlLTyyJmk3ptLsKyLHmRBZ2/tW?=
 =?us-ascii?Q?ZNbJV0PEAR7ZY8m56bt3/L0FTR+wjSE4x1A2wbm5Q09tkHhxlSr0z0feboDZ?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380d20ba-cc64-40c7-939e-08da9b11f1ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:11:00.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xvSyrny2iSLqCDHv8tP7PE7uwCkuosb81gLJJWnnDvgWcek6wMl/yklB6k/uuvml5bLWK+iB0U2vNKfwOZBdWviFZx67ALJW5juWkpP/1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=695
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200084
X-Proofpoint-ORIG-GUID: OtCDE3i3xrG9veuGgj8xMvPG4Rn0gIbW
X-Proofpoint-GUID: OtCDE3i3xrG9veuGgj8xMvPG4Rn0gIbW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steffen,

On Tue, Sep 20, 2022 at 07:54:43AM +0200, Steffen Klassert wrote:
> On Mon, Sep 19, 2022 at 09:47:11PM -0400, Daniel Jordan wrote:
> > On Tue, Sep 20, 2022 at 08:39:08AM +0800, eadavis@sina.com wrote:
> > > From: Edward Adam Davis <eadavis@sina.com>
> > > 
> > > On Mon, 19 Sep 2022 11:12:48 -0400, Daniel Jordan wrote:
> > > > Hi Edward,
> > > > 
> > > > On Mon, Sep 19, 2022 at 09:05:55AM +0800, eadavis@sina.com wrote:
> > > > > From: Edward Adam Davis <eadavis@sina.com>
> > > > > 
> > > > > Parallelized object serialization uses spin_unlock for unlocking a spin lock
> > > > > that was previously locked with spin_lock.
> > > > 
> > > > There's nothing unusual about that, though?
> > > > 
> > > > > This caused the following lockdep warning about an inconsistent lock
> > > > > state:
> > > > > 
> > > > >         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > > > 
> > > > Neither HARDIRQ-ON-W nor IN-HARDIRQ-W appear in the syzbot report, did
> > > > you mean SOFTIRQ-ON-W and IN-SOFTIRQ-W?
> > > Yes, I want say: inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > > > 
> > > > > We must use spin_lock_irqsave, because it is possible to trigger tipc 
> > > > > from an irq handler.
> > > > 
> > > > A softirq handler, not a hardirq handler.  I'd suggest using
> > > > spin_lock_bh() instead of _irqsave in your patch.
> > > I think _irqsave better than _bh, it can save the irq context, but _bh not, 
> > > and in tipc call trace contain SOFTIRQ-ON-W and IN-SOFTIRQ-W.
> > 
> > _irqsave saving the context is about handling nested hardirq disables.
> > It's not needed here since we don't need to care about disabling
> > hardirq.
> > 
> > _bh is for disabling softirq, a different context from hardirq.  We want
> > _bh here since the deadlock happens when a CPU takes the lock in both
> > task and softirq context.  padata uses _bh lock variants because it can
> > be called in softirq context but not hardirq.  Let's be consistent and
> > do it in this case too.
> 
> padata_do_serial is called with BHs off, so using spin_lock_bh should not
> fix anything here. I guess the problem is that we call padata_find_next
> after we enabled the BHs in padata_reorder.

Yeah, padata_do_serial can be called with BHs off, like in the tipc
stack, but there are also cases where BHs can be on, like lockdep said
here:

{SOFTIRQ-ON-W} state was registered at:
  ...
  padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
  ...

Line 392 is in _do_serial, not _reorder or _find_next.
