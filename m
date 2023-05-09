Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC206FBC9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEIBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEIBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:44:29 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853859D3;
        Mon,  8 May 2023 18:44:28 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348K5bra006251;
        Mon, 8 May 2023 18:44:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=hnYwl1ImJbxLwDiUbCTnK7c3cZjQO/gnfRkdn6vVrcI=;
 b=jHFoi8nK/g6dVVqItw9UwExw0V/XNjiVLc5iscRO/F8zMypua3v8q13/WdjKIt8FLNzx
 A8/ptorZMdL0EWwIxE71mmv+1wcI7fDbtCI4TbgpXqKjd1g2xckw8U561lgsci5be/5f
 nwqRM/WXaWcDuHB5Jkt6mxNccHH3YJd22YZ8iqfKYUSl5oOCHPoRRiPx+73UTsMd6sCv
 qqZGFeimDoJnvv4CeyHx9E/JOPqU+qagmZHhdJcD3JSUZx1TBsX6ovaYfi42qdHlJCoi
 19ZJPNU80fS8Py7CfVjrvmZkP/HF21wXSIH5NOo5Sx3j6pEhQyKwZNyzbhZleKF9cvnX 1A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7tbgj74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 18:44:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVBhylBWvb7A8PC5F86QsjvCMlUWJgZ7LARFdrP8JXqkKjj9HHFLQxKPTwiEqOnh5hRjHCId/pJa/oWLm8TqxXm/q+IW8QGdcO9+SLy36fCcju27forzJe+w0MSIvPDujze/xL0wy4uneQ+oX5EtGL42LbtCNj/E/yGoLGlvtQK/od0/225wHeZiLHGyr1kiXUcMxofPvNlt58aCFDlj4G99AZQEhFQrstcV5dA6pcgTjI7b8F2TeFReotzmIpiEMpdO7BZ1O+QHrpK5rNuncOEOnbJu0uMa6zqzhT9Q9oANEZC5Hv4/+3GVycvOHdw+fZBTNSaoapOYWb9wICQXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnYwl1ImJbxLwDiUbCTnK7c3cZjQO/gnfRkdn6vVrcI=;
 b=EDti5Z+l7pJb+C0hbYxzFxjY6+ZcS3JjLrl5GWtSHCg4iQBgOOftuxiApsxbFibxV6UTj6B7dPSLFZURfg4T51bNVUjMMQJO9AVo59gc/Dz3hcg/giznKSax3kccHAlPOHHcc+/MMSVkPzT0CtU3M8HGFW7njT32NMjdfLy6TYyDHDtO9Df8IBCTUklDWQGhGcPF54RYxdPjswLWAKP50equtzveiOHnbGLyEgrX9rX7n15PW0qu3APHyLHT+D6eixw9U/UWlgatBtaNhgaZ/u+VA7abJuYRMVf6Jxc6hnCUQmaOx4GnooGtePC5gnzlxs6bzW66p7ViEgdI9xm69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYwl1ImJbxLwDiUbCTnK7c3cZjQO/gnfRkdn6vVrcI=;
 b=BLO0cTtSnP5S04oDRlEg0xCGOKO/TWSfjO3vpCaGyrmEVoLA5/4qZRH7W8+acYog38ZRJ9X2y0i5sqNQgexHxn8DfwK4zaGJNoK+MnhbYdfN2WMTrjyLRvobaBCXSUVh36Xuqc1ouC7Dkv7ah/XN14rzaGDMrCLBZsZ+38X5FmK5c6hxeUai7spqhmuUI8FaW7afCJ4hlQbd6y0iOrkvst+s/84CPoU1jKfqhyvIUxHOUpV6kaZi19nMs0lq8TX77z29XcHFJXcocsL7aKGzSKr+/salURxBOH/EtmrcC2ZzV3eW30nFgTBdhy5dnTq90akNBMjM+fwDO092GMZb7A==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by BY5PR02MB7026.namprd02.prod.outlook.com (2603:10b6:a03:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 01:44:14 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 01:44:14 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     kernel test robot <lkp@intel.com>
CC:     Paul Moore <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 4/4] audit: check if queue is full after
 prepare_to_wait_exclusive()
Thread-Topic: [PATCH 4/4] audit: check if queue is full after
 prepare_to_wait_exclusive()
Thread-Index: AQHZgYLs0OdIVgE7vky1By2mkuyHQ69QnbWAgACOvIA=
Date:   Tue, 9 May 2023 01:44:14 +0000
Message-ID: <5D7FEB2D-3B07-4365-9659-F7D34F2D23A5@nutanix.com>
References: <20230508075812.76077-5-eiichi.tsukata@nutanix.com>
 <202305090112.uJSc0NBw-lkp@intel.com>
In-Reply-To: <202305090112.uJSc0NBw-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|BY5PR02MB7026:EE_
x-ms-office365-filtering-correlation-id: 2bec4973-9eaa-4533-eddc-08db502ee526
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COJXzuxsETDF1sELrd6a93jAP30Wq1TIgx81bi01B3MBziFTFTtPeMX4P7IdtD2k7jwcsOlDF2tGZC9TJpNz/4JT9+5Pktd1kZxJQW7OajXfkHBXE+HApyiUNspbC8oKruX7sHKRn8Wrn0AYaaagnJCqw2vv/pRUDSBX43+THean1Vspv8aeDHOgoKuvw+cqZGbp/fkv0OxoGgsx42pKNktBr1k30ElVB1FFbkfSln9XMPkQV8IKiZLckzEfuK/nUAeTTWzRstxFPhHgK8WhsjQTzftvJWEqoPrrHKaYnbLKFpCrdshTFTy4IqdO1ITn9u2+nQeyeWNEOnRunNYIdYss6MJs0oWGlHaQNxp5TsvxvHBNTmhWTqHfUnbGYOItUK+DPuNj0e1cYIdm8M2a7cmS5uxJVAW5w1mU9DGTrhO9XaMRQe3MN4QmQEECNBHjbCHqgAeUAOjpGyjvhhM8MDV7C1NojtZ8JNUKvJOJEHbyWUlCOzZAOL8ijVyRbdOruaWJ96Z+WonXTS6VOdFzjEARZTOptQKa3tp5EXWvBGjCsNR/HTHQxcwHC/1fFkShOqlOjhDgoqLYWMXVQzsojFHwSCp5rS9VHbhM/yvK8GZ8/adOJhg2HMT98BW2tHn0w6ggxhPDrYZY75OAWU+uSkURsrgBRMrJA8nt/YOSfZe9qLpwJuvU+dbWbOueHfVG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39850400004)(136003)(396003)(366004)(451199021)(6486002)(53546011)(26005)(6506007)(6512007)(966005)(83380400001)(36756003)(2616005)(33656002)(38100700002)(122000001)(86362001)(38070700005)(186003)(54906003)(478600001)(2906002)(6916009)(5660300002)(64756008)(66446008)(4326008)(316002)(8676002)(8936002)(41300700001)(66476007)(91956017)(44832011)(66556008)(66946007)(76116006)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWczeUc0N3c2dndsUnZEUlcxdzNlNGJ4UHNKRUkxU3NhSnRaZTlGVGlYdjNR?=
 =?utf-8?B?aEJsNGNISFZXc1NRWm1oT1BrbS9BT1lBcm16U213dGUyZEFkem1TUlQvRlJK?=
 =?utf-8?B?bWRQbExPWWM1SzlpUVRhQjNCa2E5dkNhVWlwMGJSTzVoU3dmZzdmZDhybFFi?=
 =?utf-8?B?Mm5rWUxMZ1RTTVNVWlh5VlR5dVhRdVFhTGI5bTltaXBidzRjQksxNjk3NzY5?=
 =?utf-8?B?OUVqS1ZOOVRrcWQrT3RWZFpONk9mOG9WN2NwbDlWbXNYRmRKVmp4ODRlZnFp?=
 =?utf-8?B?SGZSSFRkL3lXN1ZxUGtRQ3AxYjB2bmZuMGl6Z3hjQ3RFSTNwTzI0TGtrc0lO?=
 =?utf-8?B?Q1JtRTNTZ3hqT2pUUUdFNDl1ZTJ0WlhFWVJBZGJrYjhYaGNobXFmQmNMRVZs?=
 =?utf-8?B?eWVWV2lWSnZ0d1c3N3dqSGo4cmRMRzlVOTcvNUUzOUhHRW1UeFAyYmZCc0hZ?=
 =?utf-8?B?Tk0vc21lbDhXWFdJSlJYSHV4TDd5amdPR1lDMHRMUkhkbTZ0dFR0ZUdONkJr?=
 =?utf-8?B?N25sWjRMSmN6bW82SnU4MEcvSGJWOGszeENTV01VczlKQ3AxOVo0S1VkVTNk?=
 =?utf-8?B?MEU1bG1aajRBL05kL1F1SW1OaGFZaU5Nd0JrSVMzUE1hOFJOUVJEclNTZjJu?=
 =?utf-8?B?cVFNajJzcDZycHU5U3hzVHFHSnZmWGhYZzYvRDJkd0FpRE9iRkdCcjltdjhn?=
 =?utf-8?B?NmpzYzhORzJjN1pzZlljcTNXaUpmdHk3TDUxaDZyZnZ0dGpXNzMxSWdwUDBa?=
 =?utf-8?B?a0VpWExZcVB4aUdDTVQrTnBxMlFvbmVlMnROTjd5eXhmUVJYbGdveFZ2bVdl?=
 =?utf-8?B?VEZyUTFoTDF0MXM0RjYvTVpQTVBDdzMxUytmVGtpZzFia0ZvL0x2aXh3VGNZ?=
 =?utf-8?B?MTFIc3ZXb01CcHY4MjZuMk82aHRvOWRwZy82bURZNXhTZHVGdkZqUEVyUlVk?=
 =?utf-8?B?ZnIwT2ZMZ2g2d3dRM3MwSVd0UVVVUGNHVkIzY21IdXlqYm12aFNRbUdXcTcv?=
 =?utf-8?B?WGsvc0MzWTdWQUhnZjl2d2ptK0F2OFFCd1QzRjhDYjRJakJPcHN3VWJLbHNt?=
 =?utf-8?B?Yi9UK2h3b1RyMWlwRGhhVlFmTDcrVy9XRWFZdDZDT1EwbnhwdTY1ejNJTHUx?=
 =?utf-8?B?RXBYYzhqWXQ2N2E1V3pnYXdBTWNTdnJ0RlFUZkppdTNabzZSWG9rMUJaSlFy?=
 =?utf-8?B?OXc2aWtuSEk4a3dHMU9hUDNvMk1yMEtnTUxneEdWdmcxQlpZNHNzRGhRcHJQ?=
 =?utf-8?B?ZjQ0NmVBOFVqUVJNSHRuM0xVNTZZRHVzV2dOQzlrb1p2bmtFWTVnMHVJeXkx?=
 =?utf-8?B?b1NkbStYZEROVkk3UXYwZlZ1Z1hnWXVMcTVLRjV4YllKenNnY2dBOVF3K1JU?=
 =?utf-8?B?UFY0eXpIdXlMOWt1YkNDZHhLYUs4NnlXRzRtU0VsVmlQamZOMFJjLytid1Z5?=
 =?utf-8?B?UzNxZlE0UU8vUUdJZ0l5WE5ReWRmVkJrL0sxMmRmL3grYUhqWERYSU9EbWhN?=
 =?utf-8?B?eWRpQkp3eDB3bXcxbitXWW5HajN3MkdSc0Z4OWxjS3ZkVmhZeGQ2bmVxSkhP?=
 =?utf-8?B?Wk92amRIa3lLRjhoYnBWUWVxZUZkNjhneitrL01pbStzMnkwZ0NLSkR3dHpM?=
 =?utf-8?B?VGlJeDBDUkhiTnByTjRCNy9NSU56OFFsb0gxR2h0cVRXdllqM2FjdWp4TkZ1?=
 =?utf-8?B?L3BDOVJsSUF4WjFzZlRtTVdML3JuU2VuSC9OcFNBWmhIQnJDY25vYmsxZVVE?=
 =?utf-8?B?OXJNRkVPQnZocXdJLzI0MDdJUVlDalpwd3hIZkpOYWlLNE5rdzNOY3g0M3F4?=
 =?utf-8?B?ZHZGL2ZjMU9JNVFFditKNWxLK2QrdkRyMnpSSVFzUVAzWGtjNzNWYjI2Nld2?=
 =?utf-8?B?OWZOaEZFR1U5MGRuMjVSV3A4VzVNQ2IrYVdhYmZtTWdtU0N2QW9vWFJaUG8w?=
 =?utf-8?B?RGY4Y2FCdXdYd1VBaHJLeDkwc1ptZFJOMmlLa2R3S1o3ZTRBQTdkaHpEWlpZ?=
 =?utf-8?B?SW9BRklITlZiTHpTR3VDc1QxZ3VzWjVTTVhPMzBHUXJQSTZ3R3ZDYlM1SFB1?=
 =?utf-8?B?S0FhTHhCQ2lvbG1sWlVzY0NkOHRpWFVOWGhKRjJVQWFDOHpHZTJYSDIyeDR5?=
 =?utf-8?B?dGxJdjhvVmJKbkp4TGJqYWxqMjhmS1pPcGJWcFA4Y01uM2JjVVRUcXBEUlBE?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA93A84C44340245968407F0D36DF3BC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec4973-9eaa-4533-eddc-08db502ee526
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 01:44:14.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZtFp9rY9tStY3fQSzD1pkeT864jhkpnWJibWpRyzf8hedL2/FThMlE3USsLiF1A/Ul49+KXL8L5vyOaWX9s5GfywxjVO04a6XeBedw1SeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7026
X-Proofpoint-ORIG-GUID: 2ONUnYyJhEAAphm2qFtSrVszV_jTVU4R
X-Proofpoint-GUID: 2ONUnYyJhEAAphm2qFtSrVszV_jTVU4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDksIDIwMjMsIGF0IDI6MTMsIGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIEVpaWNoaSwNCj4gDQo+IGtlcm5lbCB0ZXN0IHJvYm90
IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nczoNCj4gDQo+IFthdXRvIGJ1aWxk
IHRlc3QgV0FSTklORyBvbiBwY21vb3JlLWF1ZGl0L25leHRdDQo+IFthbHNvIGJ1aWxkIHRlc3Qg
V0FSTklORyBvbiBsaW51cy9tYXN0ZXIgdjYuNC1yYzEgbmV4dC0yMDIzMDUwOF0NCj4gW0lmIHlv
dXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVz
IGEgbm90ZS4NCj4gQW5kIHdoZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1c2Ug
Jy0tYmFzZScgYXMgZG9jdW1lbnRlZCBpbg0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC0yRHNjbS5jb21fZG9jc19naXQtMkRmb3JtYXQt
MkRwYXRjaC0yMy01RmJhc2UtNUZ0cmVlLTVGaW5mb3JtYXRpb24mZD1Ed0lCQWcmYz1zODgzR3BV
Q09DaEtPSGlvY1l0R2NnJnI9ZHkwMURyNEx5OG1odm5VZHgxcFpoaFQxYmtxNGg5ejVhVld1M3Bh
b1p0ayZtPWlFc2ZBbG42VDAtQUxGWjc3TV9vVC13UzJUMlVGeGJvRzU4OUJYaHFKRllHNy1wdk5J
RlBaX0dPQWNRTGxBajcmcz1oSm1rV2JBUldoaUtiVkE2cmJSSnlUblJTTnU2Q0NjYmM4aF81a3Y5
T01zJmU9IF0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2ludGVsLTJEbGFiLTJEbGtwX2xpbnV4X2Nv
bW1pdHNfRWlpY2hpLTJEVHN1a2F0YV9hdWRpdC0yRHJlZmFjdG9yLTJEcXVldWUtMkRmdWxsLTJE
Y2hlY2tzXzIwMjMwNTA4LTJEMTYwMDE5JmQ9RHdJQkFnJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdj
ZyZyPWR5MDFEcjRMeThtaHZuVWR4MXBaaGhUMWJrcTRoOXo1YVZXdTNwYW9adGsmbT1pRXNmQWxu
NlQwLUFMRlo3N01fb1Qtd1MyVDJVRnhib0c1ODlCWGhxSkZZRzctcHZOSUZQWl9HT0FjUUxsQWo3
JnM9U2dzaVdxVGNTLUtObHo3cGJXdHBKTGtmVTROQ054MVBQbmY1NjFPQmxfWSZlPSANCj4gYmFz
ZTogICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0Ff
X2dpdC5rZXJuZWwub3JnX3B1Yl9zY21fbGludXhfa2VybmVsX2dpdF9wY21vb3JlX2F1ZGl0Lmdp
dCZkPUR3SUJBZyZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1keTAxRHI0THk4bWh2blVkeDFw
WmhoVDFia3E0aDl6NWFWV3UzcGFvWnRrJm09aUVzZkFsbjZUMC1BTEZaNzdNX29ULXdTMlQyVUZ4
Ym9HNTg5QlhocUpGWUc3LXB2TklGUFpfR09BY1FMbEFqNyZzPU9EbkxTYXVRVl9YWXRHekpGTjFY
TUg3V1FoVWRaZmE0a2d6ZWlSZGllT2smZT0gIG5leHQNCj4gcGF0Y2ggbGluazogICAgaHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5l
bC5vcmdfcl8yMDIzMDUwODA3NTgxMi43NjA3Ny0yRDUtMkRlaWljaGkudHN1a2F0YS0yNTQwbnV0
YW5peC5jb20mZD1Ed0lCQWcmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9ZHkwMURyNEx5OG1o
dm5VZHgxcFpoaFQxYmtxNGg5ejVhVld1M3Bhb1p0ayZtPWlFc2ZBbG42VDAtQUxGWjc3TV9vVC13
UzJUMlVGeGJvRzU4OUJYaHFKRllHNy1wdk5JRlBaX0dPQWNRTGxBajcmcz14ejBwVk92ZnhXaHhG
NnlwOHIzR0ZrN1ltRGMzNG50SkxBdkZoSGtWV3FvJmU9IA0KPiBwYXRjaCBzdWJqZWN0OiBbUEFU
Q0ggNC80XSBhdWRpdDogY2hlY2sgaWYgcXVldWUgaXMgZnVsbCBhZnRlciBwcmVwYXJlX3RvX3dh
aXRfZXhjbHVzaXZlKCkNCj4gY29uZmlnOiBpMzg2LXJhbmRjb25maWctYTAwMS0yMDIzMDUwOCAo
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19kb3du
bG9hZC4wMS5vcmdfMGRheS0yRGNpX2FyY2hpdmVfMjAyMzA1MDlfMjAyMzA1MDkwMTEyLnVKU2Mw
TkJ3LTJEbGtwLTQwaW50ZWwuY29tX2NvbmZpZyZkPUR3SUJBZyZjPXM4ODNHcFVDT0NoS09IaW9j
WXRHY2cmcj1keTAxRHI0THk4bWh2blVkeDFwWmhoVDFia3E0aDl6NWFWV3UzcGFvWnRrJm09aUVz
ZkFsbjZUMC1BTEZaNzdNX29ULXdTMlQyVUZ4Ym9HNTg5QlhocUpGWUc3LXB2TklGUFpfR09BY1FM
bEFqNyZzPXE1MzY2ZFNmSFBXQ2JrVXpYTlBkSWpKOEJPajJmb3JUMEQ0ZmwzWHdPUU0mZT0gKQ0K
PiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxNC4wLjYgKGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9sbHZtX2xsdm0tMkRwcm9q
ZWN0JmQ9RHdJQkFnJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPWR5MDFEcjRMeThtaHZuVWR4
MXBaaGhUMWJrcTRoOXo1YVZXdTNwYW9adGsmbT1pRXNmQWxuNlQwLUFMRlo3N01fb1Qtd1MyVDJV
Rnhib0c1ODlCWGhxSkZZRzctcHZOSUZQWl9HT0FjUUxsQWo3JnM9Y1ZsMkZ2MHJ1YzJsRENZS0da
Mk1zRzF4a2NtRFNtMHlWZHpfVVliQmsyQSZlPSAgZjI4YzAwNmE1ODk1ZmMwZTMyOWZlMTVmZWFk
ODFlMzc0NTdjYjFkMSkNCj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gICAg
ICAgIHdnZXQgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tX2ludGVsX2xrcC0yRHRlc3RzX21hc3Rlcl9z
YmluX21ha2UuY3Jvc3MmZD1Ed0lCQWcmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9ZHkwMURy
NEx5OG1odm5VZHgxcFpoaFQxYmtxNGg5ejVhVld1M3Bhb1p0ayZtPWlFc2ZBbG42VDAtQUxGWjc3
TV9vVC13UzJUMlVGeGJvRzU4OUJYaHFKRllHNy1wdk5JRlBaX0dPQWNRTGxBajcmcz1Vd2stV3hl
bXdBTjBFaVRsQkU1VkJkazVHR1VVT015U0tHWlhFRXBrREJNJmU9ICAtTyB+L2Jpbi9tYWtlLmNy
b3NzDQo+ICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3NzDQo+ICAgICAgICAjIGh0dHBz
Oi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNv
bV9pbnRlbC0yRGxhYi0yRGxrcF9saW51eF9jb21taXRfY2JjNjlkMGMzNGJkYmMwNmViY2EzZTMw
MjBjZmMyNDAzNGZjZjE3MyZkPUR3SUJBZyZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1keTAx
RHI0THk4bWh2blVkeDFwWmhoVDFia3E0aDl6NWFWV3UzcGFvWnRrJm09aUVzZkFsbjZUMC1BTEZa
NzdNX29ULXdTMlQyVUZ4Ym9HNTg5QlhocUpGWUc3LXB2TklGUFpfR09BY1FMbEFqNyZzPVJXYW5C
VFNSQjI4aXRlSVVLZVNWcHBqMnhxNHVKeWdmdW1zTVdqSnY1akkmZT0gDQo+ICAgICAgICBnaXQg
cmVtb3RlIGFkZCBsaW51eC1yZXZpZXcgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2ludGVsLTJEbGFiLTJEbGtwX2xpbnV4JmQ9
RHdJQkFnJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPWR5MDFEcjRMeThtaHZuVWR4MXBaaGhU
MWJrcTRoOXo1YVZXdTNwYW9adGsmbT1pRXNmQWxuNlQwLUFMRlo3N01fb1Qtd1MyVDJVRnhib0c1
ODlCWGhxSkZZRzctcHZOSUZQWl9HT0FjUUxsQWo3JnM9MTRtbVEzR1poSW96SGV1ZlBvb1FJdUtk
MU8yU2VGTDgtMWdJaTljNzlFTSZlPSANCj4gICAgICAgIGdpdCBmZXRjaCAtLW5vLXRhZ3MgbGlu
dXgtcmV2aWV3IEVpaWNoaS1Uc3VrYXRhL2F1ZGl0LXJlZmFjdG9yLXF1ZXVlLWZ1bGwtY2hlY2tz
LzIwMjMwNTA4LTE2MDAxOQ0KPiAgICAgICAgZ2l0IGNoZWNrb3V0IGNiYzY5ZDBjMzRiZGJjMDZl
YmNhM2UzMDIwY2ZjMjQwMzRmY2YxNzMNCj4gICAgICAgICMgc2F2ZSB0aGUgY29uZmlnIGZpbGUN
Cj4gICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcN
Cj4gICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5IENPTVBJTEVSPWNsYW5n
IG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9aTM4NiBvbGRkZWZjb25maWcNCj4gICAg
ICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5IENPTVBJTEVSPWNsYW5nIG1ha2Uu
Y3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9aTM4NiBTSEVMTD0vYmluL2Jhc2gNCj4gDQo+IElm
IHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcgd2hlcmUgYXBwbGlj
YWJsZQ0KPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4N
Cj4gfCBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0
cHMtM0FfX2xvcmUua2VybmVsLm9yZ19vZS0yRGtidWlsZC0yRGFsbF8yMDIzMDUwOTAxMTIudUpT
YzBOQnctMkRsa3AtNDBpbnRlbC5jb21fJmQ9RHdJQkFnJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdj
ZyZyPWR5MDFEcjRMeThtaHZuVWR4MXBaaGhUMWJrcTRoOXo1YVZXdTNwYW9adGsmbT1pRXNmQWxu
NlQwLUFMRlo3N01fb1Qtd1MyVDJVRnhib0c1ODlCWGhxSkZZRzctcHZOSUZQWl9HT0FjUUxsQWo3
JnM9Y0tyUzh6S3JXcGJDQmc1S09HaVpEazBpcWpVdTlCWGtDaEtBdTRwTUMyUSZlPSANCj4gDQo+
IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiANCj4+PiBrZXJuZWwv
YXVkaXQuYzo2NTE6Njogd2FybmluZzogdmFyaWFibGUgJ3J0aW1lJyBpcyB1c2VkIHVuaW5pdGlh
bGl6ZWQgd2hlbmV2ZXIgJ2lmJyBjb25kaXRpb24gaXMgZmFsc2UgWy1Xc29tZXRpbWVzLXVuaW5p
dGlhbGl6ZWRdDQo+ICAgICAgICAgICBpZiAoYXVkaXRfcXVldWVfZnVsbCgmYXVkaXRfcXVldWUp
KSB7DQo+ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAg
a2VybmVsL2F1ZGl0LmM6NjU3Ojk6IG5vdGU6IHVuaW5pdGlhbGl6ZWQgdXNlIG9jY3VycyBoZXJl
DQo+ICAgICAgICAgICByZXR1cm4gcnRpbWU7DQo+ICAgICAgICAgICAgICAgICAgXn5+fn4NCj4g
ICBrZXJuZWwvYXVkaXQuYzo2NTE6Mjogbm90ZTogcmVtb3ZlIHRoZSAnaWYnIGlmIGl0cyBjb25k
aXRpb24gaXMgYWx3YXlzIHRydWUNCj4gICAgICAgICAgIGlmIChhdWRpdF9xdWV1ZV9mdWxsKCZh
dWRpdF9xdWV1ZSkpIHsNCj4gICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KPiAgIGtlcm5lbC9hdWRpdC5jOjY0MjoxMjogbm90ZTogaW5pdGlhbGl6ZSB0aGUg
dmFyaWFibGUgJ3J0aW1lJyB0byBzaWxlbmNlIHRoaXMgd2FybmluZw0KPiAgICAgICAgICAgbG9u
ZyBydGltZTsNCj4gICAgICAgICAgICAgICAgICAgICBeDQo+ICAgICAgICAgICAgICAgICAgICAg
ID0gMA0KPiAgIDEgd2FybmluZyBnZW5lcmF0ZWQuDQo+IA0KDQpOaWNlIGNhdGNoIHRoYW5rcyEN
CldlIGNhbiBpbml0aWFsaXplIHJ0aW1lIGFzIHlvdSBzdWdnZXN0ZWQgYnV0IGluIHRoaXMgY2Fz
ZSBpdCB3aWxsIGJlIGJldHRlciB0byByZXR1cm4gMA0KZXhwbGljaXRseSBpZiB0aGVyZSBpcyBz
b21lIHJvb20gaW4gdGhlIHF1ZXVlLiBpLmU6DQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvYXVkaXQu
YyBiL2tlcm5lbC9hdWRpdC5jDQppbmRleCBkMzdhM2EwNDUyMzAuLjZiMGNjMDQ1OTk4NCAxMDA2
NDQNCi0tLSBhL2tlcm5lbC9hdWRpdC5jDQorKysgYi9rZXJuZWwvYXVkaXQuYw0KQEAgLTY1MSw2
ICs2NTEsOCBAQCBzdGF0aWMgbG9uZyB3YWl0X2Zvcl9rYXVkaXRkKGxvbmcgc3RpbWUpDQogICAg
ICAgIGlmIChhdWRpdF9xdWV1ZV9mdWxsKCZhdWRpdF9xdWV1ZSkpIHsNCiAgICAgICAgICAgICAg
ICBydGltZSA9IHNjaGVkdWxlX3RpbWVvdXQoc3RpbWUpOw0KICAgICAgICAgICAgICAgIGF0b21p
Y19hZGQoc3RpbWUgLSBydGltZSwgJmF1ZGl0X2JhY2tsb2dfd2FpdF90aW1lX2FjdHVhbCk7DQor
ICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgICAgcnRpbWUgPSAwOw0KICAgICAgICB9DQog
ICAgICAgIGZpbmlzaF93YWl0KCZhdWRpdF9iYWNrbG9nX3dhaXQsICZ3YWl0KTsNCg0KSeKAmWxs
IGZpeCBpdCBpbiB2Mi4NCg0KRWlpY2hpDQoNCg==
