Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08E6033EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJRUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:30:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5477B84A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:30:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IKTENB031561;
        Tue, 18 Oct 2022 20:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xveVWBuR3Ex6dtxitq5HU07eCEsA2qoDi0bnxlunrgs=;
 b=k+PKL0GJ7yds+cX/Ky//bH22luqg6+VC7vzyG339nRMUZtBy/bknMhNw6r86A+a6KL4z
 ZIS+wPjbDqFiLv669ti9o+5AtF6qNXUB25S5+Y0Hj2NArMA6dvaHwsEfQbBMJyP8/tv0
 sEw2AD0NF0b4nweqUbxdnLCssLyAkAd4SKiGMdlgQ5nnjEOUgydkRLa3q3w5anuA4Ko5
 zc/h4F9IRSGLRDLBgYME9ooz1e4UuVEPYJbTCVKBzhAAeDCBpF6aadqA4MnkBr7DBqZ9
 MD31OPVmrhwtjBP4btX4Bq0KDfHn6CNe+ApNdIJ0B6NJmGQ4ilnvKzjEoiroBO5gEreL dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtgdaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 20:30:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJml8H031353;
        Tue, 18 Oct 2022 20:30:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0r0qj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 20:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmOyw7xOvJv5AEpn+vQkt43nT+s1w+6ApRGqUlE3b8G6BJ1EGD/3EaPKeYytWMmxfaku/EmEzcSFINDEbtL15FCRycyCQtfF62949KNB+nA7hugnBHnlK0urzxlqnkhM5hf/6B9pmTdVRS3Wvouwc9k1DtstUZkhbX3BOniV3HxAbS7i7bxZn1ab8jk/rLJUSL2g0OW/ziuoMNOsi5qjbV9A+3p7hX34iz7fes/vZ/ccH4sHOlPMBzxr3s+L73Y1QhD3CQP1GLiw3iZZLjXLXkxakFePGns6nWXIuK34kZFHcafMI5oAuYB2Vn+qQu8xaqjgnRO/dJnBl5pE9x10Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xveVWBuR3Ex6dtxitq5HU07eCEsA2qoDi0bnxlunrgs=;
 b=P0iO1KY7+Fyygwxr+BMQjq6jPitNXjonRU1gFyNClMhzmwf7V/iOfl2fIrOhXn+beh7jrayXEvZt1BPC+9IGATiqPlkrVbQ34QTiYXXo/lMFFWa8xtEaCys9Zo1TlMKPSgvOgkzyMYkGyQGQoXC9XRxJlvcoJJaJC/Al+8hV/38L3OKPHuccD2B5Nl00mjrUfTD3q8dStZMc867EzWuplwbpWZcRfSc8mDFMgTH5dgZnymyqDhxliPNx4iheH/q/itIrKz4fTRX+cptQ5LJkj6gaU3hGohFkMPs7Wv2kNZMOQ+LtGSoSWoeTYAJfqwSAsWLxx4iijC5J+RfI4snp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xveVWBuR3Ex6dtxitq5HU07eCEsA2qoDi0bnxlunrgs=;
 b=hFWrRjDHy2wnepnM20PEfFQ4ucq48suIE4hYHfxY3XBNjUay20bgulcmJr5R75XsICQhQqbgefhGZzrej/QptntMuF+gTRYCYP+/rPKBVlMhxDznCwaaQfvjck74YM/IW8sz8Mp4q4Bgs4Za6aYOTVGN+QihffMlet74olHviOw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 20:30:01 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 20:30:01 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WAgAAT+ICAAAYogA==
Date:   Tue, 18 Oct 2022 20:30:01 +0000
Message-ID: <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
In-Reply-To: <Y08Hn6on37fgc57F@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|BY5PR10MB4308:EE_
x-ms-office365-filtering-correlation-id: 847472cd-24ad-4009-e4a4-08dab1478881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Cdp9s4DcCUuvVnIq1aM/GOtCl34llhS+U/9xdUaOZuE4wN9W6cHpI+6oaDyOvoaiDFk8Dna3H6eoa+MjpjKKdnbb6Wzqjbos0N/36p1DS6jHa0aG4/6TcsZE+a3BXeYF0QsJnLVmIhFm6cRVMibGR4u4eJt2Pz3bxNh/Fg7RJ/NIgBCBVOTh0nTBhDwMPl9GRxv99DI2mn2X1irP73HvwzTitq4DIq40BYxFgrTeCnpvUFHG49srKkvodEtFeyxr3JlVTlYp/4HDaY2TMtsIN4TY/VeWckqJE3Xxt5JdGrxHVS1oR8J8KDH5uVO8aqZXxSJnh5TqvQezGdPfqXPWBMRXMMqNYHe5pE/Q7J0As+0xDMYtgZniIlFwTNlG5AIiutOs6JfPywgvmC0cUvbWW1eRfnJbpngcBl6Lvn63kHv0t6D5m9vw5z7qox68OL+zUjCJcdbrp3/CBR4zRuWvEs7yxgiv2xpzhLsBr4PrNHKN1rQCbbiNTEb7q70WQrpfu7wFtytnmlK0XfUaN6gQ9IGXxgFkQDZQcemFqNg9N0gRuj5OewviDIxp3bgflG+o5h+rgVQMMa2geLM1oBYmfqqMd8pzLzIZjyjjY4EVfwkMXaCmlU53hHIAYkTgAzX71T5SEU61HcdDr4pZAvG7WYgCihSm5csn/E7epT49kQfnXx/DSoiKP5AFKiLrxK12pw16znEYLQVCdBZNY1q7LeJ+OU/zJOFTx3bg6yypBZBw3yMJeZ/AH4/yvC0kedGeIetqNPWc2jTBvW/2IopEaPVGcaLtTyNHBNWEIANejRZPNzuxcW681wUAjMPHoWntxA8nCzlBmyurPIiXXePQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(54906003)(53546011)(186003)(38070700005)(83380400001)(31696002)(5660300002)(86362001)(2616005)(122000001)(44832011)(4001150100001)(2906002)(4326008)(8936002)(64756008)(8676002)(107886003)(6512007)(41300700001)(26005)(6486002)(478600001)(91956017)(6506007)(316002)(66476007)(66556008)(76116006)(66946007)(71200400001)(66446008)(6916009)(36756003)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHF6YXJBYnhtUnNOUHVrU3FOMVdVZEN3dlZpNDRnQklhNERIVlhEcVJWSVR4?=
 =?utf-8?B?WU1tUDcySm9TOUhQZTBkQ2p3UnFvd01oM3c4VTh2empuR0pEV0Z3TlE4U0xK?=
 =?utf-8?B?b3BjMTdkUmVHYWZBWkIvOUhRdnZ4NllOWE5wekVQMjMwV1diUGtMLzYwV05B?=
 =?utf-8?B?OHVOUVBDM1ZKaW5oaVdyVUpyNC9LSVZhU1cwbTRld0oxYm9QMEZhNFdhSmRT?=
 =?utf-8?B?MDhmS3cvQkdGM1pDZXgyNEo1N1FodFhaK1JDYlc5VGNENkRvQlFsc3Ztbytt?=
 =?utf-8?B?RkRpdHJoeUJObmxBVE5oNDJFVUNiTjVHZzc0Z1FhTXVMSlp4aFFHVVVnN21F?=
 =?utf-8?B?WlFOOGxDV2ZwTnMwblpoVmYwUkswNXpzRVdib2hjZTk1ekFkTXYvM1hTeTZ4?=
 =?utf-8?B?Z2hJNVUzWFVNYjBocVN1RUdsRzk2SjI0Z2kwREsxZ0xtcEJVY3VNVHlVZ0Rz?=
 =?utf-8?B?SWJLVlVkSys0Z1hsT3V0RFIwVkJNY3lnVDBrcE9IdFA5WHFMZlAzTVR0MXds?=
 =?utf-8?B?REgzaTZLVUIzQUl4L3lkdHJJZkhqeEhGWTViekdzOHRmR212aTJWbXpRWU1k?=
 =?utf-8?B?emxLeUg2dWt2ZHZpUy9FaS9JdHFZTSt1MkI4THFuTlM0SFI3QXRKTXpkYUJ0?=
 =?utf-8?B?U0NQQTNjMnMxbU9xNDhmdzhzRUpTR3UrTmE2MzF5QlpuUldSL2podlNMNlRV?=
 =?utf-8?B?Vyt2L1R4aG5qUnJhTjdLUmRBYmlYTnR0dFA1Wi83T2dzSExReHBKeFpoMjVl?=
 =?utf-8?B?NnpEdzg4L20yUHI1d3AycFZVQVJDQ2hBMG03WEVzMEpKU3R5VXgwNWUwQ3pB?=
 =?utf-8?B?ZUd4N2kxa1A5ZDNrK1dxVzgxbXpwenJtMFNPSFFTakZydWc3QWF6UTJBVzQ2?=
 =?utf-8?B?UGFUNzZDcU40dCs3dTQyY0M4emdJT0IrSXJBWnU1NjU4YklSb1pObTRLY0tL?=
 =?utf-8?B?bWQzOUVtTDBXbmVjOTZ5ZDZPU3VwUU1kazVPOUEwcjNLZVNMZWg2d0ZiMWd6?=
 =?utf-8?B?Z0JqRWwyeXBwTEJzN0JVSXBidUYyNkdRVkphbnBBcEEzWGRISGRJVzFvalFw?=
 =?utf-8?B?WGE4emxSWUhpTGF6M09KTHJoa3BLbno0bTh4ODFpTWhNR1oyMkpzYlpZUnRr?=
 =?utf-8?B?UjI4dk9RR2hSM1dkUVpqbmNxL3JlR3JFU3E4LzJzT1NqTFc0OFpXMFRtQkJk?=
 =?utf-8?B?VURIUGpua3RDVW10OU9sb0MzcUV6ZjN1R0tRQitCY1A4TGFaaU0rRmJmMDhr?=
 =?utf-8?B?VVFSZkwyczRxNjZITEVEMHlEWmZMb1YvcHpxUVVWY0RtWjF2OHNTMmFyUjZl?=
 =?utf-8?B?Z3VVMkFJbmNNUE5nYytGU3V4Sm5IQUFnOHJlM2txU2pJMGlEL0VORHpOYm9O?=
 =?utf-8?B?VTM3UE9uS3JkcG14OWt6S0V0VmVRVGdaNFU5dkVRNmdpWDRJYk4rTWRocDlR?=
 =?utf-8?B?cXBXSmt1Zk0xVTdKYjNjcjVoRXduc2svUitLZVoxekVVN003M09qSmFVNXhk?=
 =?utf-8?B?QVhpeHhBUzBPbGZ2M29GWkVBblZ5NGxZdEcrTVo5TjBpRkJaYlB2ZVp0UEJ2?=
 =?utf-8?B?LzRVOVozQy84NmhIU25LYzlWcHZtNTg3d3pDM0ZwdUZUdkpHSkovUlYyaHZR?=
 =?utf-8?B?dXI4cEY4MElDMkpmTzNXOHI1WmNSc2VHUjh0Y3pxS2JRV2ZNa0VnME0zc0dn?=
 =?utf-8?B?dFhYOEZyNEdSYkRqU0RNYjBoTHpNTWRtUGhXSHRoS1QzOUZsVjNxMm5FNmtM?=
 =?utf-8?B?NVdHbDc3TDJqZGtQajc3WW10NnVBQmRmYzNBeE5XY2VlQ29XUnVTRGppMmt5?=
 =?utf-8?B?OUd6ampOSm84R01lSDJLLys5a25KOFkraTJoVXpDMUFxeDVCL0pmVm5zbEFQ?=
 =?utf-8?B?T3h1T0thWGRMN0dGMmNDQ1hQaWhOY2pTemI4K08wcFVQbERxYXVNZU5nU1Rp?=
 =?utf-8?B?Ri9aZDhsL0R2WTMzTk42Z0UzbVRpbUhpYlNyK00ydDl1MFpvVVhCd2NmSlFU?=
 =?utf-8?B?dEphaVRrc1dTbUpOVE95d2xBZnlFLzBCUlVIOXI3TVlsb0hhNzN5MmtpYWlW?=
 =?utf-8?B?YUZLdzNCRDlaeUVheGF3eVFoSDJMSDIrVksxVDVGK1BUVVBXRzBKRll2U2Fn?=
 =?utf-8?Q?SiNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBF98B8A93CBA84583F0187E81E9D48D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847472cd-24ad-4009-e4a4-08dab1478881
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 20:30:01.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q+BfRxGLBnZiLbVJ2V9qjm7k3wEXuNqSwA8UDASkXEKz71EJXNDOSu6QJRj4NHIMp2vSN4x+sgyiIYyfJUOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180115
X-Proofpoint-ORIG-GUID: -N59k93bc2_2FhvyxdEHDhJnbEYhALd0
X-Proofpoint-GUID: -N59k93bc2_2FhvyxdEHDhJnbEYhALd0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjAyMiAxOjA3IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDE4LCAyMDIyIGF0IDA2OjU2OjMxUE0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gT24g
MTAvMTgvMjAyMiA1OjQ1IEFNLCBQZXRyIE1sYWRlayB3cm90ZToNCj4+PiBPbiBNb24gMjAyMi0x
MC0xNyAxOTozMTo1MywgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+IE9uIDEwLzE3LzIwMjIgMTI6MjUg
UE0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgT2N0IDE3LCAyMDIyIGF0
IDAxOjE2OjExUE0gLTA2MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+Pj4+IFdoaWxlIGRlYnVnZ2lu
ZyBhIHNlcGFyYXRlIGlzc3VlLCBpdCB3YXMgZm91bmQgdGhhdCBhbiBpbnZhbGlkIHN0cmluZw0K
Pj4+Pj4+IHBvaW50ZXIgY291bGQgdmVyeSB3ZWxsIGNvbnRhaW4gYSBub24tY2FuaWNhbCBhZGRy
ZXNzLCBzdWNoIGFzDQo+Pj4+Pj4gMHg3NjY1NjQ1ZjYzNjE2NDY1LiBJbiB0aGF0IGNhc2UsIHRo
aXMgbGluZSBvZiBkZWZlbnNlIGlzbid0IGVub3VnaA0KPj4+Pj4+IHRvIHByb3RlY3QgdGhlIGtl
cm5lbCBmcm9tIGNyYXNoaW5nIGR1ZSB0byBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQNCj4+Pj4+
Pg0KPj4+Pj4+IAlpZiAoKHVuc2lnbmVkIGxvbmcpcHRyIDwgUEFHRV9TSVpFIHx8IElTX0VSUl9W
QUxVRShwdHIpKQ0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gIihlZmF1bHQpIjsN
Cj4+Pj4+Pg0KPj4+Pj4+IFNvIGluc3RlYWQsIHVzZSBrZXJuX2FkZHJfdmFsaWQoKSB0byB2YWxp
ZGF0ZSB0aGUgc3RyaW5nIHBvaW50ZXIuDQo+Pj4+Pg0KPj4+Pj4gSG93IGRpZCB5b3UgY2hlY2sg
dGhhdCB2YWx1ZSBvZiB0aGUgKGludmFsaWQgc3RyaW5nKSBwb2ludGVyPw0KPj4+Pj4NCj4+Pj4N
Cj4+Pj4gSW4gdGhlIGJ1ZyBzY2VuYXJpbywgdGhlIGludmFsaWQgc3RyaW5nIHBvaW50ZXIgd2Fz
IGFuIG91dC1vZi1ib3VuZA0KPj4+PiBzdHJpbmcgcG9pbnRlci4gV2hpbGUgdGhlIE9PQiByZWZl
cmVuY2luZyBpcyBmaXhlZCwNCj4+Pg0KPj4+IENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBtb3Jl
IGRldGFpbHMgYWJvdXQgdGhlIGZpeGVkIE9PQj8NCj4+PiBXaGF0IGV4YWN0IHZzcHJpbnRmKCkv
cHJpbnRrKCkgY2FsbCB3YXMgYnJva2VuIGFuZCBldmVudHVhbGx5DQo+Pj4gaG93IGl0IHdhcyBm
aXhlZCwgcGxlYXNlPw0KPj4NCj4+IEZvciBzZW5zaXRpdmUgcmVhc29uLCBJJ2QgbGlrZSB0byBh
dm9pZCBtZW50aW9uaW5nIHRoZSBzcGVjaWZpYyBuYW1lIG9mDQo+PiB0aGUgc3lzZnMgYXR0cmli
dXRlIGluIHRoZSBidWcsIGluc3RlYWQsIGp1c3QgY2FsbCBpdCAiZGV2WF9hdHRyWVtdIiwNCj4+
IGFuZCBkZXNjcmliZSB0aGUgcHJlY2lzZSBuYXR1cmUgb2YgdGhlIGlzc3VlLg0KPj4NCj4+IGRl
dlhfYXR0cllbXSBpcyBhIHN0cmluZyBhcnJheSwgZGVjbGFyZWQgYW5kIGZpbGxlZCBhdCBjb21w
aWxlIHRpbWUsDQo+PiBsaWtlDQo+PiAgICAgY29uc3QgY2hhciBjb25zdCBkZXZYX2F0dHJZW10g
PSB7DQo+PiAJW0FUVFJZX0FdID0gIkRldiBYIEF0dHJpYnV0ZVkgQSIsDQo+PiAJW0FUVFJZX0Jd
ID0gIkRldiBYIEF0dHJpYnV0ZVkgQiIsDQo+PiAJLi4uDQo+PiAJW0FUVFJZX0ddID0gIkRldiBY
IEF0dHJpYnV0ZVkgRyIsDQo+PiAgICAgfQ0KPj4gc3VjaCB0aGF0LCB3aGVuIHVzZXIgImNhdCAv
c3lzL2RldmljZXMvc3lzdGVtcy8uLi4vYXR0cnlfMSIsDQo+PiAiRGV2IFggQXR0cmlidXRlWSBC
IiB3aWxsIHNob3cgdXAgaW4gdGhlIHRlcm1pbmFsLg0KPj4gVGhhdCdzIGl0LCBubyBtb3JlIHJl
ZmVyZW5jZSB0byB0aGUgcG9pbnRlciBkZXZYX2F0dHJZW0FUVFJZX0JdIGFmdGVyIHRoYXQuDQo+
Pg0KPj4gVGhlIGJ1ZyB3YXMgdGhhdCB0aGUgaW5kZXggdG8gdGhlIGFycmF5IHdhcyB3cm9uZ2Z1
bGx5IHByb2R1Y2VkLA0KPj4gbGVhZGluZyB1cCB0byBPT0IsIGUuZy4gZGV2WF9hdHRyWVsxMV0u
ICBUaGUgZml4IHdhcyB0byBmaXggdGhlDQo+PiBjYWxjdWxhdGlvbiBhbmQgdGhhdCBpcyBub3Qg
YW4gdXBzdHJlYW0gZml4Lg0KPj4NCj4+Pg0KPj4+PiB0aGUgbGluZ2VyaW5nIGlzc3VlDQo+Pj4+
IGlzIHRoYXQgdGhlIGtlcm5lbCBvdWdodCB0byBiZSBhYmxlIHRvIHByb3RlY3QgaXRzZWxmLCBh
cyB0aGUgcG9pbnRlcg0KPj4+PiBjb250YWlucyBhIG5vbi1jYW5vbmljYWwgYWRkcmVzcy4NCj4+
Pg0KPj4+IFdhcyB0aGUgcG9pbnRlciB1c2VkIG9ubHkgYnkgdGhlIHZzcHJpbnRmKCk/DQo+Pj4g
T3Igd2FzIGl0IGFjY2Vzc2VkIGFsc28gYnkgYW5vdGhlciBjb2RlLCBwbGVhc2U/DQo+Pg0KPj4g
VGhlIE9PQiBwb2ludGVyIHdhcyB1c2VkIG9ubHkgYnkgdnNwcmludGYoKSBmb3IgdGhlICJjYXQi
IHN5c2ZzIGNhc2UuDQo+PiBObyBvdGhlciBjb2RlIHVzZXMgdGhlIE9PQiBwb2ludGVyLCB2ZXJp
ZmllZCBib3RoIGJ5IGNvZGUgZXhhbWluYXRpb24NCj4+IGFuZCB0ZXN0Lg0KPiANCj4gU28sIHRo
ZW4gdGhlIHZzcHJpbnRmKCkgaXMgX3RoZV8gcG9pbnQgdG8gY3Jhc2ggYW5kIHdoeSBzaG91bGQg
d2UgaGlkZSB0aGF0Pw0KPiBCZWNhdXNlIG9mIHRoZSBjcmFzaCB5b3UgZm91bmQgdGhlIGN1bHBy
aXQsIHJpZ2h0PyBUaGUgZWZhdWx0IHdpbGwgaGlkZSB2ZXJ5DQo+IGltcG9ydGFudCBkZXRhaWxz
Lg0KPiANCj4gU28gdG8gbWUgaXQgc291bmRzIGxpa2UgSSBsaWtlIHRoaXMgY2hhbmdlIGxlc3Mg
YW5kIGxlc3MuLi4NCg0KV2hhdCBhYm91dCB0aGUgZXhpc3RpbmcgY2hlY2sNCiAgCWlmICgodW5z
aWduZWQgbG9uZylwdHIgPCBQQUdFX1NJWkUgfHwgSVNfRVJSX1ZBTFVFKHB0cikpDQogICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gIihlZmF1bHQpIjsNCj8NCg0KSW4gYW4gZXhwZXJpbWVudCBq
dXN0IHRvIHByaW50IHRoZSByYXcgT09CIHBvaW50ZXIgdmFsdWVzLCBJIHNhdyBiZWxvdw0KKHRo
ZSBkZXZYIGF0dHJZIHN0dWZmIGFyZSBzdWJzdGl0dXRlcyBvZiB0aGUgcmVhbCBhdHRyaWJ1dGVz
LCBvdGhlciANCnZhbHVlcyBhbmQgc3RyaW5ncyBhcmUgdmVyYmF0aW0gY29weSBmcm9tICJkbWVz
ZyIpOg0KDQpbIDMwMDIuNzcyMzI5XSBkZXZYX2F0dHJZWzI2XTogKGZmZmZmZmZmODRkNjBhZDMp
IERldiBYIEF0dHJpYnV0ZVkgRQ0KWyAzMDAyLjc3MjM0Nl0gZGV2WF9hdHRyWVsyN106IChmZmZm
ZmZmZjg0ZDYwYWU0KSBEZXYgWCBBdHRyaWJ1dGVZIEYNClsgMzAwMi43NzIzNDddIGRldlhfYXR0
cllbMjhdOiAoZmZmZmZmZmY4NGQ2MGFlZSkgRGV2IFggQXR0cmlidXRlWSBHDQpbIDMwMDIuNzcy
MzQ5XSBkZXZYX2F0dHJZWzI5XTogKDApIChudWxsKQ0KWyAzMDAyLjc3MjM1MF0gZGV2WF9hdHRy
WVszMF06ICgwKSAobnVsbCkNClsgMzAwMi43NzIzNTFdIGRldlhfYXR0cllbMzFdOiAoMCkgKG51
bGwpDQpbIDMwMDIuNzcyMzUyXSBkZXZYX2F0dHJZWzMyXTogKDc2NjU2NDVmNjM2MTY0NjUpIChl
aW52YWwpDQpbIDMwMDIuNzcyMzU0XSBkZXZYX2F0dHJZWzMzXTogKDY0NmU2MTY4NWY2NTYzNjkp
IChlaW52YWwpDQpbIDMwMDIuNzcyMzU1XSBkZXZYX2F0dHJZWzM0XTogKDZmNjM1ZjY1NzU1ZjY1
NmMpIChlaW52YWwpDQpbIDMwMDIuNzcyMzU1XSBkZXZYX2F0dHJZWzM1XTogKDc0NmU3NSkgKGVp
bnZhbCkNCg0Kd2hlcmUgc3RhcnRpbmcgZnJvbSBpbmRleCAyOSBhcmUgYWxsIE9PQiBwb2ludGVy
cy4NCg0KQXMgeW91IGNhbiBzZWUsIGlmIHRoZSBPT0JzIGFyZSBOVUxMLCAiKG51bGwpIiB3YXMg
cHJpbnRlZCBkdWUgdG8gdGhlIA0KZXhpc3RpbmcgY2hlY2tpbmcsIGJ1dCB3aGVuIHRoZSBPT0Jz
IGFyZSB0dXJuZWQgdG8gbm9uLWNhbm9uaWNhbCB3aGljaA0KaXMgZGV0ZWN0YWJsZSwgdGhlIGZh
Y3QgdGhlIHBvaW50ZXIgdmFsdWUgZGV2aWF0ZXMgZnJvbQ0KICAgKGZmZmZmZmZmODRkNjBhZWUg
KyA0ICogc2l6ZW9mKHZvaWQgKikpDQpldmlkZW50bHkgc2hvd24gdGhhdCB0aGUgT09CcyBhcmUg
ZGV0ZWN0YWJsZS4NCg0KVGhlIHF1ZXN0aW9uIHRoZW4gaXMgd2h5IHNob3VsZCB0aGUgbm9uLWNh
bm9uaWNhbCBPT0JzIGJlIHRyZWF0ZWQgDQpkaWZmZXJlbnRseSBmcm9tIE5VTEwgYW5kIEVSUl9W
QUxVRT8NCg0KVGhhbmtzLA0KLWphbmUNCg0KDQo=
