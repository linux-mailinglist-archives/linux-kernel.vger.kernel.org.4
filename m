Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1799A62CCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiKPVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiKPVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA017078
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLUo4G016367;
        Wed, 16 Nov 2022 21:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=1LAO/gPbRuMXMGELSqf1JLfGoxwDeSccC4iE+Yt1aKiOxAcAHruNF0U9ty5Skdr88xeF
 Kb9ftl8lSibTU0F9jSuLlxA/TdMQ852xCxEgwV/lvTWZzct3TCS02O53EgfyK2uiK4bO
 WQZszkAG+hbV7L/lOsZQ8hVVWxRfwhXdXYS5ryoBWJt+1aANVerP4UlZN9Pw3B7Tuw2w
 8DN6g481VXEz4ac3NzAL/FtdhcyKVpn8lr2mwGW17/swVdQWgGDu6tZgG2pGJPiq91DX
 xLf9SuigLCqbQLxkFmaZREzaFORFGj+JTp6C9x9DWYHJaYadVeQqsf1fpGSEtW6RZDV4 dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykp6k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGKmaSe009421;
        Wed, 16 Nov 2022 21:46:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x847ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+uWAFLX0zNeM6WsjnqgVPj4KvU2j7OxOyDXlM3WYTRfYlp90AqckinbHHKaK2Doejs5GHj7HLnO05kaCkFnGxYcOW7hq3h9/oYLDYifsC1ICNochdT4joWWzwadXaeogvpBRRPiqaug5ZElBIje4okU8CNDiz5osvsFsiNs0hcez6f2qupMfA1oaS82g29yuEwbpp63QjT4ve4gLoMygIsyH+r/LWmB9xz9WqAF/+RLJYuqzljI9/8P/4FdUGm5DlHfBmPILWKssYcCeFHhd0KF1g8ZuxNc4O0BEEO9HDfvo7oayCOCyplFZm3TsrUbbz/w4Ssu/kGOtDm7Ba4xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=lcPVuGTGoQqsVBpk4v8VmefMlruzVms1A4tgKNflTmVnFkawZVrMKAkdSqkuq8K3G8ShrUDnDU4/aV2u/qX3tMyu4PDlCpXCkI525896c1DaTsfDBjefH0OcXldgBdLBY0UAPUIm4NPcskLrottqywLjsnHpQeQV3p2rgmJsFLl7WB3WGAmETuBMHUohttXKtFSy3ArIr95L14RI/yWx3E2h32ZZ5q+gjdboiHwQLW8sFgzA6RrxI70TjbeNsAzrLh8lqkufCavBszsYGIF00JCUxYHwkisbHgfSfVdox2W9ueRqqsuJokoKRyzDuhHrcHF68XQQOlvblhVWPnqbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=JqXV/Fu6W5wBC1QjBhxpQIut4L/6wv9/EOSy4U0tWEBjj+O2866dGsTHrn8ts1Zj7wutixEewQO4u41J+HpWXA16VgxIBzsLeg3rFx4Cb0Ww1JZ2IrCiyyv4vBe0y9JmG+qD4QrKzXw/ytwAXMdY0U1pqcmva0cNiQKiDrwzjKY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:46:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:46:56 +0000
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
Subject: [PATCH v14 2/7] crash: prototype change for crash_prepare_elf64_headers()
Date:   Wed, 16 Nov 2022 16:46:38 -0500
Message-Id: <20221116214643.6384-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0181.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 3603d84e-5795-4046-1969-08dac81c14aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zx7RSawR/a7q8BaEeLYBQhAyqnPwIi7lcfyua8A+XfqIa7SyGy627DLmYVNEcVzBT1E/FCZy+nKRjds5UKmuKlAdrmC/Ho45Y+5PettZlAFYbzuxuLTrlUvNgfE25x4AQMVGb/5e+CcfMvFq1pfFtolCDUDIvkCf2mgC+nx9ntqeyrFv0DTPZPFyLHJUWYkFMZdJo+Y1XslJh6Y9m7f9qVik3ISC1Nr4W5baj3IcIzP+EOqlO+Vx0XB6L4WvU29LJZUEOI0N5/xT46fGuDMVApdnC8YY7ogQyWg85L6+5lRqsZygTxLWmARuqtVIs4FpX8TNhdXKJ874w2msKWqe4mVHCgG/epSEKZKTACzoFaWyJJ6M9PAX7jvw59eAnt0qlfyammPqvWYwGqZZwHftOJqtnXKshw7rUZeHp9jlUFgb4i7dYODxhGzlEOFsHMzd2i+BBdNWxCTU9mbGISCFuTEnIcBIIMH16aAoXG8YqGmBCj7odNm8O9fAgp7EA+1HDYVcW7gfLbhGVem3G+Hu94PXme2ZMmCuxrWbByeY7h52dIySQ9uexghHLbblwOsuNzCSzGO5E/0VdJD2mnFEmj24p/8rOGypcG2hsct59L+ShD3hPc9NpJtxFLXFEEzaInW84ct7ZsSY75/Y5wxLa13gmh6dCml9TnXdxSbpfPQ8dLWdK7Qaz25KAHk2G/B8j6/INDlSKyqyRxYjYo1Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(26005)(478600001)(1076003)(6512007)(186003)(2616005)(6666004)(107886003)(86362001)(6506007)(38100700002)(36756003)(8936002)(41300700001)(2906002)(5660300002)(7416002)(4326008)(66476007)(6486002)(66946007)(8676002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhCgyWWCeRCNqrhzzmpeBxyjoMGp5OdZDfLFugpCLbfkj+KK8dHdLxQjjG3D?=
 =?us-ascii?Q?Ua8Wcn5WmQ0KlYJOMVCRbBMVuqyJIUJXn0AHcxIkwfl6R3viYwCtZ/3lqxbu?=
 =?us-ascii?Q?zgUyl19uNrfHxNtgTtAEprSaRoqdw398T8DI0+rIDJcntYabizGNGuoZu8dT?=
 =?us-ascii?Q?8AzHSYAwhXebqYBsrBj8a0YfbSk6gr5UuUS9s8vyf9fiAbNzTyGrGzzbFDua?=
 =?us-ascii?Q?g1P0yAT+StkfsJUJe0Pwa7IfRA74wL3mUKpX6ZGcSQnI9w7lRtUMqcTyuWTA?=
 =?us-ascii?Q?yh5TQ8cHAHQ+auenmnlPrAztNHfZS9jKOey2MeNUhfojRxa5Qtd27opohcCc?=
 =?us-ascii?Q?Lbjq0pOOcPRtVvHcal1sfqmk5/q+I+Uo1nWcBdvcmPiqdm0rdmrfyNYT8VLx?=
 =?us-ascii?Q?zDZ7Zv4HwA9jDJICTvcuzGIuWAYbQzr6i87XcfP6HNf0WtOdImoBpntCirjA?=
 =?us-ascii?Q?pHTAHRgyjFAgzJ4+7dY6Qq4FaK52HZzusDsQEcOVBoGECxY08Q1t9wmDb0IL?=
 =?us-ascii?Q?CHm4IhzHp+X/01kaFzXdT6uw+dJs59dI+j1FMZv9O4L1I1p175zWoegUYu7R?=
 =?us-ascii?Q?btBnW9pSIeRzekRVYK/3SBruxa9f+gXb8okiYxQ8IvLUs39ODcUgAWoW9Z5A?=
 =?us-ascii?Q?AqBEr33z/8pP51JnS4PW6L/iMZbOkey6lGOfx2RDQvXi/k5zncoWZmmK4O4a?=
 =?us-ascii?Q?C7d3sKYUNkLpx0LWD81pwS4k1/SRzmjznpP/EVK+MduF8bhh0YJZsGQLJhXT?=
 =?us-ascii?Q?GDDUvM4JumVr0lDPpyXDuG3YTBcEyE6rR2Zoa5ppHqvbuLxLtdmzFxZtnTLB?=
 =?us-ascii?Q?Rtq09SkY3eH8FAfFQvgbyWiA9zhUeIx7F1CTe1nRg8y7z5lPkO1MZwmMJIcK?=
 =?us-ascii?Q?md7BcM8v1CaTcPIVaden1RfeYtnGHG4P6fChBfB8V3P61MSZOuMjcTgYg8Vq?=
 =?us-ascii?Q?IGXSyJ+KRaGT3qbZtEWipe6VYpMZbuYkPSPqgdXr/KJdKUaZMrEfdAj3PMTR?=
 =?us-ascii?Q?K48elL/18Hm5V11pnqTpKHFi9BnhB0RfqlMTDXRQ0jB6rWf2y4bk9VLRFkbJ?=
 =?us-ascii?Q?x+AiJ1tC8+wyriHyJNI8zGBfBJxxCV1uQ7/i+6Xi6TyA+rDnvoEk6D1GXmip?=
 =?us-ascii?Q?Uupj8d6zCt/+Rlr0n0WFAZmEdUQl0e/B+VM6WfBsjiCZf++MHOm4sRKxSVID?=
 =?us-ascii?Q?oAdjoJ0fgdWddGE4dpLb62Hsez132BnQIKj1BGZTqrE8Wj3bhSufraMy7ZiR?=
 =?us-ascii?Q?UzQjogmybbrWiAhCbuL5HeC4K9exf3xl+k1Kaenjpv5Ght9I3cG7WAMlVXqG?=
 =?us-ascii?Q?7Vri9qOdYnfo5F1E/ERNtveykksA+IgK+UAejgdOlmUpZvT6SUKvPx9/8UjL?=
 =?us-ascii?Q?uxwpm9Qkkq1Qc0qw5X36OBk/O6OPvU6oOezccSVXXQKPTEK4x33wV2skW1sC?=
 =?us-ascii?Q?y/U+ap7TjUIEHjfcoMcoeAU61pgs/9ZPzExsEm/4Snew7MfF8L7GAuJCxghi?=
 =?us-ascii?Q?Bj+jg80k1meTULXbLNr4r1BEgsW8ltNwCiBj1uUVL07hsK8ZksdCcNnzjaOb?=
 =?us-ascii?Q?3k6Z3AyBijOCp/18dr3B0bUMhymoKvadbLvMo6UE1OsPizWHpIxgJ5fzDxy2?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LF8t9V/QTpcy0Ia2/C7mMR1RzQYiY+yl4MuAZ3m8NKefuAD637aa2MC6EnnA?=
 =?us-ascii?Q?b37yK1/ZojzEdkNifrwuAfjB0pP8EXHyNjwXal+RFtkhbxqJxP4hpsvpSl2X?=
 =?us-ascii?Q?ynvvQYHY6Txgg0gVMQH+UGp2SJ+xvxo5FynOIhhmjbTRnz744GRUrwSyXfuh?=
 =?us-ascii?Q?vuzVHPpyMe6x2DUDeP9BEjw3BX9t2pBjQeNh2fQl9voXkezHaNy9CXim1WpK?=
 =?us-ascii?Q?0rLG2luDRqKQ86vTs6d1+QPZIAoy48c7vPDUi7tdjE6k5QSwphwYxyq40YqH?=
 =?us-ascii?Q?ZqWCDb2FBB1Pacakm1dxxmQbsJP6DRhOpsEMuNeeS2WIlQ5/lX2Q0SWygmHQ?=
 =?us-ascii?Q?zzMfrWyycijJvcY3tM6zUNhZ950SNhuD4cX/FGn5Rnr2qVzdQaZfI0R9gdKb?=
 =?us-ascii?Q?DHbfFqEzFoYC87nc+EWgimUodRkuu39BZZVdEoe0SyiEXSdqk8yNVxu3UG0T?=
 =?us-ascii?Q?P5J3hRP0VjdhJmpmX5wVa6kYPp/j+ydIHZ5RzfBfN056bcRfXVv8cEtj/kpg?=
 =?us-ascii?Q?WQlh9v1PfY3fn53NpUzZaaCBLKnOi3yGlO0u5/HBccMy5ge1NgWg6RGa3u/W?=
 =?us-ascii?Q?efuQcCkjrOs5Ch6ZHUp3iNmAL8yQRKVKuW8kJfDJN0uoOIpa4M375YI4QNsc?=
 =?us-ascii?Q?EE2vao8M5eckocM864KtFZe9zD/2QdazEws25SYPGbBFwEZzvshLyDkhTY8h?=
 =?us-ascii?Q?8eSr+F2aP4OppqmPT3AX/zvQ1B+h4dI1kmixfipvuYK1q3mCFhhTq14NNcYb?=
 =?us-ascii?Q?wB7fDKBC9qiChsk38CgeehY9uDJbFaNSnNiiK77b1u/adRr6cU8Hx37x86bc?=
 =?us-ascii?Q?PGMMAXBjD4Zlx7Pgg0emQeuj97OrgoAtugLNytj6tCqn1hiICifcdAY1tiLB?=
 =?us-ascii?Q?T4TIUoEW4ZhiuyNCmkrxIbP2Lxu5G8N8ydPUSXBnaiQEnwFgocFI5WsmR5Ck?=
 =?us-ascii?Q?z2PsmzhSOFZJHVZEwKuf8RC7BuRjeU2n8ratipAt0BcVoIyqSEmn6s4nTdTM?=
 =?us-ascii?Q?4BJBVczUfDCzj41IIg2/RkE7N68xgMUgP2jUDyaw2vysv2jZYLQWId7+KpJO?=
 =?us-ascii?Q?j3kCH2MbJ+DStBjTZvo90XdOui4eLF+V48aL4xufth4T039h1RvdUrRfhs7I?=
 =?us-ascii?Q?/NvE8VxkO0MTLEotHZCa2DWT9VULHuBYAZtLRlZ9E3hmszKBJgwvEt0LCOgA?=
 =?us-ascii?Q?Hg4qBtvTKmqBOgvGYwmwpPsPnGcWGf2NU1oDFgUa+pJeGEuorp3cBlZawfpG?=
 =?us-ascii?Q?7uvV3EeYs30QBzRS5Jr+u0oXHqACNBVGOgujJuzScDNeBuaw2CI2z+xT47BO?=
 =?us-ascii?Q?32I9ItJzdEuGeOlCa9EenaIteGVIoVTop2S4DWYIvxLXFg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3603d84e-5795-4046-1969-08dac81c14aa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:46:56.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkLbUXZEpqZbbjj+hX3S+ROQYYR9SHdIs2NQG+TOM9ZkAyIG0q3v4SeDX1g1rci0G5bYXtJWz44dClhPwkHcVH6coZ86dxN2TYjqq3WMKWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-GUID: BxADNTa__yZ5CxHTZipuWt_SclFTyNhk
X-Proofpoint-ORIG-GUID: BxADNTa__yZ5CxHTZipuWt_SclFTyNhk
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
index 349a781cea0b..a0af9966a8f0 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -798,7 +798,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..ffde73228108 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -118,7 +118,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -140,7 +141,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -212,7 +213,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9ceb93c176a6 100644
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
index 41a686996aaa..ebf46c3b8f8b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -253,8 +253,11 @@ struct crash_mem {
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
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 46c160d14045..8c648fd5897a 100644
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

