Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957476271D2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:51:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86CCF2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:51:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ADDnBgF023023;
        Sun, 13 Nov 2022 18:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=YsvRgYg1BByDyj5ExxZYDxFDpYZOBaygUDoX2uR169A=;
 b=A82xlY5Nr/iPWbR9KjlvOJx69fc+mGl7nGCXTSDepoCwco3YB9eRG6W5M7e+DelFtnM8
 uYutztWv/N03WHrW3zd+F8cBsZ8TFdAcMz/GfFZqsR4t3YvLsLwMUaBxugP27HqHl/Q8
 ynTjS8qXIzO3w2QJ7EouVt1ml8HUto2C65z3JIx7lR+YicAQQv0SwGd03ezTA9v+GzMv
 hGXK0fEmzeyN4syMiEDlkFqVKjOZ4JZ+ngDYBWFuv1PCMHEY1zosG45vnkmAWt2aYFQ6
 cfrUPGp3wl2SWTJIDZYHLX/vK4Le6eh4Fz7GVD6EgDTALy+hfNB4jiNt7b8grqGKMeKr 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1t3g6nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 18:50:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ADIbOex020671;
        Sun, 13 Nov 2022 18:50:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9j7r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 18:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSSk2pSKCvRyDKFpRDOZ5KNZixAWEGvnAdb8BL2tk27Ii3yEaH6rsiyN10tg7/KYoyNwux4FDiyVPK3IyuY7/SoaCF8E5YP+leAfpM/uRg59b+Sl5sbQ1BjVhYlhm9vu+g4Em45s7Q3VVEFyE18fA/VwUUnw7hFtTfdRZRc3moVx9Nluf3Jot2zuWOMQqww/I3GqDX9QRtaVfRdbcXHLJlQBI4EtqeN79jvW8IxPieYBW0RZDdvznrMVHBbLyZI0DAwRNtVM/JiUzGrqcrFRN1xDxh7+SQksiUSRNGSVjvnm9HGP1hRts4qf9aMTBqKw+Se0pBcoOc5obRCUGtXmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsvRgYg1BByDyj5ExxZYDxFDpYZOBaygUDoX2uR169A=;
 b=j3SIXQlUBC0fb2W5dkkapi9zrrl3Amd3bhhJuR7C05mUIo3ww2LYQkkX/htCw23oAlCBMHGhz2I37eBhEUPvHKzkBiCjOF5QtdToq5OThwnz3fLg3bDjpb/7sonyjEljJ5HKaW7PrUwg6QEM58xA3ON3dzHrAIFyR9p11GoOIhhvp8gSObEIqEaqh2b3Yt4kZgir03QTNIE5Dzm3ilgq6w1DUa1dLMh6UAJ5UV3G7wXS+OPhTueXgfUwp73Ga0l9RHfIA3DVWPK51+TgwwKk03Sn8nPGqHddiPyZnKqZV7F9g4TkwgMYjclnHgfaC3NrO1sb1HXSCz5AXF2OzFzKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsvRgYg1BByDyj5ExxZYDxFDpYZOBaygUDoX2uR169A=;
 b=sUZwaxs2XV0tjX6e3e32kQHbw7TOZq6JnUkrBljQdw1KmdYxOAqVdfTkV8kuNNB+kCiovvvkQ8GL9+TTPZMjdVjGM5EF9zOtTeWgZG7fCCuVzf4WwdKW/qjTFmUSl50ueTaiqe/sQzkdeQQ/GonBBOObDRUprEtW0qVTL/EW9A4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5388.namprd10.prod.outlook.com (2603:10b6:610:ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 18:50:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.016; Sun, 13 Nov 2022
 18:50:42 +0000
Date:   Sun, 13 Nov 2022 10:50:37 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
Message-ID: <Y3E8ffs8jC7041h4@monkey>
References: <0000000000009586e205ed4679f4@google.com>
 <CACT4Y+apC6o7jB+nbsZiUua=P76vAT7wVK4GeCfM-hVtWj=scg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+apC6o7jB+nbsZiUua=P76vAT7wVK4GeCfM-hVtWj=scg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:303:8c::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dae4e47-89c2-43be-afcb-08dac5a7f602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Xo7Yrq2mphp2nt7D1/R+aFif7LLAeV3wLYvG+53WrDCuIHjO7aClqZSWwOvcMY2XDEb/yL5TeQiyuWuLEbVBfVA2SS6U1KImpXBnBEpafMccPf7qxZfeeH4oz9hRl35sF+4Fo1JqcekjPTlx1KXLmyb7i1/jDRp2thubAQWQ6N9UjU707Xi9tZ1UKF6tQ3tN3C2F6HbNHkRT4mu/myztbSUL6/fzRh4Fywa6avI5cpnG6++f5GlTygSOcYDQHeqSGFwLsYZn8hyUUXp73lobzj7MIMPq8yEbISJjBfzp2nFCHYNBTVWjem2e1sFZv3fs+kxhsNeCBxbMlvgqcn9M/O5drPnFPqXaPQ5bBMnqdDFt/6zQ0NIbAfrS0Ji0uvAo79BqpVc0XONXE5+tzwtCq7I6IWtT21Rnzxf1B9PTPOOj3lsWkZnSVu3O3i+otq8NXp2TnU0BVlEIofwbgmBlup12tyLecwn+4gshooNankpVkYdLhKBo/q69NmgguIAE/vDcp/sXZeoH38eEQW3ndfwc/nOw87quRbxpzUDqIynNmnEtRH2otg86QwPteTerAm+LJtZ4sDCNcE22WCO3LGBri431547u9Hf9rBH9UuYEpvlBK2kHJmIpbUtUZonQRgOmkBD6FknmCJI+QAbR/3x1mstZre/m2LwvLlzJQvpwryg9r1B622UkZ+mqPkjE8p1nPrELW+fTNi0pm0F04Bug51IYHX3mL0xp5juCjQy8qP9e/xZBVntV175cQVQjEkMfwJx4eXuLIXEjARngyFzPDDNfGlUiCJxetbPA9y9tTg0nVZX+yPljE7l1F2c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(478600001)(38100700002)(83380400001)(33716001)(86362001)(2906002)(9686003)(6512007)(26005)(44832011)(6506007)(53546011)(6666004)(8676002)(6486002)(7416002)(966005)(8936002)(5660300002)(316002)(6916009)(186003)(4326008)(54906003)(66556008)(66946007)(41300700001)(66476007)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC8AmK9dPyURUEu3qUvL3dGtdFpuEfTI5ufIO/gBPNLvI4AVL9RBYRNruzQv?=
 =?us-ascii?Q?oHooPodZSySbzqDgWV/P6lrgYpYEM7IEw8uGYOfzr2hXA0hb8YfSy+fSnpa9?=
 =?us-ascii?Q?QfDORUpt6WiiAhQgBDL70oDBSZppGDsxIkvWAZ/e7GtDMdL1eXAR0jc7v5es?=
 =?us-ascii?Q?m41d1xmN9WPsrx3sZKK6c6NaUGQblMOvTMRtC3GxdNiBZb50zOVo45r3m2tu?=
 =?us-ascii?Q?dg8H9s9xECPLwIAz18Aa3GtR2pSbXbFlqcvdJuvjQGRBY6goaSwtUIts/ZHH?=
 =?us-ascii?Q?+5nlKIZa8EmKnL4o8tnzLD1OzESUuO3G3FRmlN8fh+K13Uo7v8TFw9+xvRF5?=
 =?us-ascii?Q?dKR1Zxg27c05TopUEUNfP7zEbfRy8mMItbRZ2dn86bKkiKGk6IPY9YdHDvA+?=
 =?us-ascii?Q?OvwpTF7RyntTxI6c2YaVUilja8FYzLk7tulOEpxRotH4IvtjkUYp+eoOTKjL?=
 =?us-ascii?Q?/uOEOPmVj7ry/oUl5cVnX9R6dvUsLb2X+x5ISj0kTr6Igy+Uh3QcmGbk2AHA?=
 =?us-ascii?Q?MA7/fWW3WXJgMofBlKBfqEuq2DV/xftTtCNZrTDzF7cy4c4QJ53P1qAG8Lk7?=
 =?us-ascii?Q?MhZyYl6z/UBUAMebPZhSCqQ8aVe6x3T+eviO9H6+ffGL4icD4dp3jY64bcFk?=
 =?us-ascii?Q?1Ek4/SPjOX3mLTTsReywQ8e6Qo2tTKEl5NDM7dD0YEoeg+yG9mXBr05LVSbG?=
 =?us-ascii?Q?99ab04tmbr+t8/9wg9CfwfktfgBAyMohNrS6XN9hBShhEg7eamp1CD88ep9G?=
 =?us-ascii?Q?AV0YKUzjQOtmqB/hkt7JDrpp7dmwAhrvAGx7NyBfyRXVxTRVKX08926UmVbB?=
 =?us-ascii?Q?MIka81/yqONYF8+T0mncDNNiRZRxowf+OITMICFQkUUYRcpl1jmTkKKrdwUX?=
 =?us-ascii?Q?GTuaOzmZRIo4mNnWBLwMpoftYOOSx4bUVjhjMWzw+7/xvpv07JvmMNljDcAd?=
 =?us-ascii?Q?lYUXJPB2lCz4MUjuHVKRIy1wlH+1yKLoxuFEnZZH6xd0FS8/MT+JviFKGq/p?=
 =?us-ascii?Q?G+WTSs88rWZmCPs/g6FaTMDlnFdcxEEg9aOlSaariOkFrU9lq28oDLsrGsEi?=
 =?us-ascii?Q?MMVOwkrnNpy4jEexUhJl9swyfWOJzqyjPCoEPwNWQpr0/P16Yl0UVPMs3pAI?=
 =?us-ascii?Q?aekW+POF5YXcdTnwYg2kBelZZvoVe8RFGWv/p7YaG99p0l+SuJaRuD75MP+x?=
 =?us-ascii?Q?qXRVYqtVxwYHsu8OGGRcPurftC9RsHo9O8GCtp3uYbDwUVlQzPBIdkk9KMvk?=
 =?us-ascii?Q?BjaaPSkWnl5iYwXq6o/q7I+4ngU6F7fjXt0qJkpdPP0X6zh1tZudzPHzX8G9?=
 =?us-ascii?Q?elf07UwG7ckcooSGE1Wl2vuKBsBR/YFk+veHBhY/RJVoAuEhJLcc2CLTHozA?=
 =?us-ascii?Q?xFweqWNENL1P9VFtFczniVtfQPiwGhSE8iERM5thTT/zz6KAGReMtd0exBFG?=
 =?us-ascii?Q?1tuCnAJMHcgaw7x4Q1Zn4cRWODslDWgyT2ntKekgJIWL3O3jjvKYZ7bY9Ud8?=
 =?us-ascii?Q?f8JCnN13lLjXu+9krte2R56shHvEbla9OgAtPKhIfrOACzQdl90f7hFoVP32?=
 =?us-ascii?Q?D0ljesPPqOdm+0Jw3n57c1cY3vOpioXftrXnvG50psDRDfPsT88/AZMpSQAn?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7b3pUM1/hLYNcNR/yEDC1c/VM4n0U/GZdRFLyk+vS0aeyPatLcRahjht/b9d?=
 =?us-ascii?Q?4mctiy7S0W0bpJxigqu73HvjKXEPX07n+cX9N8WtPRy9J1C6lYP9p/95pL7L?=
 =?us-ascii?Q?NFiA+Td3DwlBVYv9o9OYUTcflcqmveUysbKLZGYcm/NhS6bkMKqLWH0CHACq?=
 =?us-ascii?Q?CGNSUOokXzgp1SUz2T41ZhlmXJjUm8s6RIlcdVjq8E9XLcHo03/XkR+4FFEN?=
 =?us-ascii?Q?bIWp/NQwKYZjmiqh0htSb2MBeiuP+a6nsld1gQiCVc+dP7SFUm1NNzoq7wR2?=
 =?us-ascii?Q?hR60J3Ym2MC5mb7NXW1pRB33CNnxk2RWRlWjxHnDO4/VxpTga2Sz2G3wVPEW?=
 =?us-ascii?Q?2f0tYSQU6rh4TyZYM17e7gkCnjWxjt7rs7tZdVoMCXc2VkCcHqEsDz34DDK8?=
 =?us-ascii?Q?qlVFAyNz0DKRiWTaLJF+gZFhEsA5m9wbPY9t1a1crE1/3oBjLzlYzQ+/F0gg?=
 =?us-ascii?Q?zOuQ+BWlt5Yr1YaD+wSgb+9UTpl0fwFajhEftoJ7zpfqohXYBLwxhMm6v/tc?=
 =?us-ascii?Q?7d9EGz6D7hK7/7k7mXB8W7kY+JZWYEi3dM663S3IVnqDyzx4JVKqaeesJb1a?=
 =?us-ascii?Q?J4ZTyrHVwvMe1NHg9yG74XDoTLJHTaNgNfiKodgR9aEMjd6Bh9hKR+C45CHt?=
 =?us-ascii?Q?Qqix1kiB7VX5b1k2aJIQo5A6ErrdKu8arfiRCp7Py1SR0TAj9sU/p8ztDkM2?=
 =?us-ascii?Q?HdKG0v70kZP39nlBVSKxiYiuLyqt9+a1PeYr8QwEZBDN70yXqVkXTSpUvAiS?=
 =?us-ascii?Q?k8wDOC62GgqFEh+BBQe/69njTj/UyMrE9pPkmnVeRdUoNG3GvQIvGCPHNmH+?=
 =?us-ascii?Q?rEPEdVZTqad398K1iAbRW7MEVu9OcO/4QXS83jaaG5j1u5iPYSSDcBX/8m0Y?=
 =?us-ascii?Q?dWe+WuIzT8aUj7NC4Oa3rni913FTDbm1TwCv2oW0aFHOEp8MWD2hut+LQO01?=
 =?us-ascii?Q?57hRxJfe/0Zezz/vBqbrulxtto3kyrfTmlX7pV1XvfYG9pjJBEwiEDZvxkYn?=
 =?us-ascii?Q?9i3qte7VDgDNXS/YHihrhF+ErBVDecw6KKzK7Phm1tkC0JwVWBPHtt7GfOT+?=
 =?us-ascii?Q?fUdBaZx9pXIihS9qUlq93afUqCdFt5PD7jt4eUNbCdWYATidXI4Dypvkx0tu?=
 =?us-ascii?Q?LfdSNJnJOu1pwhj+9UC+prBF3RzcI5u1yS9yFjM15SJsF1whU2QXocw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dae4e47-89c2-43be-afcb-08dac5a7f602
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 18:50:41.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQdRsboyOGtFJXEDLosZRvICrQHCgPhqM6UIEmvWIKCu8opR511Puviz4pgBedt7Gsywx80dWhw1RFZQfGAWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211130131
X-Proofpoint-ORIG-GUID: lk8HtagdWmYbfgMYqpZt-uMirX83yFpi
X-Proofpoint-GUID: lk8HtagdWmYbfgMYqpZt-uMirX83yFpi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 16:36, Dmitry Vyukov wrote:
> On Sat, 12 Nov 2022 at 15:03, syzbot
> <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13bd511e880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13315856880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173614d1880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com
> 
> This may have the same root cause as:
> 
> possible deadlock in hugetlb_fault
> https://lore.kernel.org/all/CACT4Y+ZWNV6ApzEv0UrsF2T8JWmXez_-H-EGMii-S_2JbXv07Q@mail.gmail.com/
> 
> and there is a potential explanation as to what may be the problem.

Thanks Dmitry!

An issue with this new hugetlb locking was previously reported and I have been
working on a solution.  When I look at the reproducer, I see that it is calling
madvise(MADV_DONTNEED).  This triggers the other issue and could certainly
cause the issue reported here.

Proposed patches are here and in next-20221111:
https://lore.kernel.org/linux-mm/20221111232628.290160-1-mike.kravetz@oracle.com/

I am currently trying to run the reproducer, but it is not reproducing quickly.
Since this is a timing issue that as expected.  Interesting that this
report is run on arm64 and I am trying to reproduce on x86.  Although, the
issue is not architecture specific in any way.

I'll keep looking, but am fairly confident this is the root cause.
-- 
Mike Kravetz
