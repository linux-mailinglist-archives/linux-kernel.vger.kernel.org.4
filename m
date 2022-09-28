Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5175EDC88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiI1M0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiI1M0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:26:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE290837
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:26:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SAf1NX002257;
        Wed, 28 Sep 2022 12:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a/cPUktkYrfgFOWAxSuTYYCxZkqTtmyHPv+OvbEhvRQ=;
 b=fd5bk/2BfytjQStsopE3Sa2FaUZ4TK6CMahY2bZukSyQ79JPhtAxUbxd3AeM/zwNPT6R
 GBxGfvsHKZhlTJkjmeJtJPWDFFF1akaU2TieaINRSgwPXiQ029hOIGVthPBL2dPv2qVb
 1HzEf+3rKhuqK3z9BwBqJn6ySTMhUltggyZibld2SktBFgHhpFXBhkUJy8mjJOHQZUeS
 3rPEnVLkY8CPdrF1n+P9RwWIG3o/7emsDOiUp+qR0lKkZK1T7Soal/CAgekduvvqmx6v
 5vQKJFaR4rDMRORG2ifLo3HGSur8qkVqCHWUccWJccznamLyFz/r2TZUZkZFCeqm6kY8 bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstps9nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 12:23:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28SBvsS9019624;
        Wed, 28 Sep 2022 12:23:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuardxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 12:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVsYDqE7L5gPoBOmHfI5TqB6jyA4k2U38/4ZI4tDjgBM6J1eD9pamU3j+GiE6N7wk9cHPEGw561Z/Q+/QTOklA4vvZJappa9+xjKCxKWJEizbGnz3Mr7cgqbZDBz/tPJlWuSq9Bm34/+mKyVLJZkU6IdBQYpPqQLE8jxyAWf33Gr4KtmdiQZIsqRjPiRZeuve74NVRD27BBbygvDZ1xG03kmHXOb5+OaSVg0baPwOWiy+0l4by80TZ608g/24ApmP+fy3CMWJgIOJj+3jUdiG0qdiM59hVORq5EH1c7BdIoE9phJUKTAbxJYYt2T7ow0jgKpEA1afA5hKf70pSU20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/cPUktkYrfgFOWAxSuTYYCxZkqTtmyHPv+OvbEhvRQ=;
 b=Nf5gpnvUk1Qe2n4vDkNO5cqfXC/FJa4XFI4d4+Inx/PkHbyjTNngjsH8fI1S+7xoAe/tXevcjYyX+dfcVJz9Go0g8V/lAzoGyLlW+E/IOQoL4fm5y29EUkIxvKxfCs4C3dUDhIL8eWgbH/P6dJYIwksefutU1N/JxWEHHYTC53DGx5ZnZJ4HnLIpcN+lKombQph4LUSx82pJPhRo6RB1DBM3L00pa20EPnbNiJU85Fsu+1Dnjs24SkALkejnYTWLOYpQFEIR1H9i0F+YSBMyfDhSA0zrt4IhaX+v7n0SJ6H4u8qvew79zfApGysmeYHw4/K0sq2pe1EJ+konomidRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/cPUktkYrfgFOWAxSuTYYCxZkqTtmyHPv+OvbEhvRQ=;
 b=ohVy4RWnazvL0R3pr4n9Ux7zZAFxJVAewI/Af2mZmHMYaN6bgVxvXhJbQ5i6NbU3Szpa36pZs+oREm0Rg8KjJB/6Kdbv0eCzDzkZcDB3fDBqq0oWMcZfLXo4iuUoTnsDv5LfxXMWfyaIbsfKbCZTH1p9FPcn2Rq9TzoOK2CqBvY=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 12:23:29 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::9169:d363:ddfa:1129%6]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 12:23:29 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Topic: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Thread-Index: AQHY0p+r+C0GBSjLKEmsL0ZKYOnQPK30e1IAgABIZfA=
Date:   Wed, 28 Sep 2022 12:23:29 +0000
Message-ID: <SJ0PR10MB4623A35CDEEDC5329E3985ADFD549@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
 <ab8fd1b3-5c36-ed7b-b385-375fcfa2ea9b@huawei.com>
In-Reply-To: <ab8fd1b3-5c36-ed7b-b385-375fcfa2ea9b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_|BN0PR10MB4872:EE_
x-ms-office365-filtering-correlation-id: a7c76f74-77e1-4e91-b8b5-08daa14c4021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swhtW+I0OYgV96MDZ+4K5w7+2/0C8ML8XZmZnYxzuZI4enCvijYg07nmoz9F1aE0pd/9723jARRxWzssnrHYkxNOIRbYN3EtZGdmrM1NiTR0/Wpr1H6zIiKl9ZIMXsXLZE/nFc1Qz922i2MRl39bm+rEbWP2yGv+E0q8BKvZuTPHR52bE7c/vJNFtPld+rTF1m3pSm7r8/8BbiGEg94YTGcrZyKBTBMEh/H/oXHNzSOv6k6P4m0y59mm2Mz1Xj8WIg/5LYw41ezpckalHYs2Q96LpMNfVVeiVJcCtqz6ykj4A+WEmnPhRwOVh0Uk1SKWhe3XX4tlThStsBHJVcCJEKfesZfdhfkg+eL4Ajc0FideXzufmoHlqiJjPFsFvSrFIlpQsHXns4zd9alrC0i0BnAWTuIbU+wgjGmSeYEfBMsOUDUsD+JGcIitFWWPvRgkxeN4G1LpyCjgXcjB3KTs5v03cP8s0qNP5npRtibLS1aQLuSI6UmGGRZ37nvAd20UxGmJSMz6E2xugO+YHosvMfpVxQVB9mgtYcl3vTIXstoX0nuJHC8oOO2nPQ/4jMn3t1BrXhH4UM3gFmo4Iom99kuB2psy5i7MUOed7OZrSfGPnYH7rn5XkP37Suh9v52eNRgGgWCuAdIxs5riH6wdrM+amTLHPt5mcR3/anrHr8G0bfKH16HL0clu54olKV1mtzomkD27S5WutPRevSc/6jh1b/DENMmuZcUvSRxrq93TQ6vvYZidp/8ZsIvVq01F6YzB45hcWZo1m5IrN0fXwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(83380400001)(2906002)(316002)(33656002)(6916009)(9686003)(53546011)(26005)(6506007)(7696005)(38070700005)(122000001)(38100700002)(44832011)(54906003)(86362001)(55016003)(52536014)(186003)(5660300002)(8676002)(66476007)(41300700001)(478600001)(71200400001)(8936002)(64756008)(66446008)(76116006)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzF2WnBpdjJIaU9QSURkOTZnZlhmblAzbmZiRFlVNWNvWVc0eUc0UW5vejlB?=
 =?utf-8?B?Nkw2WmVPd1ROamx3NkRUcEZ2eXdmTmY1TXpTODFXYzlNVWc1ZUkwMEw4dU9R?=
 =?utf-8?B?bndKaTBPUTFnSThsLzNXM3RtZkJ2Nnc4T2lxMHZ6NlRVTFpISGloSi9pSkZk?=
 =?utf-8?B?WmUwakhlelF4UGdta0ZIT1JzT1VvL254Y0xPUW5LUVFvazBkclJHVFQ3c200?=
 =?utf-8?B?OFFBTzFBTS9hY2U1bmIyMUlsamhsWGFYVndUVVN6alZuVG5lelBYZUZjWHVm?=
 =?utf-8?B?MnJYZ1BGOEEvV1Z0U2xETFY3SjE0RmF5QjR2My9JR2pzNXpqL3ZTRjBTVkth?=
 =?utf-8?B?WThxSEdwUXE2VUVoWGZ3TiswdnM1L0ZZN2lMbWNUdENDZUk4djhaL1RGN3hr?=
 =?utf-8?B?dHRuZHV0T0djRVVVR1ppdEpnMUVEeGMzNmxlSWhjdVdjdlJaWkJoM1JUYVAy?=
 =?utf-8?B?RFVETTRCbGN3V04vdmNncWRKVDZzMEtpRitIdVpUNG5UbHFlMVpaWmo3ZHJW?=
 =?utf-8?B?cnI2YUUwdmFERHJlUy8yckZqZXYxNlFtZFB2U3Ezamt5VThVRytJZFpWNmlt?=
 =?utf-8?B?SEdwc2JPMlp4WjFONVBYMDdkV0lHeWFDb3dMMUIzZzRxN3E0NU5INmwrWUJF?=
 =?utf-8?B?TkFnZHBweTd3Y3UyUE9wL0hibXZMREx3TlNtOEVDOU1vMnRtM054SGJXTWVs?=
 =?utf-8?B?YnlDVzcrWWNGYk9obTNlT1RQamUzbWNRL0J4SWRhSy9LMS9seDkySGdQMCtL?=
 =?utf-8?B?eEVKcTZSL2tBWGphZURPQXNmS2JWME5oYkluODVBNjFLMXZYekpBb2ZrOVpY?=
 =?utf-8?B?bnBmUDFrcXVtOWYxK3Nqb29QRFhUcXVYUFBmT2RQdExCei9TY3pZVnRjQ2hT?=
 =?utf-8?B?T015U2xhVkpKNzg5MmpBTXFyS3VGbXYxek1pck5DM1BhT2pCWWd0L3RSb3oy?=
 =?utf-8?B?eHFuQlI1UU5ESmVnY2pSZFlyZVByeFBtQ2N1eWNRZmI4ckxHTnhlWCt5M2Rs?=
 =?utf-8?B?MmI2bGczL3FrVzVaSUxVdG1QZUxuN3pEYk8xSlcwVUZLNmJqLzBBa0JBbjFE?=
 =?utf-8?B?a2dmV3JlaHRya1UzUXRSTlE0bWNhTnlJZE1CT1g4Z0FlMThrb2d2L2YwMlUy?=
 =?utf-8?B?Z2JmenVveDBiWkh0djhDcU1rMVZVci9lY0x1eVl5YmhEZ0s3dXNRU2p5Y0Jl?=
 =?utf-8?B?VS9pMldweUVwdDZZYTVuVUJtUlRmbExiQzZPclpOU05hVFBTZG9ZOU1FN2VU?=
 =?utf-8?B?Zlk4RWwzM2FiTjBWTzVBd0swZzJnQ1Q1RGtSYkVGYXZxOGJYNWUxaW5lZy9y?=
 =?utf-8?B?MFUyYWQ3dFYwZGdhdVVTdGVJKzgxbE81dk5kSGQ1NEdwY3g3aUdMMWRmV3Iv?=
 =?utf-8?B?L1V2VmpvZFR0R2NhM0NDS2JPdlBSTys1bDE0dFNIZWpieWhPUHZVTzJVUGN5?=
 =?utf-8?B?bnhoaE1NemNlMC9yN0VHV2J0Q2ZWQ2FFRVZqT0cyZjk4dmxPKzBON1IzUXYw?=
 =?utf-8?B?NzdHbW9QU3dCRU9yUWlZMVJOci9UZ1hER3NoVlQvMUhTNEVYRWl6cDh6OVdY?=
 =?utf-8?B?SlJTanQ5V1Y0cmNZdllvVC8yZUk3TWdRSzBHWk5PUE1oaXdYR05IM09kc3Yx?=
 =?utf-8?B?RHhYQzF2TVlVU3Z3OFpqWDNkMUtQemJYQjl2VXhOUEcveWMra3dYUzM3enR1?=
 =?utf-8?B?R1FsbGo2S2N2ZFkweUQwNmpxeFZ0OHRlaXZxTG9VK2U0aXJZWUIweE1GUWNp?=
 =?utf-8?B?WkgvbGZYTjlpeE5SMVo3YVJxck1maHNEa0NnTEl2UWplUXJwMHpKd1hDbXZq?=
 =?utf-8?B?eXREMEFBQlZ1aG1aZmpYdzdtRHR3cDhITHAwcVhkVEx2MlZnYzVwYzZmL0ha?=
 =?utf-8?B?OEl4UURmUm1YVVZ6NVBjTTRSbmRoL2lxN2hFMjJtVXdPSzlnVC95WHB5dVdp?=
 =?utf-8?B?M3RXUklHQVcrWENoblp1V3hSYmFVYnRTVFQ0bEphYjY2a1VFUUx0VitNTEJq?=
 =?utf-8?B?anorRnlLNTk5Y1JiRlRGcTFXdUVqOW9hK0lEVUpPdEVtNURQMmZmU0ZsU0R1?=
 =?utf-8?B?TWRPa2p3eDlOMGFWVGVjNWpEOFVZMmx4YTVmbm40L2dia1pKTC9neGlpYmtj?=
 =?utf-8?Q?fAOMwEYYvRBp4iyd71s44Yx6j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c76f74-77e1-4e91-b8b5-08daa14c4021
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:23:29.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LW+dvDqN9a8uz23WlbP3hgTYm4miKwFzo7iE0Aw3lXiWIXEN5Z4qrXAT8B9jxx7SAHaCzijX2/RlfmhApDwV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_05,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280077
X-Proofpoint-ORIG-GUID: l0wbKMd1uFY_knfkxQjxXBL0T00nR0kA
X-Proofpoint-GUID: l0wbKMd1uFY_knfkxQjxXBL0T00nR0kA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWFvaGUgTGluIDxsaW5taWFv
aGVAaHVhd2VpLmNvbT4NCj4gU2VudDogU2VwdGVtYmVyIDI4LCAyMDIyIDQ6MDAgQU0NCj4gVG86
IFRob21hcyBUYWkgPHRob21hcy50YWlAb3JhY2xlLmNvbT4NCj4gQ2M6IHRvbnkubHVja0BpbnRl
bC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgamFya2tvQGtlcm5lbC5vcmc7DQo+
IHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jbzsgbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGFrcG1A
bGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0geDg2L3NneDogQWRkIGNv
ZGUgdG8gaW5qZWN0IGh3cG9pc29uIGludG8gU0dYIG1lbW9yeQ0KPiANCj4gT24gMjAyMi85LzI4
IDI6MzQsIFRob21hcyBUYWkgd3JvdGU6DQo+ID4gSW5zcGlyZWQgYnkgY29tbWl0IGM2YWNiMWU3
YmY0NiAoeDg2L3NneDogQWRkIGhvb2sgdG8gZXJyb3IgaW5qZWN0aW9uDQo+ID4gYWRkcmVzcyB2
YWxpZGF0aW9uKSwgYWRkIGEgc2ltaWxhciBjb2RlIGluIGh3cG9pc29uX2luamVjdCBmdW5jdGlv
biB0bw0KPiA+IGNoZWNrIGlmIHRoZSBhZGRyZXNzIGlzIGxvY2F0ZWQgaW4gU0dYIE1lbW9yeS4g
VGhlIGVycm9yIHdpbGwgdGhlbiBiZQ0KPiA+IGhhbmRsZWQgYnkgdGhlIGFyY2hfbWVtb3J5X2Zh
aWx1cmUgZnVuY3Rpb24gaW4gdGhlIFNHWCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUaG9tYXMgVGFpIDx0aG9tYXMudGFpQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3Vt
ZW50YXRpb24vbW0vaHdwb2lzb24ucnN0IHwgNDQNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgbW0vaHdwb2lzb24taW5qZWN0LmMgICAgICAgICAgfCAgMyArKysN
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9tbS9od3BvaXNvbi5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL21t
L2h3cG9pc29uLnJzdA0KPiA+IGluZGV4IGI5ZDUyNTNjMTMwNS4uOGE1NDJhY2E0NzQ0IDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vbW0vaHdwb2lzb24ucnN0DQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9tbS9od3BvaXNvbi5yc3QNCj4gPiBAQCAtMTYyLDYgKzE2Miw1MCBAQCBUZXN0
aW5nDQo+ID4NCj4gPiAgICBTb21lIHBvcnRhYmxlIGh3cG9pc29uIHRlc3QgcHJvZ3JhbXMgaW4g
bWNlLXRlc3QsIHNlZSBiZWxvdy4NCj4gPg0KPiA+ICsqIFNwZWNpYWwgbm90ZXMgZm9yIGluamVj
dGlvbiBpbnRvIFNHWCBlbmNsYXZlcw0KPiA+ICsNCj4gPiArICAxKSBEZXRlcm1pbmUgcGh5c2lj
YWwgYWRkcmVzcyBvZiBlbmNsYXZlIHBhZ2UNCj4gPiArDQo+ID4gKwlkbWVzZyB8IGdyZXAgInNn
eDogRVBDIg0KPiA+ICsNCj4gPiArCXNneDogRVBDIHNlY3Rpb24gMHg4MDAwYzAwMDAwLTB4ODA3
ZjdmZmZmZg0KPiA+ICsJc2d4OiBFUEMgc2VjdGlvbiAweDEwMDAwYzAwMDAwLTB4MTAwN2ZmZmZm
ZmYNCj4gPiArDQo+ID4gKyAgMikgQ29udmVydCB0aGUgRVBDIGFkZHJlc3MgdG8gcGFnZSBmcmFt
ZSBudW1iZXIuDQo+ID4gKw0KPiA+ICsJRm9yIDRLIHBhZ2Ugc2l6ZSwgdGhlIHBhZ2UgZnJhbWUg
bnVtYmVyIGZvciAweDgwMDBjMDAwMDAgaXMNCj4gPiArCTB4ODAwMGMwMDAwMCAvIDB4MTAwMCA9
IDB4ODAwMGMwMC4NCj4gPiArDQo+ID4gKyAgMykgVHJhY2UgbWVtb3J5X2ZhaWx1cmUNCj4gPiAr
DQo+ID4gKwllY2hvIG5vcCA+IC9zeXMva2VybmVsL3RyYWNpbmcvY3VycmVudF90cmFjZXINCj4g
PiArCWVjaG8gKm1lbW9yeV9mYWlsdXJlID4gL3N5cy9rZXJuZWwvdHJhY2luZy9zZXRfZnRyYWNl
X2ZpbHRlcg0KPiA+ICsJZWNobyBmdW5jdGlvbiA+IC9zeXMva2VybmVsL3RyYWNpbmcvY3VycmVu
dF90cmFjZXINCj4gPiArDQo+ID4gKyAgNCkgSW5qZWN0IGEgbWVtb3J5IGVycm9yDQo+ID4gKw0K
PiA+ICsJbW9kcHJvYmUgaHdwb2lzb24taW5qZWN0DQo+ID4gKwllY2hvICIweDgwMDBjMDAiID4g
L3N5cy9rZXJuZWwvZGVidWcvaHdwb2lzb24vY29ycnVwdC1wZm4NCj4gPiArDQo+ID4gKyAgNSkg
Q2hlY2sgdGhlIHRyYWNlIG91dHB1dA0KPiA+ICsNCj4gPiArCWNhdCAvc3lzL2tlcm5lbC90cmFj
aW5nL3RyYWNlDQo+ID4gKw0KPiA+ICsJIyB0cmFjZXI6IGZ1bmN0aW9uDQo+ID4gKwkjDQo+ID4g
KwkjIGVudHJpZXMtaW4tYnVmZmVyL2VudHJpZXMtd3JpdHRlbjogMi8yICAgI1A6MTI4DQo+ID4g
KwkjDQo+ID4gKwkjICAgICAgICAgICAgICAgICAgICAgICAgICAgIF8tLS0tLT0+IGlycXMtb2Zm
DQo+ID4gKwkjICAgICAgICAgICAgICAgICAgICAgICAgICAgLyBfLS0tLT0+IG5lZWQtcmVzY2hl
ZA0KPiA+ICsJIyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAvIF8tLS09PiBoYXJkaXJxL3Nv
ZnRpcnENCj4gPiArCSMgICAgICAgICAgICAgICAgICAgICAgICAgIHx8IC8gXy0tPT4gcHJlZW1w
dC1kZXB0aA0KPiA+ICsJIyAgICAgICAgICAgICAgICAgICAgICAgICAgfHx8IC8gXy09PiBtaWdy
YXRlLWRpc2FibGUNCj4gPiArCSMgICAgICAgICAgICAgICAgICAgICAgICAgIHx8fHwgLyAgICAg
ZGVsYXkNCj4gPiArCSMgICAgICAgVEFTSy1QSUQgICAgIENQVSMgIHx8fHx8ICBUSU1FU1RBTVAg
IEZVTkNUSU9ODQo+ID4gKwkjICAgICAgICAgIHwgfCAgICAgICAgIHwgICB8fHx8fCAgICAgfCAg
ICAgICAgIHwNCj4gPiArCSAgICAgICAgYmFzaC0xMjE2NyAgIFswMDJdIC4uLi4uICAgMTEzLjEz
NjgwODogbWVtb3J5X2ZhaWx1cmU8LQ0KPiBzaW1wbGVfYXR0cl93cml0ZQ0KPiA+ICsJICAgICAg
ICBiYXNoLTEyMTY3ICAgWzAwMl0gLi4uLi4gICAxMTMuMTM2ODEwOiBhcmNoX21lbW9yeV9mYWls
dXJlPC0NCj4gbWVtb3J5X2ZhaWx1cmUNCj4gPiArDQo+ID4gIFJlZmVyZW5jZXMNCj4gPiAgPT09
PT09PT09PQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL2h3cG9pc29uLWluamVjdC5jIGIvbW0v
aHdwb2lzb24taW5qZWN0LmMNCj4gPiBpbmRleCA2NWUyNDJiNWE0MzIuLjgxMzRkYzk4MzY5OSAx
MDA2NDQNCj4gPiAtLS0gYS9tbS9od3BvaXNvbi1pbmplY3QuYw0KPiA+ICsrKyBiL21tL2h3cG9p
c29uLWluamVjdC5jDQo+ID4gQEAgLTIxLDYgKzIxLDkgQEAgc3RhdGljIGludCBod3BvaXNvbl9p
bmplY3Qodm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4gPiAgCWlmICghY2FwYWJsZShDQVBfU1lTX0FE
TUlOKSkNCj4gPiAgCQlyZXR1cm4gLUVQRVJNOw0KPiA+DQo+ID4gKwlpZiAoYXJjaF9pc19wbGF0
Zm9ybV9wYWdlKHBmbiA8PCBQQUdFX1NISUZUKSkNCj4gDQo+IE1heWJlIGl0J3MgYmV0dGVyIHRv
IGFkZCBhIGNvbW1lbnQgYWJvdmUuIEFueXdheSwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvDQo+
IG1lLiBUaGFua3MuDQoNClRoYW5rcywgTWlhb2hlLCBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdp
bGwgYWRkIGEgY29tbWVudCBhbmQgcmVzZW5kIHRoZSBwYXRjaC4NCg0KVGhhbmtzLA0KVGhvbWFz
DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4N
Cj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pYW9oZSBMaW4NCg0K
