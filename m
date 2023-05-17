Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75999705C72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjEQBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEQBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:30:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49111BEA;
        Tue, 16 May 2023 18:30:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxuAR020400;
        Wed, 17 May 2023 01:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7iBOYzgDh2IfhA6SvcCgwNibtIoxmkK2XS8iq7DIXaU=;
 b=n/iPgdTqfLIjkQzlkl/UQ779jUgSQWP1+xXT7QFyXIxbN2eLwnTr+W/v4dHID+2WfEwN
 Q0ymeQUn3LMhVuIv0d3CoF1z5q2ZpMdSvyKhRPYRFpZ3VhfSumMxS68xc+P6oAPa/qYY
 CjtXOBDw+zMhAO+keuIefsHHA9g2hLoVO2PkS01WhN1iKNTQAqPmcbXnk6Ckfub2W7/d
 NnuYynTP7swrPIhYzM5ghAR0IsS2jnQdqozSGqDnbttrKhWhpOb1ARVgza2fSiNMHq8i
 OIPrl+7/o0KkeaNopVI36e6g352RW2FAjYmtshxg64iZt1YddGp/t9hvN8jL2aBPfyP+ Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1524mx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:30:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1BvlO033880;
        Wed, 17 May 2023 01:30:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1059xg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjw2ldSP1vcy5/DJMbbg8H5rgSxwFmRIF3YUmVWVjowyQFYLkcIjtzCSLznfeVhq274FOIwhd1veBhO6vQU847d7malxdz13o54LKbOvgtEm/mQ56xcK1zE0cg13RIj/6sONcuBF0Xf/Pk3sIxe95OhhelqM8wJbX/NtBEt0Vlw47ywiyyvgjk2WrjCcpvVqftUcI9RxF2HkDc3nyFAIZtXCrN6P8MdrQx2FNOWCVolG21yMhozQjbSDyKbYtqtWDyeV8PlNipw0ZM29M+bXBHpvqwwSKYsIK3Y9vh87rBCSIWI8rxGIr4GZ7e7+1e6Tsn3ZCo61l9OIwUGsgeuoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iBOYzgDh2IfhA6SvcCgwNibtIoxmkK2XS8iq7DIXaU=;
 b=StMIKjqEzRQYZN2P6BpF0kZmLsnma+o0qF6mwWVRXR1T5uPtNV35nZ88Q5fwBusin6cLKBBxXocvrc1t67vwMfKvDvMfor6wQQ3AInxPvrIFjpXmt0QJUAeOFpAei2mt7I7BFyQoON8kC/efuRTrRKsHNW5EwPpoKcbFAaSDKXP5aocEKNoMY0Bp4pk8cTpau/iF+NUOjWcnNjgY00J2Ki+dlSACo0Po5Lsyj/8T+AgJ01Ak+bpJheKaH4YqIlOqeUI0LYNitDaK9s9QFm7fvI17i4zjPoavZf0Pa+EQLl8ehf1sFI0wIFliO26FZETbMTE0DLJQNVahq12KQCTfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iBOYzgDh2IfhA6SvcCgwNibtIoxmkK2XS8iq7DIXaU=;
 b=xcaukpsNfhL+c0CX7jyO7nFrrT9/dWabwR4pvbn1vpzHtxE7vputTQGvbBZ/AI1uYxx4jOfA67SZBqH1xuKmhSMAW9E2osbN+i0VOhzAjNtdUrTiJwqDX3i++mMBHuZtJvUTnLRKfNnMLdBzHeG40S2Q484t/BX+aDwxCCjFrWY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 01:30:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:30:40 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Convert union megasas_sgl to
 flex-arrays
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y8rvj60.fsf@ca-mkp.ca.oracle.com>
References: <20230511220957.never.919-kees@kernel.org>
Date:   Tue, 16 May 2023 21:30:37 -0400
In-Reply-To: <20230511220957.never.919-kees@kernel.org> (Kees Cook's message
        of "Thu, 11 May 2023 15:10:00 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b905ec7-c527-4b38-a88c-08db5676534e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gt03oK0KniqdsmpvmmY3LOJdymKbTZWfOhvFXiMs/YxduXy2rWu13NYYUaYNMvbA/ec8SOzSBgEdqK2K/PmYGLdm7qqjrm1QULJLs+P1TRKachFWkFejb4KcH198ApdJwoXjbduv1enXi4t+SJhYI3kj8n6jDNssf4wf7wY1jP7+a5g2UOz5GipuVB+qVLnuyPVNpXTxeOq4UEoSRnLvyZVfMk6ACygNMjUVLpC/BVNUjDazLSf+MwS+Lh+y5iGP/5tlm5ixQckjaORuWu/V/PfUwS6BkqCoPs0FKwUjpVMzCnzLxlvEdWKIVTph0pLlxz3mEJs9SYObbOOUlo6HR7r/z7bv0b+h2IsVl9E+6BMbNAUBnWax+hvp2PKirvy7Wq+A8p/MbwMvcErp6eL29iEfNGgeBVzVyw0WpGQ4KrlhMjwRvp+XgcQMqWHglEK2AuRErrnt43iby9Unu6lYM9F+bQB+StBYAMlmaAykdMQ+ee6Qv8ggebVdoXwbUvCYXGByFbvj2dxBDAgGyFojML2f+8UjUA59RAIPcFdAbTOOU4Jc4bJysA+6Mls/SuuE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(54906003)(2906002)(4744005)(5660300002)(7416002)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(4326008)(6916009)(36916002)(6666004)(6486002)(26005)(6506007)(6512007)(86362001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XKY8GGoRQkGzawKfnQ38trekVfDwOX72WXbixBTqv/PP9BGwUXBv0/YNrh1?=
 =?us-ascii?Q?HokCFbNmK3LaCAOxTifRnKQTmwuppoXYw5HaDgbhtjPs/XQAvga7ws3w/URq?=
 =?us-ascii?Q?/xFjeLc6KJ1MtBNLg4Q+AFzl5B9acqOMju9jjm9RbhEDe3JC6iUDqnkF1SxH?=
 =?us-ascii?Q?T+hc9fcAdr39GcWQ5ftoDgmC6J6J6S9MsMASbZiwE6/IdKEDrkRHvqxDaanm?=
 =?us-ascii?Q?BOmwfAfet3nE7ner/qKdjUYbLvucL4OAam37X/EWjzLjMM6D6qqkPmfUwymf?=
 =?us-ascii?Q?sFa30cLP8jVP8vg0xsbfk1Pxqp7Qxdlluy1lbb424Qo50aTFqbUWMb5lns0z?=
 =?us-ascii?Q?HQx53N9LRysYdvNa97mQmPtEU9ul38LKByoVjui6UdewOD0tvApPOu/p0pmv?=
 =?us-ascii?Q?x5+jL4zE4DCEkQWaBq4julfJlW74m/WU2dimV6IRf0cAr4gGtxNcxgFjxqkP?=
 =?us-ascii?Q?jqGjmTe29hraUECUlEdecs4xRP6pUFgBcltq8jXocLGQCFYiwe8/kosmxYuR?=
 =?us-ascii?Q?Gn8o5lemHtM+gqvciN/P0S96NInHLhCE+ERcINX+s5Q3YIIcYnGGGFwp+3wC?=
 =?us-ascii?Q?KqXZTYt1PUQ0IEmL9ty8HUforAE286VF5ht5T15+fpbWDFDzag9Ti+DkSwDi?=
 =?us-ascii?Q?zaXEBbalnDzsBa9+nAGOZaAKpjlHmF/2SIetkEr+I8HlN0+XOcYYcyUQsUyd?=
 =?us-ascii?Q?IR2DRce613iJVYRjGSKJsG1Tmz5uZqqYeFvMclEh6rb4M2uXstNqXFUT+Uhx?=
 =?us-ascii?Q?fZ8GCkuR+KLKOwORDVkj4Qut3PBSomKhEtMpm+fwhnTWYkYqEU1D8MhN55QX?=
 =?us-ascii?Q?ga27Cti+KasY5h7ER0h8u2CKBUJE37RgHMo/wm4GB6HdKHUdFVrvNtRP/Nku?=
 =?us-ascii?Q?DMTm12ImPrspPzSYH7sWSNPCJeU6kZDrf1ohNihfYvVikPinnaduW1f3YhDV?=
 =?us-ascii?Q?JOd53ztbx4S/V9GYAuFnirvM36S8UFeSCykcFcAltoxONvxEjcNsT451Mn0M?=
 =?us-ascii?Q?+9wlms6JWnD5oJDqgSraf8SFOkELxNYYGRgCLA2EgHxCmXuN+aM9861i3Bt6?=
 =?us-ascii?Q?gZFV7/FyYlGk5RZGWD+y4FzF43HJ64qzCg8ZvSCSK7Kh9dOaVolkMzzSI1AR?=
 =?us-ascii?Q?loHbf0ZtCJVnVtI31r8yEPDSWSuRYB7hEaA4rQLNivb3dHUoVaakUemSK76i?=
 =?us-ascii?Q?+aUXdsh1vhma9kaDrQ4tkJ/J2VyBjmNSfJzI7adNP7HLgtkBaYZ3cCr8plXh?=
 =?us-ascii?Q?MmDhRk6Q6oN0eIlS30cFWKBmLFxVe5a9gGgLMUxKe+hEEZZcdA3ZI0oYza7D?=
 =?us-ascii?Q?C+3m0hed6+essyZDoKCKlzJuSQ12IeRiZWZkAMFzly5hxiah/iYQqu2X8hqF?=
 =?us-ascii?Q?jRTmBr4lI0sO+wad7YjuLI1ZDZ27NGXRf4Ldobs+4SmTAVNCDvf0xas28tEO?=
 =?us-ascii?Q?CvvH3RuLAYi7tWFLvTh9Ujv0iJ6VRUtbdD6+2IYmjR4iUO2+jva4vpzcEeNC?=
 =?us-ascii?Q?jsFKsTUEj6L3MdPYuEJt4LC6LQfauhfgled+QvKwxSqsl6MKq3wlW2CBQMBQ?=
 =?us-ascii?Q?BgDZVulWAIxOOspyMseptnikNWEne1AMYf42qdgLKNcOAXXT7tU03gGBWXY+?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hW8CSJBZ4iZQQkOD1Rr4dDNFtkVJghlojzQ0s+graFldIoVRUp+yKy5zzObHFDo1+LTpgRnOsDmsovbncD/Sw0RFjlBul6B6jL+1E82qSU9PYSUZmVy3QufgB89QYB3c1g0PLU6MiokURa5B3DsufaVecn12XY09WunNaI6dBnm7zwydjoz78rSIDcUZbxpFvZvldSyPuNTTb37ioYQ17cqwZ/lXrBziH2DOFSBrMoI1jz8FxeN/jGTU3TS8NVFx0W9EW8ImA1My7kwt6cmtTDI4a4nCdzHRmLuvbm4v39v0EE1Tx+bqZqdcJsMWEfpB6SOdc2QnnEQsDSbIR4rzFiEv2RM6AERdyoXQfVwKJbMJhR63til5tUcUR+hpMC2usE5jvb8XOt8VcRGUHiry4kIe0a/NA8TRwY8rwr9qwsjEdU7IdmzzoK7LBKghkQcElihaeRHblvW9dRHuabh1n/Y91tjnuylDSkmFSyELIA+aPDL6E71tZJTzUvvsk3uSBS+Fja9cCwsU9V2bJldUNczHCHeSr6V87gJOtMJZGC54qh7AaQJKFLv4RctUGZS68R75q7Rte+V0Gy8sZBnbDrMhxEqSqnSo2QjXkFLewnIUF0iTdvJ1hq+loDcGnO7AX6UFVfbtPJeTjfobtuULdC/rU+Yxsu7gwytWodUIEOSyEarrJFicL5cnA3pToAH4Gjvlqwu2x0yhbn4AXx2V3yH1u4nthMUOeVUUCY1vDA4B38al7EcqV5j+HesPtiYwR8RrnOy+GDX/ZI9+xYxZD4nDzH1QkcH0pqsBK/cepO+O+qhGYZtr+YaF4s1Z4LFCjeOAkMh6w81ZR3nVJLUUa/trYRGt/R1a8sXrzWQTMA05stoldwXDylM32GWlHmNqIPMahzuVavKZQgtzhCYPmg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b905ec7-c527-4b38-a88c-08db5676534e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:30:40.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEGcpwLpnt5g61IWaahfcOZSGY67YRlAlMIzZCiwy3iBKdg3mhTHyuAYPzLDEuJeC56xzphfWj3JYHIWBZZwkdQUir/r3rgWJwIhniQYahA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170010
X-Proofpoint-GUID: RYW23HvXXJuSOffsOPj89g7k9p1jilhQ
X-Proofpoint-ORIG-GUID: RYW23HvXXJuSOffsOPj89g7k9p1jilhQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> In the ongoing effort to replace all fake flexible arrays with true
> flexible arrays, replace the sge32, sge64, and sge_skinny members of
> union megasas_sgl with true flexible arrays. No binary differences are
> seen after this change; sizes were already being manually calculated
> using the member struct sizes directly.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
