Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26B74185C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjF1SyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:54:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59560 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbjF1Sxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGx6RN006753;
        Wed, 28 Jun 2023 18:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=lEgLG7qVVMHvyUlEIGJBOgjofPkAf+XbcjPu4W5nzvjh3wnuGlA18tUHrLuH1jSzFoKx
 PqZp8C95it/DfqgGxeEWSY7g7i90+JIJB7FU+plmmdbD20uMSY+1X7sskJI2+XTcAxbs
 r0mU1TiPI252o9WgphE7PVx5tjjgZbne/yOJVUu5CJXAHZRCLUNK43SGKMXFB1mZklGm
 HITlcquRJYvCm5jSaq38tf3ySq94g/4LwSVs8aTmcb0ISRRPyGBXPmROXgdywGsm46vM
 ob3IfrXOjoC2z3Mm8txr6FkXZYbf58W5N1ppDg1gjIEvN9Zjzc9d6oP4afi4gxwS6Lfh SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq310pg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHaNjJ013088;
        Wed, 28 Jun 2023 18:52:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6n2wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9Em39nZDiGuesOEkZfjaMp7L/cSCL5k3bGdc7tdExLLIS2PRJ9zpLWbV1uPpHLeuXJlVIzoUPu/SDjoaKN9mZuPvAlg53xJcyVCsL3xqi91v4Z20ZDnJ0oK7nak2XMO6XVu9Uw4tY6YrwyLsQnubffSkUzKR5e1Lvb90PL7WRnnPtrEhzLEBV4HjAQgCZsBXQT22Ly+0Vvul5uMN7q0gQYSVwUyaEg4hJWGZCgNGkcFVjQ9FwfY21THtQBUWCXDKCpWt5PwFD8oBBozUfGeIbo1ltCPoEVyv2rrGHTp4RxnkIpRt0DZC9vZ+BNiLMdksnJLZPJgZCkPXU88X2EeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=VYUcQ79+rZp+nk/5js/gKmFE4CEH2hsC2rvs5/g1UsUWd5C6xiCRoScoi/hAgBZS6+66cgWS68YclR3ZFe6fSrUeGZSMvzwfJj+BozgYR3wtPUrCPngdp+tCrkf3d61A1rCIhZZeesjTQcbWFkx4M7x7RrdYaqA3vNKS6WwE4BU4dk7ahFvSw7PSVh8Tj8RrnJNmdix/UkTWOKlkaKi8nT5VkqNRrcGrvf2Qts6/J9HoiBYbT7s+xgFke16ZnT17EbW024oy7CxN/V77QCFSZIxEUSeoveU7AAeSBwvirjcpsYyI1d8VPGEXmDvo/ve169gvNiqcTWH+2LZavGOKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=YhATAq0bsmCdG97eIHi2MwV4TU7UrgYSPz4hvJz1Jx2IyLJSYLIRmc3UtuR2JN2/sruCJ/vjz//JGUjZQ3/rM9Zj8xGgKpkhgt0GjSCV/B2aD9tVoKdgTCVbKdunqIMwJvFF8MPj9LAWLHr0rODBYNu0/jx1heZbGrIWtdiiGK4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:45 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v24 07/10] x86/crash: add x86 crash hotplug support
Date:   Wed, 28 Jun 2023 14:52:12 -0400
Message-Id: <20230628185215.40707-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: b782763a-503a-4e44-7d75-08db7808dc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAnwHv8GjQaq0CrAPppI+2N1dnqG5ENtCqEkeBneH0UjT5ILpFUMEDZZ/KQxoyY2x4gSvwtKsVayLx7gX9t8SlJFx0/kG0Hd9wW9A2cZxDcKqHHk4JCELcecc8a11w+HCDf4bR9ppGKkZlULk22DA/Vga6XZE+eAfIwYloA0obJOgkBi67q3WOEt90ea3iMVu+1iyzzx8G7czF/Q7roO5GCkVnk1txxBqbapmImdjNv20jGohIaKc3oapPC+1ltstPLhovwShBHI/hMLLVhz7niMKKd4hOkfXzA1anhtGTSw7d6WPswH3RZMADizJec3PPOwvnkxcaDl0Xs9mq8sgxNyvkTcbgP3SAyJkaKGSbZifbtDuQc2hdWFKkkRS4+5A7xfGBOelwz7H2gGZwSNzlwISAcTt5pKr15dNtFa88uAmQzUAFgcDgyXaDWUrs4hYShl+PQmV8iBXFMW3YU1xMvjd+u58HeBD4hW5TyuyNrOmnwzESs/QSoYRbz2RxxAfXWw4yqnT8RPuZsbqsVNwWuIxRkpZMoX4WNGc6ChiA8VX6EQo+j5+y/eRHcDO1TavBCjVjxA87Dt/UFD2KfCZlcHxjT/a+MyA6xarD9fnQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/7XCOnGIaFXjDEm+SuMWPwhVnpO/uxGC/eugnOXRdQ9oUGn5e0xmjh0Q7NT?=
 =?us-ascii?Q?FsQfW2nlF+zTiLz5Bn3Vx0yMj3zZFDsx6Gtnmewjok7jt+wQDaLtb+pQfg84?=
 =?us-ascii?Q?aaDERrBh2tpzZc/YkE87O9w7B+dJEhsW4dxlX13HfW6GMOg3wCKtoOo+xccy?=
 =?us-ascii?Q?fx6f58wbq7Obiyz7iIHTXo2Ycc0G6ALZy6kXZ0n99vqLUJqf+kXLrq1TXVvo?=
 =?us-ascii?Q?KJxk0aNYSZoocNLvBbx/qhVUd03jy3829MPtltakSGdT6/PDd9/fg7PZ5ukT?=
 =?us-ascii?Q?oa933Kpr0J5+ihIUnAfVCCxOYlcjjqKKeDCbAGcCc+hh/aTHX0SJWXfxcG/N?=
 =?us-ascii?Q?GZeL/FefYiH//7rZsCvzhq+kqi759kdoDU2t61H+iXvJ4NuGIG/wvQxAU4Y+?=
 =?us-ascii?Q?COcAmMn4N8hSJd87djFMRqBf0ztEfvh7DmHWkdutVrGUhdl/JpCvOsfwjMGa?=
 =?us-ascii?Q?yQioLiNZi+FajXWVnJN/wuFBfn324GTrlPkg4DxVNies9k1h0jDz5RqRE9vn?=
 =?us-ascii?Q?AFHXY4GzXfH+bsrG3eXX+zFCFKLGa7aSF4dB+nEIva0uvIu02T9JLctxOU61?=
 =?us-ascii?Q?dFnxICnHtBLEu9MMu+31ofL7omP1Vo2HEynRUMRrFsIkDPB4UcwD/QarxiPy?=
 =?us-ascii?Q?WB1CI+E2ZTb7KM9QL0iHtBEnrCvlDBgO8JtNkKfnBogGsIldLShRe9jnJaGE?=
 =?us-ascii?Q?iJUaDSHQATZ2ALYfrctYTTb84UyZ0hZAd4TLEn7nM4Ovo3K/T4lY5ALFTlFX?=
 =?us-ascii?Q?rZSI4WZAG1twwSb9cj8abA/J3Rvhe5AbraEft7FPNivqZYJmYG0IzoDB0PUs?=
 =?us-ascii?Q?27KoPzDxZcQz9ElQ+VIIqDi1yR7kxfkAmH2g1oUCcl50yDa2/1yQrrTkNv+e?=
 =?us-ascii?Q?wQ81xBWi3wS+OmN1uTKkqQ4Sao+/u7wrOwKyHt0vz8hnJHujotgAV92U103B?=
 =?us-ascii?Q?0DtkjYN7UDib8LxthmTyxd5C+Vy+8WvDYlTeBO+cRf8DwimQUFvF8+UfYxnA?=
 =?us-ascii?Q?kDmuYvRdfmMjIKx+X6CBkA2kGy7NVlXDf7wNEamMW47fbz7TGenO1/+BB91L?=
 =?us-ascii?Q?sqZGpnQ+fuNziYS7Wnv8Cl6hd2Uw9Emz2SGEjb1hc2u8zN9iomq9HZE3NBwM?=
 =?us-ascii?Q?0q3dZ4q7ds6iQ2f2QIQgx01+NH0oHrWq6Qs930FDR7qpRK0cUlh/zDwGoNrN?=
 =?us-ascii?Q?lETeob+nxnxv7GxPFjE1iHRbOE+0f0D0gvlSfT6Ak8ygnw6FXdzCt2ufSbom?=
 =?us-ascii?Q?bfV8MfYRM0K82BPrMqPqvlCeuVNfW8LIsOAq/cm++Oamvzugvpchur6JcWJp?=
 =?us-ascii?Q?+LQRB+8EBBgg/lfI9asntP3lNt9RP1Spkk8C+B53eQ+NAUPnpgJ0jFbyJlWv?=
 =?us-ascii?Q?Apamzd+75KU/F+VfrJyem80EWxtVHaVhZVxNNNFXFwsNHIY+LOc2xVS9P4+p?=
 =?us-ascii?Q?UwnuXq2R5hH0esZ2j3fBUBuEYtY/+B5fdlmPmzd7kkXenCseQLattDWBc+ow?=
 =?us-ascii?Q?BGlh3kgTupUfZUHSUqUq03TSKFbmyT9ZD4SpwVg9BwxdvIBnsIb4hOzbUxDq?=
 =?us-ascii?Q?SlrTQk76Mw1ibhjjPhGuA0f7FxZ4bb8IyEiKKxHsnDQNSHmwP7/05V0QkANe?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PhOlsuzP7Zfl/Asnc9ULSLcGFd2G/qHp7GDTPtil4odZWCW7LKfXOuE84CFf?=
 =?us-ascii?Q?WkcbSWQGqCqS3m3eOWoQRsQZfEdGvIJTkaEKEFFmML7Qe7g8yoFvI9Furp0t?=
 =?us-ascii?Q?X1wvhLnHkvWfBhuM7pmJss/zqD0YezmrDnR9UlHHqZX9zd3prfCb9VG9FlPv?=
 =?us-ascii?Q?wIhO4yunsO/doQR6UaC8J0QhoZGgyPrxSXFF2f8NkuUQqICAMRcvS6giQSVu?=
 =?us-ascii?Q?BpEcTKcxy4lD4siqa5i68luRm78EwiezfV6aZthe/UtqLtbVViw8c8Po7pwH?=
 =?us-ascii?Q?37MbS1JMmPJOsrasKVerZNPbP9EpC1thiU1z0A1MjnSfL9oDTbDSlXaEKATD?=
 =?us-ascii?Q?rS2+FzQhm81DehJB/rAWYQr54KXjVtkS9d9F+8pj37XU3+3gRZhzn4jhQO4f?=
 =?us-ascii?Q?H8BK8bAdpxXlssivI3aJ42o17ZqiLsd31Jrvfx+cvl9dZ3GB5Z6SMTrKc8Is?=
 =?us-ascii?Q?NWYPNMuvGiaEC8IzQcysLTV7W1tkRqooo9acX92ztPCKljwYFTgPRfcZfL1G?=
 =?us-ascii?Q?WCPNq8ZTr3xDrnGEqiNf0lEQQGPVJPYIQ/UzIMtJwVDGvmq9GQcaZBZNBGh2?=
 =?us-ascii?Q?7Acn1m43x4iKeKVQT013r4eglEw57ZSzOyFrS9PCFI6XBpD4asUe5nM6Qi1b?=
 =?us-ascii?Q?RTOrHXY1ST3woHLkElAnp5tbclIgnkCPSLTh8UruRF49C3VZ+nNtnLB4aqdC?=
 =?us-ascii?Q?KOie6sd+PqhpxHc+KjRasgxbPuw4wwgoRnUnm2HWjxWpQm0tsu39L5/ZKCXi?=
 =?us-ascii?Q?7cYlP0slHSuncDH/m3HNbhMiDjzR38tomx8aLJ+4se0ACQg+jSTGEdkKzJ3d?=
 =?us-ascii?Q?iYl8x2FRvYBkWGOBb7hO/EwNgCYvLwmBoVqySb0qhHOMss727weJWDzKX+Pc?=
 =?us-ascii?Q?aflwWAiENNEN5c+6DXrKvn5DP6gCNbrhvs/QQeNqWYQTAnSjGjB/y/OVgYtO?=
 =?us-ascii?Q?w7b1ZGU2vL4Vhb6ke+FBsaPys1i3yn8NOd2KrpGmKOOnJRFxtspMb336zhaS?=
 =?us-ascii?Q?nU8J4Ni2rXNSu5pz2ZHsKVzXflpdDd5DKUbKNM85eeuDCP7AUNxAJSVvs9Pu?=
 =?us-ascii?Q?mrGBCAk+DK9YcIyfrGb3yy8APQ17udzG4Z8Zd41rMAE1KVi1+0MzCjuCnbgZ?=
 =?us-ascii?Q?ToLTMIHAewTQeDdlgQ/9jSHeQAFj/zXICchDTMym6mVcGYCrHlNmcGUTTqFV?=
 =?us-ascii?Q?TQhV0R1IKYbGIl3CPoS8go1ts0qJVXiWzqu7SkolPPSo4FtvmFbDzVNJ1c1x?=
 =?us-ascii?Q?f4bNmhlLJGz7x4eUjk0sPKAUaKPjBQoavMqkVeq7ru8gD+gY3godh1fpA+yJ?=
 =?us-ascii?Q?9T48jVm36RBx/m4z+NCofrq3AESDkWDXIxHQslaC2KDBclRKFOe1Vk+0PPbK?=
 =?us-ascii?Q?zYW5oAp/isRWdoqLL1nL0DtbkfYNdnBpQAjcvTsuy+WqTo7YFRbVDjnaEzR2?=
 =?us-ascii?Q?XrLBrOy0UX8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b782763a-503a-4e44-7d75-08db7808dc2c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:45.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPUexnmufsGi+qg85rP3ZAb6VWknIJSZPsLbHsURWf99qKZwxOux4y9q5SisLXuBNbSRLrWXdDCXoO1NnSTktlX+xnIJEtSe7GAxmXeSnGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
X-Proofpoint-ORIG-GUID: 1iKA8ihLIlBCk7NfbfbuuCSx3BJTiulX
X-Proofpoint-GUID: 1iKA8ihLIlBCk7NfbfbuuCSx3BJTiulX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
and replaces the existing elfcorehdr. The segment containing the
elfcorehdr is identified at run-time in
crash_core:crash_handle_hotplug_event().

No modifications to purgatory (see 'kexec: exclude elfcorehdr
from the segment digest') or boot_params (as the elfcorehdr=
capture kernel command line parameter pointer remains unchanged
and correct) are needed, just elfcorehdr.

For kexec_file_load(), the elfcorehdr segment size is based on
NR_CPUS and CRASH_MAX_MEMORY_RANGES in order to accommodate a
growing number of CPU and memory resources.

For kexec_load(), the userspace kexec utility needs to size the
elfcorehdr segment in the same/similar manner.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, prepare_elf_headers() and
dependents are moved outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 103 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 06a4472d0fc0..42c083da7ce4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2058,6 +2058,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..c70a111c44fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +229,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +247,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +258,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +373,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
+	 * maximum CPUs and maximum memory ranges.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +421,66 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

