Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A66D27A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCaSP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCaSPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:15:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0C1C1DB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:15:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VHOWLU007457;
        Fri, 31 Mar 2023 18:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ryZTOobqz64EiDXCeygPOfLBYmvnzRWaSND5dgHL35Q=;
 b=NxcHKC7uK7wGumd4dtCt+dB3Tuhel88LjUwclPk82P8Sa9fWQUsbgnGD3J2F7cqo/NUn
 7s/x886L+mqX3XUb+PEXM/aX56xtCev/RyrXP026NXw8zHaPk4T0CnuL6C89+yVNGKdM
 PveeC33sunsU4t8vji3h7H1rB4t1PzQJ0xLMRBbu867kEySfIp9FJGwlX+arV0bSdexs
 PsKSFakm17sn+uNJFzG6flb/rbiPdUpqL8pkfD2Z79W9khCbdhoyv7jHsDLI8TychxLp
 Qm6TKl6KrF5+b1ae2GnJxHT2hc3EcdcrCbHpW6SdVzIre43YhXzdvMdJOrt4uFIPl/BV Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpeqvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:15:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VHcKSL034750;
        Fri, 31 Mar 2023 18:15:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvxcx2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcToOUYLWIAhjfwoXaG46lJhRnrdTLwjol3VoNOYg7h0GNuY6Mz6uOMmjrjDX01LwbAXgBQpl57l2h3a/D6zcVqAiKEc1nJLx8bn1VAVPVFcY8FEVWHjqSdhTLvvUeyZL6b0m5OReVml2LkLXUq392fnp+M6nj1vDJA3IAIKzYdWtpc4eyTrCD9sas1f20nhIe6BF8hV2kv45qxDPIOaIl0kNu8IGzmxp/sMK4ATQ93po+lABAbE+P9fXqu0SP9KwXC75PDpbLkoNhm+RH/qsOQF3MghU+jD+dkzq5Ok0EamJlZzqQo0CIO/L7BQ/ZnV0tR3vsVJJf3G2IVnViu0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryZTOobqz64EiDXCeygPOfLBYmvnzRWaSND5dgHL35Q=;
 b=OZAlnRRbaoj92Z+PEv81o79ZrHuWqqeQI5wgaFd62kLhewwZtSzKrpnv6liqfg6m7oOj9Urk6IA6XILChIB5RkrEYAbeIyrBNNtb07m8VThXB0SF9wAaZqqZ4fekBXLiZEO3s1+5K1QpiihrIu1xC9NQk57MwaI8REddMBhV9e701G25o0cO3l93hje3WOaYZmwlBPSG4MPlxXo4MZ04tSEzSAGJyM0UnvGUWpi1+RML10HMPWL7hQBzUi+5ZNdxbg7EfwKvm4KFfb5AJ2QCKN1NgC0M/b8ibkXFCSwd8bgvT4DoHo1cyk4974gRsVptGRGwZ5gfnYtGxT2CQ5AEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryZTOobqz64EiDXCeygPOfLBYmvnzRWaSND5dgHL35Q=;
 b=JdG7s1D8uYU6LSIAklk9d++++nSTp02YOSfGTCwiad4ojI2Bjv+CGomeYrPjqCbWStQbhFitZRAhUxmN4CIIQ3VGxmOKNwnRZwSeQG6PHzDe6AcPWLbbx+uYGEa8vZoi9idMzOutLEnbaf5TZ+jJHy+FtDECx6IFYpcCWZHTtXs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 18:15:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%9]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 18:15:38 +0000
Date:   Fri, 31 Mar 2023 11:15:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into
 one
Message-ID: <20230331181535.GA12460@monkey>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160705.3106966-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160705.3106966-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5335cc34-3cbb-4b67-63df-08db3213edfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2CEs78Lux4cQSTz6WFPsH8SwfdvEQqy4u2Nniph3fy/JOt1gXMUA52mxOFB0imssMHqHYPWNJYUymOlF3cgdD3WOCWq3j9in3wPr5wW563Snw+E6rVHGa/CTe9VL8EtU/jNNuFuEeLrm6lNeC78ox8bEffvKsjCABb3/jBeyqBBLocq4i5CI5t+HwJAVif57roz0eu2W057n7lrCw7ehZES7lOf/4hE3PhrDFqEdg2sVuLRWAtyZXAjrR/VIY34jMhkTie0bsnSn2ltdkOIR5fQgZEHtQCSb801JSAmYL1IhEzCXNj1Nvp4to4q9AVdP3vsuFm6+jjPNIQkQIW/oIEwRX3NffOmLbyZksxLM/V3pRBsitYJv9CLLnAquHhFdm1zUTKPoZhIvH2C3xHhSKzp7biIINmqcZLlWsHltgyf2zamKPdWyWjZXz8dhRIl0VP85N6YPTVy6Ue+DCZ7nL5N3P1xh8AYDfr5dUB5oPqsk+Ryum7X8W5zJJrcanuU2aKeRoxa1196Z6Iv+wo9Vi+3qsKLM8ARtEuWY+EZThx9nfDEpU4kxqDiHD4nsNuTGG6/tCT5xT64exWicoT/ZXIlSwmwyu/ZfLOMRNvNH8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(2906002)(4744005)(6916009)(478600001)(83380400001)(86362001)(44832011)(7416002)(8936002)(5660300002)(66556008)(6666004)(54906003)(6486002)(41300700001)(66476007)(33656002)(8676002)(4326008)(316002)(33716001)(66946007)(1076003)(53546011)(186003)(6506007)(26005)(9686003)(6512007)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCMJ2fdG5fEGRD4MP3m9bFZmAuUZSG5S1YIhyYd7jXEgCv5VNh6iiZEch3J/?=
 =?us-ascii?Q?shIFCf33X/E+Qt1OFKiIOw8gsnGbcY/wv/UvlPOsnrMRQSiC/skYB4WC7ZPC?=
 =?us-ascii?Q?qpyN/Ly+u0HQjjmaI0cSw1TRQ6VXOqkqomFfLJo/k/83NH+VThZd932Rgu1s?=
 =?us-ascii?Q?0BhegLSsHtisYMML6WrYwl9HbFi0WUT732m9LI8Lor1iH9fYFIySab2jthSs?=
 =?us-ascii?Q?OVciTwasxrsYVq02pyglBBsqTwUIjBovzyyvnZrv3ilDMLPib7fxA06ZmEiQ?=
 =?us-ascii?Q?GdxEx/36qUEokh3Ycuz9RPuPmIx5XBLHYXL2/EycUZE4Y9e8mELRKzu4FyQq?=
 =?us-ascii?Q?XeqEo6tdMM5A+HpA/MDm4rbudF5SD36HV2Nv5z01nEA/Yh2xo8JC5I2bSwDy?=
 =?us-ascii?Q?EXxvHdGeSuXhTmHa+msQHW8ITShll55qVbeVl3YDfs9jcx9YptYAVpTUv9zP?=
 =?us-ascii?Q?7yM2oHU1hkwpcnkWFxJ5GyzSVS7m98rqD0kC8/TNzB7B6Pwsn3Dncypiwjkw?=
 =?us-ascii?Q?1GJZHSFywITg+CgUyyVpPMMu82x/klhJ4Osv5qcgkrpYnwNvQDSRVvfmgkvo?=
 =?us-ascii?Q?k/mL9PpDLOo+CAvi/ki6Nzxn/pVdfv6EYoHccB311AQGiaSIKY7UO4qBZxGh?=
 =?us-ascii?Q?H5fduniFeJQ1/Ot20FPHPVghcwVcINKHr/nKM89Iq2SBp66zNXNOACjJIxRX?=
 =?us-ascii?Q?q3y11Q4c3IneOwXbB0BYWY8tuMyVWHdlXqvRm00nndXDwl5HtO1YJ432q2S7?=
 =?us-ascii?Q?z4nnFyhjWJ/wn/ZXH7CPFow40aQoc0I0wivlJyvE+F6ibOXnc1olBAjrDcpO?=
 =?us-ascii?Q?4V8T5bVjC19Z5wcU/bjdOwr8Ol9R2qzzxe0PRTnQJtTwvi+Zl/P7XDDxCDlB?=
 =?us-ascii?Q?+YNYBQ7fV5yTQ8mAoPkOy0OpWHk0w1s4utpaTCdqnZuvGIyTGnozvIALLtY+?=
 =?us-ascii?Q?JIzru1KgXR25G5KLlV0V0ekxvN40Mdu9FNveSpDpieGXcEME8k4evolu3yk0?=
 =?us-ascii?Q?1OVU75hNeWTfgDv6l7kG6cwciFIjNmD/vgQLTtqNGj0JwRsQsIEhbBdDcEcz?=
 =?us-ascii?Q?sXANyfexjj4ol4AA+p7mhTMxaMlhLLE6p4CgQASmzPUO/voQcp4YLqVX7WNC?=
 =?us-ascii?Q?q8P6BJxaWWoCV5aKTV/ZVfuXCROB5v6uahyaq3fFo8FgfBjajTkW57boQW6/?=
 =?us-ascii?Q?F109O8m6/Tyn/DS8O/cppTG23b3v3vKrsPkeJidqDeeCqpx3hj3GAI2qCmQm?=
 =?us-ascii?Q?qDhV/vMHqNEAWmdU+qy4wfxDp27a9gZUbD8gevGMwNQaiCyDaTF26757Eq+f?=
 =?us-ascii?Q?kvF32ZTQTPgtWDwNeHdNkFNef/WqtV2D+ItSl9QaNDG07FWBM0HlH7N+cZYg?=
 =?us-ascii?Q?/gEyMr8t03y470fd4MFmDPYcj7c5aRobKAaAeqJu1s9QmcMdV3jfZqTG2TMu?=
 =?us-ascii?Q?E7u/Q4e9mFh0WWUutFpdqGaivjDuJse6eLejPO2WWGglPFkdPUu0WAZzTfrh?=
 =?us-ascii?Q?SPy2hz/WVY6D9NBEOAwMwZx8u12oKF6KFEmcbWo6jlOFhqWg3ANiD2aRPrVG?=
 =?us-ascii?Q?TMSHK5qJZ7xxBJeJmNHflkvyh3IURhUeRXoJqpp+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bf8UUoIJzPSydi3RomVQ3x+KTh5RzwzN3uZ3Id5vYG2EWGgFNUKunzD7wXKd?=
 =?us-ascii?Q?lOCb+kMFxdxkD6ywfKlOzFBpWeT5agxeQ7cBfr8zXVev0wBt3V8+nWbgi9ti?=
 =?us-ascii?Q?u9q3Y9uTV90rl+KaYheCvn16xcPqyhRdbz5G6VamPT/qPJjWfcZ0XVvhVxvY?=
 =?us-ascii?Q?teOBeXFt/gTko7nMtu3tSCO4aqC34M/5EEodKtzLVvENzknbDp3iadG6dOad?=
 =?us-ascii?Q?c/HBOGE1aeeb3JD6x3lWhWG1I9+PllSumhbKvnFfDiR/OvssmvgXRu1NU8NM?=
 =?us-ascii?Q?0p0GM/uEFukwUV70etmVm7338KHlkIFljf1Ag+W90bqg5PDhf2SpsOkmfA7U?=
 =?us-ascii?Q?+OqnWhFQdCpcBxi1/VTQH6XKy24DgbSo6wNQFngoqtwMHmS4hCKGjN6wY6cR?=
 =?us-ascii?Q?g0JqXBpPuq/vaibZoSWd7Y0FgitnU/0grkRH+LsWWmIUloQP37kft2/P7R5E?=
 =?us-ascii?Q?fJKJY+gYZboUnUdmsP64zelwA1wyXMUycB5Fn+sxRATh0xIunBf94nOLj7Q8?=
 =?us-ascii?Q?IdVtyjeOgaXgDKBkF8tACqr0eUCGLI5bEhMr715kDvCEl5AOfxb42xNvR7DG?=
 =?us-ascii?Q?si7L21XRxbhEFum5WxLzsqMS9dgJI3yOnVAti4Pi7YrOV7RR5vt3DbAFCIL6?=
 =?us-ascii?Q?zEZNwLeKDaTsMhwRtrkbutjn6eIlTL5mHr0TMdkER+SrPRgIj0c124x6g0zd?=
 =?us-ascii?Q?8Gnb3fNJ23K4wppJvBGq/jCN/oBhHQvJO55VkCPlR13dd4x9UhiBQP5lv5RX?=
 =?us-ascii?Q?cFzEQtWur92Gz46zO5ICuhLA0hPoGfbEuP8Ll+CWndDB5kJWq3JazXYBmKWx?=
 =?us-ascii?Q?O9eeC9E0nzj27++1V/p7B0lIJ6pK+XzMp3gy67NDf7SOo5u4yNHshYT+fOTr?=
 =?us-ascii?Q?b5vuK83CBh2iaTefX486NChTZGEtG81s/Ch6juJahNJld1JxOhZkTaw5gACD?=
 =?us-ascii?Q?p2QP/du5lG+SaEu96gU/KVU4ZLGvcQewFTCELGJR4dQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5335cc34-3cbb-4b67-63df-08db3213edfd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:15:38.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7zgJd7JPrFHkM1aU5hwXv7M+SIg4rTX/pJyuBLiTE2lp3dlJksnJ9Fz9qsyyRTLvhtPZi7xG7Ogw1z3rFLYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310146
X-Proofpoint-GUID: _RTF7Gr-jp1isbKUGhz8l9WzeC7RXU75
X-Proofpoint-ORIG-GUID: _RTF7Gr-jp1isbKUGhz8l9WzeC7RXU75
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 12:07, Peter Xu wrote:
> There're already 3 same definitions of the three functions.  Move it into
> vm_util.[ch].
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/hugetlb-madvise.c | 25 +-------------------
>  tools/testing/selftests/mm/thuge-gen.c       | 19 +--------------
>  tools/testing/selftests/mm/userfaultfd.c     | 24 -------------------
>  tools/testing/selftests/mm/vm_util.c         | 21 ++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h         |  1 +
>  5 files changed, 24 insertions(+), 66 deletions(-)

Thanks!

Some of those copies were make by me.  Sorry.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

BTW - The same code (even with '... copied from mlock2-tests.c) resides
in the selftests/memfd directory.  I did that as well. :( Suspect it is OK
to leave the copy there.  But, it does make me wonder why memfd is not in
the mm directory?
-- 
Mike Kravetz
