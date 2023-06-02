Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95E720808
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjFBRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:00:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8018D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:00:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CnUO3023124;
        Fri, 2 Jun 2023 16:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RCQ1zrtPG1Qy/nFY2lwKdkqyuy0ROADmAMcddFZaBrM=;
 b=CIigDuTRFLSzCYTTgwAbGXSrt0Z8D3+iGiR1sF/xtGUnsATJv5SftFHHR7OHQCi0afgI
 dhLiokvRbbGvOKC6aAiXu07LZ/GmO0VJcbUQJfZxDNBRNQLS9A62RzQKYRgi/0oMMYCL
 XhnNBeOT8zqWZ+mjRbHvbRFc93KbN3b9Q6WmZ149SakQ5f5Cf+6UHK02y1IKhYMR3u6w
 dlQ9dRh2FNL8Vh5JUvIsb18cSQbcPyhnCf1MRx/pkuJv0YHAs5kRSgwWeNxgF7WakN5M
 8RQRsncwL9sFNG8TlQcnBpVfxsYmpo0t8Qsth5p4FQGdeXbzF8iY+juCxpZGwQZVeTs5 RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjhbdmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:59:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352G3a4c004703;
        Fri, 2 Jun 2023 16:59:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8afd1x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgQP1XsEqU+7+0SH5fNpqzg96CEhde+vpDrrTABPAQFDTt84fLEKBEu/4jWQ5oBokI7Pp2cPo1dzUOGsxI4EiDt74uMIYlcrkexq0zgFF0aj0Roo3EXogTGPBRXxcEzuVK6oI7X3GxyhK+64VjzR5R3ck1ToV0w7jrHpdlKY68o1/enOvojI7b5pmrOIingxw7vd2hHjRpv2XGiH0l8GsafGm2JHpn3dYkrqSxz6kH21CvBAfym6RLEaJxzytlxRdVSs5MYFgQV7jlNyL6bFPLl+h6Ewm4Jjro3KdRfMh5QonKm3y9B77Spf1mO2T0M9IT1iT4yQc2FD5fTdYDYQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCQ1zrtPG1Qy/nFY2lwKdkqyuy0ROADmAMcddFZaBrM=;
 b=MUzo2yL00R1JZ621NTwWklAv1iVbzW9tQIYQpwxGJB1Bi/h53td2VSFuhDzryNMIQfEXYeQKjsDyk1ZX18EWl/vY9FkjhHcuqDtLymeZGL0cd0IfkR43jq9TAaCOvG3C3HzI3EglbQZTQxSb895RslBqC8M0oym6EOzYHkUcx9NcxKDusjy3ybjG9WvNvi9qI1sP6XM60CU1rjN/CaQILyOYxSW2AY7GQX1sEGeb8sCRnp6WWZKGZMkgWDHbh/c3pmbKIPuunPHJ/PV48pQQ8JYb1tZBE12JgUaLlZsvHqCb+cGPtTNVzdX2t+ufzFRXW41/UezFB1/zrPed21/zRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCQ1zrtPG1Qy/nFY2lwKdkqyuy0ROADmAMcddFZaBrM=;
 b=iEz9e6lO1v0VDhVpQWQ21sCuOuuE0u4F4RrEGefqgrDr509xEmPz8MRdG2hjD6K0v80bt86l2rKDuT+t8sVS7QMolRO86PgEi+4iZCUd9BvEiAT6cWO/TB2zAHb+lquSQFOGzeTo8fn1bUMhNzU5jonTtZ1Mq7SJz4TJ0pNzh3g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Fri, 2 Jun
 2023 16:59:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:59:46 +0000
Date:   Fri, 2 Jun 2023 12:59:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: optimize mas_wr_append(), also improve
 duplicating VMAs
Message-ID: <20230602165944.3fsu6w5um232j77x@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0477.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d7ce48-416a-4eab-06e1-08db638ac4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQhL9EZrkMCqJuHL2C8GY6bUZgk5W/yy9AHOAU8KDNhMbP/mQIicsz9112EFOQtTcVpNTU0fEBa8uBFRxH5/gDDuNaPc0v70G1qNm5lQwzySqH2vqc0ZS0a63/98zO+XM/dUosQdKxP+0Xlzww/sr3egNGLzZ8OKhOybZLqCbZ2ne1vvekM7BfCCX31c/aMeMWDIB9uIN7OFQQtSApthx0g++2Jw1ZDwFmqk8Z28CVIGECWXzUa2Wt3eYA/LyuUldrG0qnNPazeovBys092bx98UAbZbAI2AhQjvVMxGI4hckBW7y8JhjUL/FCj0RjRyLzPzSlHMg6hV96nKz5QFDUcsknyzaLKlLdahxUEwOWltuB3zS7lfPzhS98SPM0YY6v69h4/Avg+SVVeB/8vQ6qT4bQnWUmVbZis6RCQguDWjnrTtof4waRj4DL0KfIU1/Tsyu2ArLsstcY9hVsMtpuYzaigHwAOfq8HGSFGBRvYyADp4u8PwPGKiB2Ldm4ZYaUxzx9RNqE1AsdGCBFsynyDzPxzxydzXgaTP3cWVPg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(38100700002)(66476007)(4326008)(66946007)(6916009)(66556008)(83380400001)(5660300002)(41300700001)(86362001)(186003)(8936002)(8676002)(6486002)(966005)(33716001)(2906002)(316002)(6512007)(6506007)(26005)(1076003)(478600001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4PdVnE3CEWwk7Spyo+aWs/dLldKEKns/EHbhXIrucUI4NexPXQh5+FmxN5T?=
 =?us-ascii?Q?9XSMIq21+YI20DavjkC8f7EJn0rY9yQLHrQqpzGHol1jrCJlyFl7xrxy7bfT?=
 =?us-ascii?Q?knPNXKLPuGOb0C78dz9lwmPG28Nuilu8oaffDNFZOjnNc7p7HNJlm0Ds+fCY?=
 =?us-ascii?Q?hhx6TCtnr3wu7NQ6sTe1yJm03Cx7A0Hnj4KJFMgZAKjgCxhOzAmvNdjTK7tq?=
 =?us-ascii?Q?xNzfJ2CBnvZgUobJqh4GG8o9rmZo+fCOXdd807oOeunjEWKdLGpKEUC7sjgP?=
 =?us-ascii?Q?Ufccpiwkra91SCEnOL0/DZTrn4ICAvS2KG40Uh3Y77TgINOktd2Ql+bw+/kO?=
 =?us-ascii?Q?BdjoP1s8Ums5REv5msGGZXTCmsKLMMmq9qPrkay0RfyomMFmK6FcDyciccGV?=
 =?us-ascii?Q?6O1zYhIoEwXijrzv4ROKL+99CWs2hgvh9zSQwZzNDs3b8IrFsKkcqghBckFd?=
 =?us-ascii?Q?WzMUc/8jiMIczVKs275K3Hb2+Cy+C2htwnTR9h5L2tEMz7nN8t7maoJvbW7+?=
 =?us-ascii?Q?6A0kq/RIestkSMzCIHbM81nRcMJgMfSAQ4QeDVNpoLsWbgW8+trqIwtwANpE?=
 =?us-ascii?Q?urDqbVEX5KBPWbsmAbv1mGsFcx3siBcScbbDlQVobsZW2V80hRJAjCcqWcJy?=
 =?us-ascii?Q?qPAHYTO3yd5nATtfb8eUMOapzRNTNNBv8XMO8M6VahIMPP85BfXcBxCvYuQy?=
 =?us-ascii?Q?0qh6w6lf/7+QZC3yh0C1TSp8Axm1QkfRn945fnwNL+0E/1aGD4YJNBs1tN9H?=
 =?us-ascii?Q?rtCiRiW+uOMCCKT5yphB8dbnhEFCtKRNLFJPCxmwj12bm4HNTmprmVhxO5tj?=
 =?us-ascii?Q?JWVjFi/GHWM0Bo2r0qUsowV/8e7bdz8BC2BvTi8Zsj2J2ZEvKuIHZB5i2t8U?=
 =?us-ascii?Q?L8C+6Vhn8om9oNrvWP+PetA2YxXlsN6XBTmB+GBpiAOWSg+BRuVJAIEv8Glp?=
 =?us-ascii?Q?8Lfja9TX/5ng1rOUCJqyyM5VYlcLlLuMRiAz/ZlNvV07bUqTn5cyk4fFbtuz?=
 =?us-ascii?Q?4o6hwWzHuYmr3OhpF/76sY9kdy+TNbhHUPmW8YbxywwpmiWYk+K3zntcxNMf?=
 =?us-ascii?Q?HfJURxwyW7JxSncJRnVdtTxdY9mpvM17XUwY0RkMD8JsBWv+IJDbqCg+qnjC?=
 =?us-ascii?Q?dg/HDJp72Y53qNaVTHol9J55hf1L0iwZYAGdkMUqxIl81D9q0YOqd+N3kz8d?=
 =?us-ascii?Q?zdJIIXQi/q6JZmCdaOCllZsHgTLVMWdvRnSD2C4DASLLuVmHRBwdiEYOWrh2?=
 =?us-ascii?Q?LgbBhFflu2Om7ajQ80MZ3t+rKFIS2qHUj9030H7wy8v8Aof3kqB0KVSOpKEh?=
 =?us-ascii?Q?2jaHdJg5MVtiqkbuGZl9GxgWwN0ibs4TjH1yvQqUL28lDxRrSgkwKOYk6fAt?=
 =?us-ascii?Q?1DWZvYYYMSIor1ZG3xwIBoCOLjLy5hNP/E2qhG4CXSGNPcZRf6IaQdqDVZyp?=
 =?us-ascii?Q?D3nR/CSSPfFKilu6GH353iMnrVG2kHwSR3b0zsrk0aBrxzAJWoP8z/cujLBc?=
 =?us-ascii?Q?eMoz3auRpEkl1cC/PGJh4gF7+LOu/89Ob3MEg3Zig+2H0opHVYvre/KSHuoz?=
 =?us-ascii?Q?KnXgljyx1vbjT54JtRDpo+s8XUJL8yruDovFML6sGBHCDsYgcGnCnR+mBHgs?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?k+uQI/br4GZHP+1sbz9gX2Fhf08cpFR/9qCpvv4lDXx8wRdzEUK0ny3kz4YX?=
 =?us-ascii?Q?5ZA6R29HyhshyLX1bRuoeSV4NIByKdUzvbtvHnjEGuCcsQKyoAm6QBXkpADr?=
 =?us-ascii?Q?GL+KYRj9UXGmry6ikZ7UdqTXSOuI8YmqU5YgKLtViE/kDqpskfV1leenhJ5d?=
 =?us-ascii?Q?WxyE6Vv5kZTkFQw+Vu1qpEwUzr/Eune6DV9KdXkuVShP6qzLFz4mxmWveLDw?=
 =?us-ascii?Q?mVVZl8qA4H9UXY6Ir74YHvfP4vX4ueUAk9OU3laF18S4ycc8cd6SqKrIRPwR?=
 =?us-ascii?Q?0POp/LHURodorWeorT52KhoQrHjIpXEYTxZi0T4ybPFmyiD7syTY3nA/+tfg?=
 =?us-ascii?Q?0cnZuXwYAczUGNxLvjE6jZ84V1T/gd4zodhmvYlAL5afwTLAPIrJATaUOB3k?=
 =?us-ascii?Q?8xwsML8kayayFp0nZui4EiJ1L4RSQDFvug/XF7MbOIhkZUGC1i97TbIiedxl?=
 =?us-ascii?Q?ZvTAhoeEw841lRh5lXgS9XVhv8OUU/GZXE9cWkrLvh05Vbc7Juw+80jGcF/y?=
 =?us-ascii?Q?ttpOvwiV7U5OQCBxxhfoEpUBgxLPtx73hGpd29BBtZJuPJzMMaEfWnq1+Ex0?=
 =?us-ascii?Q?6bc3plttt68KirPcl6f07VgWv0/0rpGDroiTPjntZbQo2fWrwLSgPsj5M1Nt?=
 =?us-ascii?Q?DfSweHMQlWBJZFeHHYq+b59/m93dbWFDtR0wPk9v4v15R84U3ZyIKlp/ua1x?=
 =?us-ascii?Q?X6Bjl/+QHTtvh62thnG5c1i/MhkZLKdwZA9Qjanum8qYgGFKerDc/mGIjdIz?=
 =?us-ascii?Q?s12KW43YiMwDc1tc3F0DHU5rOTq9dtlZ74ZDeZPCZERUTzzabZDdaGB3fsbg?=
 =?us-ascii?Q?lp5Xit37tuWgiteOKpjNKz0xCthXfbrgCXj+EaMrej4BevVC3OmhX0FxvXkx?=
 =?us-ascii?Q?nBOLnrg3Trj+Hj4dAs5TpYaKa11y4qbz3ML7AeNCRSUra9AIcWvMHvdnR/Gt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d7ce48-416a-4eab-06e1-08db638ac4ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:59:46.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eMsN5h9N4bmpckZQwZINViJSle/FoOM3s9yALn/ox6iOCmEXmxYCuqkSZ0MU5e2OtmPZoXcUF3tOZR38DSHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020129
X-Proofpoint-GUID: VjjArOUUbhYz85-8veljbRM7S8TlsazL
X-Proofpoint-ORIG-GUID: VjjArOUUbhYz85-8veljbRM7S8TlsazL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230602 03:54]:
> When the new range can be completely covered by the original last range
> without touching the boundaries on both sides, two new entries can be
> appended to the end as a fast path. We update the original last pivot at
> the end, and the newly appended two entries will not be accessed before
> this, so it is also safe in RCU mode.
> 
> This is useful for sequential insertion, which is what we do in
> dup_mmap(). Enabling BENCH_FORK in test_maple_tree and just running
> bench_forking() gives the following time-consuming numbers:
> 
> before:               after:
> 17,874.83 msec        15,738.38 msec
> 
> It shows about a 12% performance improvement for duplicating VMAs.

byte-unixbench [1] has a 'spawn' benchmark for forking, it's not perfect as
the number of VMAs is rather low (21 VMAs).  So we're talking about a
height 2 tree with 2 nodes - basically one of the worst scenarios and
highly unlikely.  We're going to over-allocate nodes and return most of
them, we're going to balance to the left and have to rebalance as well.
For comparison, even cat /proc/self/maps returns 24 VMAs.

Anyways, with your change I see an average (over 4 runs) 2.1%
improvement on this benchmark.  This will obviously scale up with the
VMA count, so it is promising.

Another user of many forks is kernel builds, so we should try an mmtests
run on the kernbuild benchmark.

[1] https://github.com/kdlucas/byte-unixbench

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by:Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7dd54afe66ed..cfd9fad308a2 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4199,10 +4199,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>   *
>   * Return: True if appended, false otherwise
>   */
> -static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
> +static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
> +				 unsigned char new_end)
>  {
>  	unsigned char end = wr_mas->node_end;
> -	unsigned char new_end = end + 1;
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char node_pivots = mt_pivots[wr_mas->type];
>  
> @@ -4214,16 +4214,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
>  	}
>  
> -	if (mas->last == wr_mas->r_max) {
> -		/* Append to end of range */
> -		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
> -		wr_mas->pivots[end] = mas->index - 1;
> -		mas->offset = new_end;
> +	if (new_end == wr_mas->node_end + 1) {
> +		if (mas->last == wr_mas->r_max) {
> +			/* Append to end of range */
> +			rcu_assign_pointer(wr_mas->slots[new_end],
> +					   wr_mas->entry);
> +			wr_mas->pivots[end] = mas->index - 1;
> +			mas->offset = new_end;
> +		} else {
> +			/* Append to start of range */
> +			rcu_assign_pointer(wr_mas->slots[new_end],
> +					   wr_mas->content);
> +			wr_mas->pivots[end] = mas->last;
> +			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> +		}
>  	} else {
> -		/* Append to start of range */
> +		/* Append to the range without touching any boundaries. */
>  		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
> -		wr_mas->pivots[end] = mas->last;
> -		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> +		wr_mas->pivots[end + 1] = mas->last;
> +		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
> +		wr_mas->pivots[end] = mas->index - 1;
> +		mas->offset = end + 1;
>  	}
>  
>  	if (!wr_mas->content || !wr_mas->entry)
> @@ -4270,7 +4281,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  		goto slow_path;
>  
>  	/* Attempt to append */
> -	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
> +	if (mas_wr_append(wr_mas, new_end))
>  		return;
>  
>  	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
> -- 
> 2.20.1
> 
