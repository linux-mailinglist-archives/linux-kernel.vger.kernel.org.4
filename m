Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91567B3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjAYNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:53:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D016448F;
        Wed, 25 Jan 2023 05:53:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDjZTj005659;
        Wed, 25 Jan 2023 13:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JtEWRRXF9bY7zL6B82D9sgxD5Mh18wLFdmKZx+STp28=;
 b=hV5U2qzreNw9YnpGHArlitEN6/vki3xuLj9LOKH+TXeFvwP02UAfwaela6MVNokOKBd/
 jrQ/nfdNVkg4vT7/RxCxequCd9CdOz97HWlTejPzjmrGAzQJZIU/94r2/RvjG/s2I2PP
 d45WLsgsA2eJ5sd+DKtmZzu9HmkCdtJKhX3JhVLlpns5r5yAZI+puttCMEqMLDHuiwkn
 gIorNEPYcBW4dgJ4rXA7z0CyFYvRSA+YT4gukpHZ/ygfo+TuTvI/q9GV/B3Vv3ju6xsu
 SRkq6psqHvvM178mYHOj+72EUuKR5jBH8QRoORAQxoI01opitTt18IorQwgfOfz8aF2g 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcg196-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 13:53:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PDA9En019129;
        Wed, 25 Jan 2023 13:53:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gcv7a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 13:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coNbhndmfS++bqLZOnKbyVR7Z20nvvaN4a8yzAN4R/GZAhThLlaa3DOz9iOzcMAusxr98Bi6MN+CcQ72pJ9XC0Tgyl91LMjgpfrS0gQi0HEn3lH4w5ucSgb4l6qzstHiWHeXl5ToIRsa0pD+HDpvj4Q4C9l3tcs+HiThqJ1x4pWXz1l0ApMjpbR+esUiYuPnFc7HhzCnab+sWlSz0gA+zjgBQBespmkMoP7ZBzkORldRx0g7EQYnJ0jw6tozhhGQ6bSNEwtRFxJhgEvW5e65DOFcUkwTs8IB0gltlAmyctdM7dSi5DDa1LQi7SUIGCcbk19qaRC3cJEEZzRG0l0y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtEWRRXF9bY7zL6B82D9sgxD5Mh18wLFdmKZx+STp28=;
 b=k/UengXMuIfhiVMRjHDdj0PCehjB3t9EnUD5KxkLCmEW1O9lMl41exzJAT0QVf5zJrSy9miPWOOYUSSxfQdPA71qXc+r1e+ZctarLS9L8cfBsaXleSJqEfvbDkkoG0G5cK5MBuPn+dKpIOYCS8mL1sGmGC4tMxpye4ovbHaUiB8DbhkADvROjXjlwurIu7aalxYhbH4gZNnFoO9sPWfqoMHum8Z8Jr578gb090KaaksyQRsg9D7BiviYGmxuf1tYkYfgdYVULmZgqrzobNNGz8UQ3PXTtfIBJIKjDLAWOji4DK7N6nqPO7rP9dn0WOX89mh9RdJpo+fMbSa8q2FB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtEWRRXF9bY7zL6B82D9sgxD5Mh18wLFdmKZx+STp28=;
 b=dfiR1b6TRGMbTNEfQRxPmOreD+2y9cxYXijrB8nsX31yZfaP+E9btoGkWQ0GfAYFlwll6JJ99Aui+JEqO1jdbdPWmhE2CzEjci0BJsEpVMfKqVwhae7cs+hz391L1xNFzOC0le5JYaURCf99Bd+46ArMkwFQuxSgvhOGW641ZOA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4487.namprd10.prod.outlook.com (2603:10b6:510:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 13:53:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 13:53:27 +0000
Date:   Wed, 25 Jan 2023 08:53:24 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 15/49] ipc/shm: Use the vma iterator for munmap calls
Message-ID: <20230125134558.mm3dopfa7cxqux5h@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-s390@vger.kernel.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-16-Liam.Howlett@oracle.com>
 <yt9dh6wec21a.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dh6wec21a.fsf@linux.ibm.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 6223306f-d9ed-4ef8-c7b5-08dafedb888e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5186MxEfuTLMANebomziJZDKbHGLJ++3aMBsMmqgxN9rJN3u65PyM2wIkL7xU7y6zkHVzsFPGSwCN2EgQkOKstqXNjcmaiGRs4AGtmafZrVcwDbR9LKvhP8GMOFkLpjVaN9OBUf7o2s2ePnyaDkOVM0ILPXOp9A4kSRPjdv9/k9Vc3VAGwqeJ/auKEc4wsGNd6cTlePp8BxNipLPno+DDgyM0r9Hz44Kdaqd94YyHW1WTIkx69pGqsYCMMiKqRXNKE8m6535I2E9juI5kFciZQJ2RxQOTemGHWVERpnWKyjzOss46clC8b1O2v+Pntc9WfIu/zpZJm4ROpWBnWU0AOQJKdyFuuosrAj8OErTrbMxL0h1t4qJlvh/vLnRehStEt5HtF5eaa48FTYUEQyExsZi6D5B4Yi5rB8C+qjyLOK7EUKjGrx399qBahurTIbb4JxBt/De0gDktR2KZI3bjN6g11en4KyLHtt6mc4yQpp1uNLmiL/rCQnXckYYzx/Xcy5t3Vvlakry9TQLTsPbs6p99OV6+4EbWPEKVUdQhwoe+ItBdR0cZJ8xg0cl7m51/B7V40fHtWdjxEBx4Fqls3XJsGPr1nHntZcKAcAW6wXnfGFfEuwtyGNwdwZ+P1zb5uuwEIxT8f66PcFsMVJQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(2906002)(38100700002)(26005)(6506007)(186003)(9686003)(478600001)(6666004)(1076003)(83380400001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(33716001)(8936002)(41300700001)(86362001)(6512007)(6486002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eIGQdTGsSttPWImOj6bprnLNFFvqdhXSlUuMoPJPxmkHc1s5peC/9RzPD0bU?=
 =?us-ascii?Q?UbwEOw3FmLFClKQqKliSL+HzTGxU2tpCTKnjnTV7T3C2FOok8YXW/+3r7Jyq?=
 =?us-ascii?Q?dT5+DU6lEBeltaWAw8hITKW1ZapzETCTv6HFlgIePnskcvbW+Vwf3SvMgxkn?=
 =?us-ascii?Q?Qm/pwVG6cQA139PC00Zf3Gk2OO6oic5KOd/iUVHtjm6u5Nctbeh+Pn9aGQEd?=
 =?us-ascii?Q?GYCHE6his9fkOuxVUImua1U2LS2VAb8wUcQvRBKU4flNo0ReQq06Q9mMOFjm?=
 =?us-ascii?Q?uSNeEzwNetdBO+nqGLGjTXbN6bhzACcy3JwTNhTst0vXf0l+90oqKfZBxmAZ?=
 =?us-ascii?Q?2ZsGGz4ymrqVPqBHj7is3Q6OWvBmBlhfI7gN+9pqCBybv159lkMUy2tglzkk?=
 =?us-ascii?Q?6NTyNpx7uSb00Unken3uupqDYNe0IcBK5Yai+d4giAAyFhy0w96b5qVu7JWt?=
 =?us-ascii?Q?9ZSZV3uBo5ufiJaX4I+73VFndX/F4wB4rti/yPnHdYiuhTyYqCJa1PXPpSK4?=
 =?us-ascii?Q?Dss+Ku5bVfCkFDXhFj69y0eLHSH0DP1vpSMNIUUqYtAlR6iDvncxJcrXkRDR?=
 =?us-ascii?Q?/uZ/0jIkz2FtP0HBfwvk1RoVFT8OT1M7YFGZsFBBlZ2NCtbp63yDjvnX/xMW?=
 =?us-ascii?Q?S+cCxxLdLMs5i9d/qXW7PJTPqNs3uPX4Cu0mZ/ec2ya7pqpKu/dwpMOi+m2L?=
 =?us-ascii?Q?dBkCtC/KJSSUF7PVhyUid4F0lm2tj9pOSyJTvzTCrH5MNZ25E3P9yR8qeh/y?=
 =?us-ascii?Q?WoXP6MYF4sX8owbvBMnaMwbYC1jXYSo3AM03FGdvscXOxN2+l1ADjh35VCWw?=
 =?us-ascii?Q?3bU/+iFQcXk0b7LUeWAtopLwML/2i4wBZzjeI3Z+gicSmvOxW/DwPDLEvX2j?=
 =?us-ascii?Q?THX8M+b8xSlSK8LoEE+Q4e9A+HfZbAJh9UlroOm++QV7W0HIIywqRIcN6aL8?=
 =?us-ascii?Q?34DgXTB88xszJu4RXnQ3F3uJuEkbB9rXZfwedHD+uUCc8+v+0YyDqMu5LRNC?=
 =?us-ascii?Q?aoCEibKq1sGqgSuC4m5Dr3lwySBvhG3UaHvRKxzS4tLiF4mCgvNgvOjZKEpu?=
 =?us-ascii?Q?VEk/38wSFuzxFr9SbNwfqm9kFP1rtW62ZdicExtRVaxDL9hZo2EtYaO90IzL?=
 =?us-ascii?Q?VuItMkYnqjboH4fQ3CdcPUo/PL3wrmLsZ5GY/u6ExJ1dOoZoGEljpnSUrriW?=
 =?us-ascii?Q?TPnNy5D+RwvSP7HtYdPB56WBuCH8g+VewHUF1FBXXwJNSz0uwKr0hnV5jmYQ?=
 =?us-ascii?Q?5gl8fFwv2wcZ+vxvXAzrVRBRi85BZJjm0C3pLIDmab1zJfZgS2J3RjwI4TnE?=
 =?us-ascii?Q?h309HD/du1Oak7wbTc0GOqHqIJemZXIj1sEJBOdJlecp/oPoH/rj7cyVyBYP?=
 =?us-ascii?Q?6dCjtFOdDCl7A+bRv9VDSGfJ5QoHZTxSWdg8Fn9b0BG8kjMmywKk2jUK52uA?=
 =?us-ascii?Q?2XIcav0ukmO10FiccIgvYWtyjqRWQBPaNkZVk0eli4ldEha6C+Vnkkq05cEs?=
 =?us-ascii?Q?58/zactv2r1OiAuNW/Pzle6nUeMFZBMBvw7JC5xrx3qxb/cmvKmQhgmFVren?=
 =?us-ascii?Q?hRP4LXUKzJWIVjh48brTnn+oQP1rPu43TExpQ6lTRJa1+2usXLQu7ng1QWb9?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4CZssZdL8QacIkvgcAv9o1rScaLAl/9f75+rtpxcySZ86Eav7Ros8JK0RVbQ?=
 =?us-ascii?Q?v04q5IRGKWIQfsd5kuZiTDdd2I3wzwv9TRCZtPtrCvhqgI1s74YGdO7/W8vy?=
 =?us-ascii?Q?t7nrfRWC10Goa7hOdp+1YXhc4UOzD75JSZTMJ+inRP9qH5sY5oMz+mP8X4BU?=
 =?us-ascii?Q?zcGtTexhswFvqCK2YZTXxDgzOg3/vrmWgaUKQSKdbTzNHHGRRerK/jlKnz+O?=
 =?us-ascii?Q?fVYr7w6XkGoxBPRIi921tbIbv1XD+w1ws4GLOXksrnwa03ysahqedwfQdEME?=
 =?us-ascii?Q?pQWSiG53Ck+NfbCJegG/FgzyIojc/VYqLyuvRfp5F/RT8Zg9RGLG4Nbh9WbQ?=
 =?us-ascii?Q?O20qIfHqc5vcHyEE+1FRObL37m+X09oRrp5dHWEbpOArlDi79xWVjBCOouE4?=
 =?us-ascii?Q?wdIxIK+zwymYKkfKINUyVWYo2M1yPP+I0/nwwBt4Ccdq6jZXDy46lG9Qa2s9?=
 =?us-ascii?Q?CpuK1IYcn866t4AkpQFPKKGusYAQs7W3gaE80UkXRmvsPlA+DwColAQu/ONK?=
 =?us-ascii?Q?Mz35IAZ+v4OvreHA+FYLIOax7Ywy/bP0jga8MUmXa7urbMpHy9d4ylkBTCb3?=
 =?us-ascii?Q?Dvxzkr71FAa9K8IavWjXmP2v4dk+Q1ULaWyoPOm3sSd+qESui2vauAKEMLbA?=
 =?us-ascii?Q?xnv81aJeYj7B2pJtajv53S5MfqVEdkZM/N9iCsjgb0mOOhLnu4SfBP4cH0mc?=
 =?us-ascii?Q?rjwwJ0ibEvSGX+ZZZJ0gCs+NWN3AOFH0i6q9cK8H7/YwRA4wisUF1PTCWiEY?=
 =?us-ascii?Q?FlRfemmAtFemkBU9LhXWQDfvWKLU7YOVWOoGFQRAj4+h8RyeyvanizN09Ta3?=
 =?us-ascii?Q?zCtntIVs7Ou8vb0890Eb3Xm3K3Ppl+eokLX8qaVIgniDsxCa38QjeudV6vJy?=
 =?us-ascii?Q?FDbe5qMec2/xO9p/brl1uBav5f5Zc1nxBJCBF5L6ankuHMphcK+62reEhRcw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6223306f-d9ed-4ef8-c7b5-08dafedb888e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 13:53:26.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Acn8r4wqt6V+RgK9/kxoXD6BMvpesfxlUrH1rWzNdjtiNSDJO+ZOTmJVsTwLrcUibeDayq5ACI2eIjIEHPO30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250124
X-Proofpoint-GUID: Txn8jwZDvPGkKT8ilawF-yN1aof5lB-W
X-Proofpoint-ORIG-GUID: Txn8jwZDvPGkKT8ilawF-yN1aof5lB-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [230125 06:00]:
> Hi Liam,
> 
> "Liam R. Howlett" <Liam.Howlett@oracle.com> writes:
> 
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Pass through the vma iterator to do_vmi_munmap() to handle the iterator
> > state internally
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  ipc/shm.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> git bisect says this breaks the shm* testcase in ltp on (at least) s390:
> 
> # ./test.sh
> tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
> shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
> shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)
> shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)
> shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)
> 
> Summary:
> passed   1
> failed   3
> broken   0
> skipped  0
> warnings 0
> 
> #
> 
> Can you take a look? Thanks!
> 
> reverting the above commit fixes the issue.

Thanks for testing this and letting me know.

I'll have a look.

Regards,
Liam
