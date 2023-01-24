Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C16797F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjAXM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAXM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:26:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13C45BFD;
        Tue, 24 Jan 2023 04:25:54 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBiWTv025885;
        Tue, 24 Jan 2023 12:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=E4RxZRTfWnXlplcefHfWEaRrxsIZSqbBVurbi55X9O0=;
 b=ImPcfYLtJ9IfonltGL2+FIZWAwPYgn1XQKwjvhNJ5DQMaFHMX+KdkHJsoc4ebTu5YWz+
 HSIVWWDDsNIsOVUNID6XkCNehD/3qsBLQAYOntepr3AJNsNcCc8XsbCWYuNXCZeTy2ZG
 0Xrog02N8WUrM4Jk9YXbZtQt/iocZzKoqUgWVXJnkgdw4CA6ONr3f2FqelLjb3cnIy8w
 926I1YuhQNdtoRqDvGhBb+RJQXQxhyeLaT8SSV3l5UfLMfTUcjsQe6Otuw43kuCYEReb
 e7dVdUxOlHM9bhbr0AlJcwk3UBIIAqXyhlSgHph61SkzqqvqsLSNuMUSbUl0J1gwwyCj 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktw3bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:24:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmnmE005863;
        Tue, 24 Jan 2023 12:24:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4u5hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDvIZzPZsVEVUpcnc1ky5tPJv3dfngH0nA60sq3rmx+0QkqAhH2Jy2dowGYUMLIByqzMELuV504W+cB7UmGXq3EZ0zNOIbKTxDFDOkFQJSSJmeWXFikhyJvKAo4XE/CqNUVwZO6ms0ausADyh9CtoqKxbF7ZG5I8jB6q2xbmV5y+CfVFQvPKzXCaGGNGNT5XwknSrQpMgMHkEZQTKT/sKq/DrSfBX5l8nlW94dWGvOFd3I3/s22a8rbGjzvZp0HEUBDfH/zJpx+qoiETbj5Y50B+1KbuT/i9U3uZBdh+qZnFP98Uo6E85xdiyIcXcjcx40xgcYvYleolMvevnz2gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4RxZRTfWnXlplcefHfWEaRrxsIZSqbBVurbi55X9O0=;
 b=INfUZw6Hi5400YkeUskVG5BjVe97Q9EA6dlp0f8ze1Af9t8UMhpnG2kh15vK1Fk+PxIxnUN25xGGVTl8Sl4Pfx2aiCtChouACb9NO2lRe1ua1w1AX9S93xor8/Rnd6ffGBFb39WBzabZ8XYU09XaRAH7v5ewn9D6Ofyw6qyxv5RVeF2a7LcBJfPA3qZljXy0Qk4Pi5P1Z/6k6AWn5kZZHnow8KiE72T4tS0bOdgtVboDunIHEhUaiZGjospoidXiimV7aTMl8FPDt1VaB6cOTKcU9EpSbIzE1keHluNrifM8L/7kaBBB15NrJvTcJ1JonFaSa//pUqfaPsJJrySHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4RxZRTfWnXlplcefHfWEaRrxsIZSqbBVurbi55X9O0=;
 b=0QUPcgHhqA4GN/alCka4TQnFYpQKZOIMZgiiFtDGsM2rhCrN78jN/eTH8kBXfrBlVqtk8CRBjC4tv6V+M4y505FrZcZ5R3pSMPtTMVB5c3cmTmpFf3vl0dZ33AVRAIYMWd4mTnabMnDQhWyCtTkYAzEj2glNJMeSG+UCutIWITk=
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 12:24:54 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d%6]) with mapi id 15.20.6043.014; Tue, 24 Jan 2023
 12:24:54 +0000
Date:   Tue, 24 Jan 2023 06:24:49 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        akpm@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Dennis Gilmore <dennis@ausil.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] sh: define RUNTIME_DISCARD_EXIT
Message-ID: <20230124122449.de6el5gd6bhzejyo@oracle.com>
References: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
 <9553643d-8802-e863-bd21-c316f2788f79@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9553643d-8802-e863-bd21-c316f2788f79@physik.fu-berlin.de>
X-ClientProxiedBy: DM6PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::29) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3d2865-c16e-4ee1-9496-08dafe05ff7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZBRmzz6goU0foZ2shFj1IPdtX3YBrVJqT8A/8Xnxwb5AUDk+X0xFEiTVuA+hnPenYAZHPijCKdwx1uenE548fqCvhWGAuZ8AKmrAkpIUhYq4oZ/+Iqm7casoccxLq6YdWcXIgyvgA/IqUaH7K/zdJRD2o1c6fg296frSFjFPf3p6b/qkDi37rhts2Zrz4ImEyjUkKHk6thpCps/sT0LOUhE1E/F6fl+pn3qfSddt9KfNx/Ka8kRYQuLJ87qMpIS8c3erA6owexCLDusUECyRRcgFlQNuTFiokjQNPJJ1hrV92PaRk6JuGttenNhwof9RDAW+XhaxFellezIc4ic/SP4PtN5c/V8cQirA9TDyayw5UMTCne4gdVd8wMo1E8aVtGdrgvVEdTW+2LVX//VhRPNbzrf19llCL24W5i9+Mg+N2HOwGH3sIBz57i8VVChZrpC2YioSqi/Q7jmNR/77hBezmXeWz9/1VZJyRyeKKnagYsYJv+pW2K6bMMt1dTOSWrM1U8HfyOKOswJrpMLQXi5Vkb8NwWVQEXb75uXs69JHAmPSVS6XHF5v8x6ZOcJrrUq+rDWtb9miQcE8bP13utMZYrYVFj9fJrnlyrOBUGRsstRANEnMsVOrea/5t8toO09TEuAQPa2fGJMFnFUlU34dZpUMj6wYNrwiYeYz76CXi0FgJtTPp9W+o4TRzonrKBviGB8imP/4X7nFpwkuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(54906003)(36756003)(8936002)(83380400001)(41300700001)(66946007)(6916009)(8676002)(66476007)(66556008)(4326008)(316002)(38100700002)(86362001)(2906002)(44832011)(7416002)(5660300002)(966005)(478600001)(6486002)(6512007)(66899015)(26005)(186003)(6666004)(53546011)(6506007)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVPK2ZBbnVYcFZsbnh3dTlxY00xSGJHdTVPQ0Jrd1JSOW52WmtsRjRxb1NL?=
 =?utf-8?B?UWFRZUE5cDdIcjRuUjVPYytYWjNUUTBoVXRYckExcDRqTG5EbmlpWXRyU2Z3?=
 =?utf-8?B?ZmtDK3BrVkhBMGdTczRPdVpmaWUzTHk4STdDU3FMSVpjbGdTM21IRllVWXR0?=
 =?utf-8?B?Y09lai9CR3dUc09sKzQ1Yno3VVlpQ2RCS1ovVUYxVk9kWnpodlM1NjgxYktK?=
 =?utf-8?B?UG5GOEtEQkJNY1cwQVYzb1ZkTDVlWDRoV1J1bTJleXBYaFF5aGdsd3FtM09p?=
 =?utf-8?B?RW1TakJCOHJpRmcrTHBUaFJVMkoxOGY0RzFTY0J4Z0hZTWhaTk1wUmdzYWcx?=
 =?utf-8?B?c1k2TEsvNExUN3RmMWV4c0dVdFAwZDBGYmtxOTFhNDNqaDYreXpUYzBYQmZY?=
 =?utf-8?B?d3l3eDIyQWhTcU9EQk0wT3FVVFplQjFQVW52K3gweDRyQjVRYmFXMzZTenBq?=
 =?utf-8?B?Q040VE1YaG93OEJjRUIxL04zVURaT3E3OFNxYWZ3SFZ6ckNKdmZYZlpndHlw?=
 =?utf-8?B?djFrMTJZaWZKVU5kditRd2c1RDByVit3NWZFbUkzQ3lMTVA2WFp1N0N4ay9D?=
 =?utf-8?B?c0VJOVhSZTAxQWxoWkNIY3FiZUppbng5U0ZRejA1dFFodUVzbFY1U1VXeE1a?=
 =?utf-8?B?Z2RtbHFTRVJ5emhoZ3FPVHFQckVSNmlrTDgrcmJUbWZkNFJNblQzbXFManM5?=
 =?utf-8?B?NmlOQm1FS1ZRLzJxUU9nYUpyS01MY2hTNVpySG14dEE3QllsSnVFWlhKbFBz?=
 =?utf-8?B?ZkIxenZwRElSVUZ6WDNtNysydkl2YU1Ea1JNanE5bHFSNHVFZnV5NVBycm5t?=
 =?utf-8?B?RS8vRHlUdjFaaUQxQlpnNjU5WmJiUmFyNVN5OWZjRjBaaW5MU3Q4VFh2c0ty?=
 =?utf-8?B?ckt0anZGNnR2UDFZZ1lZbmRmMmhOa1htcXFkUUY3bXB5RTAwd0Myd3VnT29j?=
 =?utf-8?B?dmQrU3k2aEN1TW5RWXpYS09OeDJQT0pWckxzQm5qVXk0VzFGdFc1L2dDaXlH?=
 =?utf-8?B?VGdjNitBWXR2T0d5aXlZMlFlK1kvRWdsakxVVnowOWkxWi9KaFhpRWU2TWZ2?=
 =?utf-8?B?dCtXNGpwMDQrQ01uMmcrWWNyOEE0RzNTenZKSmpkZjRiQWREbndNRzRzNnQ2?=
 =?utf-8?B?elZnc3NqQXZsT3Z4Q0kyVHRSMVVvTmFEM05tTm9rWkYzMFZPdmNCbmNNaE55?=
 =?utf-8?B?NlhIcXBzbUVWSFBOMzloeHVNd0pkVXVweHRCRWdVUEpSRzAzWTJlRmJPeEsz?=
 =?utf-8?B?VlZYV2hnVGdpTjdZTmxhcU1uTk1zM2dpZWVFNktDLzllUjVPdXkzSmJFZzU5?=
 =?utf-8?B?ZjF3VXhFc2NLcHo1bXdzN2ZUR1V0TTMvanRnT09obmIvMzQvMHM5amM2TlEx?=
 =?utf-8?B?VExqTlNBY2FBMmVQMlFHSEFoNWRoWG1zQUZMbU1zZzA4azhXeDkwZFUvdXpZ?=
 =?utf-8?B?VG5SN0VraUZUY1diYVFEcDNwOUczcGpMQmxENkVkUXVHa2h3Ny9rTHZXWkc3?=
 =?utf-8?B?SWhabVg5QVRwMWNsOEtnMmxkY1FEMjBES21TVHlZbERqSFJsdmJoUGFpY2dS?=
 =?utf-8?B?VVZNTkJDclpjK2ZhcGZEa2pBUnpWck95YzRRWkl0MC92OXA2Uk00N1d3Y0Vm?=
 =?utf-8?B?eFVUR0hZcm1jcGorWC81azRpVVl4bnRaV0VkUzBWdElpK0RyZVpSbEUyaWpx?=
 =?utf-8?B?Qnd2YnRtMVFxSWhJOUxvS0hST2JDQVJHL0lOYllUSEh2MUREVnJpQjE0UDFu?=
 =?utf-8?B?Z255RzQ3QmprMDMyL0ZDL2FxQ3pVR1l6SEV6M2FIcnlSbkx1WCtoSmNTSHBJ?=
 =?utf-8?B?eVQrL0thQjdYdFdDNHJvZU1GeFdUN0FXaTBSaW1rS0FKb0ozREN5bFBwU3Iy?=
 =?utf-8?B?dzRSa2FROTZ4WHhvSjI4aGJjM1dIams0QnRJRWsyYy9scjZVYlhXZWNKdStw?=
 =?utf-8?B?Z3ZuemJ0TUo2UytlbExhNXdzcVF4NE1HL0dmc2EyOER3Qy9yR0hTYVpUUkJw?=
 =?utf-8?B?RHBsN1JZcWVnS2lCNXFlTFpRRHI0bnl4NUxzbTlnSFhtcnJlZHdtVG9CU1Nh?=
 =?utf-8?B?dDJNZEhjQjd6bWdIMGh1WHp5NlByKytMcDkvR2RuR1c3K3RQUk1iRzVzUVZr?=
 =?utf-8?Q?lYm6FsLdZQCC+C8IORgGpaOGB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eGI5WFJPVXBYNTdVRlB0NStQYjIxbHU0R1RPR1BpUGp1bVcrSHo3VWwwUVpP?=
 =?utf-8?B?RHFCTnRiZE5hTUtCT09icUFWYUJFRVozZUtPMSs5QklPblNWV3ZsbzcxM0Y3?=
 =?utf-8?B?MEdxY09zUStjWnlReDQ3clRKcGNYYU10SXRLWkxFVFVUaGVSeUZhb0lqMGVx?=
 =?utf-8?B?MXliY2pLSThGL3Zob3pOREhGTGNYUUdaZzl6SjRBOVRZRXZ0WStGSTI3M3dl?=
 =?utf-8?B?ZGdybGdzcmtqTEtNUmRLZTNIYkpERnhtS2FXL1JGbVhYN3kveHpjenFKRmRs?=
 =?utf-8?B?LzNOMThUWW93MG9vQjQ3d2tHczZsSGdyOFBmZEtlUDZ1bW5xUWRMcWhmM1d1?=
 =?utf-8?B?U1Jja21PN1FZKzdwdHNqOXRKOEZUUzVQZ0ppRzN1cmtjNElGWWRqa1BReFFO?=
 =?utf-8?B?aHF1MElnZkxIdTI2dm5RcDFvS2NoVEo2OERKRFNSeEt4aG9RM1o3YkdIYk83?=
 =?utf-8?B?dms1dWhMSXoxbmhFaUJLNzNvNFMycFgyZFNab2VNMS9wTW9qTjMza1FvbXQz?=
 =?utf-8?B?emQ3QmlxcXp4RmdUbVZiT2ZuM2ZQR3VoR1kyMndMMlFvZzJ1ejRxSmFIbEtI?=
 =?utf-8?B?Skl3WWV5M0crNlJTTjE2WUVHaVhwNmppZTNGWWo0UndtSmVDVEFNSGFDc285?=
 =?utf-8?B?ellJSGtOQTdHRnhYM2o2UmdLWTViT1VVaVdVREg0QUU3MkI5VjhsM2pmY3N3?=
 =?utf-8?B?Y3Q1a0svZ0luWFVuSnRhVnlWTWpWdnJLSGFvL1dkeW5NakttUzFSRzU4cTRC?=
 =?utf-8?B?UmNuTUxtMmppNnRwSGM5ZFU1VE8xZ2huMGxxeVdOZllIaC80ZUMxMHNUV243?=
 =?utf-8?B?MWdOT0xBQVhLWnB2VFh1Zm1BdFloOGxJb3J1UnYvazlnYm5BYUVUeVFKUmU2?=
 =?utf-8?B?M016dXlUeTNzeDU4YjloVHJuenMzL0tpbk9vTitwaDFDdHU2THlZcnBxdXdU?=
 =?utf-8?B?bjVuNDIvRGVQOEpjNUtvaXFXRlZSbS9YZkJZdmI5dCtkcSsvbXZsdUprd0tQ?=
 =?utf-8?B?aDN2OWF3MXZJMDVMNGpmamtTMEE3Z3ZTa3RLMlU1YkF6bGc5OUNVVzJsb1Zl?=
 =?utf-8?B?blNtalJxejVFaUhhc1A3NklVd2ZHQmkzNTR5K29LKzJyams2RzBBUzBSZFAy?=
 =?utf-8?B?UHU4VjM4WjYydjhCRDdpSXoyS2tVMHpuSTRjaVBacmdEbnlYeEplTGdsR3lz?=
 =?utf-8?B?Smszc1RScmRpRzRybGVQcWJEeFdLQ0RSMTRkd09IYTFzOS9IYmQveFh2ME50?=
 =?utf-8?B?QXdCdnFFZTJqK1hRWDVKNjlXYzhPRmhqSXlQV3RHMFVHM2NPMzJkVEJnYkJT?=
 =?utf-8?B?a0p1Q3dYOEVqeUNtSE9BYXdBOURCY0ZVdlhYN2N2R1dyTzE5ekVyVHQ0emxq?=
 =?utf-8?B?L2ZqWDFBSzVHSFNwc0hLTXVyT2FLMGlzZG9idHpPbXc3QkhkUXdYdDRDZThr?=
 =?utf-8?B?L1VuRVBGU3dSSjJ3WUhSUmovd2JyU1NkUGNWdmZqOUJwTmJKdWZTYmM1ZHFJ?=
 =?utf-8?B?QnVROEJpNlNsc2FHdmRhNVVyTWNuOVZEcGEyR2ZEWUpIL0hhOEVOTFdla3lo?=
 =?utf-8?Q?144IcfqG6e3GXQ3ExDx9IcG+g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d2865-c16e-4ee1-9496-08dafe05ff7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 12:24:54.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVPouJeeXfvKZF1Ia7DnNezHaZS3yMl6QbhN3XUk3TPGAFVh6mlW53EHcBs18UKQsFq8l8m24SmA4u7uctBNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Proofpoint-GUID: nbFUoQ7p4vNDaUO5Vzc1xjI0PIOdVpfr
X-Proofpoint-ORIG-GUID: nbFUoQ7p4vNDaUO5Vzc1xjI0PIOdVpfr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:09:26AM +0100, John Paul Adrian Glaubitz wrote:
> Hi Tom!
> 
> On 1/24/23 01:09, Tom Saeger wrote:
> > sh vmlinux fails to link with GNU ld < 2.40 (likely < 2.36) since
> > commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv").
> 
> Works for me with binutils 2.36.1.

Thank you for confirming!

> 
> > This is similar to fixes for powerpc and s390:
> > commit 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT").
> > commit a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
> > with GNU ld < 2.36").
> > 
> >    $ sh4-linux-gnu-ld --version | head -n1
> >    GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> >    $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- microdev_defconfig
> >    $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
> > 
> >    `.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
> >    defined in discarded section `.exit.text' of crypto/algboss.o
> >    `.exit.text' referenced in section `__bug_table' of
> >    drivers/char/hw_random/core.o: defined in discarded section
> >    `.exit.text' of drivers/char/hw_random/core.o
> >    make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> >    make[1]: *** [Makefile:1252: vmlinux] Error 2
> > 
> > arch/sh/kernel/vmlinux.lds.S keeps EXIT_TEXT:
> > 
> > 	/*
> > 	 * .exit.text is discarded at runtime, not link time, to deal with
> > 	 * references from __bug_table
> > 	 */
> > 	.exit.text : AT(ADDR(.exit.text)) { EXIT_TEXT }
> > 
> > However, EXIT_TEXT is thrown away by
> > DISCARD(include/asm-generic/vmlinux.lds.h) because
> > sh does not define RUNTIME_DISCARD_EXIT.
> > 
> > GNU ld 2.40 does not have this issue and builds fine.
> > This corresponds with Masahiro's comments in a494398bde27:
> > "Nathan [Chancellor] also found that binutils
> > commit 21401fc7bf67 ("Duplicate output sections in scripts") cured this
> > issue, so we cannot reproduce it with binutils 2.36+, but it is better
> > to not rely on it."
> > 
> > Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> > Link: https://lore.kernel.org/all/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
> > Link: https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/
> > Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> 
> I'm in favor of including this patch for the said reasons.
> 
> > This may be moot given sh might be soon removed:
> > https://lore.kernel.org/all/20230113062339.1909087-1-hch@lst.de/#t
> > 
> > However this did come up here:
> > https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/
> 
> We're currently busy trying to save arch/sh.

In that case, glad I sent this.

> 
> Thanks,
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
