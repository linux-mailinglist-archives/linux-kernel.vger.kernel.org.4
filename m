Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA15FB2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJKMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:53:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D0D5D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:53:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBctMs016641;
        Tue, 11 Oct 2022 12:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VJ11X4Q9R039omR4dKQXLSxvO1xf+vY5h78DXJYAZl0=;
 b=10AzoUh73tmPvrD7YDASt1nrLD81MkDSp3RceZU/OUj7lt9k6GZ6KD3ug4GbfP4cOSsK
 VZM5uxiEwkiZwntyrbxnOGETsFvwWWQOnz9Lxjzxn6u0/sLEOCnVOWI/LgBESWxNhjgP
 1ly/Jeagk7XjtZbehGW/DY3QhVlpu+t/q4JYNvs/wbEYpvxhhV0mDP0mu4BnnfJbwJXg
 aDqqTg3WQbhtd/iWrUy731QCU/JdcCqjLEPh1/efsu4Kom0oCmakq39dK83aswz41ffr
 tbUBRyy9UaJydPYmRsVcytHW7RBzQGQKvwaUC3DUzS8X18yJvQjJWp8dchqJqk2HPv16 ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30tt6hey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:50:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBlVkh021861;
        Tue, 11 Oct 2022 12:50:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn42fpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfKZ/egAWJAyhe68h4j4kZTPJ1YzYsfOxfkQOk6HVeo8n8Zn+9UW0UvfosCbHogAddL3GRWbGNih1Jkk6iTV+yHtxV4W3O42PMsBKHotGS8xOaZaG5Wvu7uVtEZ9G1AP9AV1rwQ3gpTMSqQMnu6mWu9ieqIdkwuiBJXL1C24UyBaFWolADTSvZ6HNezl7ppYXGNVRaCl6U3suXGUdJqocxKwHgSEsUOCGrJ2EZnGvaqF3c7Tg8UIS+SRhpix4HDgE9U/YlO9QmZhnOO7O7fmaSfMtBOFTNh2o3KSD2c1v3oBBXK5VWbj4fgvbVytNdB6JZuhbbiLGojgo1GyQuHGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ11X4Q9R039omR4dKQXLSxvO1xf+vY5h78DXJYAZl0=;
 b=OB3d4MsIWbVT8gW8VMdnNEDL9cKLH1F4BrZKtc+RtbOkWIxzP0iy8FrxiA68vmiX0aFOdIQibcxSDcxTU2u4bE0K5f5n0MleckhezrEvBKn9SoxejEYkA5yr8bARB7YySna+fHAGYpH4odMSNvg65lAOZmuo1XhYWMdz2I94PhWa+xJcIVdEEptd2AgbbNwgJSZtzDjLrrWAG+VTK5PLHh9/LqW7fE4KV2++UjnhUOUYGpOe3Q60KOkAR544XmLl/PR3BbAijW2hmTWGHJH9GXiYgxl4DxL4BEaKGSugz439oEFdFbYYl4xUI2IuN85v8wkSGE9GDaeLycdlm/aGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ11X4Q9R039omR4dKQXLSxvO1xf+vY5h78DXJYAZl0=;
 b=NOqMQ0mvl8d3rO9lDWrWaUUipGCMMyijYwVAtSwatNYDvITa0LW77AaiiFbw7i1suWyCfqra/YbcFrsH9cvdlSbMQObgog5dVKaibic/aEBl3D+FqBnosCKc/Cqv0CSe06JwXuCkNs44ClY/I1C8UurSpkbcNFv6qX80FunUvD4=
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 12:50:49 +0000
Received: from SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::db78:add0:eb08:a97]) by SJ0PR10MB4623.namprd10.prod.outlook.com
 ([fe80::db78:add0:eb08:a97%7]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 12:50:49 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.co" <reinette.chatre@intel.co>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Topic: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Index: AQHY01BMI28NH9i9cUWEbeacOZcSpa4ChtyAgAayc2A=
Date:   Tue, 11 Oct 2022 12:50:49 +0000
Message-ID: <SJ0PR10MB4623A849ACF972FBEB602D41FD239@SJ0PR10MB4623.namprd10.prod.outlook.com>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
 <20220928153832.1032566-2-thomas.tai@oracle.com>
 <20221007063343.GA3240211@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20221007063343.GA3240211@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_|DS0PR10MB6173:EE_
x-ms-office365-filtering-correlation-id: bb4a32a2-4ce7-4e5c-e73e-08daab873914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYO2Dpm9pABL5Vm+R3jgfFV/tRjwjNfbK3gDy8QcQGU6ntu+anD4ZrRCEzAM1e7kKudetcIZmesva2J5Vuh1hfeTxtuqGSNCWliiPbW118geshmMZOdMkBwx4wepC8RlLbTnXgKxi0/O+FJrnbyTDIoYY5sv+JVM40whGL7PCswqG7lHtlAwdEvIijC5U0Owj4JgA9S+tlRFqWPRgpRJigoxr5Az3SiOw4/mQfVdw0rgF/SZRZ8ev4vqL/wJH02O1aQetnjaUWN8tbGc/iSvxx5VLO+S+xaU56mOYmBDwlyZYdScnpatSArt45sQ1sCFQbHFMonDWfI9n2QHAxhIfG6l4Wd/Lvw6E8/rIWc2L19oX5sAuV+9ATyS8RRXld0nluSK7anAoY2tq6lUcebUe+LhN5mEkD3vvqSudeuPg4lX4grXs+7aaiy3aoDMufBRLm+dW6zwt074PKrrWm6fyCiR3VFIBio2rn4BR+bQBz9udHXznHE7C+a6QwmJb66qR2NePbkuh72WmJ8MOSAwDJ9rwDV5EXN8uXssguq1SjQpwbJM6+4kARiPXT9WjXtQvt9DREdkeTUMM+Co27KKlXf3u0xaH3XIt7ttNFnsgYz+9URgIY7QsLGE8G4Phejccx869TOfWp9ON4oFE08HDIr19HCbrauGgoaggx5DK4FY2czjo7ycCWrZHZ8q+vyrisFEMrkTpz+1m1nvX8Iz8C9BjdqBHk+y0wSpzJZCArJI8gDLXcC2SR9LL4J//jgyN1+5seCHLWa62wjHeBIPyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4623.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(55016003)(33656002)(53546011)(7696005)(6506007)(26005)(186003)(83380400001)(54906003)(478600001)(9686003)(6916009)(86362001)(2906002)(76116006)(41300700001)(316002)(44832011)(8676002)(66946007)(4326008)(66476007)(64756008)(66556008)(66446008)(38100700002)(38070700005)(122000001)(8936002)(52536014)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHlHODRRa1hvYzM1Z0NoRXdnMkQrWXJ1Tm00UmZXQjJoQTQrbGpPOElEaHpp?=
 =?utf-8?B?M1padEgrY1pRakhpaXVoOFJMby9lK3RHSmJmZXBVRkFna1Z3V2RLM0V6MmNl?=
 =?utf-8?B?RTk1M280VEE0ejZoMVVyNU56eTlJNmw5YTVvVTM0dkpTVW1nNjU1aWZUd2w3?=
 =?utf-8?B?VE4zN0lqR3hVUmtHbW1laUZXTWRKZVZvbFpBRVdEK2ZPL2hPZ2oxM2pDRTJK?=
 =?utf-8?B?YXJ2VStQdTVlTlBDbWhVbUs4K2RENE5JS1AxR1NqcWVzYURRRFBUOTZjMmhL?=
 =?utf-8?B?Z2lHbUVDU0ZnWFNXQkRVV0FjUzd3TTZtOVIybys2YmlmMHdveHV4a3hhVnIz?=
 =?utf-8?B?QTB3VWxyRnk1dUZqWUZjR3RnaGd6M2ZLQ2EzL216UGdiQjRMemhOWXFleUpF?=
 =?utf-8?B?NWlSS0dka2FCdEEyT0ZxTmMwbmkxUk8yNEt5dVFkTDNlVWJSanNUUkVaMkVF?=
 =?utf-8?B?RUFMMDhnbEpjWldWK0YxSUhGc0p6T2RhUlJsU3JkeHBCMzByd0hhbHNGamdx?=
 =?utf-8?B?cDdRaTJ2MHlSRjJJM0w4WVRMZndwQjgyb2dJWWY1VHNYS1h0WThUam1VdlZm?=
 =?utf-8?B?RW54TjY5bENESzJQclhYbGovSTFpWVFUQytLVjJlVTZBVHU2cGJpanQ2RnVB?=
 =?utf-8?B?UlZaME1OQTk3eGE1WngyM09oSWJKV3ZURHJFOFhjMHNNR21rdnJreUZBQlJa?=
 =?utf-8?B?RVQ5Tm4wNy9TeCtPYVZUUFk4UGVJVi9Rb010ZjZtZlg2VG96bzJ3MkRkbXd5?=
 =?utf-8?B?ZXFYTXlRRWlHaWJNb29hUGZFSU1MTEZvQWhuc1Q5Q2NCRjFyc3ZiZll3SGRp?=
 =?utf-8?B?dnZ4SE9XSWVEeExxczdVNEVGZGdzNkhqVW1ERkR6Rzk4YWZVQXdQQjZDOFpC?=
 =?utf-8?B?ZERZYlUwU3dndURaM1Y1NlNDRFFvQmhsdFFzL0xyTVZLckJhWVNuTUNzNmxr?=
 =?utf-8?B?QzdtYkphYms1K1VpOGtLTkVpaHM2Q3JNQmdFVzltdGFxTkpkZ2dGRG5FU05B?=
 =?utf-8?B?dk9ZNTFrNStYWXpGWjd0Um1tMWVFU0l0Y2FZOEMvTXBIdzZvYk0zZnI1YWhE?=
 =?utf-8?B?QjJXRVpMOVpvRGJjSmdtMndlQlI4am81aTUyVDBpZ3lGTkVsV1l6Y3VES3pr?=
 =?utf-8?B?VEpHMVYwK2FwTW0wc05id0lnMDh1NVVla1RzYUVLVXl1dno1L1ZWQjlsN2NG?=
 =?utf-8?B?cmo4ejh3bFNCT0tGVEdNajZNTzFCcjVNMmkxNlBDZ1piNHJoVnpYRUVURWpC?=
 =?utf-8?B?YlhGNzV3TTZHdkZCM21XbzBZVWxaUHkwZjl5aE8xanVtZmJlVHFBMlFoL1V6?=
 =?utf-8?B?NmYrZjNYa0NWTENvVzI0TnAyS2laL25nWHdUdk4wRUR4TFRyWjd6SDBkVGJL?=
 =?utf-8?B?MDErK1ZQeElYOWlEeVp3emRWS3R3QVYxbzRWbkdBNzlRdUc3WG9nUXlub0Vl?=
 =?utf-8?B?c0IwRGdBc093KzVzbmRHb2FnbzhwQjBJaVJkWFdtMURBUFc0R2VucWF4OUZq?=
 =?utf-8?B?UHRodnBBUWNtOWppR3FZL2hrdzEwbU9ILzV0WWJvUW9LTGkyWE5qWlZwREU5?=
 =?utf-8?B?NXd1MDNZbGdBbXFLRktFS1lacXV5WTNRQWNnZmo2bHpjSkUvenNJa25QZ21X?=
 =?utf-8?B?cEpDQVBac1VaU0lQUU5DcXYzMkpuUlR6RXNPZE1EU2VYeDVJVGF3SWdhY1VE?=
 =?utf-8?B?Zk1TT0dXRVI1K1dtMkYvSmRQVEtSV252a0REb00xdm84NFdRbTJVUjQ0R1o4?=
 =?utf-8?B?RXNkc0RObG1PUDVwRlFiRkxLZUJmbVB2SkhJMzRRRXd6SGJ4SEFmOUJjZy9O?=
 =?utf-8?B?R09hdUxBci9LZEFDeEpYL2NicExjUUVBQVR3TFZVS0I5NHlJUElzQlYxV2k4?=
 =?utf-8?B?YWhQbzlQUnpYbFlGZmJBSldoTnk0N24yTG8wRllOV0JtOWltRm5saXlHOGVS?=
 =?utf-8?B?MnpaYWZCTkRYNzBOeS9Gekhud0hlMjMxNllLWDVXSktDODgzOXk0aUxVWU5s?=
 =?utf-8?B?c09UeVVlZW9NOVZOK1MzY0lpTWw2eElzRXhyR0E5SklRQ1lGc0ZHMXlDTE9O?=
 =?utf-8?B?RkwvaFp3UEtzWWRvWE44UGd1eStldW0wTk1RTEtLK1dnNDVwcExyUDVLM3Ex?=
 =?utf-8?Q?u8E7ZrqrRLocoNsKlOGECI3sG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4623.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a32a2-4ce7-4e5c-e73e-08daab873914
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 12:50:49.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpV1yWGMyp8CeevNmvY9T4QWRUkFRygP91b6hmtTpUeDRar2MXTsusYe23YHc4L3SMlOPA2BeCXCYE2spiHx/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110073
X-Proofpoint-GUID: x7q6mJR7Wr9qekEppRM4iXnBUHSKu0FJ
X-Proofpoint-ORIG-GUID: x7q6mJR7Wr9qekEppRM4iXnBUHSKu0FJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIT1JJR1VDSEkgTkFPWUEo5aCA
5Y+j44CA55u05LmfKSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+IFNlbnQ6IE9jdG9iZXIg
NywgMjAyMiAyOjM0IEFNDQo+IFRvOiBUaG9tYXMgVGFpIDx0aG9tYXMudGFpQG9yYWNsZS5jb20+
DQo+IENjOiB0b255Lmx1Y2tAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IGphcmtrb0BrZXJuZWwub3JnOw0KPiByZWluZXR0ZS5jaGF0cmVAaW50ZWwuY287IGxpbm1pYW9o
ZUBodWF3ZWkuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgbGludXgtbW1Aa3Zh
Y2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjIgMS8xXSB4ODYvc2d4OiBBZGQgY29kZSB0byBpbmplY3QgaHdwb2lzb24gaW50byBTR1gN
Cj4gbWVtb3J5DQo+IA0KPiBPbiBXZWQsIFNlcCAyOCwgMjAyMiBhdCAxMTozODozMkFNIC0wNDAw
LCBUaG9tYXMgVGFpIHdyb3RlOg0KPiA+IEluc3BpcmVkIGJ5IGNvbW1pdCBjNmFjYjFlN2JmNDYg
KHg4Ni9zZ3g6IEFkZCBob29rIHRvIGVycm9yIGluamVjdGlvbg0KPiA+IGFkZHJlc3MgdmFsaWRh
dGlvbiksIGFkZCBhIHNpbWlsYXIgY29kZSBpbiBod3BvaXNvbl9pbmplY3QgZnVuY3Rpb24gdG8N
Cj4gPiBjaGVjayBpZiB0aGUgYWRkcmVzcyBpcyBsb2NhdGVkIGluIFNHWCBNZW1vcnkuIFRoZSBl
cnJvciB3aWxsIHRoZW4gYmUNCj4gPiBoYW5kbGVkIGJ5IHRoZSBhcmNoX21lbW9yeV9mYWlsdXJl
IGZ1bmN0aW9uIGluIHRoZSBTR1ggZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhv
bWFzIFRhaSA8dGhvbWFzLnRhaUBvcmFjbGUuY29tPg0KPiANCj4gVGhhbmsgeW91IGZvciBzZW5k
aW5nIHBhdGNoLg0KPiANCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9tbS9od3BvaXNvbi5y
c3QgfCA0NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBtbS9o
d3BvaXNvbi1pbmplY3QuYyAgICAgICAgICB8ICA0ICsrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0OCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9t
bS9od3BvaXNvbi5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL21tL2h3cG9pc29uLnJzdA0KPiA+IGlu
ZGV4IGI5ZDUyNTNjMTMwNS4uOGE1NDJhY2E0NzQ0IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50
YXRpb24vbW0vaHdwb2lzb24ucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9od3BvaXNv
bi5yc3QNCj4gPiBAQCAtMTYyLDYgKzE2Miw1MCBAQCBUZXN0aW5nDQo+ID4NCj4gPiAgICBTb21l
IHBvcnRhYmxlIGh3cG9pc29uIHRlc3QgcHJvZ3JhbXMgaW4gbWNlLXRlc3QsIHNlZSBiZWxvdy4N
Cj4gPg0KPiA+ICsqIFNwZWNpYWwgbm90ZXMgZm9yIGluamVjdGlvbiBpbnRvIFNHWCBlbmNsYXZl
cw0KPiA+ICsNCj4gPiArICAxKSBEZXRlcm1pbmUgcGh5c2ljYWwgYWRkcmVzcyBvZiBlbmNsYXZl
IHBhZ2UNCj4gPiArDQo+ID4gKwlkbWVzZyB8IGdyZXAgInNneDogRVBDIg0KPiA+ICsNCj4gPiAr
CXNneDogRVBDIHNlY3Rpb24gMHg4MDAwYzAwMDAwLTB4ODA3ZjdmZmZmZg0KPiA+ICsJc2d4OiBF
UEMgc2VjdGlvbiAweDEwMDAwYzAwMDAwLTB4MTAwN2ZmZmZmZmYNCj4gPiArDQo+ID4gKyAgMikg
Q29udmVydCB0aGUgRVBDIGFkZHJlc3MgdG8gcGFnZSBmcmFtZSBudW1iZXIuDQo+ID4gKw0KPiA+
ICsJRm9yIDRLIHBhZ2Ugc2l6ZSwgdGhlIHBhZ2UgZnJhbWUgbnVtYmVyIGZvciAweDgwMDBjMDAw
MDAgaXMNCj4gPiArCTB4ODAwMGMwMDAwMCAvIDB4MTAwMCA9IDB4ODAwMGMwMC4NCj4gPiArDQo+
ID4gKyAgMykgVHJhY2UgbWVtb3J5X2ZhaWx1cmUNCj4gPiArDQo+ID4gKwllY2hvIG5vcCA+IC9z
eXMva2VybmVsL3RyYWNpbmcvY3VycmVudF90cmFjZXINCj4gPiArCWVjaG8gKm1lbW9yeV9mYWls
dXJlID4gL3N5cy9rZXJuZWwvdHJhY2luZy9zZXRfZnRyYWNlX2ZpbHRlcg0KPiA+ICsJZWNobyBm
dW5jdGlvbiA+IC9zeXMva2VybmVsL3RyYWNpbmcvY3VycmVudF90cmFjZXINCj4gPiArDQo+ID4g
KyAgNCkgSW5qZWN0IGEgbWVtb3J5IGVycm9yDQo+ID4gKw0KPiA+ICsJbW9kcHJvYmUgaHdwb2lz
b24taW5qZWN0DQo+ID4gKwllY2hvICIweDgwMDBjMDAiID4gL3N5cy9rZXJuZWwvZGVidWcvaHdw
b2lzb24vY29ycnVwdC1wZm4NCj4gPiArDQo+ID4gKyAgNSkgQ2hlY2sgdGhlIHRyYWNlIG91dHB1
dA0KPiA+ICsNCj4gPiArCWNhdCAvc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNlDQo+ID4gKw0KPiA+
ICsJIyB0cmFjZXI6IGZ1bmN0aW9uDQo+ID4gKwkjDQo+ID4gKwkjIGVudHJpZXMtaW4tYnVmZmVy
L2VudHJpZXMtd3JpdHRlbjogMi8yICAgI1A6MTI4DQo+ID4gKwkjDQo+ID4gKwkjICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF8tLS0tLT0+IGlycXMtb2ZmDQo+ID4gKwkjICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyBfLS0tLT0+IG5lZWQtcmVzY2hlZA0KPiA+ICsJIyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAvIF8tLS09PiBoYXJkaXJxL3NvZnRpcnENCj4gPiArCSMgICAgICAg
ICAgICAgICAgICAgICAgICAgIHx8IC8gXy0tPT4gcHJlZW1wdC1kZXB0aA0KPiA+ICsJIyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfHx8IC8gXy09PiBtaWdyYXRlLWRpc2FibGUNCj4gPiArCSMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHx8fHwgLyAgICAgZGVsYXkNCj4gPiArCSMgICAgICAg
VEFTSy1QSUQgICAgIENQVSMgIHx8fHx8ICBUSU1FU1RBTVAgIEZVTkNUSU9ODQo+ID4gKwkjICAg
ICAgICAgIHwgfCAgICAgICAgIHwgICB8fHx8fCAgICAgfCAgICAgICAgIHwNCj4gPiArCSAgICAg
ICAgYmFzaC0xMjE2NyAgIFswMDJdIC4uLi4uICAgMTEzLjEzNjgwODogbWVtb3J5X2ZhaWx1cmU8
LQ0KPiBzaW1wbGVfYXR0cl93cml0ZQ0KPiA+ICsJICAgICAgICBiYXNoLTEyMTY3ICAgWzAwMl0g
Li4uLi4gICAxMTMuMTM2ODEwOiBhcmNoX21lbW9yeV9mYWlsdXJlPC0NCj4gbWVtb3J5X2ZhaWx1
cmUNCj4gDQo+IEluIG90aGVyIGNhc2VzIG9mIHBhZ2UgdHlwZXMsIG1lbW9yeV9mYWlsdXJlKCkg
bGVhdmVzIHNvbWUga2VybmVsIG1lc3NhZ2UNCj4gbGlrZSAiTWVtb3J5IGZhaWx1cmU6IDB4MTBj
ZjA5OiByZWNvdmVyeSBhY3Rpb24gZm9yIGZyZWUgYnVkZHkgcGFnZToNCj4gUmVjb3ZlcmVkIiwN
Cj4gd2hpY2ggaXMgcHJpbnRlZCBvdXQgYnkgYWN0aW9uX3Jlc3VsdCgpLiAgU28gSSB0aGluayBp
dCdzIGJldHRlciB0byBhZGp1c3QgdG8NCj4gdGhpcyBjb252ZW50aW9uIGFsc28gaW4gU0dYIHBh
Z2UncyBjYXNlLiAgVGhlbiwgeW91IGRvbid0IGhhdmUgdG8gdXNlIGZ0cmFjZQ0KPiB0byBjb25m
aXJtIHRoZSByZXN1bHQgb2YgZXJyb3IgaW5qZWN0aW9uLg0KDQpIaSBOYW95YSwNClRoYW5rcyBm
b3IgeW91ciBzdWdnZXN0aW9uLCBJIHdpbGwgbG9vayBpbnRvIGl0Lg0KDQpUaG9tYXMNCg0KPiAN
Cj4gVGhhbmtzLA0KPiBOYW95YSBIb3JpZ3VjaGkNCj4gDQo+ID4gKw0KPiA+ICBSZWZlcmVuY2Vz
DQo+ID4gID09PT09PT09PT0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9tbS9od3BvaXNvbi1pbmpl
Y3QuYyBiL21tL2h3cG9pc29uLWluamVjdC5jDQo+ID4gaW5kZXggNjVlMjQyYjVhNDMyLi5iZjgz
MTExYzFkOWIgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gPiArKysg
Yi9tbS9od3BvaXNvbi1pbmplY3QuYw0KPiA+IEBAIC0yMSw2ICsyMSwxMCBAQCBzdGF0aWMgaW50
IGh3cG9pc29uX2luamVjdCh2b2lkICpkYXRhLCB1NjQgdmFsKQ0KPiA+ICAJaWYgKCFjYXBhYmxl
KENBUF9TWVNfQURNSU4pKQ0KPiA+ICAJCXJldHVybiAtRVBFUk07DQo+ID4NCj4gPiArCS8qIElu
amVjdCB0aGUgZXJyb3IgaWYgdGhlIHBhZ2UgaXMgcGFydCBvZiB0aGUgcHJvY2Vzc29yIHJlc2Vy
dmVkIG1lbW9yeQ0KPiAqLw0KPiA+ICsJaWYgKGFyY2hfaXNfcGxhdGZvcm1fcGFnZShwZm4gPDwg
UEFHRV9TSElGVCkpDQo+ID4gKwkJZ290byBpbmplY3Q7DQo+ID4gKw0KPiA+ICAJaWYgKCFwZm5f
dmFsaWQocGZuKSkNCj4gPiAgCQlyZXR1cm4gLUVOWElPOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjMx
LjENCg==
