Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486F570B411
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjEVEWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVEWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:22:44 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E827C5;
        Sun, 21 May 2023 21:22:43 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2NQ2A003825;
        Sun, 21 May 2023 21:22:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=3Wzb32o9CADP49S1PGw4IrxB/g8thDWH06DFEWOKjS0=;
 b=zA0SuZ2bYKp8ThGGQOBWra4aMuSBt5/ZKko0GPa1aoIcHgSSFGjJUlRIBF+wHEulk/8e
 uDVTzmDdN/APmyXu9eNkOUzGxdJ3p1Dx1HnlZRSY51saVT6wQZnK3GWXOzF2s9bbPF4j
 m6qzgTmtJnX3u/3sj8uEVnC4H0Y3Ivn81n85IqR7POoIoP68Mr4Pc8bvvPPtjQ/swyae
 +jtzPlpUNWpsYIuYuXpNkyO+mdMQDW05rU4nEblpxGELKQB9JaX5IE+JebsYnxiqjYlG
 tIHtkXDnKHe6a1e4nSk3B6fF66/NwguP7A3LRe8eZ0DBSelQfLWZTRkOuVRnDYSbL0oW oQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpwrva8rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 21:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqyoNnamalIKj22lR235qy1x92X5qBOyIzspKJop8oBW5fXieVnWCaupEE4XuZbI9mPFLF9b6/O2aeOh5PgB2z9sqYOe2moewr4Ut1072NgVpfHqp70f4VIO/O8nuR3nc5pQ4VH0O/sNT2TOX4pG9eVZIOYUKeobTGGzloCUNEr48UNzz435hQyMbTMSJNaJVjvABtdQJbzxCKwWtXM6ImdM82DZlPSYyV0E7Oji+gm2Dj2VOoh5VRmGYKhBcwyrnC5TTgdUfBct8iouxZ+xjsiFri0dKbxvpwQv8e+i8F3B3MW0jjnQT8JlKHR3hRm1BqbmDbkmGzmKqMHDsjv9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wzb32o9CADP49S1PGw4IrxB/g8thDWH06DFEWOKjS0=;
 b=GpWeXZ4YTxYiH7uXl6AiG95Bv1VFWm8MOMGUNWU2rhYH7S/i5WlXtElSBLdpSxXi7mOFye+xHmRLtG9jKY11pDIf22qwZ6JT5rvnN7r7ivXCcdS6Op6QdKfHuf9JJNFmdA9Z7kTy7M6vDnhlkeJZRmQxIWzkp/1I3HEzNUCDz9X6VmP4c6AgjbLqqb1Nk7ar9Xy9PMMES543RFUV3GfcQNo26NvfmQAAfcJJ/+vzKHB4bMsZXJDGYYkfV8HB4l7kzTxPSbKy81LTmY7UGL2+sbmX8DT5k/fzC7ek5Y1xLlRJ8bw1/76nN2N5hKBpBh05oMOVGG/3XcANSbl7WJLHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wzb32o9CADP49S1PGw4IrxB/g8thDWH06DFEWOKjS0=;
 b=XS5OUgWNgrsfZLV0DN39NRST0g/YJekdTEGTqyr41u4Xbvx/U5HatCcEh5mSU8qfIqbEzC4PAe741UyR1ZcMdM2dqjpU+kfiuyKbQ+rqZjQF9AJKNI+oXLLdbGxvwSDRAHS2NboGZijcnYHjd/bocTiFWh/02ciMbJ6iX8lczLkXxCBeHFt3MlNqxsuPtxvDtvcqipIBaQCWJBkEdh/i+rs3naXr3bojg3yNxXT1Tgdrvp7JQLiCvpRO5u31KVH/OGtWPVh42GmRBoY3xN1wqixPo0kfu8FB+zV43Ciy8uwg+HIQYeVoUeJY2k0f8YKvnVVdcQasL9pyTo4kTy0Caw==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SA0PR02MB7434.namprd02.prod.outlook.com (2603:10b6:806:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:22:38 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:22:38 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] audit: account backlog waiting time in
  audit_receive()
Thread-Topic: [PATCH v2 2/5] audit: account backlog waiting time in
  audit_receive()
Thread-Index: AQHZipQjjaeabz5VoEyUMzSuh9XRgK9ltN4A
Date:   Mon, 22 May 2023 04:22:38 +0000
Message-ID: <B407A72B-68D3-4FE8-B3E7-20B4DA3070C6@nutanix.com>
References: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
 <18aac53d73e41b33b71d9e5d0f5d4286.paul@paul-moore.com>
In-Reply-To: <18aac53d73e41b33b71d9e5d0f5d4286.paul@paul-moore.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SA0PR02MB7434:EE_
x-ms-office365-filtering-correlation-id: 8d93df66-c6af-4f67-2b3f-08db5a7c2d4c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Oml65n1t6Tf1pf5viSpif3lQMv0mUODQ81cVvevSq6364Fonf8lKrv/WYcwJbt3cjv4m+pJoUkCyepfEIsVzcNrQ+Y1xLE+k8DuEovX6EB8iUXrLgVjxr6zSy22+8bexABXbCMN3uzA+JYHA+tr/5egScLNhbbGP6OMGiZsm57+vh5hZ0p8LZomYxxluuMeQeErhOGNz457zocGGetnUiUlm4yfHv0+AF7Vht24Wny7GHkQZGDKEv+ybS863LMj0Glqk25N0Ng5gUpBqquL8s4QEQntyXkLL0ayVc669azGdEgQ4NPrfMRXrwxbzi7+zW9aMb9sXhqpZqWM/0bqf/+fAtF0d3+9QjsmFPh1oGs7FXAj/UNpSN8OYtw3sFPCBwgOfUvZv0hI7mX6fIxK1URtCLjUjzGks+zbWWAq8dW5y3XodXNfno0fiWOj/s76oNZ9uhB2WZoerebBYOPohKnhfMtE75ITXhQOcLaG4AJ+pLwu2lDgsmf4MJ7/ZqtdDWWiV9gNmJhuzY+K5Tuc6Q/JnSF61QQyPDEs/1YWFarC3aZclLSGYU+w9I69UESqqnMsKD0yWTARCeO4WhICVUtG+vTzzaUPsNxXpJRYOcmxsJ2lWvlmS1ywoA+BCzSo6A55JyrnUVjq/3NSVIHHzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(83380400001)(186003)(26005)(53546011)(6512007)(6506007)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(6486002)(33656002)(71200400001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(91956017)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(15650500001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVJzQkFnczVFcFozditYU2tTeC94c1dNbVJJNXFYLzJ4akxkcmlEczZqRmhT?=
 =?utf-8?B?TDBKU0IzUitPM3hTMk94eW16VGV6VmNEaksyeXYxdUFCMFY4c3VvZmZnVUJB?=
 =?utf-8?B?RFBGVjgrZ1U1SWR1YjZ0OWtOdGZzVVgyUUJiRHphclp2TGpUSDV3cXFmUUtu?=
 =?utf-8?B?WmhMZ1V6YTZYNWdYSkRrTFpOU2dPWG52dUp2V2wrS0g3RHNlVjNJZGNYanNR?=
 =?utf-8?B?N0d0eE9vMU0weFhSY3I1R3B2QUlmY0hPWnpKbDNqZnRxWGtzb0xoY3BJUlh3?=
 =?utf-8?B?RFNkVkRyeGUxY04zV0I3OEdiL2J4N2sxSXp6OThURTZHOHN4eHV6NEhIYmFr?=
 =?utf-8?B?RUlEb0dFVWZLakhHMTdsZlBpbHZJOWlCeXFwNHg0cEVybWFOUXB6SXVkcm90?=
 =?utf-8?B?eElZOUdrQ3hJQXNaRW1Sdm50a2p3ajFOdUI2THNyTDMvRUJyUWE2ZHZWWGJF?=
 =?utf-8?B?NitXNXdncHA5L3BZcFpJR2M1Nm5nS0FPQkdMZHh3UkF6RFNDanhkNzJTMjBQ?=
 =?utf-8?B?QjNPcEtmNWZKL3NzaGRTWG5pMUxvdE5xTTRqdEJ1cnBVY1JhQ1pVdVNUdVgz?=
 =?utf-8?B?WVNRS2QvZnhyam1lQVNOb0FrMElVKzhGY0UrUEZWV0dkMHRFb2Fja3B1ekth?=
 =?utf-8?B?Z2tiZzlsbTV4TkwwNmVOR3AvYWY4QjdDTTd3eGJaSXpBaFl4WC9GMjlFVGxW?=
 =?utf-8?B?K0FnMmtHdUZWNW45U0Q3Z3pUeUpSVEwvRW9hUHYvT1V6dXBTWG5pZmNaYzlC?=
 =?utf-8?B?ZVdMYkg2QkxOdDhrTi9KTHFsTDBaL3RQNmJDaFU4cXdaaGlUSzV3b0ZBWkRL?=
 =?utf-8?B?OThtTC9EQ2U1aXhvUUdSc3kwWXVaNHpPRnM0OHFmOS9sUTQwMWUvRmpoTHNE?=
 =?utf-8?B?VGQ3VTBXNEpVSTNxYytjejc0b3dUZDdTU3I4bnNyYjJCWlBUNmFaOWVsa0Ra?=
 =?utf-8?B?ZTRMZ2pYNWFHYUJQYkpqZUNLZU5xdm9JdDlYSTZrMXZrdkIwenFLUzBJdHJE?=
 =?utf-8?B?bzEvMW43NnZDYVdRNnljMFMzaWJGZTBvNXBEcjAxQk5sNXZNUG5xWThMbFhL?=
 =?utf-8?B?N0szT3lESWw3WU94ZzlDM1FBWlhTeEJ5bU12dmhLd2ZndXlVL01Hcnc3WVA1?=
 =?utf-8?B?QUtVRlVJRyt3Q2kxRTJhUFN2TWNHY2tidXF0ejVBbnljZTJSRnl4eWdHMlRQ?=
 =?utf-8?B?ckFLYnkyWG1qZFVmMEl4UWZwQ05Pdi9CRTRWKytiMTF2R1VyUTA2UVRaUWNL?=
 =?utf-8?B?MEdYT0k3TG10L2E1aHA1ZEVybEJTT0pCMVQ1Rm9WSnNEWnlIRmJUOUk1ZGRs?=
 =?utf-8?B?cE5mSW05TWJtRjB2TDFKaGl2RDFTaHJOTzNCOE9ZSWFwUU54WU5oUUZUOHRS?=
 =?utf-8?B?eHR4N1k0dHE1U0FWVndzakN0QnBZQ09Qa3ZiT09EVExVRXVwcHdmYlJ4V1VB?=
 =?utf-8?B?b25WbU1pSVRaemZmTDZUM254NGpGQXQ2ZGVldmowNjJIZm9hdWYyNXRvbXFS?=
 =?utf-8?B?UnI2YThTZ0dGRDZCMW1kUldwWTY4WFZZcFcxbFRkdTd6Z3Axc3IveHliWFNX?=
 =?utf-8?B?dGQwaVVLbHQ4RmtsOE1lOVhJdExKd0pSTWNNTkNNems3NHlRRDZtNWN3TmJu?=
 =?utf-8?B?cUxqbUJDZmthYXYyT1N1dEhqRm5lSUdWNXJGMHRvRm1SN3ZUSTRjbzZqT3c4?=
 =?utf-8?B?TXl2N01LdGpONGFWMC9vQ3R1djdnNFo3citOaWRoU1M4WkJHU1JrYldIWC8x?=
 =?utf-8?B?RjZpdlpJT0NPS0EvRnFENWY3c1ZqdmdTbG51Tk82NkVrY3ZrMGRpR1pVSEdo?=
 =?utf-8?B?VDArL1Zab0QzOFJDK04reW8zZ1hNdDFVRkFpenE2YlhVQW5rOHY0RmFTdStH?=
 =?utf-8?B?NkwyM0s4RlMzaERoZitubThHM3VSbzgwZExEamV3WHpIR213M2Z6NDFMRUUw?=
 =?utf-8?B?ZGVNa3dXRTZob3lock50QWpLNHBjUTAxd2RmU3lKRkMyc2d2ZW5WaG9lQUZD?=
 =?utf-8?B?clo3Rld5Y2lxZkpjSUhjVkFHTk0yZ3dLWXRVRG9pTDRGTTFpcmo5YXg5Rjl4?=
 =?utf-8?B?Y0JyUjYxWmNlWjJEbmpnWk9BRlZaME1xOUVPVzRzNmNwSzFoL0htSHJ2b0dy?=
 =?utf-8?B?SHRnN01JRkl3SW9DdmxTaE8xWU8wS0hJeFEyZVdHUDNBOFVReDh2T2Jiakw3?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49FF513E6D3278439771DFA7C8FAC790@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d93df66-c6af-4f67-2b3f-08db5a7c2d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:22:38.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ojz7GQn18dWXmp1oMiKXOxF/Fsf3SmgF5lnJXQb5whHa04tABKY5yqy8UCpObmSA7ep7cVz38gZsogHSHKZoVQlDAwNjYIXmn0WHw6QiGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7434
X-Proofpoint-ORIG-GUID: Qfk50JP4dPzXhSdHg2QX--ERnl1x4VM3
X-Proofpoint-GUID: Qfk50JP4dPzXhSdHg2QX--ERnl1x4VM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDIwLCAyMDIzLCBhdCA1OjU0LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1heSAxMSwgMjAyMyBFaWljaGkgVHN1a2F0YSA8ZWlp
Y2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBDdXJyZW50bHkgYmFja2xv
ZyB3YWl0aW5nIHRpbWUgaW4gYXVkaXRfcmVjZWl2ZSgpIGlzIG5vdCBhY2NvdW50ZWQgYXMNCj4+
IGF1ZGl0X2JhY2tsb2dfd2FpdF90aW1lX2FjdHVhbC4gQWNjb3VudHMgaXQgYXMgd2VsbC4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogRWlpY2hpIFRzdWthdGEgPGVpaWNoaS50c3VrYXRhQG51dGFu
aXguY29tPg0KPj4gLS0tDQo+PiBrZXJuZWwvYXVkaXQuYyB8IDQ0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBUaGUgYXVkaXRfcmVjZWl2ZSgpIHdhaXQg
aXMgZGlmZmVyZW50IGZyb20gdGhhdCBpbiBhdWRpdF9sb2dfc3RhcnQoKQ0KPiBhcyBwcm9jZXNz
ZXMgY2FsbGluZyBpbnRvIGF1ZGl0X3JlY2VpdmUoKSBhcmUgcGVyZm9ybWluZyBhbiBleHBsaWNp
dA0KPiBhdWRpdCBvcGVyYXRpb24gd2hlcmVhcyB0aG9zZSBwcm9jZXNzZXMgY2FsbGluZyBhdWRp
dF9sb2dfc3RhcnQoKSBhcmUNCj4gbGlrZWx5IGRvaW5nIHNvbWV0aGluZyBlbHNlLCBlLmcuIG9w
ZW5pbmcgYSBmaWxlLCB0aGF0IGhhcHBlbnMgdG8NCj4gcmVzdWx0IGluIGFuIGF1ZGl0IHJlY29y
ZCBiZWluZyBnZW5lcmF0ZWQuICBUaGUgZmFjdCB0aGF0IHRoZQ0KPiBhdWRpdF9yZWNlaXZlKCkg
YWNjb3VudGluZyBsb2dpYywgYXMgd2VsbCBhcyB0aGUgdGltZW91dCBjYWxjdWxhdGlvbg0KPiB1
c2VkLCBpcyBkaWZmZXJlbnQgZnJvbSBhdWRpdF9sb2dfc3RhcnQoKSBpcyBpbnRlbnRpb25hbC4N
Cj4gDQoNClRoZSBpbnRlbnRpb24gc3RpbGwgc291bmRzIGEgYml0IG5vdCBjbGVhciB0byBtZSBh
cyBib3RoIGNhc2VzIHdhaXQgdXNpbmcNCnRoZSBzYW1lIHBhcmFtZXRlciDigJxiYWNrbG9nX3dh
aXRfdGltZeKAnSBhbmQgdXNlIHRoZSBzYW1lIHdhaXQNCnF1ZXVlLg0KDQpJTUhPLCBpdCB3aWxs
IGJlIGJldHRlciB0byBoYXZlIHNvbWUgY29tcHJlaGVuc2l2ZSBjb2RlIGNvbW1lbnRzIHRoZXJl
Lg0KDQpFaWljaGkNCg0K
