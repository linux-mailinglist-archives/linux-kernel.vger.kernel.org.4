Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEA627491
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiKNCY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiKNCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:24:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF25640D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:24:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ADDeNpf029246;
        Mon, 14 Nov 2022 02:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=BQDfXtKj8ex5u38ItIPPPo8MO6JMN8DUu6/05+k3efY=;
 b=yB9f9gt4AHY0kiwKLVmJEGYY/2+4rtXRm9YUr8ksoVQRbo8TG4Zug8NaK2iB4xg3bkX4
 b73cMQ2Sthh/LwQbq4JgZQAr9shMOXrhxxo79yxnwkQeD4yha5dXpRBaIzBwrOlnb7iI
 S0KUF1rsSwYEv211ClmQkv6q8B3hwIXE+XtOc4iMZKCeXUh/OSV/k6bT6gAUva5VU+55
 gBcsmPsNUHvcvqGxFeDENQnVxfdrNwx2RvED7hHZKV1ZV0pM3gTEBIKAvyZoHFmMAmVs
 0He3Kb/9AFBjEIXcy8sBRstx1w/8fDR5VuXfwjNnr+3Hp98dfaDCFtLdiFcH+TlnV6ll Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1ng0jc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 02:24:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AE01LsP004256;
        Mon, 14 Nov 2022 02:24:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x3hp7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 02:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Px4kfXhnncTqGqFzYiH5ygMM/PjxjKR6b/lkFjVuNhQ2M6lX8CC2FkkhOsvWKDVE721Wv+8B0QxTxzkd/RDv9cN3xE9YXqgcv1xnFsEkC/JDXGjks6hAEWbr1BIM8w58H/bYKEMwEoQda/E5nD9+nYU2las3kFxwzSCA9VO58nUb76RWNejoCWderQ4u62ZN2d+SFmilxJOasmRFkXyHvTZ16xCLdW5lhes4Hc/+Zz7Fille8OpR0DqPF2TNK0kjUmO7jkS/LwvFY3Xid8ygro/3XjP+eO8DhRuPu2STA8iNVAf/xuh0IvwIxvgzxu+2u/9YhuWiIQB+fqaXwMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQDfXtKj8ex5u38ItIPPPo8MO6JMN8DUu6/05+k3efY=;
 b=LCVjUAJU20oYDeX1Enph9ZnNIpnYEuBvjxkj86i3uKa6HgroxCNQBwNt6uKoyzuk77W44p7MsE079WfFFPZyy7C6s4ELh/W7AvfGaFhc9J5rkRk8yhOk2C0deKOSOcCUuC/0RdsqhZK9UqS/8EPP7VpojaqBs7YtKgloJOpJcOUbt2V5oy4DMvdbG5qKItj53F3ano2CUlpXbCIhfb2WeJuGJ9o17H4Xo84XZmFtBorsJkN+nYGddb0A4Osst+2hZKRcCcndBgs0f5ZVRGXY/1KOYcwcsCl+q7ez2sPQx9r7JbL4YMccyEhRxgNwIxAdv2yG+S4basGguPsMsXSXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQDfXtKj8ex5u38ItIPPPo8MO6JMN8DUu6/05+k3efY=;
 b=O49E8Yr0Nf+kYYM+jKmVtmodzJi142eGaouCgN2mZFnfDiE7NmABhrIEnvsz1lf4uoYgwBkXfZbyaDQOgC+Tub2F7aBw6a8CP1KGyPcOmGbuX6XNifleWx2Unqr3y+ePCTxSHyymPViwZD8L3MmyOp3Ta99UbU9b40TGk/AlJZg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 02:24:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 02:24:23 +0000
Date:   Sun, 13 Nov 2022 18:24:19 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
Message-ID: <Y3Gm01DB9a5PXLOI@monkey>
References: <0000000000009586e205ed4679f4@google.com>
 <CACT4Y+apC6o7jB+nbsZiUua=P76vAT7wVK4GeCfM-hVtWj=scg@mail.gmail.com>
 <Y3E8ffs8jC7041h4@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3E8ffs8jC7041h4@monkey>
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a14786-f9bd-4ee8-2c82-08dac5e7574f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7nbndEep4bFODdamXlWVTYM65fi7rg/AkkY4LtDLcwllH7Hv/lXzFtxxYs3ZKanteUFOlgq5jqXTNG2gGHS63pQLa2sJMa5VhjGuwXwjDtM88+wNE3oKS5RwtL4ovRbyXbQg5TvH0xZ2TdB2WtcfJynAGTDhp0st+8qC7VYp3LpGmyLhze4xuDseC/leqWUcNB00nCzAZrYgjascspDpmP27yv/8pnDDnEXvUM7EnpO7fqx1s/EGZP1iMb8JNpzTBbdZAPzQps1bAlle93+/wtjyfTd6ykSvAz2bi0ZT31azNmEIMuRaR9/ZRsoc9a13DP68JsL76QOlEz/eA4TD1DYlw5+3jGU4OMY6BN33KqEXX9Alq4qaYo/0LCGDrEHt6v+W6Zq6VNeF/VDxpoDtO62wpkU9XJLeDl99Mp/o2ajSYAXImZPJRDYtVbeKjkSWW6NqKRj4Mg/fqvfIGQAg8DqP+6HWNIY0kb8uDw78xYOUD/FLXU5cQMrODdtx2rePhsvNRDFR2mh4UedJtaB7QzgY7Vu6Rqsrssve0mQblBmpUfrHh9roKX6PrWWaRATz9JPmdZJus4QlQP8Qw/d3SeXvrc5nRWJHaceFrtbCpqyqYOVX8F05aWCvIv3kz8+QmybO0izAzWCbDBhfQVvLtF7gr0dNccmF5MawI6M/teMT41BBb2LA4PoIS/g0IG4NXmOo30J/iOw+hh9IxC68W2LfigY2wtOUwseZhCmBdMuOEneZPA2Lnhhu6SOApfCxs+WLTy6Byblj2ddp5R/5sjeMUscW7TgBQZxPM5Eifi5a/8EgJICu1YWdUtqH1rR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(316002)(66476007)(66556008)(66946007)(8676002)(9686003)(4326008)(6512007)(26005)(38100700002)(53546011)(86362001)(6506007)(44832011)(83380400001)(7416002)(186003)(5660300002)(2906002)(8936002)(41300700001)(478600001)(966005)(6486002)(6916009)(6666004)(54906003)(33716001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWuxdG7AnAi3jiSOQ61jCRFqE/6Q/5rEhMMh3busGvm+iPsRwI0lrrmopt56?=
 =?us-ascii?Q?InF6Z3OqNA8PMxN56W263nAOmtYdcwv9AN4t6hoz0U8Vl/auG0OODex29wGK?=
 =?us-ascii?Q?d5TGP87XFYo3bbTURgbiWodgX0a6YWSaRM/gpOqHMjVanT+rWev+qTZzR1ck?=
 =?us-ascii?Q?nL6Dpybo3ZGUo6WT2p6hDJo0Xj3lMV4QN0Li6e89Nv5RrFfnnZWDw7uyp/gF?=
 =?us-ascii?Q?DvFlQ+Sdb6/7Y0q5dq1gX6tIIm1XiBv+5uhGAnPyHWtP1/ujHoFyXy+ZSXIx?=
 =?us-ascii?Q?XWvVjU/A4S+RlWOG5/LMnpHXS28t8Vo0ZpuwWxgEJKXlHQ6RFNstjSKGpDTF?=
 =?us-ascii?Q?ayMl1yRGMVaZIqRb51J2zf8KwPiig/FXKTRodm6q2npRYefk1OBmZA0+YHwt?=
 =?us-ascii?Q?69bA49gt2vOvXbbEOoMdPQvK+KrV48RawQXedr6h+YnESTwuK8tIYe9X/AzH?=
 =?us-ascii?Q?pZ5f1pXuq+QYu6Pep1Ip269RJw1qEHFegGlSdimhWgyxGrwXTclQUA46zleG?=
 =?us-ascii?Q?dOWM9AUnjiVQ7iyFetRrHrucfNrYDC79AjfCgxT2JbOmODmN/h77FYkKLmZB?=
 =?us-ascii?Q?MPHooLEvTHvKy3hTeRjvUb+nz8By0GW2Rwe+s4Hgbg5o6JL6yVIn/WMYd06p?=
 =?us-ascii?Q?aJ85Z6Mf0eSak5YrViAXsyZ11HsdOI3xrjdgw5qKptr4vPq5RzNo4ZSnDRhV?=
 =?us-ascii?Q?PYJCAbhj2EsPTfZcdrmncoLc57RyD716BBDT8RnonnO6Pl6Wokej0o27T6Xi?=
 =?us-ascii?Q?CfD7Ue6CsvQRQ0rdjUoN02/McdYluB9WlnuAhDKJstuD4cuB6MkXKUI3FdUJ?=
 =?us-ascii?Q?6TTnHCWJ+O9wHFDuhf9QANCLiHqUdSGndDjbfz3741fCX48JaXYj7UUIQc6p?=
 =?us-ascii?Q?ypvPATUeLzSCPbvy9L/XWZjjhnzavXZ1Z9PBjGIhaRwFZPlMb82k33YGkHKq?=
 =?us-ascii?Q?2+U7lQ7hURWPGXcQ01pE64o2qpz14UmmflE+sRE1E1kdtz2+uI5tXxGc+R8N?=
 =?us-ascii?Q?iPyVwVEuWN6NUOJsR1eAJgiT8P96se0eYjUhvYHYNs6EofMUPysonwT+8n3x?=
 =?us-ascii?Q?Gvc0QlLQXWmKg9/dZg9qGP0WtdkCA/V8e/6bCDaRy1A1MhGVYwxU8OtDlf3g?=
 =?us-ascii?Q?kqbMD2HYmo+SKoGM+g8HIRQnda4UH8Nd1GzpgiLwL0s7QEs0f7GE6kpqQ8t5?=
 =?us-ascii?Q?1kesb9Xy14q5OTmULmIeO23ddHJQK+oW6+TdQ8ufGHTEcDHfM5Z8bqGhODKr?=
 =?us-ascii?Q?4zAhvpWAcuxjRfUR2kHkjSKhPc5lATnIThKDaLv9t5K6RIm1vUwBVe1D9XZW?=
 =?us-ascii?Q?hnMaRaw9iRkm8l+6I0aEgwnzpJt2T9zYvX/qkQa2/mU63PbboBn73T0vHE9E?=
 =?us-ascii?Q?gHVrpYCJWP03adp6hHGpVVLPeU/03OXlugqGT7l6N2g/43+eZhpXzEDXRaQa?=
 =?us-ascii?Q?9V6LCV9umSTwO5X3RbeuZZ1R29zJ+XkduAL1abX3eNkHpKRn9fQ0XtNbBFpV?=
 =?us-ascii?Q?MgInsIaFhjGPV8hkAdAES6qICE1OA158mzEomme0bzQVK/zLMGSHIFUmSyBd?=
 =?us-ascii?Q?EjeeZwBOrECVBwQj6og+beYXd4hO75C4/qDJrC8VXu31KmOMrXE62tJIX/UV?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?p/Xp9Wu3NkhwSIt7FX/YVQRG6VGRsKfBlBC+Q20xgiQFpX22boxVoi5KDusT?=
 =?us-ascii?Q?WNVAm391qkuO3Y4AnnQoflZKLlu6buoi+bHCAlo+qPmy2tdRJYUsjZgdWcHy?=
 =?us-ascii?Q?nA1vsvfcvzOxp6Yl4QzB4Lzy+H/f6jOnATE4ZRQZEfLeN8tknQR4TjrnihjJ?=
 =?us-ascii?Q?PjGuT8iW6XZm5cX72vaN3hSCfr9+nV+DVfuUfRvmUwdW78f7ZBbpi7he32oV?=
 =?us-ascii?Q?rNksKSv6S75f5t7GRAoAojwdtGvvOWOrcrukEGZ3NF/mAdyWXiWNIIsoajJ3?=
 =?us-ascii?Q?7AWNAjieQte+YrYIZ1f6jWenA1wRsWWYNOPQRAw+fUBGi8zJX3wjIoOg5Ys6?=
 =?us-ascii?Q?XS0hu5zuaUOTmkHFC6oepd418HD53HJqKN5NfA5A0Yv3YYN3CsYw4ztsgEFF?=
 =?us-ascii?Q?yBKHqcG4w/Szyte3idyBkg10rgWjlRd6Ky0tO39PQjAvOMwlRcCyUKQHcNtY?=
 =?us-ascii?Q?FpqWtrlzxNlgDBNf8GprtAQ3VUXyy4O5sdO8WUvs+Rr258N3WP1Er7uBjSLc?=
 =?us-ascii?Q?dlx14llEo1TBfZJJwb8L6NmhURiALGd/GNG8zKGjC2T1CZT+AJnNdDeU92TB?=
 =?us-ascii?Q?DgMiPNcdzi6rpZGW+X5612bXJdq2lbRxb6c4JHz2hURq9kHZ5hg4+59v4J0G?=
 =?us-ascii?Q?xDeWPCiMmMS1B2uUmbbq8M11SHaAweSn0pP4HryMFmjqTPon1v+pfRuOcHZC?=
 =?us-ascii?Q?FNN/IkqLD8Sq7zeMXfBdGO0Wsf7877fhp5YvMZfAIzPccXw6VpVxgzMzhor3?=
 =?us-ascii?Q?u8/qLS3ZQEpQH6KzasIMOs968deY4ByDPHmZRYH89Xjh/dFU7STp/FDGE2jr?=
 =?us-ascii?Q?IQTXg3j8PSGDI/9hAcko9ckVGe4QfOthN9bbhyMtRxfAReTRoods2IIgCE/H?=
 =?us-ascii?Q?GPme7E82P6WK/eV/zqFrAUfSrpiFHITNKgrhzQ8DDThixqkGQ13+am75PXy3?=
 =?us-ascii?Q?XuxTY+HI8O8WJJBosdh6olBg5JjbudZDoGeysKWwxC5YNYTfJYOYbblOvevn?=
 =?us-ascii?Q?CLq5s4t06j6HdAWYOyWqX2aExCHTdsjinYPwNMCEwH5qt8OB8XO1/O1h4kHm?=
 =?us-ascii?Q?Y9I9Cwsv1PHixp33ihbsuV1nd7DU8bD1hzw0EKvZWXiRVWeb6UJhXTBJmq/q?=
 =?us-ascii?Q?GtN8AtrZSdyham4zRIhRwskLGC43RM8aXYLCzbozIXUShIgwddiNJ5M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a14786-f9bd-4ee8-2c82-08dac5e7574f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 02:24:23.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N66tDdvbeWFue0UZP4BFWFtxOswNUKCKDf7712cjuoQqfSv39HbFxvap3Rew7LSqT5sXomlypuUrI6mpGHePQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140015
X-Proofpoint-ORIG-GUID: WhH3wp_wmjOk9xd0LyPjBAorbn1dmKxx
X-Proofpoint-GUID: WhH3wp_wmjOk9xd0LyPjBAorbn1dmKxx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 10:50, Mike Kravetz wrote:
> On 11/13/22 16:36, Dmitry Vyukov wrote:
> > On Sat, 12 Nov 2022 at 15:03, syzbot
> > <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13bd511e880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13315856880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173614d1880000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com
> > 
> > This may have the same root cause as:
> > 
> > possible deadlock in hugetlb_fault
> > https://lore.kernel.org/all/CACT4Y+ZWNV6ApzEv0UrsF2T8JWmXez_-H-EGMii-S_2JbXv07Q@mail.gmail.com/
> > 
> > and there is a potential explanation as to what may be the problem.
> 
> Thanks Dmitry!
> 
> An issue with this new hugetlb locking was previously reported and I have been
> working on a solution.  When I look at the reproducer, I see that it is calling
> madvise(MADV_DONTNEED).  This triggers the other issue and could certainly
> cause the issue reported here.
> 
> Proposed patches are here and in next-20221111:
> https://lore.kernel.org/linux-mm/20221111232628.290160-1-mike.kravetz@oracle.com/
> 
> I am currently trying to run the reproducer, but it is not reproducing quickly.
> Since this is a timing issue that as expected.  Interesting that this
> report is run on arm64 and I am trying to reproduce on x86.  Although, the
> issue is not architecture specific in any way.

After tweaking my config, I was able to reliably reproduce.

> I'll keep looking, but am fairly confident this is the root cause.

I was also able to verify the series above addresses the issue.

-- 
Mike Kravetz
