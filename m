Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C196E2950
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDNR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDNR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:26:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925559C5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:26:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv9Ps020096;
        Fri, 14 Apr 2023 17:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=glIk5TNUCnpiw5+B+cm0NSndhpn4Cxz5eoY6q6AHT24=;
 b=P35TL8/wfDvpygW/vPeMdwQLTmm47mdcC+scCswnb79E3xYWjSt54vvyaXuhfyY654bQ
 qhrIqEX85a88+JEO3pPTRpONNFauFlcrBr+AWjXi2URYoH+9U+YhJ1WmeqgKyUbyBZsJ
 ggQ0aKrFzaJIQEft9cmECVlsqLTcFUEnhpC/c22PfakRdXQsa81KS6UrRKQOz2Jx6vPc
 Ru1EUD1SAgoFyspN00uRIBcke4UguUWgSTHm6g77Olb2z9+Yj0qKg52Zflg/eQHM3XXh
 vZpZeCGyhSiUaNjQ3K4yzrl2wpBcChMqQ9qnq1L40rZMlMHCvfYCoFYgYGRNnOQVKpaf tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwppff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:26:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EFsS79037719;
        Fri, 14 Apr 2023 17:26:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdu6vkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 17:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrskt8sjDfHKH7eWixDdaUkouGo8cJLOYvx7R2UIzgnSdGYnmMyppehsZNwnXxtuTlRZ26dJGLuhRRkVZMdspTaUkvT/8drVQlki2oLjt8m6i5tvUZPBXuz3lG9M+cUEbWi4eU1yd5ooIMItU8SlZZQW897aj8EFXQ/9HGC9ih23kPcjrDs//R05E2TEEZRHJx4ki6x641r8OI3Ynsh6wZ/l9kUtfyCQSGHqJ3Rv1aCacfl6BtY0unec1XRUykQNDsr24NJAFd1me9sYzKG0ujHl54IzJwRBo7hweqJXA/POCd+wJqGey+740tgVBFeHEmLTFW3RhwnFKNuNDnSTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glIk5TNUCnpiw5+B+cm0NSndhpn4Cxz5eoY6q6AHT24=;
 b=E6nmdIKd75/ZkWqDDLZNhUN5EdErBAQHaRVsQKrpoQHzIYVTEnQJ06GPtRbRrT8FUwWTDVJwlRguOGETMdVlJkg8imAmTcjWiWC0f4GMj7cNBV5IdyJ6WQMPvaSIkcpHB3HAXPNmIhICkAWFG/Sx0YPFqy/6quVJDu6ah84iHvDg8JaAgTQz8iiFmAm1bjIWO3y589XvrQnCD78zv6mIXQ3/UCn4JhqLQB8ChkFX/zu9pahvraBs6jDsSSIeP52jh9wSKadSawplRa6/0swE6dyrJWkAHiiHxPgZtPCbilLqsvydYljx0cYGJ9k1819J1WIYeJn/ncaX7X8y/gSwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glIk5TNUCnpiw5+B+cm0NSndhpn4Cxz5eoY6q6AHT24=;
 b=Fqds43wPFz1tZNIU+TAbY+jizkkjwmsCCFXk6KGF3sdoPrPRPyLFeCyum30/UdD/+k/CvTeARP0I1ZL5dYOQZc8IgOuMuiHk/VIWKcT0yxfNjOyIrDck59ZXucIaGJfTlA/HaBJAzfKl5B2LTwDhZe83qu7St1Hgqn1etABUe9g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 17:26:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 17:26:12 +0000
Date:   Fri, 14 Apr 2023 13:26:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230414172610.f35pngvz6cilxsdq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
 <20230414145728.4067069-3-Liam.Howlett@oracle.com>
 <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ba630-381f-4b4c-3412-08db3d0d5833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfrw/k3sAOShLRDxUEJFI/y8pGtBJSJRHsRZuctC+TZ4XxjniED1l4RxpSLKqay/hGhKxwjXATG6h/VJ//y6O8f5eiLtWcJYd6zZF7At2PQfi3qWa+p/k6GdetpLcxxlc3jCA5kF0EtJxmXQo2933yYoXDPb5mfT+mTMcUPd5xL9Wn6LqBNKNCPN97SNBdmJeMeyknxO3loxHqWRNfkB9jeF6VsHkKo+WAnuVvRqGAfP8TYqujJY6FW9Naj4D+NjYFMT3OH71YAKpLCqhtMw+AwguuUeXrstFwC46cfSenUKHQP/pI3UhC+vGm8Zs3o2e3VzXUFs4g0nIL57RlEO6O5haHipQ5BJMXxkb/MhXus9USvNilAXEmLkcFmZnbSi/qUbaeViFGPZ3H2k+y/lTZTpKFdiBFqLUWeaGmF/RUOjK9CiYTkv5XXoWBWa6lYVNs6wc7vhbuDFCU2Ic9VoJpndo/RKBqOBebNoanHw57B1zpjwVIBg/68ZxtuENZ9z+hBOvILl17hEcpWcBTKJbSmNrbn8cWsD4cr0fcYe0IyzOk7a+Y/kFwe9H2zU8OFe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(316002)(6506007)(1076003)(9686003)(6512007)(38100700002)(6486002)(86362001)(186003)(26005)(33716001)(66556008)(66476007)(83380400001)(66946007)(6916009)(4326008)(54906003)(41300700001)(8936002)(8676002)(5660300002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BS7loXGY1uAGmgeISGlLaApdl6s+YTmvlYF5m6GkagYcuc/44tTx+RXzuq?=
 =?iso-8859-1?Q?q8Mqp0s4taqjlZR42ZgROapzkPi7YGo3UKCQaMz5gTivYZ+4LAybBVCjAH?=
 =?iso-8859-1?Q?PK5ASUVBePHoxMGGr5dZGtiIzHp3wpwnu+xsW2xf9XKFEhNOjtNLcmuoEB?=
 =?iso-8859-1?Q?i5XaIcT4gkPViiXT6BJpkJRdZ4i8QHaj+87/1QXjpfzyQvVfJIf152dGYx?=
 =?iso-8859-1?Q?9tygZSuc99NzhGQpsgezTGiBRslFlKgSKCKlx4Y7MPBhdD70/nHdfrVpkA?=
 =?iso-8859-1?Q?XUSVMcMYTFB4uU6yxd3IHhcssuIbyhxbqJ1T5AZv0ww9v/stTjEnp8OhnW?=
 =?iso-8859-1?Q?kRorz/+z7mgA1xln4OKQJviDbYZB3AtFyATP0O/ksrntS/Ls39rFt41nea?=
 =?iso-8859-1?Q?J9EgLfPMFEhIEvoi+iGA5PPDEQB3V10NMCEUBiSWTUn60nMXvvExy6RWcb?=
 =?iso-8859-1?Q?QQ2cZJth5Mwh27OCM3X281x4R8jezhrryLnldTj3im/GE4GLGis1fYQs5X?=
 =?iso-8859-1?Q?zA1Ig5/UodMuO71e6QPmwjfkjgYjdlxexNIEBwrbe74fZMD77Jf85Q0cmS?=
 =?iso-8859-1?Q?VyiPAAmyX6u/eeaZNpfpyfSX6uAq/+m6hsuEQWYtCZloePAfprkRLGvk+h?=
 =?iso-8859-1?Q?8w8xRTf/Gu3BTmvk5narAAHvleU17H/Zl4yi43gJtqUhMDJ4A0XcJPrfDX?=
 =?iso-8859-1?Q?JfLEgorUCG6W23m4zLZ+BwXQJrJtAIlvzWb3JQeOqL/lv/dhN25mS7aPw2?=
 =?iso-8859-1?Q?cUbZmDHHfBlsIryc7j0VcOSX3A9e4STCCpstb0y82j3WFrZfS2eHdHXMMv?=
 =?iso-8859-1?Q?pmUa2qsDIBF0F0VcplTkmaf/I9Px6CjRPIkKWpM7Nh/iV8gS8kVrYk2tpV?=
 =?iso-8859-1?Q?Rb9l6gDtCe8LMwSWPAbtbz1tGuA/CwHHzbgNDACg/chevJhRE9l4OJd69D?=
 =?iso-8859-1?Q?gzJ5nKqvG/6w/ka5orSAhhxsa237ba5ugNfJzUTdhJ8uKEIquqmr1UUs2R?=
 =?iso-8859-1?Q?sjrFZd1PHeknv0vxdhwQuBUDGOLAr4BYlAydoKGZjnIdPqx6O1ns4fmVdL?=
 =?iso-8859-1?Q?LUyjbRGUlxKNiqwulyhgsFSqy961/MHDfGeKlvUvMwO3ZoKEkBlJaKSnBm?=
 =?iso-8859-1?Q?s+tVasBP08e+tPDGiJQ2TOuFwV8WowQmO9bijnFLhkHZV7ZofoPLybxB9H?=
 =?iso-8859-1?Q?lvbsxD0yQl8bnPAJnoyrwEBPmK9LTyYS/cgDTymEOZDq/Idbv9zhJIoowE?=
 =?iso-8859-1?Q?IBijVWE5DkI627o7t/piZNlQk6AQfs7NGv/U3S9b+jc76uN6L/Vzwvs6tr?=
 =?iso-8859-1?Q?nvJCENeQOHcmArKFCDb5OhgKn/zK+6VsmsiFAH34UveaoErBA1XrUVJ5vL?=
 =?iso-8859-1?Q?220TrVx0fKeREcTANu6yqPdarSxmxaUtk6tf6yB0s2QTfGwPZZax1za53k?=
 =?iso-8859-1?Q?a7ThTUTv4H9b//3UP5hscSkupT5EJ2Ulpj3mXb/8g/f5xy1IMD2Kpoxp6r?=
 =?iso-8859-1?Q?wLklAmgZk+1Pyod7N5Rl0WoR3ST6WusVwXIXnaDVRCNsmnZ8cQTKmMUu72?=
 =?iso-8859-1?Q?eJsQVeTdAe17fkcSQHeVE8m3pnihavXLB9q7Z41A6zNGEbRzvglVXhqtza?=
 =?iso-8859-1?Q?6zWMC6ZuYqZFp3Wb0wKEfJXPmTdRKF89BKGyLa7uRQag+icEyxk5gdiA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CXmcQ8nc5VoiNBDyUBkgc23hiAiSvS+lldov+YDSd9J+5/MgCI25iJGatW61exNHLVXNFbBMnJm5+PJDSomHK9kDvAYa8Pd9xiEzOl8qImJnmTy2Z8Wh/Oxb4XScekzlFjBK+HcaFBN3A5nAuLiSum91Gngr5JKaHyr0r3/zhP1vwj22i96zJ83Opq5bZbbEvbyauE5A2UcUcDvrLlHMpqldD9aR8rdfI9WHOiSUCVXFAkTMv+8MmIaz1f99162TL8VFnrihl7C5SBHvsHrtb/R1dUcicyXUNlp3ANH268K95LlFD6m08mKFQbPnOznF0uti9WjZIl9U7qcIt6YBY3Zn4hfoU7koXeloPoU4WQAjKFtk1HBIJxbxdnpW4jDT3iCIZDmVXTeGKzy3jrPI7mzwWx07zHkGjETewuPTOpPW0M0ZuPlBtZwdViBgG1GG55sdWjye1vctQmyFbPPE7N1LFNveSEAAwHHw1tnOTxa2aM4qZ0pfDgEwVScCsaP8VaO6sW5KKbtl5mmLDchFpANaMyjaMklgZUXLqoMzhe642TGepoWtBkum+SNXikN5WBJgaJ/SzBjhPIWmo3NWUbGrCLlwflQONn4zkbIpH/EesmA30kkYiP9E++m7wGZC72IX1MVEKgccSLXXP7hpA+btHGHMXz9Jz4Kl9bmhMUv2v/+WMC9NF1hKDRjrzL+MJORpuxS8dGg6thtlLka509NXGIfxkHb+nypbXLa0WSwU401hDNQU6TAGeBWgtXcKd6ZYdQ5l70VROxfK91rxffs+uK1fPiNYmdd+DWFjF0UixVnG1f5mClw6q1Cf0WkYHOzniiJDcdJYOIwLZMNmuTlb/0iOoTx14ieJJAeTSYpCTqZqq3tQi4+3Dcxm11oY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ba630-381f-4b4c-3412-08db3d0d5833
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:26:12.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLGiIjzDo0J0t8aH4vY1z7DH7KkkQfgHnyYQJj7Eq3a+iYnJvX1RDUEJEKEzPweuYJHYLtHM2bFR10N+aKyFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=736 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140153
X-Proofpoint-ORIG-GUID: _37JHsgbSarbeQJUhzuU5YsqJkQIZi1I
X-Proofpoint-GUID: _37JHsgbSarbeQJUhzuU5YsqJkQIZi1I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Edgecombe, Rick P <rick.p.edgecombe@intel.com> [230414 12:27]:
> On Fri, 2023-04-14 at 10:57 -0400, Liam R. Howlett wrote:<br>
> > +=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_next(&mas, ULONG_MAX);
> > +=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) {
>=20
> Why also check VM_GROWSDOWN here (and VM_GROWSUP below)?
> vm_start/end_gap() already have checks inside.

An artifact of a plan that was later abandoned.

>=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (vm_start_gap(tmp) < g=
ap + length - 1) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0l=
ow_limit =3D tmp->vm_end;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
as_reset(&mas);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto retry;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_prev(&mas, 0)=
;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm_flags=
 & VM_GROWSUP) &&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm_end_gap(tmp)=
 > gap) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0l=
ow_limit =3D vm_end_gap(tmp);=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
as_reset(&mas);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto retry;=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0}=20
> > +
>=20
> Could it be like this?

Yes, I'll make this change.  Thanks for the suggestion.

>=20
> tmp =3D mas_next(&mas, ULONG_MAX);
> if (tmp && vm_start_gap(tmp) < gap + length - 1) {
> 		low_limit =3D tmp->vm_end;
> 		mas_reset(&mas);
> 		goto retry;
> 	}
> } else {
> 	tmp =3D mas_prev(&mas, 0);
> 	if (tmp && vm_end_gap(tmp) > gap) {
> 		low_limit =3D vm_end_gap(tmp);
> 		mas_reset(&mas);
> 		goto retry;
> 	}
> }
>=20
