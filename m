Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6B5E535C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIUSwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIUSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:51:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD979AF95;
        Wed, 21 Sep 2022 11:51:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LIBBgi030322;
        Wed, 21 Sep 2022 18:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XQcYyLCcmQyAQNtZnxqDEpu66Qtd4Kmf8BlzsoXcick=;
 b=okKAhyAVPUIlweumwpgmbb7D8ARo+HfNlTzv2gTHhrO1QZ/Gwe+2UFxdVWUBAVoj2JWj
 aPmp+CD3nFuwTprQ87GiGFo4Y8/0CGBVx71TXO/P8+F/p4Ch+kW/xiVJ26N+acrgMjU7
 ADx/5clhFZHzd7bhIYEYgT1gzXq3dj0S5sz26lTQdCmsva/puls9qW9MxJco6gHiSR5P
 efR3Z30AWJHmLFtFHE76rewLZE+nDJNAzvWUB/8F39jivg4VGbkJFgMaXEYolWoRudu1
 SWq784mTm0SGgl9pw5MtIVh10GdJc43yMqBA6huK7LMaa5cqvMTFVj+zSY9OBdkpex8I Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688jwwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 18:51:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28LICCaJ009922;
        Wed, 21 Sep 2022 18:51:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3caf16r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 18:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cexDLvkohta7UW7YinVtz2krrDwfUTQUvJiNj13XQZVQQUFFUyLsz4hr/U7yHiKJtEzzF/n6qCFic8Ks4wmzinU6Habe5sMw6SKIFVogu36gcwxdT3n6T52MDjbQZ+YoK96v9yzv79ufd8OQicLQPcMzIRTpw2DZZWTv2bCL1HcCqaEXKBFql0Ru/snG+upTJlOahEKmiYtUGLPShlFuCJFkmg6qNuvFibQ0iGg4ThsjRm0DUVZLzd3XKH4jbMnrP7zrgB0UJY8EJLnRMyDzF77FpY33JnTGMLhu1lC3pD5rHvcykI0clTpnhxbgKW54HYAcY9EvyQJzG06cHDcZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQcYyLCcmQyAQNtZnxqDEpu66Qtd4Kmf8BlzsoXcick=;
 b=PcRjx2Cg7R9L2pMEt4LEBegoITFiSFwiaY3g+L1bX1GJ/V/4X1KdAVGKYYCr/9JbKISEuwr+n690sCOBncRSQOy/4fbdhQTABiljG3n5FT2faTuqr5JMysIUQXBTIM7vi/BAYha9BXcGEdTQxtTuJb8ticVSoFSnjU94E9BrOD8XwWBI8SV3Uxf/19ecwM717EGa8ia61oKUhAkuxqxSAIwGFgNorzRRBAptgmgFfd78QdKP1qfwHoirYEHr3K25TERTo94VK9EJv6oqNvGHQYA/x/pSZ7ay0sauP4UzMUFs0pBbEmSH6c5mzVqIiRApDzCAxJK+muJwEStS0h2z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQcYyLCcmQyAQNtZnxqDEpu66Qtd4Kmf8BlzsoXcick=;
 b=UVinQTcFaPoch1JlWa3H813aHJyBzNzRqC2yYQzEI/SrZw1BJCQ/XtfJ2ON/l1WVwKtf1mq17g/cvzFaO/VSZcDVbnlIx6N+WylqWgCXcWdpDJ4PdXZP/nz9QmpBg5U+qP25aheAmB5xPxfkTHHgLjxlEDsYTCp9wu+L/fVPaJU=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 18:51:42 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65%7]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 18:51:42 +0000
Date:   Wed, 21 Sep 2022 14:51:38 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     eadavis@sina.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220921185138.c6chlv77ugfrsukj@oracle.com>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
 <20220920014711.bvreurf4ex44w6oj@oracle.com>
 <20220920055443.GI2950045@gauss3.secunet.de>
 <20220920141057.cy54d5ukflrgay3a@oracle.com>
 <20220921073616.GZ2950045@gauss3.secunet.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921073616.GZ2950045@gauss3.secunet.de>
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: bb85bbba-38cd-4aa0-0afa-08da9c0252d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxmzfxCOGVBZ6kmHxswPIshm25/22OvxJ3syIjG+kPPugpwCxh3m5uaP3gG7cvOCtpug7ZrGGq7Eu08nLcUK/EXrRnGTPfbksgqfpV+kEY6PUKRcKNW9XgGi60En11/uU3zATRhEEJGO12Nt9TmQaWVmrLqbMl7mx/UC0cDJwskeLI8k3JPQuhjooY7vJnpkq45nGT6tmn5CuUAosrMybMW12lZh3yitLkzJi90neDY3KuzvG82nAX98AHZ7j3KQsAr5F+6vXofntyMZLkWnMUAZNk1uvo+s/XCVYzvMK7ny0+HKi8MWht+1QCug1VsZwbo3+/kV4uv13g1se6HXF19dCbGMHkpWshUNOYbCxKpUQbwKBc8xeT6WoL4P2Uua78RBtVssCVp8cbMWM7N6w8QMwGz/VIep5um3EW5M2hyppbtCqz6fxP5onVfuLT+sAOyrDNmsjnCXDMA8q6ORmG3cVAKVrNRjtEJy4AOaf9OZY8BopwfXVweQjTczsDXpBbt3lipBCQ0h4ijWJdfI4yQo67YEVCl6WbEmVh9jEfs5RWoavJKcjZ9pfTG2aRImQrNzB9+9KFBr0eT9GmOsc+SYE4MGITf4+shS+rvITBCxw+WRqkdSx7L+NAlK+AAZA8CVxBWTe/z371DEhF8OC96wM7iCT99QeuZSBYm4LwClHvziFpaT3JfGIYiQiGu0X/y1qzAKcWeiwyPMC2C3OVAADovPiKnh5ahqz+kX27EE6UwpqODFVWx7F/8WwhRj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(2906002)(36756003)(4326008)(66556008)(66476007)(83380400001)(38100700002)(38350700002)(8676002)(5660300002)(66946007)(6916009)(86362001)(316002)(41300700001)(8936002)(186003)(1076003)(2616005)(478600001)(6512007)(26005)(6506007)(6486002)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0eggLRn7bau+Bh39h7yAUC5NGJbfDXf56EBbnzZl4ADwbOV7xQcs37YXvxX?=
 =?us-ascii?Q?b5hAntuyCyZ1Nb67gxrcC4wepx5yb0dfOVr5Mjcz7k/bqiglUF/qu4FfOOwE?=
 =?us-ascii?Q?67Myw0eOED8xJDS709QibHHsAkd0ojCMcYrIeWY3o86eSacyD/peoow5FsHO?=
 =?us-ascii?Q?J3D6rk76eAb2kCkJIk1wtAwYZsajsoAOhQd0IHQ7n7IuhjLQ4MyLGBPwGVKO?=
 =?us-ascii?Q?o87YABJqJpj/qKTJAE4sFIitF/oewtu275zCy6LqKQtAXpLUHNHQ7GE505as?=
 =?us-ascii?Q?sahqWKYKTl3V3ZJisAzJHULt6hVHUeHUcn/3pHcUN92FmBI1xhe0rowhUHPH?=
 =?us-ascii?Q?O3+O4vQEsKn1MH0qC6KTQTOvZUFuxMyotnR5e2ZCB7EfnktMDJoI9IQS/ZSi?=
 =?us-ascii?Q?MbLbtGnTFdYwFMifh4lkyaPVBdXHi9nRfnyf9uqRioRnsyAfDeKF3s3bDFix?=
 =?us-ascii?Q?LkG8B6cKD+c6Srujh51wk0pNv34gzunK46vPT9M3/09eswGHPPYcyFo3fFpC?=
 =?us-ascii?Q?4JdwFJKENkE9MnMPvKjOwlW5Ie203WgX68yKeN/zpR+Wl8VPpGn9SODkzQVB?=
 =?us-ascii?Q?OwsUtF9O5EqrH4af+jXm+ZRuiy5Fr44MfaZOdaFpoIvXTcuR/Iiqa8zi8WSe?=
 =?us-ascii?Q?pM7deDz25KXvILx0M3nDSynbXE1s+oVCJ94CpXu6W0trpdRQxSJvbYYpNuJv?=
 =?us-ascii?Q?gTwDS8RncvnUFlM6bV4fSR0QPTABKitVSUwIpzqkU8H7bwwh8mV/+Gm7TI8n?=
 =?us-ascii?Q?Nd3oTtmC9cRd6gWHtnF0C5s7puMHbdz0bqzywN6k01rEc4wl281i0cWMN/sg?=
 =?us-ascii?Q?VaB+AkjcfRsPQGULMAhfolYpT+GFwRRPiQPtVmLkCFGL/cYsQj0Bw0aLWyGO?=
 =?us-ascii?Q?wPn+lW+rD4myfIqUVSoKonZuaNZdhm0OgixZy4qoPM5T40otaghv6jVDO+hi?=
 =?us-ascii?Q?pDbHXN1yvCJ0Zl+/zHP7Oq9V1BeeVEm+4UzknbfTV+0WjVaygAhfYFbkco8D?=
 =?us-ascii?Q?uF4Zbw97UI6oRZUz3i/WSyDMEej2jYdI5xvoXYaFGETPeLrp9uQseura3nNC?=
 =?us-ascii?Q?Pdu5ifySt2npMDpOLPjaVn0Bqkwz2nXevtoQICl2OaXjrpfQ00ZRO3a5vmgE?=
 =?us-ascii?Q?/9jpNFsGpYHzNfW98fbq7epZYwP1oI6mh4VbNglhEgTX6zx7dLHQPJzDqGJT?=
 =?us-ascii?Q?vJqZuAxdnXE4JsxMOTjGBxHiZCI5d5TaGHPWZ6Fhpg2ioqXOiObASPAHdjPk?=
 =?us-ascii?Q?KbjOsuXjmTm/hjj8/oY5A6M44V4IosP80fpyJCKamJ6sFUd9Yt4TryfOhuhh?=
 =?us-ascii?Q?zicCXsLPKLpxGBFWrn3tJ9pxUiRpAZhZrpxIqwAtqN+cSyNExgk8Kc+Fc6So?=
 =?us-ascii?Q?Dqq0LzosBJlU40j8sVFxCawdZQzFMhr9NpB66m0OyfWNhzY5HdlLQVSzWcgd?=
 =?us-ascii?Q?VJ7l9tKgXXdwzdIbSr+hTIiri91HlCoPHRQrC9J4V0aYE4ASEWHv92wKm+z2?=
 =?us-ascii?Q?BdOG5Zj2liu8menAhnOitHeL6xL2VSzkDFqwpt1vaHKnlG//CVcplL+RRnsS?=
 =?us-ascii?Q?uMPB6mrS8Phd+e+JX5y60oM7zIH8ua+VAnWoK4g8S0eOe2x/AFtBBlgfF/l0?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb85bbba-38cd-4aa0-0afa-08da9c0252d8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 18:51:42.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giMgrqAeVWyKEYwlRc0XF6efMB4cQLRev1t2mRvFngDENoo3BFyNlDrRDG6bPyvRTNJQtfmYdEml1oJlp3oEE+S2qUXdSexhnIPsa2RS1Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210126
X-Proofpoint-GUID: nOe2zmgZHZrVzM0qXWNEGewvrxrIUeml
X-Proofpoint-ORIG-GUID: nOe2zmgZHZrVzM0qXWNEGewvrxrIUeml
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 09:36:16AM +0200, Steffen Klassert wrote:
> On Tue, Sep 20, 2022 at 10:10:57AM -0400, Daniel Jordan wrote:
> > Yeah, padata_do_serial can be called with BHs off, like in the tipc
> > stack, but there are also cases where BHs can be on, like lockdep said
> > here:
> 
> padata_do_serial was designed to run with BHs off, it is a bug if it
> runs with BHs on. But I don't see a case where this can happen. The
> only user of padata_do_serial is pcrypt in its serialization callbacks
> (pcrypt_aead_enc, pcrypt_aead_dec) and the async crypto callback
> pcrypt_aead_done. pcrypt_aead_enc and pcrypt_aead_dec are issued via
> the padata_serial_worker with the padata->serial call. BHs are
> off here. The crypto callback also runs with BHs off.
> 
> What do I miss here?

Ugh.. this newer, buggy part of padata_do_parallel:

  /* Maximum works limit exceeded, run in the current task. */
  padata->parallel(padata);

This skips the usual path in padata_parallel_worker, which disables BHs.
They should be left off in the above case too.

What about this?

---8<---

Subject: [PATCH] padata: always leave BHs disabled when running ->parallel()

A deadlock can happen when an overloaded system runs ->parallel() in the
context of the current task:

    padata_do_parallel
      ->parallel()
        pcrypt_aead_enc/dec
          padata_do_serial
            spin_lock(&reorder->lock) // BHs still enabled
              <interrupt>
                ...
                  __do_softirq
                    ...
                      padata_do_serial
                        spin_lock(&reorder->lock)

It's a bug for BHs to be on in _do_serial as Steffen points out, so
ensure they're off in the "current task" case like they are in
padata_parallel_worker to avoid this situation.

Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
Fixes: 4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/padata.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e5819bb8bd1d..97f51e0c1776 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -207,14 +207,16 @@ int padata_do_parallel(struct padata_shell *ps,
 	pw = padata_work_alloc();
 	spin_unlock(&padata_works_lock);
 
+	if (!pw) {
+		/* Maximum works limit exceeded, run in the current task. */
+		padata->parallel(padata);
+	}
+
 	rcu_read_unlock_bh();
 
 	if (pw) {
 		padata_work_init(pw, padata_parallel_worker, padata, 0);
 		queue_work(pinst->parallel_wq, &pw->pw_work);
-	} else {
-		/* Maximum works limit exceeded, run in the current task. */
-		padata->parallel(padata);
 	}
 
 	return 0;
-- 
2.37.2

