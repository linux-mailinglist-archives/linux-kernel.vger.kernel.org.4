Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7552F640B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiLBQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiLBQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:59:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3B925C5;
        Fri,  2 Dec 2022 08:57:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2Fhinh003543;
        Fri, 2 Dec 2022 16:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FfTMBNE79osxJMnX5TIcRmskvfag0bhfBUkxWqsqy8s=;
 b=vw+wOisqMRFohrdNgGLNZ8ql4GjhdfrRwv472o6oDp4Pf47q++bXj2nB8YlZIcKWG1OZ
 ztl29jtciCuGLwcrKIeW69d/dH1QOgF1y5VuoVEBgO4qRL/9qDqZsaACgQXzirgL74jt
 JXqhC4F/YkHJ5JGlS8BpAn0n9K0gheBGVXUiq0+53hRWFBwyGoraUTJunwMdPBi7OSaF
 KD6/E/r7c+Q0ed7F+BDKE4gdjcJ+fqOpzbUI5Y5uct1yidrcSyODnLMTaIfPEMCxoXml
 wjDOj+iSy8bi5mP25mxCHrHfik9W4gk+dKiT136837U0cihWbc4ICuCRNQ0pIsLwD8/0 tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m782h9y6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 16:57:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B2FPhdb002804;
        Fri, 2 Dec 2022 16:57:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398d7rau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 16:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P73X3z0NmnXloHRs1T/BO6iRpBFwgE8Fbq+vUnYTH6xPAvSNvYL4PX103yaoz3y7zKeCyWRB56+sNxeC48eDiwH+iXBcx1VIv/+2F7aJZcKIyF5ifCqX36v5yQWtMjATxjVO2zW7fNR8+yV58WyWUgolgfznhcp8E8qz/Dd8lhQSdxmLoRNfV2Kj+zHgauzo0F/pD/R5h9CjH4qHdD2dicRtr9VTpzl0OaBAJb9NMlR0xMx26KNQbxj0K4bXkAZfa6SaZMX97HVCmOlZECvLxuEmIVjYqgxpI8qUHgH1L5Vddnac9M9AneyOsaH1vUs/GV2LgcWpbQ4F1Q3qUgxKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfTMBNE79osxJMnX5TIcRmskvfag0bhfBUkxWqsqy8s=;
 b=FQBQaQ1TRZAdsgPLlKbkXqyy8Cwd8rXSm+i5hYQ0/ts37lUTNW5AAU/TCsh0hyprAwbyz3rggicY2bgxLBGVGGnF4Hr9TS+ipDUTkHrwDK0hPPSs34gXdu+cx3fdpbCbmTM5iE3NuyObz/shdyNe9gWi+oGkhZ2S1fIdzqIBLhSj9fgD4v2BPbrwgbW33MQwAcVZ1jqHjrTlXozo8x3iPY6RfOyCj90OTrzUU5yQe4uO1TO83yu56edKeTJwd2wvBCNDl6AH2vKLZRvxd6ivK6FeJmOELHpL2c0uIhC2FjlPOI3VrnWN6iMFjeo+uGFHlt+CYKFiVqzvaLpcE+4znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfTMBNE79osxJMnX5TIcRmskvfag0bhfBUkxWqsqy8s=;
 b=aT1BJ5hXQ/kOpzhxHGym9GKQM+aYnahkbofmT+ExmJ/IRAmGkMa4HbHBP2y9T7af+Fam6xpVz4+OW+Hg43/jc7HcbVeqjEPPJOMijiryw6riuwUZrS1e+k3VQuBk9Nn+kMi7NkS7b0xUVlMVs9FA0y2OF+LorXVOFSWCo9/yMZk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 16:57:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 16:57:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] mm: do not BUG_ON missing brk mapping, because userspace
 can unmap it
Thread-Topic: [PATCH] mm: do not BUG_ON missing brk mapping, because userspace
 can unmap it
Thread-Index: AQHZBmsFAkrli55WlUiTpq8z55YrNa5a0WmA
Date:   Fri, 2 Dec 2022 16:57:24 +0000
Message-ID: <20221202165713.xgiqahqfc3zvm6px@revolver>
References: <20221202162724.2009-1-Jason@zx2c4.com>
In-Reply-To: <20221202162724.2009-1-Jason@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5791:EE_
x-ms-office365-filtering-correlation-id: 05f72e01-44a0-4196-bc60-08dad48648fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzTmzIqyizLv32TTZzfBRCLDJnIG7MXq0ODHTqDA3Q7C+F38hIAzipU/ip2I9dejIaQgLW81Gtyu0b47ruf+xcoSW4n5Qn0ghuR0zA9+XgiJfWFdW8jgDOiBdfjQ1U5c9RiNYpTVE5ApDLvNANJ9d4n5+Lbzx/j+RDEIcvPvilsGPBNw399D4ca6dNE8OEIzojYN5/6Lhd/DK2SZ4d/U7zavEEsD6VpXKrS5ApbdRWUbg1DHhxgliKcbkqhSN8JzV8L/Gbt4zGvO50zlRQDeinm9KPXvK3cmC2s1BUAFJF+SJ+0cBddozhg5Imvw2Hz8qBncJi14PG+0HVwY4SB0xix7PcAqxR66LujOU2yVUfVZ1fOw71uB1YAFS0+4wadgF87Q2tK/FXQpVMS40wbjr8N23bzV6XnJG2EHyCYk+1ntxAu6inzErcf/am66jSLaxaV6xhVISwc8K/yElHmSp4RCcfFk13eherSu0AfVQLmNeM2ZYUpyrnNb8ezhIn807Y6EOGDO0gAGCFKkKlWYazfN4XaYskfzRZ9FixPcyLBM0rVWEicrIZeVNSR/Fbjgemgof0NIFDL8e4yGVqh3TCmwX+XWSj4IOeEc8e66NkLcJCqV+/Xy7yavr6oS5Bua7x4Ss1iCmrbQRkGrMfL5wUOIzNeRQ8aO2eeF2kc7a31Jy58VdbXfstncXqZZqCqEbI7f5Fp9Xue9Lk/yo7zVZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(5660300002)(44832011)(7416002)(66446008)(66476007)(64756008)(4326008)(66556008)(8676002)(6512007)(41300700001)(6486002)(8936002)(71200400001)(76116006)(86362001)(66946007)(478600001)(2906002)(316002)(91956017)(9686003)(186003)(1076003)(26005)(6506007)(54906003)(38070700005)(6916009)(122000001)(33716001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1q3jChTJuX1OrCXih/bAtkfnqePMYXWeafj6TVPt0RWU/kxQGb81yZWeSRJl?=
 =?us-ascii?Q?ybvPXwY76ab5e9lvnZ6TSx1PVAFt0Pjt5Br6CHZHAX0bWfImorr2Jz2b/bLw?=
 =?us-ascii?Q?/SxlGIsAf9Brv3CkA6NqPUn4A4YI6D7xQ8hIJZ3Gps027hy8+roJcAn/SaSS?=
 =?us-ascii?Q?txFXQO5r47vfNvR/+fPgC1r4LX6AFUwyBQ2oMP3C5Y0PUi8JmnUBK17azkz6?=
 =?us-ascii?Q?m3w9LLGW3xwD4Cd1VyPm7I6jYWysMFtVnM/QcJTa6IHymnRmhHg51WlxZx8h?=
 =?us-ascii?Q?dUt8GfVole9vDGEps9CjUGGZqvnGTEB4zKFXwczlowGpL2aV5B+dlpyzOh3l?=
 =?us-ascii?Q?MobBj3elTSMG8+nxpuRF84UAoQKERdTJECl/NtqNsSJ98gZKLBWBylFzvR3l?=
 =?us-ascii?Q?wHRcUrtnaR/cHoOXZoLokPyCzcyAaCEUwqyFO4Y+3Lam+EY5U9F8gWcMAVeX?=
 =?us-ascii?Q?PutsacLARqdVDJJdfqVdjbUyDjqH8M840r2aoqKsHPqmZVgmi0L6Mtb8GG9h?=
 =?us-ascii?Q?ep8jKAYpSEOYG5HeaGYa9tnBoa3nvpNBUJE0ckVNtThNimJhMBSbBGEq2jnM?=
 =?us-ascii?Q?BaJGqsdpMKiyIzgk8CO9qBqQPGv19JD2T/TRgBdjv+dSrq7Au0rloC80E8nD?=
 =?us-ascii?Q?r16hfzbNj3OBSdecVSdJzjYBNe3+7igG5r6s1EXODiVjfPhVdhZLDj3fALo5?=
 =?us-ascii?Q?ECD75pd4FOunkW3tfGPgLKBnANfb4P0zkhM2gZIvEj1TyVweQvTmNymj1QFO?=
 =?us-ascii?Q?F9Jd6FSEqNuH4hquDY0eTiWpwwdMQpu4ZaUptJiv+pyot+TNK5KQ72Tk8L/e?=
 =?us-ascii?Q?a65aPgldS00helIc8VGYmELxBeHCpy4oNuQnjhdCUszrVLecRnEmZebk+xWx?=
 =?us-ascii?Q?D5Nx01vNKWE9FTtIjIwc4GyaVwhm5A9eksMeedNDPlIs1YzojNM7jVgGD5kt?=
 =?us-ascii?Q?Mz+1bRq2lRPSKqA3V1KDJw/px1tR1yNNhAk6ri1ihbOdTeFyW/5XQTIHo43p?=
 =?us-ascii?Q?Q2EB121fdBCKwHy40YUz4qWcCrHuDq2CiT6FKBwyfD9EzrYf26p6tzelKg3C?=
 =?us-ascii?Q?Q2hYT/bZ0Fq4nNWrIzOKRU/gb+6dZjCGSfhpujNKWOnc/oLe3HxtdnFtHP6j?=
 =?us-ascii?Q?ByLZs6p9eVpU+XrOJv0ik0JGO4IgI69BeCbUMU9m+uOM+dxEn2W2BrwlJmy+?=
 =?us-ascii?Q?9eOir/we6AuaYqCMlh18IQh40LZtBt9LpieXOeQtLdeDmePdSamimwlUKuL1?=
 =?us-ascii?Q?K1vDgTGkVWLsL2UzjYZJISYMzdbILdoaU1E9oWQZgPoRyfmNrFiT52mcvwJE?=
 =?us-ascii?Q?RtXgwT3sJMubadVJlZoZ08G9TPzo4IZYX1Vqq/LAN11pduuf+Yj6l8KPT7aF?=
 =?us-ascii?Q?VOaiuiHuMQf26RA9aPDRbrJi+085AFGwzXnnGzwBDsBUinitrsNIHlyr7nug?=
 =?us-ascii?Q?bM/kgEcSRbv5VtRuMbQ+6DS2Ca8Jpx5v1eepsm+35SGWJ+gwGsIzPAKXk2MC?=
 =?us-ascii?Q?qdOom6nvnCD0U/eh/ELKEeJQXcc/dyATonHbo+NV1KkTPesUqBU8xT8dpi9j?=
 =?us-ascii?Q?h51YNLGLFw5EIVYRlD2AWjWLwZGJhnS4EP6CtKFaBxNblG18ddiob35VIIgM?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8AEA5C5141C184BB7368F0E67621D26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OOqaRizV/Wd1mdnKpS51hvlDm3A7fDSNkIiKUQvs951V3vGZEiACbU9QmLNa?=
 =?us-ascii?Q?fejBhk5b9NqrsdXN6roCtzC1mbWYOsmqDbIvehcx+2p3czcB6MxMZkLv3WY6?=
 =?us-ascii?Q?4aDh7x3DAekviFTqj5et+UO4Qic2VnDnpSCXG2aF+qMThGGtmY4d2dOUFObx?=
 =?us-ascii?Q?21xB4sKYzZkiSUVK/AEnT9SFg1af6sKEYpAb8Fue9GRUYCiQfFrzbWhOkhnl?=
 =?us-ascii?Q?ZT/3ZFcCn1hTx/AKo6VtU+EsWwxlQQzynsuOV3xWpJCIKKXDI8aIPVRDWqVv?=
 =?us-ascii?Q?qSbnn75opRUOts8OaPN6kCnOGkG0IEtwpBva/UC6UYB9ZfQpiHRg5Z7M0PUG?=
 =?us-ascii?Q?Yu2BK8Nj7CkX0HXuGCSKsw0s8xhty6+naQSVOoSF7f2o7uQ1N+4quvebnkbY?=
 =?us-ascii?Q?7notsmkW1WVj2WCc3gV3LYCbozMZ613sCqhpDfhuzwoRoL/r4TX//YmEI4Y3?=
 =?us-ascii?Q?y66T4NPF35tuj3k3v50bMvas2TV4TzUKv9fxEPbt28npi44GNhdY49OBOV2O?=
 =?us-ascii?Q?25RvDY5fRhftz9JvyyDtUUHg8lWCKjzZJ22MBCGcbiLPiv75689Qt0LPqjup?=
 =?us-ascii?Q?gFINPObKhkxDbLJOWiJ/leh2bHsLRCj+LgDMpuwd9YqpeIohYrdmvpm37Lsh?=
 =?us-ascii?Q?A4MHTMMFWuQ2KLIga/8AWSZ6We3i+o65cOzemlCN2XIGF1TDCHOFu22tir7A?=
 =?us-ascii?Q?NiRCeUBXpM8okaRcLBqc/pf6LU7g+VpvPFfo6PDC7aKiwoVuPTWj0wT7P0Vm?=
 =?us-ascii?Q?4rdrbKWa+WWS7j3vVYvJDyVS23QlhFw4WxVPe55nrp5NVc/z4Iq7LFY652l7?=
 =?us-ascii?Q?mvpQ8uSZj3Ir9odZsP6N8NzlCDdXVsIscudLcnwzfE6tRIsGMXbs88GFaO6W?=
 =?us-ascii?Q?//Dfq2qZQcLyd+tIIA2swv2vAsBg1cLIbRozqA2QYb0nh/hIEXy9Xuaga0Id?=
 =?us-ascii?Q?607nKnv49mqc0EEdPcMzUNllB+ktYv8y1TnVzSxZ3me0Xi8HzFAo78G1N0Wk?=
 =?us-ascii?Q?KXzEWiKKGmbbAZ4qSHKkkGWOvtaLMZOxZiyf0pNWkBoOqpuFUBGhTsshlXoO?=
 =?us-ascii?Q?Wsw/7wQKxM+VxIPLTzDFL84W1ZbbtyZn/VIPEIhjtDdJ1CL1KuBVn+5SMwvD?=
 =?us-ascii?Q?1wkjRAO4KjwfE+ib2T4pY8ESO7ND+fjU5yM+ZSD+r0/wCay6SF8Qf9Ln4sSE?=
 =?us-ascii?Q?Bw7NwaHNzWLWkR6BQATSj86DoRydIShAuNKVSA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f72e01-44a0-4196-bc60-08dad48648fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 16:57:24.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbIgXUENyYvrT+2mo0PITqYNg9fa/HM80AbWP8rg09nCs0QgHOF6oVubrrlAxU0NmOJbjQama7lZv2UxUnPIeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=921
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020134
X-Proofpoint-ORIG-GUID: y5bSXH41ZfGsb2SS2RspsVGfcWQT0rTB
X-Proofpoint-GUID: y5bSXH41ZfGsb2SS2RspsVGfcWQT0rTB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld <Jason@zx2c4.com> [221202 11:27]:
> The following program will trigger the BUG_ON that this patch removes,
> because the user can munmap() mm->brk:
>=20
>   #include <sys/syscall.h>
>   #include <sys/mman.h>
>   #include <assert.h>
>   #include <unistd.h>
>=20
>   static void *brk_now(void)
>   {
>     return (void *)syscall(SYS_brk, 0);
>   }
>=20
>   static void brk_set(void *b)
>   {
>     assert(syscall(SYS_brk, b) !=3D -1);
>   }
>=20
>   int main(int argc, char *argv[])
>   {
>     void *b =3D brk_now();
>     brk_set(b + 4096);
>     assert(munmap(b - 4096, 4096 * 2) =3D=3D 0);
>     brk_set(b);
>     return 0;
>   }
>=20
> Compile that with musl, since glibc actually uses brk(), and then
> execute it, and it'll hit this splat:
>=20
>   kernel BUG at mm/mmap.c:229!
>   invalid opcode: 0000 [#1] PREEMPT SMP
>   CPU: 12 PID: 1379 Comm: a.out Tainted: G S   U             6.1.0-rc7+ #=
419
>   RIP: 0010:__do_sys_brk+0x2fc/0x340
>   Code: 00 00 4c 89 ef e8 04 d3 fe ff eb 9a be 01 00 00 00 4c 89 ff e8 35=
 e0 fe ff e9 6e ff ff ff 4d 89 a7 20>
>   RSP: 0018:ffff888140bc7eb0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 00000000007e7000 RCX: ffff8881020fe000
>   RDX: ffff8881020fe001 RSI: ffff8881955c9b00 RDI: ffff8881955c9b08
>   RBP: 0000000000000000 R08: ffff8881955c9b00 R09: 00007ffc77844000
>   R10: 0000000000000000 R11: 0000000000000001 R12: 00000000007e8000
>   R13: 00000000007e8000 R14: 00000000007e7000 R15: ffff8881020fe000
>   FS:  0000000000604298(0000) GS:ffff88901f700000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000603fe0 CR3: 000000015ba9a005 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    do_syscall_64+0x2b/0x50
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>   RIP: 0033:0x400678
>   Code: 10 4c 8d 41 08 4c 89 44 24 10 4c 8b 01 8b 4c 24 08 83 f9 2f 77 0a=
 4c 8d 4c 24 20 4c 01 c9 eb 05 48 8b>
>   RSP: 002b:00007ffc77863890 EFLAGS: 00000212 ORIG_RAX: 000000000000000c
>   RAX: ffffffffffffffda RBX: 000000000040031b RCX: 0000000000400678
>   RDX: 00000000004006a1 RSI: 00000000007e6000 RDI: 00000000007e7000
>   RBP: 00007ffc77863900 R08: 0000000000000000 R09: 00000000007e6000
>   R10: 00007ffc77863930 R11: 0000000000000212 R12: 00007ffc77863978
>   R13: 00007ffc77863988 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
>=20
> Instead, just error out if the original mapping has been removed.
>=20
> Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing V=
MA and add do_brk_munmap()")
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  mm/mmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c3c5c1d6103d..f5a37fe9a19e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -226,8 +226,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  		/* Search one past newbrk */
>  		mas_set(&mas, newbrk);
>  		brkvma =3D mas_find(&mas, oldbrk);
> -		BUG_ON(brkvma =3D=3D NULL);
> -		if (brkvma->vm_start >=3D oldbrk)
> +		if (!brkvma || brkvma->vm_start >=3D oldbrk)
>  			goto out; /* mapping intersects with an existing non-brk vma. */

nit: The out label does not return an error as you specified in the
comment, it returns "origbrk" doesn't it?

I actually had something like this prepared to reduce the calls to
BUG_ON(), but I like this better.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>  		/*
>  		 * mm->brk must be protected by write mmap_lock.
> --=20
> 2.38.1
> =
