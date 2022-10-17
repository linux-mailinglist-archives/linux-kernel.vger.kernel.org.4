Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE2601B15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJQVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:12:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656779EDD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:12:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKXbrD017373;
        Mon, 17 Oct 2022 21:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/w68rVbOTHxppnXvXfQ9TOcxgRDrjUrDbNftpv9kNyw=;
 b=yPU/TGcq0E8o8GK8LYJNcgy461yRyaPQwMIZqGFzogBd+MeC6Gv8LkW6r2QN6HrhkEz4
 xreyAVRNHSWL5Hpsv91ligGO8uZx9mf5n1HcpiEwZXfCesAQKwsuzAOQzuM5I34L8PrZ
 sIuhZEITTXxeMHGVENdkLnxLQSoQDaLO73olb4XQaZ/85ENAFdsG5EIXP054PpF1IlLQ
 4RI711LcDd7yJWo0y0XEYcdMyj8UuFYdXTVTBhBlAXawDJaNNoXoe6c7zIGimBZRFPJ9
 e9fM46ahZrJAE8h9iGJ4v4m/rWeErcc5u1yQYLTjm7MWy/TRuDNE63f18Jm5PETJgjmT jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww0p38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:12:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJdncD019381;
        Mon, 17 Oct 2022 21:12:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0pq726-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPcbe7orqxQ0coOwQlwJJouTRPsHazpVh4VDhkMlVZ/5bk1hET9xZ3/ayRTtoOgoom1yDOFqFAgHQfAUWgE6/z0iG0VRn8nQdXmQIY1CyLAh9BO9kR9o548gKKutub6XdifjBCKSx/pB9X9P9Ai9AN+UDraNluRBeu5qzN+5LXOK6MKT2uZimd1hEpCTDQllUA22XWMuQW8+FCrcTR/ewenX5xI3B1a2CvSt0dtAGD1D825diYYrtqmhvec2R7i7ukkvieHDNdYgFKvAFroIUFarzDjIyt8m0Ml9M0VkURyFOcG5ztMHDZv3YwcBSCK/cuAZV5SUaC5hpMOtRwzLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w68rVbOTHxppnXvXfQ9TOcxgRDrjUrDbNftpv9kNyw=;
 b=NiYB8anfu8m4ADGA0OM0pPMfQQAWHZcz62Ov8QHDg5FKvm5HdmupYyLAYatyXujrGfrcKNordo1Bc+VM1ayY5ZjnYiANw/mq0QB9bA8Qb63ZRWZOzTyCVt1++rkkbZNebPEuxsxfd/uPkIJLDeIqYu6HEmGCZjVvatOLy6Ujb5pWLwT7elSLNm6EfHj//uaOwsfuy1zQw20/TzcmloA1NBjHH437xNRM6HZBWQw4iX1lPQFgtFL/USCo3vGGTY0M7cRzJ92InNcU9DoXxlLIfv032KLwv7vi1/YcD5WWDanZMYMOEk2T4nmA5pegDuyBiIeH2ExIronKY0goyB0wuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w68rVbOTHxppnXvXfQ9TOcxgRDrjUrDbNftpv9kNyw=;
 b=IDagvL8svuuQ2/8R2xMkf2zGdi0w8SthI4VFhn0/T1kHwoNC7wc/JhHIMTmOTeDAgERZ4M//0Kr4S2nuLfOKaOxZVLbMSjNgGs7Vtur/39noGqIwpZkXo1OPcM4uvquLhZTeBTpYC3kQyQdmYGNfhN2VFxTp7FHtf0A31aKzjrU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 21:12:04 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 21:12:04 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Topic: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Index: AQHY4mDwWLEpoK21xU2/k+8Paef3ha4TCOCAgAAMkoA=
Date:   Mon, 17 Oct 2022 21:12:04 +0000
Message-ID: <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
In-Reply-To: <Y026l2PZgvt+G6p0@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|CY8PR10MB6634:EE_
x-ms-office365-filtering-correlation-id: e8dddaf0-fd22-4b51-0850-08dab0843db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TPFqGScoaiC4vjj0fuaMqVXqOSETv8UnUbvfMyxahKX3+57+7bqPeYPh6ctWMkoiVAhNfjhJFS1F5oBu+17wc9kjgmJLUvcpMnPWdt9giNgvU6RDy3rDO43qmw8yf+QWhN0VUjHuzH7s9I1ErOe6Uq7+1PwNhou4mQojTpMPm77l+hnfJjz1sEJMNdtb9MllZqF/7JZ9Jp3obTYkDPuUrzm6vW2BSEw6futSmfzRzniOxpvagXubsflx496DrTMAC4aZ3MuRCYUz79TPFXcgvNTnyCPNJHJ5iqpqHcwOlW/NJdn4C7KG15mnpvOQQZxwGuNh0/PAo2qHrGkKxnnFeL1lkJHFUC10HpLtlURzdtkpEuwtU3+GiKaYJUkt/l+pxrKXGhC79shhSYquep7jsvXiz+6PYCPBzW7xBwruZQIaIVnbNO7f6bHDzD8b+2scZLFIBoHEsje1jv7+o00X69Ic5OLVu7fG0/yKmJHc9d/7TDmUauEx9hB0TI1Tg6bBvgWFdoyXv4G0TO1EDNp3r05MTgtK3MXgKmnN9d2J1pPwCqqc/HXS5LdiOG+TgRVf7zBQNTqeG6VjKPnuROAdXKWMApnXGt+rD34fM4Ge0Qv5XZAxMaECycQ5+RmtkqbBi55jfJVcNQdyj2ljHb2cvQHo8AsJzzjdvvnYMBv6j3HN6adXcL7Xq6dXv50KSxnltMnpC4td67lq8StSnrvmVf1qkpuBqmMgNVmR9h4baZe11suwFcDCWJOZbxxZHH1p8cZowOU3eB88K/22xzbZv8MTjtOkxEQr1M9mqzBBcj6bmPnR3UrwNDpNNt7l7YIE/e5E9u1JCFZDIh+G7NZPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(38100700002)(71200400001)(186003)(2616005)(2906002)(31686004)(122000001)(6486002)(478600001)(44832011)(38070700005)(26005)(66946007)(66476007)(66446008)(53546011)(8676002)(91956017)(36756003)(66556008)(31696002)(6916009)(83380400001)(54906003)(64756008)(6512007)(86362001)(76116006)(8936002)(66899015)(4326008)(5660300002)(316002)(6506007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJBVTNGK01zdWhaUlJFekZqSmFETGxmQXZScDRaMG1jcmZ2eUhUdDVsVDN6?=
 =?utf-8?B?OXllUGxmVm5YQkFUSnhRTy9uZGtDTjVuQ005NEZKbWVBLzZHNUJURUtnU3Vu?=
 =?utf-8?B?TkhOTWxJNC85bWdtSmxpTWFITko4VzlvZnJHaVdMRS9OeHVWVG93MUxMazYx?=
 =?utf-8?B?bHc2WjNublFxdGxwVWpBNGxnL2ZWbTV3VzhIYUlldzlOcFZSdU9RNEc3NzZk?=
 =?utf-8?B?VG5JSXRBQktQb2JtUmJKSi9ibjY3UTVYenh4WWl6VEhXc3FreW45WktyWGJF?=
 =?utf-8?B?VTRrLytXTGV6L1d5aVc1Q3hQWENSSmdqY25XVXNTZ1JDSmNIWjhFbUNIUUpz?=
 =?utf-8?B?QUpoaUZOeVZmSkNvcGJlVGI3TGdpYlN5U2pqQnJrRE5TM1Z1TGZISy9RWkFO?=
 =?utf-8?B?WFowanR3dEhia0sxdmg5aUk5Z0k0aFp5UWRrbmpldUNPU2o4OE5jdDViOFhr?=
 =?utf-8?B?Y0hxVDg3SnBRdUUwQ0w4YlN1MFQ0UkVBaTcvQndzSzJBMG9NZ2RZWkJKWXR0?=
 =?utf-8?B?cW90czkySnIwZXRmMEp1Rnh3VXM5QVVDbHhtRzFmMWQxZFNpWVVhRnErL241?=
 =?utf-8?B?RVQ5VE1hTGIxL3dRbk9WVjlRVmY1VTJhNnI3YnhuU0x2UUFtZC9TTFdLVEtr?=
 =?utf-8?B?NmVlZ0huMWpDTU04QSsyVTB6cHdCZEYybFF4SmRWZGpPcytMYWpxbnZNU2Uw?=
 =?utf-8?B?ZTFINHhtL21vRjN3UFNURGhMQ0F2SDRRUzZDaUdxWVRJRWZueXNTS2U3ZStt?=
 =?utf-8?B?WStuZkZBaFlmR1kxaXZTUjB0cTNDMnZ2Z0txQjdXVm96WWdSdnQyT1A2RXI4?=
 =?utf-8?B?dXJoc1N0Y3Y4Qi9BaUdTZGY3YVFsQlR6WitZMzdzWDUvRllMZzY0ZG5yVmNB?=
 =?utf-8?B?ME8yUUNvRllOcFhkd29pRXNCMTNmUFB4dHRCakpWL1FEc3FrWEdqV09uQVlz?=
 =?utf-8?B?OE1iZThnRDZEV3p0SnhXY2JUbCsvRUVDa05MRXVMczUySGFCZEFvclN6cFdm?=
 =?utf-8?B?Y2xpanl1TGh4WkpzbEVTdjNkUEF3bTFSYk5yRnBRME80Ykl2bFZzZ1UxcEdm?=
 =?utf-8?B?UUs5RVptQmVVT1FZNm5CRFVIeFdFQ1BUTVlVaE5hN0lwWTJmdHY5T0NibDhm?=
 =?utf-8?B?eVN4bGVIaU1PN2wyLzlJMXVqbEtkYmpjSXh4eEJaVnhZVXZVRFZOQjY5Q1Bl?=
 =?utf-8?B?Q2FRQWEzUk1tMHR1cThFUHhEc08yMlBKQUpsOC82OG1lZ1A0czd2Ukl2LzVH?=
 =?utf-8?B?UVY5b2NNaElhY25vcFNPL3hKcW1nYWdPdTFOdS80STBxTzZNS3JrSXpaejF1?=
 =?utf-8?B?V1dxcUpEKzk0U25maUlPa1R4YzhHcng3SitYekp2WjAySGVzeDlvamwwU2Nu?=
 =?utf-8?B?emUyS0ZJcVVicWVHSkVHZWdSMjJHVURnbmlZbHNyZ0piKzRPazM0QjhVeE40?=
 =?utf-8?B?WlZkRFVsUUx3Yk9nejJEVVhpV3hxZUg0Q29HRVBHMURCeUp1TTNMcythb2gy?=
 =?utf-8?B?YXFrM21yZ2h5Q3lIRkpQUUNWMngrTkh4S0xpWWVUS2hpbDNmTThHcG9wRGRV?=
 =?utf-8?B?OEY2Yi9nVmhEUHpHb05xQXJXa2VOc0h6UWdhekdnTWM2VWZYaGpZdk1ET2NU?=
 =?utf-8?B?ZThnQjZvb256Zlg2VmJHYm1PM281Y01iV0d4OVA1VlhvcVl2bFgxWFdnVnNC?=
 =?utf-8?B?MnVDNm8zQXNBYngyd2FVYm9iaEpKK05iNi9TY2lRTDc3Q0xpUVBabFhDZkdT?=
 =?utf-8?B?M0l5TXNYdlUxUEp5UlN4dDlhVVVWSmorNDQ5MlJ3SXhSaWFEdjZpcTRDTXNX?=
 =?utf-8?B?dXY0di9wSVVOWTJrdVZya1AxcDN4UXBzZGpCKzBZN013VXB1MTF4L015VnF5?=
 =?utf-8?B?aytYcXFxanUwRDczOWNMVzV6MDk4TFJnQTFyd2dsdkU0MjQwWEdISjR5NlpL?=
 =?utf-8?B?dW1OdnVwQzc0MktzVktGalRqSmZlSTdkdllkQU81dDdhTjhHWHQ1VHA1RXBr?=
 =?utf-8?B?dkp3Rmt4QmZ0NUdHcHlKVzcwd05nWnpDZmNFMVZFRzR5bUtYWUN0RFYrNXFN?=
 =?utf-8?B?TlJwSWxSTzJuV2kyWU0ybUVaS0wvL1BQYnZqVmFVd3Nxb2VmbVJQN0J3NHRI?=
 =?utf-8?Q?qC8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <037E2F15436028449C4BDB0D42CD0893@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dddaf0-fd22-4b51-0850-08dab0843db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:12:04.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iD6ldsM5+TJ/iJuHqNsqvUAPLkkV29thZXtZa+No9K78JStvzdipvKZYWKwKaWe5NQ0BERJrAn9pooq5CFe6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170121
X-Proofpoint-GUID: FR9QmezxTE5sSXjXeHLHwv4Hgk08pMff
X-Proofpoint-ORIG-GUID: FR9QmezxTE5sSXjXeHLHwv4Hgk08pMff
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjAyMiAxOjI3IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIE1vbiwg
T2N0IDE3LCAyMDIyIGF0IDAxOjQ0OjQ3UE0gLTA2MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gV2hp
bGUgZGVidWdnaW5nIGEgc2VwYXJhdGUgaXNzdWUsIGl0IHdhcyBmb3VuZCB0aGF0IGFuIGludmFs
aWQgc3RyaW5nDQo+PiBwb2ludGVyIGNvdWxkIHZlcnkgd2VsbCBjb250YWluIGEgbm9uLWNhbmlj
YWwgYWRkcmVzcywgc3VjaCBhcw0KPiANCj4gbm9uLWNhbmljYWw/DQoNClNvcnJ5LCB0eXBvLCB3
aWxsIGZpeC4NCg0KPiANCj4+IDB4NzY2NTY0NWY2MzYxNjQ2NS4gSW4gdGhhdCBjYXNlLCB0aGlz
IGxpbmUgb2YgZGVmZW5zZSBpc24ndCBlbm91Z2gNCj4+IHRvIHByb3RlY3QgdGhlIGtlcm5lbCBm
cm9tIGNyYXNoaW5nIGR1ZSB0byBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQNCj4+DQo+PiAJaWYg
KCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCj4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+Pg0KPj4gU28gcnVuIG9uZSBt
b3JlIHJvdW5kIG9mIGNoZWNrIHZpYSBrZXJuX2FkZHJfdmFsaWQoKS4gT24gYXJjaGl0ZWN0dXJl
cw0KPj4gdGhhdCBwcm92aWRlIG1lYW5pbmdmdWwgaW1wbGVtZW50YXRpb24sIHRoaXMgbGluZSBv
ZiBjaGVjayBlZmZlY3RpdmVseQ0KPj4gY2F0Y2hlcyBub24tY2Fub25pY2FsIHBvaW50ZXJzLCBl
dGMuDQo+IA0KPiBPSywgYnV0IEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGlzIHVzZWZ1bCBpbiB0aGUg
Zm9ybSBvZiByZXR1cm5pbmcgZWZhdWx0IGhlcmUuDQo+IElkZWFsbHkgd2Ugc2hvdWxkIGluZm9y
bSB1c2VyIHRoYXQgdGhlIHBvaW50ZXIgaXMgd3JvbmcgYW5kIGhvdyBpdCdzIHdyb25nLg0KPiBC
dXQuIEl0IHdpbGwgY3Jhc2ggc29tZXdoZXJlIGVsc2UgYXQgc29tZSBwb2ludCwgcmlnaHQ/IA0K
QnJvYWRseSBzcGVha2luZywgeWVzLiAgSXQncyBub3QgYSBwZXJmZWN0IGxpbmUgb2YgZGVmZW5z
ZSwgYnV0IGFnYWluLCANCnRoZSBidWcgc2NlbmFyaW8gaXMgYSAiY2F0IiBvZiBzb21lIHN5c2Zz
IGF0dHJpYnV0ZXMgdGhhdCBsZWFkcyB0byANCnBhbmljLiBEb2VzIGl0IG1ha2Ugc2Vuc2UgZm9y
IGtlcm5lbCB0byBwcm90ZWN0IGl0c2VsZiBhZ2FpbnN0IHBhbmljIA0KdHJpZ2dlcmVkIGJ5IGEg
ImNhdCIgZnJvbSB1c2VyIGlmIGl0IGNvdWxkPw0KDQpJIG1lYW4gdGhhdCB0aGVyZQ0KPiBpcyBu
byBndWFyYW50ZWUgdGhhdCBrZXJuZWwgaGFzIHByb3RlY3Rpb24gaW4gZXZlcnkgc2luZ2xlIHBs
YWNlIGFnYWluc3QNCj4gZGFuZ2xpbmcgLyBpbnZhbGlkIHBvaW50ZXJzLiBPbmUgd2F5IG9yIGFu
b3RoZXIgaXQgd2lsbCBjcmFzaC4NCj4gDQo+IFRoYXQgc2FpZCwgaG9uZXN0bHkgSSBoYXZlIG5v
IGlkZWEgaG93IHRoaXMgcGF0Y2ggbWF5IGJlIGNvbnNpZGVyZWQNCj4gYW55dGhpbmcgYnV0IGJh
bmQtYWlkLiBPVE9ILCBJIGRvbid0IHNlZSBhIGhhcm0uIFBlcmhhcHMgb3RoZXJzIHdpbGwNCj4g
c2hhcmUgdGhlaXIgb3BpbmlvbnMuDQo+IA0KDQozKyB5ZWFycyBhZ28sIGNvbW1pdCAzZTU5MDNl
YjljZmY3ICgidnNwcmludGY6IFByZXZlbnQgY3Jhc2ggd2hlbiANCmRlcmVmZXJlbmNpbmcgaW52
YWxpZCBwb2ludGVycyIpIHByb3ZpZGVkIHRoZSBzaW1pbGFyIGxldmVsIG9mIA0KcHJvdGVjdGlv
biBhcyB0aGlzIHBhdGNoLiAgQnV0IGl0IHdhcyBzb29uIHJldmlzZWQgYnkgY29tbWl0IA0KMmFj
NWEzYmY3MDQyYSAoInZzcHJpbnRmOiBEbyBub3QgYnJlYWsgZWFybHkgYm9vdCB3aXRoIHByb2Jp
bmcgDQphZGRyZXNzZXMiKSwgYW5kIHRoYXQncyB3aHkgdGhlIHN0cmluZygpIHV0aWxpdHkgbm8g
bG9uZ2VyIGRldGVjdHMgDQpub24tY2Fub25pY2FsIHN0cmluZyBwb2ludGVyLg0KDQpJIG9ubHkg
dGhvdWdodCB0aGF0IGtlcm5fYWRkcl92YWxpZCgpIGlzIGxlc3Mgb2YgYSBoZWF2eSBoYW1tZXIs
IGFuZCANCmNvdWxkIGJlIHNhZmVseSBkZXBsb3llZC4NCg0KdGhhbmtzLA0KLWphbmUNCg0K
