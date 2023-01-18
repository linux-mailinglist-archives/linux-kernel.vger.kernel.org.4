Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAE672AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjARVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjARVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA564D83
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKmkKE029504;
        Wed, 18 Jan 2023 21:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=wPvd7rgd2CkG32i/iHGtaxg7bcz/HOGRE6PPcA9rw5xWnC2bToqUBekBtkMFyeHvKUwi
 qZPmYqCyY9UZsEB8xYJqYFUcVXgG4tyOePvrVtMOvViV/RVJhcg5gyIbfDvrCX1kj/HD
 uDB6dg85DMmiEKA8/BAaGIzgvJcdTnkVrF7D35niv9EsUOyh7K601EBXBS+KRcJXzaDi
 oR0MV5sM+yXJ66XPBT52rv1O39VRqS3wvmpOkQXxi0i+tcFY6FhcnGBK8LsNyFQZbDJo
 01t8i/k0yVX8w/zTXaZ/naSsePpF8wp8hVZaBdEEGQwksBQuRIA1u1lNM/CNC99OfUtb ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0trpuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ILVkZC009793;
        Wed, 18 Jan 2023 21:36:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmcu8p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjPjfDB0rRaC2d+QLnyMVIxHk74F/TBBzSBVRZMt5AGIDFq0YEgQU8waZShrksa54MOao0+ZZ21Nqg/FKRdak19Iq710oOOm6KuFRi/tTTp0DMI6FnkOfdVYfcJK3BbFrxDax3n96Jd7oxOEl94eHHxvM03oBzbyuf7S/Xy26DXiqtlsORBr17PITXdehSMs08qPCrULwT+Cofu4rJ7KXkAjnjRi2tAp7HVu/i24H5Dczak0zmrlh6K6qs/q69kTYQWwB3OxxUNCAXbjuopPViXkpbZG0iiKYKfGrilWfhKf2NGqdJdWjbzN/otnH9NWczvQwOfuLQKdnaJzuKErYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=JjwLB7ICGNrqOnnWXAyy1CFQNZjLvp9B0U7jzk2WBZe6zlASPHX8O6HoNUfwOqRFW2fvqRZBsA+Hfbrt+Vk+T4mWo7zJMrzGWHq0HuUKH+gghPs8Aq4n8h8GReKITW4M/ZhSuSkMron2NxI70gsX8nfgUbI86yMyayH3GMo8WEQHDCvAxoX0HhY4Ywr68qK2MhHBfpR/MForVeHNGiuYCuMznNv0QnsfO+o3aD+v/LHRCRuYPcxInFhMo707qKmnofPkIlbQ06V2aMxVQPGbJxEobsJJyH3nRpjPctAqSagcyxRPIiwEsRvQWDfgI/2SVlW6sshKAZEfONMJ/fh/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=uHwU35XwVj68si3cOUhL5JdAsUg4lGbdwpl4KOSC7JQX/OJls2UHhRWWNgKcGOhgclR2zF91x54HNdMxAyORYBxLQR+9fXfFXDCd+OVy9VxrDGIvIzduZMSys3WyxFtdVhBaeaVdbOIXwPDwOTZNy2/keYeNMDMn0hhvEaYgZto=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:35:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:35:58 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v17 2/6] crash: prototype change for crash_prepare_elf64_headers()
Date:   Wed, 18 Jan 2023 16:35:40 -0500
Message-Id: <20230118213544.2128-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: a233ebe9-cf05-4106-ab34-08daf99bfc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaIYwkmiYkXNCLlRzezxE7WXk7YvMeGG9GruZZnPS9In3LLmMeBzUL6Qae9sILryYP1x3pXPn7yxfDRaVCjHueauE5KEabjQzTc/BUv5jsharzXuS7o+2a38pqUk1ZFKQD09frLT8PsrxNIGVr8ZPO8rhL6xNDe/YaFveepqrJ4dhQhwVpKGlq37i6jrzAgewM8fDvB2rB58Hn/WVaio5MY5R4f3b3NqHy99l+FI0yvCVZC+ujDxSurvyB+WkqJYfa18SxYGANZqs+KHsKYCvdoZSRJ0yhDlTHJXj0sbN39IYL7OueRRtuyE1pDbWfqOvLEpomsgQ0PmF4YXDktyLF5+q3mDTwcSdyIdOxWf8Orcopb8N2BXTpcXwoUZYIVQD8xbbSfcbT9aowJ4hjowJAblIWj3kbAs7YZzfWcOoI/tItS3em3jXGKVDwtXdGmcWjuZYuReluvW0BucJp45MdSySz00Xw21br0cDst5PeO38FWmnM/jFEuA4GpdOqupPpmWmzx4QxcAlrlDIf9GHgxHsbkmE5/xe2ijYbI5Vxtlqc0ErodZvBQgqsP5csH1AYhrQeD9jW1nEIdP+l806wZfl+tsSZdfpC8mFrI9NtCZpOcDPO6ZONZk5Y6SMG7ryjnee9nxMfO3A+iF+f2srA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66476007)(66946007)(66556008)(4326008)(8676002)(36756003)(41300700001)(83380400001)(86362001)(316002)(1076003)(2616005)(2906002)(38100700002)(8936002)(7416002)(5660300002)(186003)(478600001)(6512007)(6486002)(26005)(107886003)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMzvsufwjwBgSAnF3rK5nf/H+M3EUIfbOfQUZdWHg9PYHQnqaQ8c5CDNuRJh?=
 =?us-ascii?Q?sHNpe7Rj6VoYHTYrXxwnJO9lCmrMu018pQTDZp2RSDfVAZOujs/Ztu/bt0IT?=
 =?us-ascii?Q?HK/yweZugnwRm57Cz9XzTh79BolIhyUyzdpDDN5k/3AYmkvlQVIkwFL3flCp?=
 =?us-ascii?Q?5Pbp2INRqUBnGN327JUx1uUnSwjuuCaeyEorAs/uYKajFj/Pe3IIwgTDwui0?=
 =?us-ascii?Q?p3lSs352ps5o/Lsq40pqZFSN6mKORwggM0b/b4vnh/ouRVhFIg5UzMcoapf1?=
 =?us-ascii?Q?swy8nsMY4KVMMDzwaVDQg+xBJmlFheanYuwKyeOFYZffnNxh+YbEfi9l91PA?=
 =?us-ascii?Q?0biNiQsWkV5pu4rtj9JLReQmcBnNHgT8KrAkD4s0rncLse7qQsXIg4wn6KYv?=
 =?us-ascii?Q?EkEJ284n19+9CNUweZBKH1R7TR5UXQ4fm8IcUsUqOmFhGAOj/1pBEXPmbZGa?=
 =?us-ascii?Q?ONfWFTPWIIGFRPDr5zmy27K47u9K7G+6GIkd9YtSjUpp4IxiWHwJ9msxG6Ij?=
 =?us-ascii?Q?bRHsr4qU873hgIswOH8KAbGYVMk7hl512roVX6RgmrprCBJH8r2b8tBIJgbp?=
 =?us-ascii?Q?WIwgbRQ21WNQqPyueLIM1QHKCQDUrRb96qIbW996WjskrtsHjW3VG8kiOqxN?=
 =?us-ascii?Q?rSlkFsrcZ7UdetZfT7W894OdQY5TiDQJJXZG/z3FlsAF7V/1DIPvdGgNqcZ1?=
 =?us-ascii?Q?M8OFaziXwjMYWfIiKwljyoLaCS8FEdl35pia3+quYiK8UIm3UKtqCMaI2W/5?=
 =?us-ascii?Q?hGmh9yI3laUG8lil8rbFnXdQOGYwEsQcAjAN8OTa/2SIhyl+C38HBa4neolC?=
 =?us-ascii?Q?vRanko/xPN5QllDsYQ/gf5PuMHZ02O/iNHDkO4pNmFlxuzaS/jVguhO/x0ca?=
 =?us-ascii?Q?cmCAFheBENqCaWp4PW819h0xnq/JQktG2iTJkNefUAEJAz3JL4Iwb63rrG5T?=
 =?us-ascii?Q?5qPJYB461em8TfQxDzSGH0pwYUHyGmYRv0hNvf4LfF0TvhVOgz66eIpf7qCR?=
 =?us-ascii?Q?VS4xX49Dcp6xS7kZdYs/DmiHfdbGCH99/G/cUths3oGkwrjbQiV23jfQ13MW?=
 =?us-ascii?Q?uYi3KQCKprIauYuMzZMO5d611XUCzNqvIuyakrCIbknVDCMARXJ1C8CZWjyZ?=
 =?us-ascii?Q?GU3/okDX+EfIEesNNDBR5Wh/yKBOIqVkg4VwZ7oV/LscoDJBKA7ZsN89j44s?=
 =?us-ascii?Q?BqqZoGgSZYZkwG//YKwo2YxHc4DgKTTI5KKtH+zA29kPvaF2TFLaJMXd4uP4?=
 =?us-ascii?Q?P0lEl4HRIqrevUCFArbhZefJV9DnVSNUCygTiR2HqtrMcCjWUXdSUIif90Zl?=
 =?us-ascii?Q?ZCXFDuBfR1Y94MfJO3qglRCrHd5C3xIMSOovdFP+3NYD20wscXYrmuvfr25u?=
 =?us-ascii?Q?+DfLl5CcAoxJ2qa8Y8Im3hTMrLlhbpM+CgXK8YHGEbqJzifavGWteQS17PlY?=
 =?us-ascii?Q?GiFWIcssOW+vX9Ttsp3rlPHzZAHKvHwI9/KixoV8t9VnpcbafRy47pC+P5Xl?=
 =?us-ascii?Q?/p0ErHhojo2jYchFNzDhRd4haqrH8/vGzSEPFUxKhd6/IwWRxdxXTCqDKtlP?=
 =?us-ascii?Q?B0RDnkc6v9+H0wVChs37+Va6RThadZnujIkaNb+0l5ExiN4YFgvUJUOsOlwS?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CQWweTHbtaIMQm7ca2rrzybuMWmDQudyERSi/Fn61mPc3IuKQKFrxKB5TdKI?=
 =?us-ascii?Q?9WqvU9inDrse3WVbCoitmRLhwn0tYkVrfu5adBnsFB7ORFjhaROHSEU1+vd9?=
 =?us-ascii?Q?IYQQrXhPKvM/lPEx+cIc4yyTqQtmxzEva/5Ji65I66XCqjZh264BUT7UC4Bw?=
 =?us-ascii?Q?un+eeGBjtQox+l8TqoWTXcLHW8n5buDF/s+T6bUwShzWqKf7c+0VgsEARes4?=
 =?us-ascii?Q?de4h9nwFcwE7XMlklF8cA4vph02q9fOHS09Hm/KCYHQzt7e4DQa6hJPw46CA?=
 =?us-ascii?Q?OtA3WXMaY2ADrgk6AlzOEcoYqZyxZitBOJud7c3GHXhNTsmZuxFlSEWL/+mB?=
 =?us-ascii?Q?PwNNk7ENFOJH99JmYmw2ZufZQaLsSYz3q/VLWHfPVZC5innpEJc9sdMudglm?=
 =?us-ascii?Q?sUsv3rZ3zy7EKUQJ2MYVj9i8gUPfq6EH32OImVPxSovNdj/ZmmfFOWWspGoN?=
 =?us-ascii?Q?7S96aEXvgTtkI4kELxmh73rY8zMGCmRsZnuT5j69uOvbZE1MHoI/VWbc7tyw?=
 =?us-ascii?Q?33XLOkm1p0GubzSnC23Cbf/2u0YJuZLgLkEjRQbeXTJCfZgWUT8cwVtcBFEF?=
 =?us-ascii?Q?METtm+HU8TBTI7nUlfg/i5Pj7SQ9pc2mwDoFdTRuxzr2gm0qe3JF11PhOjml?=
 =?us-ascii?Q?F3BHEhvkJvsIUiMK+lI6/1YYiehikuJMOHy7N8QNpDmRBOcCa6IQ3EyLeIhX?=
 =?us-ascii?Q?W8+kY/R/+N42g8B2wppr5vd2bjOhsvOGm9H08A45pw3oKdNA9wKPtOjpKuNy?=
 =?us-ascii?Q?TSrFADKGGgelLADL2UsWFeP4jjifavqevLR+EWQ4yjJpZSOhdrxXbkLncCCD?=
 =?us-ascii?Q?CrB9bYRjk9wtgzUTPLVt4aiPIPnpGUUSIA5zYAo+vHjJ0suxUWEdcLWak6TJ?=
 =?us-ascii?Q?U/PeNpiOPDs0yKJX+NDptKCBFDKm7dGwGYRlJdWttlP4UGLXtO1H+Q+n4V/Q?=
 =?us-ascii?Q?/h/SWqEIWf5xPrk91jlc9EShIfgbp67Xu8gTKAGKTbflCH8QZppP9AwDoVgC?=
 =?us-ascii?Q?qZHCC/erQoeJ1lbPzPrXo58EVUIitsJ5nW1nZ8C4I5pNBNX7AEgq8Q7SK7+i?=
 =?us-ascii?Q?Ur4n6PCSDFmTPjHHaWvv7WIeDuTUdhZ+0vjpNaa00/IX9nMB1pJdGaLD4ILC?=
 =?us-ascii?Q?2qmAT4rHsZq7L2CDq9qXEysX/7PFDklayqgEjW8hpQcJ789dGtYpUe0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a233ebe9-cf05-4106-ab34-08daf99bfc98
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:35:58.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0N9bo9Xf2UN/aGBnXJnbJcD4YmZ5zA3VZjTINH0PNKVkAUyiDtJodzeXRdnhzU2AR0jgpLkzyVaOcecsYFjVu2uPr0GasQkh4xDo2hxdIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180180
X-Proofpoint-GUID: GIJgoJuvIb82DNaBuRyALJPnmxL-WiQS
X-Proofpoint-ORIG-GUID: GIJgoJuvIb82DNaBuRyALJPnmxL-WiQS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/riscv/kernel/elf_kexec.c          | 7 ++++---
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..2f7b773a83bb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index af8854f9eae3..e51d8059535b 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -799,7 +799,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5372b708fae2..8bb2233bd5bb 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -130,7 +130,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -152,7 +153,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -224,7 +225,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 305514431f26..8a9bc9807813 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 582ea213467a..27ef420c7a45 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -117,8 +117,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a439b6d723b..a3b7b60b63f1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -315,8 +315,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1

