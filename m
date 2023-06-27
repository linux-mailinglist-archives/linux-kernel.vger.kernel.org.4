Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6573F0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjF0B7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjF0B7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:59:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D247171A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:59:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R1cRI5024351;
        Tue, 27 Jun 2023 01:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=iodP2sjFmdsrzcizcy40qsNU2cMItZpGnS2YR3IXX64=;
 b=L4QofmalS0egcUWkJVGuvuZMd82v0Fcw/DNiY4I3Vmvw72h7t1Nb5+CsU2sbZhyORS/L
 g1s/olprCB50aDfwyLwQc4OjboKp+wBjekO17ivNwYAKqAqOIjssZI1+nrhhi7QAcK3R
 Voyhvgw7ZTLLpzXjfH2V5mxFD+K58+qoQUz4Z+hooEcix4KQihwIHviqDjAcny/OBN0b
 QL64rCr1ozGpqpIZpgIsO0ZRuF8cCp0MEFsw99h+bhiRR4DJM7WHylIA0dgFIJ7bpZ5a
 BXAFXbplORd6OC39w1HcDsBuksMqrZ4G05JWIT6n+RaGOluqE4SOvvYcNRRydpEDoXi5 Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933yj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 01:58:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R10wEM018869;
        Tue, 27 Jun 2023 01:58:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx43br4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 01:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f572/lEyFgLy7n3OjoZRMI6WlQNEGbXQ1vZQQeP/3R0wsoervFyKI54tS+snRPSQHcHvdcdfdXXUTemR0crfbHqKibHSUTorpLovM5hkmTh9PMAKJLYlmhdMr5QJhthO4B1RZ2UKeRonAA4KlAG+cnWUbANt+zoWcSry5+PtsfysYy5bA4626C1lrHlN3gzupnBgRD4z/1w4qQvAejR1Mbu+BrSd8JH18vuEopptePYYYbrmHW1xonO0B+sxQGhmBbbX6YlAPAaKYSOYxy2Fk6KjSnLDPtb7rLf/U67RA0oQ70D2Tu4LfbkZcfo2WIg8f1zZc2dkJ8pQqO+YEzqKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iodP2sjFmdsrzcizcy40qsNU2cMItZpGnS2YR3IXX64=;
 b=LCMITwF2as7CGN2cD4niNslESkrOpJ2sX5j9/251QrpeC2vBSacFp8mTbTx49fiLR7KmqWM55K3oWNZ5+E4wcD1kYBYk4XB0oA1pAET1zlQgOGFxBPnK7f0JTJYahmhBdPvC9aeqAjVSP7fRzv39hiLzgW8zn64KwnmU2U7P79PUERHFdXa4ILn4FG9brrEU66v2TU8G03UGUoARbDlEhuUu8EQ8Yac3V64PsTQqFdUpGItjYB5A2RWUx12FxRRjORNtVJ8aUXkvqL0WB/SkEbAJLvwu5VNrdU2d3Vl7Pks8ga7BOFu0CNzOCpUkTx6RAgBstnXoJCj1hQh3smQIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iodP2sjFmdsrzcizcy40qsNU2cMItZpGnS2YR3IXX64=;
 b=jQsFd13hS8loAbDtrnWadMIWD981rBXex5ca/Z0TOUaGCv4CD/GV76Aa3LOxkjb+sTdoRsJ/30/WwCKdXWHlaRehwvVOclilLxpcMHS5NmpSxl+nSssb2dqnyNYcOIK+76O7g+w5qibq4TpNnLPbueqGiR1NI+qxHENQ3cxT75U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6742.namprd10.prod.outlook.com (2603:10b6:8:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 01:58:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 01:58:36 +0000
Date:   Mon, 26 Jun 2023 21:58:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <perlyzhang@gmail.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Message-ID: <20230627015832.a4rojonhlykemose@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <perlyzhang@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
 <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
 <8cc06224-8243-e08e-d0ea-4db71ddc7745@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc06224-8243-e08e-d0ea-4db71ddc7745@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 426d737b-51a7-42f2-02ff-08db76b20496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XRsp7ZUjbu1iCGDrYEDE5Xj4oM//NlUKwbwgun6VOSiE/cFQjWGb/tXK5jSDYkuwoxlW+vt/yT+jv5Ls7tjmJPoJD9K0TLW2ZQ9ZtnrBQCRSSUAR5279A0yLBwhrUVnn9NT8XPxLmGN08Pr6gGD1Kd3QVV0Mh+yAkjCup7fGHXKt1UtmMQKnulLmr5mCIzqkzTzwLSOsp5qUdotskAKEGCvN77SmokaqVEDEO8pPygHxFs2aBhAEx/xMEkXdX/oNfHtzTiju10YBpO/f+7pDmSozWd6UmqL0sUHB9Bz1SBsmuEa7Ql1GEe4VfLzutrqVy4aXb+pLQxHm0a8Rv7FfU/+fAxpgbjNbEIx27erRRRi5tnRQo0+XzFHfWwyykRcAzLrRzXbkixICRwZkeAM8ftZae5SHxO59CQ+sG7cYqN0o8Cj3WrX4eBzOltgXZ/ax6dGl1q9oChT3qOhrY5X57aOiLASUD477ELOiveFb0i6GNzvBrIf30WDm3U63aOBTUd5hr9WHn7k32O2QqxAyVte75i7GoqPW9fKHXqyC/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(33716001)(186003)(6486002)(38100700002)(6666004)(83380400001)(1076003)(26005)(6512007)(6506007)(53546011)(9686003)(966005)(41300700001)(54906003)(86362001)(478600001)(316002)(66556008)(4326008)(66946007)(6916009)(66476007)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0FFPsvtNQjywHinPeKjd0T/3MCBlEi8xpsIXDurBK3cJtyt9kPQoyX7MVOgt?=
 =?us-ascii?Q?Tv1f3impJURvqgbIDQAGVzbNHc0Py6TDPc6hWbD+/WnjOgb8Z8woqYXJ5IVk?=
 =?us-ascii?Q?LFjvvDC7D/v8m7k2XK2WDP3i3X6knvQVsiBHToRa+/v93j1Z71WXRnX2aVfW?=
 =?us-ascii?Q?CImqwAjGhnPWMic9LyrKEr/LJ5Fxt4ple/mFk20vcUj95E3GNsIVRIAvFyaz?=
 =?us-ascii?Q?R3t9kXha/sCD6QCc6UOmYItcHYqUewptUtiPUSlcEncyT7VLmbu+c4zNrY7v?=
 =?us-ascii?Q?N3EGVjwjyEbn9eoSv0O8b4e5XccpyAmLv5CBY3VYqXqOQh4sRGwm1WOUQmWZ?=
 =?us-ascii?Q?vltPEmNxYCsvYrrHfjtn3WCG5oYKhS0J+KcPkrBdEIwSM9DfXaz4ioBXBxnI?=
 =?us-ascii?Q?canhgObiuys4wiqEbjfSmbjifVLG+pCO4jyrc2HMkZPv0dSy2X+FfSqFeOIt?=
 =?us-ascii?Q?/CmlNSBc2hzi3/+o19rifQgHVs7XpPDOvYicycnRprSsPOuz1SP6MJCQlOoL?=
 =?us-ascii?Q?NYhJn3ym+RqICYd58SEwLg+wfmwAsnY1nnObB/KE5jX0PI2sKn2Xb0XvVR8T?=
 =?us-ascii?Q?KqUl+x9Vit79GnLRfmiKqQT+UmqYSpCLYgKYEj+cO2xFALPeMnei5x5KhiKr?=
 =?us-ascii?Q?1Qv90uP9GedxLzowDZLiw++6hdmGIAP8Qd0qyOAok33Hl8G6YbDgyBeP2J9D?=
 =?us-ascii?Q?69vUVyv6txDpe8bd4R70bcwG73fSxP6ggj0QPPP8r/p942Z/G+o/ml0u+wWC?=
 =?us-ascii?Q?yO0r27E0DGlZ4qKKRXake2hYDvkuHeKCAhzZJpFXM9Oi4JjvriRtxYUEbs2r?=
 =?us-ascii?Q?sfztPRVdp43royFDtd8i13nYBTBgwgg5nAJiK+zBai6R4qejhqAk75cXkBFb?=
 =?us-ascii?Q?WA+w6VhfvRFv2rLwrDQSNCP2pYOZZ5pC7QEmk90N+AFktYCIqi5gYoKxBOnF?=
 =?us-ascii?Q?AaI3hdZBA3uzpgwe/r1c6TvzlGpv8FLf49Hqph42jZnjhR0z7N4fDzJJihSw?=
 =?us-ascii?Q?DA8YLgDmG5uOKU8KYGr7OugRSOWfJR12KFfro6UbX+EDHBueHqajb9AcBTxb?=
 =?us-ascii?Q?F9KMcRMvtCS7A4gmI7JbUvRDJo5SzMYIYZqtUG53RMtssQIep0c3QuIKuCNv?=
 =?us-ascii?Q?/CeSMQnKblLrovSGeSN/WdWItnWLK5GZXd0TK7T52LqFoTDGQeJ8NsASYBON?=
 =?us-ascii?Q?9imEzM2U2AoLKskiIFzY58cQR7vDByJNrJJ2MAsDMNd3ztfSvKVFPY2eKE3R?=
 =?us-ascii?Q?cF8ntth2ggmJ3T8uiwln48Y0YpWBn27P0N3XXWGH+suKqemmCo+i4+zqnIMs?=
 =?us-ascii?Q?tWLcoJpKKF2acV2qhz8K/f/NeYNNGJYOtKkKPJTx2BERFDxejnEBxEnAgUls?=
 =?us-ascii?Q?gJeuX1O7qtyUpEeIbkYwOKeMIe2k+lWBDt0gDeKUBIsSgQAFY47JQe3YPICn?=
 =?us-ascii?Q?z3LThZnS2f3iwtwdcldfPlYDscnMENBpzp3OUGS1zXXkhQXYPvz2zMBt6x9Z?=
 =?us-ascii?Q?4+YimZ93WuxCW1R8IUEWFpNr88hWJvh5f1OI7Dm43YzVHWTzFp9YUf8UnC4J?=
 =?us-ascii?Q?hG+zoAe96ntDy6X9G8D9QvkmPAJmf0Hz/eImVSwoGZJUuHObBSuHo86QPh0D?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?188yyJAhDRbZk4jTZ/FQFRbR/8zUp4c8SGlwA9/GMz+njLgmGphzdStvYrFe?=
 =?us-ascii?Q?mSdr8sUhcWmns1VN8CTMlFunczn/+C6WNFezKrJy3/jfCB52V8osaQQg6cyT?=
 =?us-ascii?Q?YLb+mhMZLK2c2fg0n6Vp22zY3rbwEwWgiMyX88YJClMhIXBAoLqYu+FmJHZG?=
 =?us-ascii?Q?1yhapkjU9lkFRQR/zPHLCNT1MIikOHhG0dubXDb7iCJNqmg3ELmyX9EsKOZS?=
 =?us-ascii?Q?q8flba8tr6N6bueHo74GhzQLg2KmL653R4sKGy6yWrYTuoisKBa66y4z7TxL?=
 =?us-ascii?Q?aL6uLl8xUpQuZufsTE8Kz8L76Z9wRAJ6mHcxJrodKg+iYozHQTCxaI6YT61K?=
 =?us-ascii?Q?WNv1gZ3xBz1hrjG192AbKgJW6NYcjfJBWrnI4H4/WFtKFcvze/C4EhgboU9P?=
 =?us-ascii?Q?mHo0KydYuQmoqj49tVRcfj3CPo+v1ITP1yIcJrQqnYbgOPShNGRbB86o5x/X?=
 =?us-ascii?Q?tPNHxK4INQJZLyyPs8/A/UilYDp+4P1wqkOzgbZDzc4slNa1R9bBd8PgOTG2?=
 =?us-ascii?Q?zjsn9s74KBNrDwAj3zxPZpk+/XYe+YQP3DqjZnhk2hkIOCAfiRsnFZvcXdpF?=
 =?us-ascii?Q?1CxK3wpGPW9DC3fCB9krtJ/OaN0KfcLNGYok3TwILkds4E4i/WyQ6s4ImGny?=
 =?us-ascii?Q?ToHoZl2uMPHJgGol9jLAohiiiBkwmBd2G0sH5ONGOw3Hrj1N5tW240DEc8S6?=
 =?us-ascii?Q?ro9rErxpAVzRiuHM6uMYrQLF9e8zUGZVib/7sFZyq7JgvLo/o5NcOA5AtJVz?=
 =?us-ascii?Q?JieRKZy9SwujZ1UDGKlg10+0x1i/6EXTgwNjt1eVkRZLgJZZn0ZFtubEnb+v?=
 =?us-ascii?Q?H84x5M6S0/dPOyBwOQ5+WspsAyffTGE6RySqRQMq2gIYUoqnvlc5wVxVOwdS?=
 =?us-ascii?Q?+DOp92g4fQhluA205sQE+07dcxDv5AFQmfjaqQ2myVlZ6dctAQwBBpViBDXi?=
 =?us-ascii?Q?zC1td4MwhzxF9PW1OwgasAQOHaJQPOvz/yCVoVnS9hrF/KkHbbXB8yUTqHZH?=
 =?us-ascii?Q?t0/sH1gk+PDc7kxYQK2rNWU1rSXojaYZOFW+PHNELCj5bsbejJZ43Woh9sQx?=
 =?us-ascii?Q?gDd4N51S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426d737b-51a7-42f2-02ff-08db76b20496
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:58:36.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1gFVlOyfnCA2DSQ0WLeFZMkHAy4mAo1zdME3WmHpJGkOF1MGPWwzVzHK/UKaqnWBPNof7qB6Fel5OYDJCOUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_20,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270017
X-Proofpoint-ORIG-GUID: 8JyprTiXbYrrrwkW_GhaipfJQbbmJL9L
X-Proofpoint-GUID: 8JyprTiXbYrrrwkW_GhaipfJQbbmJL9L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Danilo Krummrich <dakr@redhat.com> [230626 14:37]:
> On 6/26/23 16:52, Matthew Wilcox wrote:
> > On Mon, Jun 26, 2023 at 04:27:54PM +0200, Danilo Krummrich wrote:
> > > On 6/26/23 15:19, Matthew Wilcox wrote:
> > > > On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
> > > > > On the other hand, unless I miss something (and if so, please let me know),
> > > > > something is bogus with the API then.
> > > > > 
> > > > > While the documentation of the Advanced API of the maple tree explicitly
> > > > > claims that the user of the API is responsible for locking, this should be
> > > > > limited to the bounds set by the maple tree implementation. Which means, the
> > > > > user must decide for either the internal (spin-) lock or an external lock
> > > > > (which possibly goes away in the future) and acquire and release it
> > > > > according to the rules maple tree enforces through lockdep checks.
> > > > > 
> > > > > Let's say one picks the internal lock. How is one supposed to ensure the
> > > > > tree isn't modified using the internal lock with mas_preallocate()?
> > > > > 
> > > > > Besides that, I think the documentation should definitely mention this
> > > > > limitation and give some guidance for the locking.
> > > > > 
> > > > > Currently, from an API perspective, I can't see how anyone not familiar with
> > > > > the implementation details would be able to recognize this limitation.
> > > > > 
> > > > > In terms of the GPUVA manager, unfortunately, it seems like I need to drop
> > > > > the maple tree and go back to using a rb-tree, since it seems there is no
> > > > > sane way doing a worst-case pre-allocation that does not suffer from this
> > > > > limitation.
> > > > 
> > > > I haven't been paying much attention here (too many other things going
> > > > on), but something's wrong.
> > > > 
> > > > First, you shouldn't need to preallocate.  Preallocation is only there
> > > 
> > > Unfortunately, I think we really have a case where we have to. Typically GPU
> > > mappings are created in a dma-fence signalling critical path and that is
> > > where such mappings need to be added to the maple tree. Hence, we can't do
> > > any sleeping allocations there.
> > 
> > OK, so there are various ways to hadle this, depending on what's
> > appropriate for your case.
> > 
> > The simplest is to use GFP_ATOMIC.  Essentially, you're saying to the MM
> > layer "This is too hard, let me tap into the emergency reserves".  It's
> > mildly frowned upon, so let's see if we can do better.
> > 
> > If you know where the allocation needs to be stored, but want it to act as
> > NULL until the time is right, you can store a ZERO entry.  That will read
> > as NULL until you store to it.  A pure overwriting store will not cause
> > any memory allocation since all the implementation has to do is change
> > a pointer.  The XArray wraps this up nicely behind an xa_reserve() API.
> > As you're discovering, the Maple Tree API isn't fully baked yet.
> > 
> 
> Unfortunately, GFP_ATOMIC seems the be the only option. I think storing
> entries in advance would not work. Typically userspace submits a job to the
> kernel issuing one or multiple requests to map and unmap memory in an ioctl.
> Such a job is then put into a queue and processed asynchronously in a
> dma-fence signalling critical section. Hence, at the we'd store entries in
> advance we could have an arbitrary amount of pending jobs potentially still
> messing with the same address space region.

What I think you are saying is that you have a number of requests
flooding in, which may overwrite the same areas, but are queued up to be
written after they are queued.  These operations look to be kept in
order according to the code in nouveau_job_submit[1].  Is this correct?

So then, your issue isn't that you don't know where they will land, but
don't know if the area that you reserved is already split into other
areas?  For instance, before the range 5-10 is backed by whatever
happens in the fence, it may have already become 5-6 & 8-10 by something
that came after (from userspace) but hasn't been processed by the
kernel that will live at 7?  So you can't write 5-10 right away because
you can't be sure 5-10 is going to exist once you reach the kernel fence
code that stores the entry?

Is my understanding of your issue correct?

Oh, and I guess the queued requests would have to remain ordered between
threads or whatever is on the other side?  I mean, you can't have two
threads firing different things into the kernel at the same region
because I would think the results would be unpredictable?

Can these overlapping entries partially overlap one region and another?
That is, can you have three in-flight writes that does something like:
store 1-10, store 10-20, store 5-15?

How stable of an output is needed?  Does each kernel write need to be
100% correct or is there a point where the userspace updates stop and
only then it is needed to be stable?

> 
> So, the only way to go seems to be to use mas_store_gfp() with GFP_ATOMIC
> directly in the fence signalling critical path. I guess mas_store_gfp() does
> not BUG_ON() if it can't get atomic pages?
> 
> Also, I just saw that the tree is limited in it's height (MAPLE_HEIGHT_MAX).
> Do you think it could be a sane alternative to pre-allocate with
> MAPLE_HEIGHT_MAX rather than to rely on atomic pages? Or maybe a compromise
> of pre-allocating just a couple of nodes and then rely on atomic pages for
> the rest?
> 
> FYI, we're talking about a magnitude of hundreds of thousands of entries to
> be stored in the tree.
> 

Since you are not tracking gaps, you will get 16 entries per node.  The
maximum height is 31, so that would be 16^31, assuming a gap between
each entry (the worst case), you can cut that in 1/2.  To assure you can
successfully allocate storage for a new entries, you'd need to allocate
30 * 3 + 1, or 91 nodes, which is 6 pages.  That'll be highly wasteful
as almost all of these would be freed, and sometimes all of them.

You estimate less than 1M entries, that would never go over 6 levels (8.3M
entries with the worst-case).  5 levels would get you 500K in the worst
case, but realistically you'll be in the 5 levels almost always.  So,
5*3+1 = 17 nodes, or 2 pages (1 node over 1 page).. assuming 4k pages.

[1] https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#Z2e.:..:20230620004217.4700-4-dakr::40redhat.com:1drivers:gpu:drm:drm_gem.c
