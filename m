Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCA6D71AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjDEAtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDEAtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:49:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0619C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:49:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KosIP024544;
        Wed, 5 Apr 2023 00:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=IPQr/q+GPYC84cZqJuTXQXQBFzyLK5dlDmMmm1QRVy4=;
 b=hNRB5ioCvrEI2G8wwSExaNwWYhfqbdaMtZeaBeEDH2dHlf1qm6sTfZ0gAEOQ6gM39wvk
 +2zeIg4NXiqKTNvwM7TUi7VOdQS+skpmCKHtxjP81fT9j3v+x8yP86DXrirbFybS9g0g
 giyp+FlMLD1oCRZB8eiXUDbhO65P4ft4FspryTvkX3/98cmvgwrXu2nueJk9qCsRpb8d
 B4Ka28BS1cYV9MNBPhcD9iD9/XxpkVb/S8rYqfsZOIiYI+i1RC0NHaiI6Etjh5xDpZCg
 xPUjDlDBQlfNNWOqRgM9XeBAVWSRDmjsZtGqQbaUd6E2x9wbor55+nwGZ7J/mcnPp0da 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgaq68f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 00:49:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334MkW0J037964;
        Wed, 5 Apr 2023 00:49:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjswk3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 00:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuIPJkGdhs8/t3Hql8u6WDjZ3EX2YDzEDRLAdnXNxa40xuCc9xoX1umnN4r1ROv/fxQAgvL8M1MIBe345ynSM8U82ZIlibW1UaMicpYOGZwrTfOaVF47TUss4n/22GStyWdSmBYCUk83eu63xw6HOSTwdutHbqLr97MbJdC1aQAF77G+BAWOD5l9QjsMqnXiwnnKdRhpApndTGMz715R+ciHi0iJvbaU7SyFl/t+9uokJRQvsuvqFVdpiy5xOjzTQEV5b0VCZ3QbtQDOKc63pVK/M2a23wWwuM449oaK6gOA2P+dBouVIeKZOL8hKvtLLWWXUluzvR6RuvjVF75Cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPQr/q+GPYC84cZqJuTXQXQBFzyLK5dlDmMmm1QRVy4=;
 b=fVdLJg1zXWqvv755tWavFwniCOHv7KlwdUanIbY41pGJJkvOBmxA+jZfiGP/VOWIi/ZO3U53Rs9shombwdrDrVg2WVmdL3AQNp4LKJhLjvHy7ZmQxjkjHvk8WD2eVsvvnWhTzfPJMw29EXihFu5DchvwvrbfxOESa4Wk/lUwkgKTlux0WfoiOKq3KTY/RYqSWJDZWt0Ko2e93/z/lq2HQVKCD4/zUSl+E0PH8TFNRgSd/0FsFcWxwn1n3+kYWGVHBgvsi87qpE7wBeto90NOtDMICjRm96iHxmWEWc1r9RV0W7SjF5fbP8/VOY109lwi3bA82hZ8/tED1CPXGJrpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPQr/q+GPYC84cZqJuTXQXQBFzyLK5dlDmMmm1QRVy4=;
 b=RG2neMthmGT9ds8scFdYj6QtNhUpcbf5AaYx0/+xQ/J4mCkk2JTR77Dh7cnEg2J0yne+DSilYESKH8GEa+3ZvwL1FpMJ06j7e+bKSxU23ufikVMjjE3ZeekQH8F4+P76PpXnalAaOHHDpRMQ42NKltoA5h2iAB9xYX6CXF3Ygzs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 00:49:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 00:49:25 +0000
Date:   Tue, 4 Apr 2023 20:49:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Some fixes and cleanup for maple tree.
Message-ID: <20230405004920.apjshy4khofipqr4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
 <20230404132702.9240f3a77d0c00fca4b9bf55@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404132702.9240f3a77d0c00fca4b9bf55@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c95f29c-9990-45dc-92ee-08db356f999d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jB5GFC15jP7TSpB0jtCAx9b2lWwRkQirLvEnXAmsz3yHvgG6rNG26dvsaORwLOkr0ucZJ4B2uit54Ab/YB85ITK9qhtmEqkVa1oaufL0isI8eguF0wgiCmFK2GIwR6Ccga/TfAIplxvVOOaAk/MV+BDf2vtrkoOX/WpHhja4Js2Bnm9W5Xr4dw+RmbWv5QiFcoRiMXlLzyXuZzMueHMX1ffA8ivfdUCSAT4w8T4z9oHqqKYqZKwEiFDNIEc+6rDg7AUiORCjge5UCM4wAi0sHI/Ha0WlJBUalI5v/xqkr6waQYiJqL/oFGIWn293mOcd8ByfTya5sdmDlbZsS8dwnzRqcv2l5uXp8R+DkawTWpaQz4IjGhzjovROvVLvntF1rRkD2ofkUio7rRU17bxRMc0Cj2LINtEGqfdtF6/CEqeyjyC+fPY8sQktalrQSHqhgIP/Y8bvDh9Sf3FLreX5FcpR6QGkw8+LM7NP58DQcr56k+xKTF9grE4F0Z5+2oU61D3kNmXdgGPU4tFsyl+s22sL/XU/ChAhPRuQDfKME4nV+L6VTL3+dK3ENumf898R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66556008)(4326008)(6916009)(66476007)(6486002)(8676002)(66946007)(316002)(9686003)(6506007)(186003)(6666004)(6512007)(1076003)(26005)(38100700002)(41300700001)(33716001)(478600001)(8936002)(86362001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9JcB0KbZj6NvIa0GyzNclTY8FJ2DJHtBDpNtGvVGMnOFKPEQ+Uqg9Xer2fD?=
 =?us-ascii?Q?mTtW3eOXeIymAAmz2tscZ1UALdI2XC7HKOg0pn14nZTSlQ9KjI0mbfyZ2mUi?=
 =?us-ascii?Q?UFJ9Cw+mn44ySLpEIJiviRmQtTAr5iNpPRHvspeFky3enUmS5otkq7YaJ9Ds?=
 =?us-ascii?Q?DMtr+I4CmSlyxLRZADH7clO0vXHGLHuhMHokgw5cJFgVSUcZWS3OvK6Z6ih8?=
 =?us-ascii?Q?g1SfPnkUtv5ACbqbQrb1GYcu9v2lrDJgLsEoyTAGYlytI/YhaXLZhABFIpBS?=
 =?us-ascii?Q?b2DSLEZrZUUTqkUu4q9Ie0/NYumNYUODedZjUS99ouUjlA/M8d2OYM7CbZjP?=
 =?us-ascii?Q?ayxCLVlSJTqhWG69I4QDKBxqvFWY6+1T2ywONrdVJ7g/2T54SgVUNHSCwG5R?=
 =?us-ascii?Q?Ua/Mx3USU+3TNbVgCdSGdeyjYodm9u4oRpBdfSzOY4VgoJnksXKQgZnXa11J?=
 =?us-ascii?Q?4UI71m5zcDw9+vdcVUHTyuqwlu5ZDu47RDSj5+0Sfwp6byCM22RD4+BR0wBK?=
 =?us-ascii?Q?Ehwc4Rb679zRz6IP9wIWAvyZWnYcoSp/3cicCFk1uG4ZUxfvUqK9rnuCH1HI?=
 =?us-ascii?Q?FCZVduoBCYnYex6dQ+pnA9XXvf7QmQZS0fHHdh8oEcQG4Ut3moMfVH4bh5nR?=
 =?us-ascii?Q?uoMpg3d4kQf2R1ptkJWEd6nxVszspZQG0M+jz9pkL+FTGv3PKYlQKYmWVsSE?=
 =?us-ascii?Q?/DZMPYcp00L+ThutwK6U/paGQbOqQ46eB4hgTf/rYM+39IS6UhcfuiKXYDNz?=
 =?us-ascii?Q?BDVMwwZ+LjmtFMbLWzDe+rOj5pAaxFMeNoBqgs34bOEJmG/vFmuDJXkQlT5V?=
 =?us-ascii?Q?6O4ImpMuMK/luByGEZB2NBTZaR893eg2nLfqw4TJ6zk55MCuxqRNmcogD3sN?=
 =?us-ascii?Q?8L6Ty6KD1m9KBUa8Bwp+1wocplncG86gxBlMZzpZp/jliCY7DAIWQegZL1kN?=
 =?us-ascii?Q?XVKeSJ5sM3bPUyD/2ieBGkRbfUBGLRxNo1EbEooNfexcq6BrKbZBe7C+Ynop?=
 =?us-ascii?Q?Jv1EjQesJfZR+RXoZX5Xv6Uyqmb0bYIMVABmIAoo1jqu8NAozzE/q773AoRN?=
 =?us-ascii?Q?2GS0lhNgED8VrxiuIXIlPxeKVYW0LMrxvw09O1rcW0S/MRTPFI7Ie67c6DTN?=
 =?us-ascii?Q?RRQ0Ty+/MoS9iEbb6TUjCbhAmN6fdL0OzpEPpASrhblTnF3nOgUTRK6z2deV?=
 =?us-ascii?Q?AEqhmrScogUl5UrTWJM+tQACS82hawLXdPBVepbFmzSiReZxQ3tcfdW04XsG?=
 =?us-ascii?Q?KhWmPf38ihyRUifY6mTuWrUXIZ+JAdiYqcKbUb2SyTIXZ8m4I1y8EV/bQsjI?=
 =?us-ascii?Q?sSmV9MzDou9fnzQc5DRcLPn24hgOMgQsK3KvWHtO6LBb8td1tvIM92OjI3oB?=
 =?us-ascii?Q?kkA42GRu8VdE7qANxv7+siIiD16c3pHlXL6v9kd03N1cfrt9LP4NaDlUeMJz?=
 =?us-ascii?Q?u0qH5XJiZPgiy8gngIDfIaUMH61wMkU4CxMlge7ja6N1U5JWebiW5wnV/Clz?=
 =?us-ascii?Q?9bg2lbfufygqpPfHfO2glD57BF4I8GtquswO3VoUCPq44rVEDdJV4qYnb7/q?=
 =?us-ascii?Q?hX19yXzsUQ+Bayh3y/Qb1BRn5vgB1qefklFaNoouhben1+XRKjLNmlw2vle3?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qSfyMTbWQv1p3/enIndnlPEysw7ytO/HYDLoZjThDYcFYQ6oWGH6ZfptFoRW?=
 =?us-ascii?Q?zg+npB1zCpRK39UIW+PNIrMNGAYx+qiyFXSGJR3YmEY1gDaNwyWO5ZEOCE71?=
 =?us-ascii?Q?IuQMGmhoymRh4biRCWhRIn/cTMLngP5JHBHlJOWIJfpP9IMDLYX9ShUbLxXt?=
 =?us-ascii?Q?mQFzRU4t+URdxbdb4DZ3xnL0aw1+rwNTBDgG/xogCLN9AgFvzDIDmHbw14vu?=
 =?us-ascii?Q?142FJH8X+u/gmqZGwivOWSah8nU7hinNbYIGvUfVBWEMcl08Wb+zKNLAUFJy?=
 =?us-ascii?Q?nf4a4/ZKNJ+vvPX0ySE1x11tgAObcdKItlwX9Ibq41AVzev6hWMnkZlLKFMs?=
 =?us-ascii?Q?8ED0/tXoSIIwq4HpvdZOR4nurW0C3J4DtjL55DoqLddkpda87W2p0c9lbi1T?=
 =?us-ascii?Q?Iez85taFN3ZB7RhTZW2q4iYW+luJ62kPvoOyHaj7dgkbq/Gd7ZHrVcmuN7b+?=
 =?us-ascii?Q?VjZWJ9tMjvIr8KtB1KceqS68LJWR1hciadjMQwOG5SYIlxqwReNLCWHDeIfy?=
 =?us-ascii?Q?qU7TcUniVamxhUi1d7YnzCRh0rWtrmEALA16+Efl7eDBBvnzCd51HxzB0kqX?=
 =?us-ascii?Q?x/lklGp9Bog7FBH9QrMH4OxGx5T9A8hTyRT9vaBog12tEbz6VA3aXBmumtwS?=
 =?us-ascii?Q?wO9aK9GPTE60uF6i02fsuQG4OYOB5bNNGnCnLePDm6dqVv03OB8pxjnrHALx?=
 =?us-ascii?Q?8UpurdlaBnor9AfiawP0wjYz73dG+HjKYUaBohgFY4EODWyKwIuRwkvYHkJH?=
 =?us-ascii?Q?3mTb/ELDiYuKTZ9ldcZGUK92xjfqfuc9BvFY/FHt8rwPGQb54/+WXqj8whcs?=
 =?us-ascii?Q?/REiSP/516rVMO62857ZDt45GjxGQ/Pn+5rENj1coXeKrJm3viKmoQrGkK9l?=
 =?us-ascii?Q?eYLWIO9EkQG+yUScxAPhs2T5gDSgptoevCYTmKRXy86ABtToC69szAPqnv3e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95f29c-9990-45dc-92ee-08db356f999d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 00:49:25.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwLUihbHhB0bCi8iRbwtmh7+bC5kuM5CD4PAVLN+i5QJKXTLM70MNsAildQP6OWjCBNqhKT72xm7x3sNnbx7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_14,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=644 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050005
X-Proofpoint-GUID: HLem6k37dzwxlH-3E53BhP_vgmWU9iik
X-Proofpoint-ORIG-GUID: HLem6k37dzwxlH-3E53BhP_vgmWU9iik
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230404 16:27]:
> On Tue, 14 Mar 2023 20:42:00 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:
> 
> > Some fixes and clean up for maple tree.
> > 
> > The bug fixed by [PATCH v2 1/3] does not seem to be triggered due to some
> > coincidences, because now the implementation of mtree_lookup_walk() scans
> > pivots one by one and exits the loop early. The test cases for the bugs fixed by
> > [PATCH v2 3/3] are difficult to write. If I think of how to write them later,
> > I will send them out. So I send out the second edition first.
> 
> Do we feel that any of these should be backported into -stable kernels?
> [3/3] looks to be a candidate for this?

1 and 3 are fixes and should be sent to stable.

2 doesn't fix anything so I'm not sure how we could get it to be taken.

