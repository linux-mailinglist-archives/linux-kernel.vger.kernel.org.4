Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C7604306
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiJSLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiJSLRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:17:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6EC18B768
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:45:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J9ivLV011838;
        Wed, 19 Oct 2022 10:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BGXgZKuu82LyhOnUWVC1mq6+NhCbduor9QCuN8oFQMQ=;
 b=Yml5yEJGmX7XaVWGmwq3V0+qJy8DdvoQzDMdEpy0OoW7lTZCMHsscdSfbwF+DBBwhhrb
 Cb4Q2v4FMTmyaxz2ObsPL3TEhvX642tww+2p4NaRtKRNkQ5LqOOHrJAY43/z6KtF9+/o
 QqsONR3ecRYegY2jwPH5DV9LQLKL3tAwaXcgY39vbywIj8TXC3nPDUhtR8HRC80j61pT
 Y+mQJQAXMU8Iy23uyc4t6yYawx/gNCaVOE+atcLpRBY2tzMHYWcVrzgGLHJ/4uQcJlsI
 2LkCLzjxGGy6c27+Q2lajy6QC43M4kIsShld9VwKyrruCB41yhi7truYm5hFia9Olxa1 pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntdq1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 10:43:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29J97pLU025648;
        Wed, 19 Oct 2022 10:43:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr0va56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 10:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCv3nFMDVhGHxQHZpqt5Lfr/zkHsBAiuCI9vZgSjCQB9+fM7B8AGV6nLJ4SjE1yQd+E5C46LsKQcfRdcRgpLphQuURc2NvLZ9Gz7yFSPVIug5/VQIzVCgA3rZ+rNwNUlRgFdF4U9zkcMdZOGahkyYb2D+9T1e2LLXuyrfA28SJXbAGL3Emp09qJK3WnDv2azXDy1KguEhmwKKrnRDDoGexDD6nHNHoETkn8BDoBzdD4r0AbwSlL78epZwg/QWuNxYgAUSbdrZwL1Dnj2PntyCnfcNazYfC1P6hJBbecuKLly6YQXkoVDrL8h3WXXnjuxFAKsBTr2yZWSAnsX3xU6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGXgZKuu82LyhOnUWVC1mq6+NhCbduor9QCuN8oFQMQ=;
 b=kaFwCmDcgsKeOsbNg7hobWRHsBCDdUXqkZQGv/XyJsxLa6wIMveBwRIAcVTlIHMhySBdcjEQBQ1oKwaLtXRpPnn7Rj7FxY0GxQtttPFLRlalLB70bS/fKZIMRXdW5/xOtzIUFjOR98/nMOnsxtPKrGrP/t116fAttPr2P6/wV8pdaQYuBkRT86d82OzHZwp+bwtopQgHu+sXNkkHi/qq4blHmZPkZBO1My/ctcSjxw9Cn6X7quJQB22ngVMzcCJAf/IeUUeEILC1ny9OZM7hdGqRdMruZH2h/07tW0YCPqZA1cD4JpJ/G1jrxZduOHNZVkr7sGQufYaDWWT75hqnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGXgZKuu82LyhOnUWVC1mq6+NhCbduor9QCuN8oFQMQ=;
 b=AcGsfwN2zSPK4sKUbyg8HKoXk7a+dx48xgLlkV3P5h/l1tzM9IZVsV5DpCK8AuV8+Pd8TBa8rEiE2S9HO2ELvgQ04TTkqtnYnc/MDusw1ez6LTWHwaNHQGs8OLJs42lNYjFAsjFg7MIZqXKeMMwVoSgL7+64bIMSjOrPRdf2qn8=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by MW5PR10MB5763.namprd10.prod.outlook.com (2603:10b6:303:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 10:43:07 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa%4]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 10:43:07 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jane Chu <jane.chu@oracle.com>, Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WAgAAT+ICAAAYogIAABW6AgADo6wA=
Date:   Wed, 19 Oct 2022 10:43:07 +0000
Message-ID: <198982F5-E94C-4F95-8197-FE69EFBA670F@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
In-Reply-To: <Y08RVzvniYr8ycKV@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|MW5PR10MB5763:EE_
x-ms-office365-filtering-correlation-id: 1a0b7f02-fcb5-4426-085f-08dab1beb569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofDCvRaC24dQAHQRs26gBoDEj/q5FiNceUfL4hy4RKf4eGZNoIIoBGAu60hzU55+ZKaBfpppuUmNyLwcoJoactUBzlIv0YbMGfG9o/EQpygsTas3FKcttt3zg3N6NEjckOXVLNyXXqFAmh8f988vEWPeNKcQRwyKf8T/5QxKowQpiZvluD7sz3uIXCp5kXGYhFbK7A2/EoaP1sTSSFFRKoBIghyMGxsb4fRBIjT7tIBtNxnv4dHiO3D/5Fq40ENu/GA7oNofpe3lB2khope2xpcpF1ojmNG7H/ZfiRVIeBt1ZCS+oF9ibItj2z9loCX0euf1YdMDBkM/yV0EbCikUweOk+lgd42L4gBe4CYFEC8y6n0r8c4XUmoWGIAgK5d77q5AOY7p2l4lBig+22qd6SfzX4n7aBo0yq7/nk3qIT5kkYJF+AYRC59K6lzNvWDq8TQHWF43D0LAc1DQEZZxsrzKhbS37JyTERiMK12NVJeyyXwDbU1NCLOK2upOQSZTt2dVAQ1jHSZEZ+tyA0mqBkiGoqQSS/D5CcRZezpj6RebWSo8FxV+HXiMCi2j7oOA4AWjHZwvyxtNBJCxA0PF+NF+AZhhSLFNd6jSqz2XBBAFArZH9slTH52qOTNC9BaC5C2zslCqOKQ4wIHyxDZJb84eVj6r0DECSciCnkdS6ywPJXW33Ny4U9QEkGe5ObCG1BmP3gc1NqeY9uT7/PWBPmqL6hiCdT4NQM0tz0KozLkJUWHMncDbdq1t+8H25zIhrLfJOF1HityUpZnGGv/hTYsDqU9KeAyqaFlPKPIFP9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(71200400001)(186003)(33656002)(38100700002)(2616005)(478600001)(4001150100001)(122000001)(6486002)(38070700005)(44832011)(66574015)(26005)(66476007)(66446008)(107886003)(53546011)(66946007)(8676002)(91956017)(36756003)(6916009)(6512007)(83380400001)(66556008)(54906003)(64756008)(316002)(86362001)(8936002)(5660300002)(76116006)(2906002)(4326008)(6506007)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RQZWdaSTJZUTN0bmlmQ2F0V2NhM2RlVEoyQ2FUWmc3ZlVNbEtkZzhNR3Fh?=
 =?utf-8?B?VlV6NFJ5b3o0Z2dPOWErSFRmNkp3ekY2SU81V29Mb2dGbk1PTm45eWkzSXNz?=
 =?utf-8?B?UW5BRTdsSWNrLzkwTVM1MVRFNkMyY0U0aXQxR1hmZUozN1pETGF5QVhiN0t0?=
 =?utf-8?B?azBWNHYrM3I1TlRXYTlFTHZFamMxdFNPUzJDYWlBNndUcHpWRWdtR0ZQdEw3?=
 =?utf-8?B?Y1RLNURkU0x1K2tncVZOeWNuNjkrbDhlTmVSTGxuSyt0YTlPNFQ5blY0Z2R3?=
 =?utf-8?B?MlFXS2JoQmx4SVRqMFlBazJqOTRUWU56L3pMT0t6a3lSWmpqMXhXT3BLUDJo?=
 =?utf-8?B?c3pIaE1TR2RlMFNrZUpNQjlhTVRNcENDQXpRakJtVXpnM1FDVnY4LzZDM0E3?=
 =?utf-8?B?VDFyejVQRkVrc3pjR3QwbWVrREF5aWV2S3VFTnJGNStyRXhWQ2dUaTJCckRW?=
 =?utf-8?B?c3F1TkxFeEtxc09zNzIrTUZ5K1lka0d5TkQ3cUpwRGswVjZtbDNnblZUdnBs?=
 =?utf-8?B?dHRPei83NUE5Qi9La0VrNmNoV1crVmo3WmtIQ09HZWM3TG8wZkdTdHlJRTBz?=
 =?utf-8?B?RHk5TmJNNytjNTJwc0hGRGhIZ2V0Sm02S3QrY0ZDOHJGWnVsK2NYMUt1TEdJ?=
 =?utf-8?B?NzQ2bUx0QWtnVWtsOU1pYktWNDQ2S2hteE4ydjRHa0N3cU1oZnB2M1R1TFdv?=
 =?utf-8?B?NnlRMVc5TUY4SVByRU93aWFPUGtaMnFCeTV3NUdaS05JZkJkYm5GM3JvdzA4?=
 =?utf-8?B?eEhyNndtYzltNWtIWmVyNUZZMXorYzVWai9BM2hSZWZpQUEvdmx2Tk1wUTNt?=
 =?utf-8?B?Q2xlaFJnUkNqWFd0b0Q2YzVsODVVYmpGamUwQU9YdWZPNmNDVytKNUwwMUZ1?=
 =?utf-8?B?Vnp6S2gxL0l2K3FkMTBFTmV3Tmt3NUZaRlkvZU1nd2pzWWlYc1BsUW82VGNR?=
 =?utf-8?B?c210TjNHRlBQd2lpcnhsQXNIb3kyRmxKWFQ1UE1EcldTZk9PaEc0cDF2T3c0?=
 =?utf-8?B?NHdVbDBKMzRHWWxiTG8zOXRHdnNSS0pBMG5tUU81UjF4VE5CaHE2eHd1cHVJ?=
 =?utf-8?B?ekJvSURRUzN5emozZGdGQTc5RGxwMFI1WSs5WVdDcm5RYnN4SGN5Y2s1NUt4?=
 =?utf-8?B?aHBSRG9HWXFGbGcydkJpQmRNUWY4MWU2U1BLWmpPN1ltWkZOTnNXNG5qaFBq?=
 =?utf-8?B?WkNMYkNJbXpBaWdPcHBTYU9qSjJFcWNLQStJL01hb3FYeUFUU3p0dmpNalV3?=
 =?utf-8?B?ejlBLzdramtkR3NQTllaZzdPSkp0UVBMcGRHSkFsak9hdWlvMXJWUU5rb0dy?=
 =?utf-8?B?T3RjNlZaNnFOYkdVQ1Vvci9xS2NGL2Q0cnYwTjE4TzVQc2JEOG9BSDF3b2Vx?=
 =?utf-8?B?ay9FU21zek1LWUJ3Rm15Y09HUWpUc29XK1N3WlhOc0lPY3IyY0lHQ0hKZCtH?=
 =?utf-8?B?dUFaVHdYQnlvd2tjcUNrc2RjQ3JMQ1lQWkJneUhzZEE0ZjlDZjR3bEREUVU3?=
 =?utf-8?B?Sm9UcVBjblNPbE1YRmNLTGxpMFpGMGUzWVRiQjNOdm12MDFzeWRwcjhEdjBQ?=
 =?utf-8?B?K1l5dnRhemYwZzl1UTREVXFjMElRK0ZSYzkzSDlFTlZyYkJBUDZEcVp0RWFO?=
 =?utf-8?B?ZkJ6eEJtTk94WEZodTlXT1dFUTJEdnJxa0dBYkRYcnBUMGducHlBa1RGU2JZ?=
 =?utf-8?B?NUdyK09JS3JTQzZVUWs2ZjBtSUUrY3NQelBwOW9WaWtpUGRvZzFkekJDcmtm?=
 =?utf-8?B?ejRrbGFyTWl5RWtPRVorQ3BEeThUVmEzdzRtc3FFZlpKQlZuNEY3enVXZERB?=
 =?utf-8?B?K1hPMDEzMW9CZkt2amVtb0poQTAwc0grSVBxbmgvK255ZVBXbE1MNnpaeVlk?=
 =?utf-8?B?WGF0b0V5R05SRmxQMnFsYTVjZ1ZuYmFsa0xVZWJSbEt0dDdFSjM4b2VhZ3hW?=
 =?utf-8?B?Y1lJMGJObnZKakNnS1Jnam00V00wUEJob2V2RDIrWHRHM3FEaU5YWTh2d2pJ?=
 =?utf-8?B?aUNFRUZkcTZnaC92NkwwUjJQaUVQRUU0QUF4UWtVdld2Q1VHbDk4dmw4UjAw?=
 =?utf-8?B?QjErdUtIZlRHeHJ3VGUrVkttRmRSTHpidk44bU1mS3F3SkN1MEI0SnFnUmsx?=
 =?utf-8?B?VUtZQU9ScXNrU3g2SUFtajAzZFVRNUJvb3ZIMTV0c205RnArUWxHdTJEQU1n?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69DEDD85C465284C8B43760556110798@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0b7f02-fcb5-4426-085f-08dab1beb569
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 10:43:07.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTTtInuU4LvnoHFp4Ab3BxvMh1lR5vJHrLM9IQXDFr8bico2j3HMcH4afhwWkmbB9CJmO3ktiFFnxVv7vgn8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190059
X-Proofpoint-ORIG-GUID: sw2M3PLL9NlQC_yVjMMLz59ulWSWBEjO
X-Proofpoint-GUID: sw2M3PLL9NlQC_yVjMMLz59ulWSWBEjO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTggT2N0IDIwMjIsIGF0IDIyOjQ5LCBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAxOCwg
MjAyMiBhdCAwODozMDowMVBNICswMDAwLCBKYW5lIENodSB3cm90ZToNCj4+IE9uIDEwLzE4LzIw
MjIgMTowNyBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIFR1ZSwgT2N0IDE4LCAy
MDIyIGF0IDA2OjU2OjMxUE0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBPbiAxMC8xOC8y
MDIyIDU6NDUgQU0sIFBldHIgTWxhZGVrIHdyb3RlOg0KPj4+Pj4gT24gTW9uIDIwMjItMTAtMTcg
MTk6MzE6NTMsIEphbmUgQ2h1IHdyb3RlOg0KPj4+Pj4+IE9uIDEwLzE3LzIwMjIgMTI6MjUgUE0s
IEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+Pj4gT24gTW9uLCBPY3QgMTcsIDIwMjIgYXQg
MDE6MTY6MTFQTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+Pj4+PiBXaGlsZSBkZWJ1Z2dp
bmcgYSBzZXBhcmF0ZSBpc3N1ZSwgaXQgd2FzIGZvdW5kIHRoYXQgYW4gaW52YWxpZCBzdHJpbmcN
Cj4+Pj4+Pj4+IHBvaW50ZXIgY291bGQgdmVyeSB3ZWxsIGNvbnRhaW4gYSBub24tY2FuaWNhbCBh
ZGRyZXNzLCBzdWNoIGFzDQo+Pj4+Pj4+PiAweDc2NjU2NDVmNjM2MTY0NjUuIEluIHRoYXQgY2Fz
ZSwgdGhpcyBsaW5lIG9mIGRlZmVuc2UgaXNuJ3QgZW5vdWdoDQo+Pj4+Pj4+PiB0byBwcm90ZWN0
IHRoZSBrZXJuZWwgZnJvbSBjcmFzaGluZyBkdWUgdG8gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0
DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IAlpZiAoKHVuc2lnbmVkIGxvbmcpcHRyIDwgUEFHRV9TSVpF
IHx8IElTX0VSUl9WQUxVRShwdHIpKQ0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJu
ICIoZWZhdWx0KSI7DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFNvIGluc3RlYWQsIHVzZSBrZXJuX2Fk
ZHJfdmFsaWQoKSB0byB2YWxpZGF0ZSB0aGUgc3RyaW5nIHBvaW50ZXIuDQo+Pj4+Pj4+IA0KPj4+
Pj4+PiBIb3cgZGlkIHlvdSBjaGVjayB0aGF0IHZhbHVlIG9mIHRoZSAoaW52YWxpZCBzdHJpbmcp
IHBvaW50ZXI/DQo+Pj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IEluIHRoZSBidWcgc2NlbmFyaW8s
IHRoZSBpbnZhbGlkIHN0cmluZyBwb2ludGVyIHdhcyBhbiBvdXQtb2YtYm91bmQNCj4+Pj4+PiBz
dHJpbmcgcG9pbnRlci4gV2hpbGUgdGhlIE9PQiByZWZlcmVuY2luZyBpcyBmaXhlZCwNCj4+Pj4+
IA0KPj4+Pj4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUg
Zml4ZWQgT09CPw0KPj4+Pj4gV2hhdCBleGFjdCB2c3ByaW50ZigpL3ByaW50aygpIGNhbGwgd2Fz
IGJyb2tlbiBhbmQgZXZlbnR1YWxseQ0KPj4+Pj4gaG93IGl0IHdhcyBmaXhlZCwgcGxlYXNlPw0K
Pj4+PiANCj4+Pj4gRm9yIHNlbnNpdGl2ZSByZWFzb24sIEknZCBsaWtlIHRvIGF2b2lkIG1lbnRp
b25pbmcgdGhlIHNwZWNpZmljIG5hbWUgb2YNCj4+Pj4gdGhlIHN5c2ZzIGF0dHJpYnV0ZSBpbiB0
aGUgYnVnLCBpbnN0ZWFkLCBqdXN0IGNhbGwgaXQgImRldlhfYXR0cllbXSIsDQo+Pj4+IGFuZCBk
ZXNjcmliZSB0aGUgcHJlY2lzZSBuYXR1cmUgb2YgdGhlIGlzc3VlLg0KPj4+PiANCj4+Pj4gZGV2
WF9hdHRyWVtdIGlzIGEgc3RyaW5nIGFycmF5LCBkZWNsYXJlZCBhbmQgZmlsbGVkIGF0IGNvbXBp
bGUgdGltZSwNCj4+Pj4gbGlrZQ0KPj4+PiAgICBjb25zdCBjaGFyIGNvbnN0IGRldlhfYXR0cllb
XSA9IHsNCj4+Pj4gCVtBVFRSWV9BXSA9ICJEZXYgWCBBdHRyaWJ1dGVZIEEiLA0KPj4+PiAJW0FU
VFJZX0JdID0gIkRldiBYIEF0dHJpYnV0ZVkgQiIsDQo+Pj4+IAkuLi4NCj4+Pj4gCVtBVFRSWV9H
XSA9ICJEZXYgWCBBdHRyaWJ1dGVZIEciLA0KPj4+PiAgICB9DQo+Pj4+IHN1Y2ggdGhhdCwgd2hl
biB1c2VyICJjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbXMvLi4uL2F0dHJ5XzEiLA0KPj4+PiAiRGV2
IFggQXR0cmlidXRlWSBCIiB3aWxsIHNob3cgdXAgaW4gdGhlIHRlcm1pbmFsLg0KPj4+PiBUaGF0
J3MgaXQsIG5vIG1vcmUgcmVmZXJlbmNlIHRvIHRoZSBwb2ludGVyIGRldlhfYXR0cllbQVRUUllf
Ql0gYWZ0ZXIgdGhhdC4NCj4+Pj4gDQo+Pj4+IFRoZSBidWcgd2FzIHRoYXQgdGhlIGluZGV4IHRv
IHRoZSBhcnJheSB3YXMgd3JvbmdmdWxseSBwcm9kdWNlZCwNCj4+Pj4gbGVhZGluZyB1cCB0byBP
T0IsIGUuZy4gZGV2WF9hdHRyWVsxMV0uICBUaGUgZml4IHdhcyB0byBmaXggdGhlDQo+Pj4+IGNh
bGN1bGF0aW9uIGFuZCB0aGF0IGlzIG5vdCBhbiB1cHN0cmVhbSBmaXguDQo+Pj4+IA0KPj4+Pj4g
DQo+Pj4+Pj4gdGhlIGxpbmdlcmluZyBpc3N1ZQ0KPj4+Pj4+IGlzIHRoYXQgdGhlIGtlcm5lbCBv
dWdodCB0byBiZSBhYmxlIHRvIHByb3RlY3QgaXRzZWxmLCBhcyB0aGUgcG9pbnRlcg0KPj4+Pj4+
IGNvbnRhaW5zIGEgbm9uLWNhbm9uaWNhbCBhZGRyZXNzLg0KPj4+Pj4gDQo+Pj4+PiBXYXMgdGhl
IHBvaW50ZXIgdXNlZCBvbmx5IGJ5IHRoZSB2c3ByaW50ZigpPw0KPj4+Pj4gT3Igd2FzIGl0IGFj
Y2Vzc2VkIGFsc28gYnkgYW5vdGhlciBjb2RlLCBwbGVhc2U/DQo+Pj4+IA0KPj4+PiBUaGUgT09C
IHBvaW50ZXIgd2FzIHVzZWQgb25seSBieSB2c3ByaW50ZigpIGZvciB0aGUgImNhdCIgc3lzZnMg
Y2FzZS4NCj4+Pj4gTm8gb3RoZXIgY29kZSB1c2VzIHRoZSBPT0IgcG9pbnRlciwgdmVyaWZpZWQg
Ym90aCBieSBjb2RlIGV4YW1pbmF0aW9uDQo+Pj4+IGFuZCB0ZXN0Lg0KPj4+IA0KPj4+IFNvLCB0
aGVuIHRoZSB2c3ByaW50ZigpIGlzIF90aGVfIHBvaW50IHRvIGNyYXNoIGFuZCB3aHkgc2hvdWxk
IHdlIGhpZGUgdGhhdD8NCj4+PiBCZWNhdXNlIG9mIHRoZSBjcmFzaCB5b3UgZm91bmQgdGhlIGN1
bHByaXQsIHJpZ2h0PyBUaGUgZWZhdWx0IHdpbGwgaGlkZSB2ZXJ5DQo+Pj4gaW1wb3J0YW50IGRl
dGFpbHMuDQo+Pj4gDQo+Pj4gU28gdG8gbWUgaXQgc291bmRzIGxpa2UgSSBsaWtlIHRoaXMgY2hh
bmdlIGxlc3MgYW5kIGxlc3MuLi4NCj4+IA0KPj4gV2hhdCBhYm91dCB0aGUgZXhpc3RpbmcgY2hl
Y2sNCj4+ICAJaWYgKCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFM
VUUocHRyKSkNCj4+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+PiA/
DQo+IA0KPiBCZWNhdXNlIGl0J3MgX3NwZWNpYWxfLiBXZSBrbm93IHRoYXQgRmlyc3QgcGFnZSBp
cyBlcXVpdmFsZW50IHRvIGEgTlVMTCBwb2ludGVyDQo+IGFuZCB0aGUgbGFzdCBvbmUgaXMgZGVk
aWNhdGVkIGZvciBzbyBjYWxsZWQgZXJyb3IgcG9pbnRlcnMuIFRoZXJlIGFyZSBubyBtb3JlDQo+
IHNwZWNpYWwgZXhjZXB0aW9ucyB0byB0aGUgYWRkcmVzc2VzIGluIHRoZSBMaW51eCBrZXJuZWwg
KEkgZG9uJ3QgdGFsayBhYm91dA0KPiBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzIGJ5IHRoZSBjZXJ0
YWluIGFyY2hpdGVjdHVyZXMpLg0KPiANCj4+IEluIGFuIGV4cGVyaW1lbnQganVzdCB0byBwcmlu
dCB0aGUgcmF3IE9PQiBwb2ludGVyIHZhbHVlcywgSSBzYXcgYmVsb3cNCj4+ICh0aGUgZGV2WCBh
dHRyWSBzdHVmZiBhcmUgc3Vic3RpdHV0ZXMgb2YgdGhlIHJlYWwgYXR0cmlidXRlcywgb3RoZXIg
DQo+PiB2YWx1ZXMgYW5kIHN0cmluZ3MgYXJlIHZlcmJhdGltIGNvcHkgZnJvbSAiZG1lc2ciKToN
Cj4+IA0KPj4gWyAzMDAyLjc3MjMyOV0gZGV2WF9hdHRyWVsyNl06IChmZmZmZmZmZjg0ZDYwYWQz
KSBEZXYgWCBBdHRyaWJ1dGVZIEUNCj4+IFsgMzAwMi43NzIzNDZdIGRldlhfYXR0cllbMjddOiAo
ZmZmZmZmZmY4NGQ2MGFlNCkgRGV2IFggQXR0cmlidXRlWSBGDQo+PiBbIDMwMDIuNzcyMzQ3XSBk
ZXZYX2F0dHJZWzI4XTogKGZmZmZmZmZmODRkNjBhZWUpIERldiBYIEF0dHJpYnV0ZVkgRw0KPj4g
WyAzMDAyLjc3MjM0OV0gZGV2WF9hdHRyWVsyOV06ICgwKSAobnVsbCkNCj4+IFsgMzAwMi43NzIz
NTBdIGRldlhfYXR0cllbMzBdOiAoMCkgKG51bGwpDQo+PiBbIDMwMDIuNzcyMzUxXSBkZXZYX2F0
dHJZWzMxXTogKDApIChudWxsKQ0KPj4gWyAzMDAyLjc3MjM1Ml0gZGV2WF9hdHRyWVszMl06ICg3
NjY1NjQ1ZjYzNjE2NDY1KSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NF0gZGV2WF9hdHRyWVsz
M106ICg2NDZlNjE2ODVmNjU2MzY5KSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NV0gZGV2WF9h
dHRyWVszNF06ICg2ZjYzNWY2NTc1NWY2NTZjKSAoZWludmFsKQ0KPj4gWyAzMDAyLjc3MjM1NV0g
ZGV2WF9hdHRyWVszNV06ICg3NDZlNzUpIChlaW52YWwpDQo+PiANCj4+IHdoZXJlIHN0YXJ0aW5n
IGZyb20gaW5kZXggMjkgYXJlIGFsbCBPT0IgcG9pbnRlcnMuDQo+PiANCj4+IEFzIHlvdSBjYW4g
c2VlLCBpZiB0aGUgT09CcyBhcmUgTlVMTCwgIihudWxsKSIgd2FzIHByaW50ZWQgZHVlIHRvIHRo
ZSANCj4+IGV4aXN0aW5nIGNoZWNraW5nLCBidXQgd2hlbiB0aGUgT09CcyBhcmUgdHVybmVkIHRv
IG5vbi1jYW5vbmljYWwgd2hpY2gNCj4+IGlzIGRldGVjdGFibGUsIHRoZSBmYWN0IHRoZSBwb2lu
dGVyIHZhbHVlIGRldmlhdGVzIGZyb20NCj4+ICAgKGZmZmZmZmZmODRkNjBhZWUgKyA0ICogc2l6
ZW9mKHZvaWQgKikpDQo+PiBldmlkZW50bHkgc2hvd24gdGhhdCB0aGUgT09CcyBhcmUgZGV0ZWN0
YWJsZS4NCj4+IA0KPj4gVGhlIHF1ZXN0aW9uIHRoZW4gaXMgd2h5IHNob3VsZCB0aGUgbm9uLWNh
bm9uaWNhbCBPT0JzIGJlIHRyZWF0ZWQgDQo+PiBkaWZmZXJlbnRseSBmcm9tIE5VTEwgYW5kIEVS
Ul9WQUxVRT8NCj4gDQo+IE9idmlvdXNseSwgdG8gc2VlIHRoZSBjcmFzaC4gQW5kIGxldCBrZXJu
ZWwgX3RvIGNyYXNoXy4gSXNuJ3QgaXQgd2hhdCB3ZSBuZWVkDQo+IHRvIHNlZSBhIGJ1ZyBhcyBl
YXJseSBhcyBwb3NzaWJsZT8NCg0KSWYgeW91IGZvbGxvdyB0aGF0IGFyZ3VtZW50LCB3aHkgZG9l
c24ndCB0aGUga2VybmVsIGNyYXNoIHdoZW4gdGhlIHBvaW50ZXIgaXMsIGUuZy4sIGEgTlVMTCBw
b2ludGVyPyBBY2NvcmRpbmcgdG8geW91LCBzaG91bGRuJ3QgaXQgY3Jhc2ggYSBlYXJseSBhcyBw
b3NzaWJsZSBpbiB0aGF0IGNhc2UgYWxzbz8NCg0KDQpUaHhzLCBIw6Vrb24NCg0K
