Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014BE6E49FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDQNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDQNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:34:07 -0400
X-Greylist: delayed 3480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 06:33:52 PDT
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFF72B4;
        Mon, 17 Apr 2023 06:33:52 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H9b4cJ007485;
        Mon, 17 Apr 2023 04:42:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=U2ebeCyPs3ziSco2c9JqyJpdQGW9tue/cAC9fGjRwVY=;
 b=P0Vq4D6irHmjH25UWwWQgvd0SSnMj3aeGyKiM/aBvP1emOpuTfwZxYtuwjGJ5f1JYKDw
 5QxmiiahtjR2wc8T+Tfuo6ewEXChEGFdj7u+4Avfdkbo41bi9iqHR9lPr/3jJ8UUVflD
 taD5yu2a9bD9xRk3kBS+DdLttWFT76mWB8+6r7d8hh1kwufynyTPwVqa+AFU3uOzvBv4
 wgQJgDu+eWEhJwDByGC4VcIpEtQ75xhjAnl+z/6ONhWsYd3IAKJ4WbEBW0RgLvaj4o/0
 4LKjClKLUYXd9QCn9BXcP9P+5dDvQwNYUACt8rivpsYHfxzIqzHO8pxNCj6syzBoPIkT Aw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3pyr8uu784-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsGNp0ZT31Dop41QgubGoxHgcmXCfaEP0cNSA2AL/bMn8UuPRPoKlo6G2TS5ZL93llrFiLy/GB9dpWx9YuiyeE0CRz5mZ0Y0H15tbo4DtSY/mSYOsgrY7rNQDPVq8CUTLI0btWD33udoPnmUtTLXNYbSM1tpjOhusjGeWei4+08r+nFh3Y2QmVN2dNH9lbuXytppwuVAgir1B8OBD2fKVtItRbYDizLdSC73+AD5qKUrYi0iVC57IL7YuGXeC3SNhmvgLoRhOMDvhZSGYGvEmb5PeY/vmeNGI4KVJTxN2WwMw1T8sUvAwGoDsTN9+Ek1zc084gtQdo9N1uTtmcJN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2ebeCyPs3ziSco2c9JqyJpdQGW9tue/cAC9fGjRwVY=;
 b=ds1jLXKlKl+eRaEarDMU3+OVauo6uhvF7Zo2kUkeu16J2zV+1jfUKO4XeBqvpxZytw4PboWe+5P8B50Kud6JuJ6g50R2wIPcuF2uuqdfcwLxYT/+6XZZCE5RwSItDtBAWKsppMX7jpCvo+49vJZZw0k7BpWd1V0nW9G3mt8ERa2x3sfqqo8TRHtwBPmg02zIDGTLsF1T+F+LRxKx39GbkXAncuASIDzO/WDXP5YxenAFcYRFy3Jsfmnw6IUBB4TnA8Cr3ZWjVHsvwaSv7bSUQIkGsZ7pDneftIYiw6TkjnmC3AlZ5HLAi6akNSjrwXXAvza+I56ejOKeUpwreQ7nJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ebeCyPs3ziSco2c9JqyJpdQGW9tue/cAC9fGjRwVY=;
 b=Cu76vRSKtIhWFYcKBwUZ8m+OUs1gafgAwjPYyOtVnKvQFtwYY+tzobexGOal8hWfGv/fUxiQhvIowx7wUa58tKi0x/1YpbojfzfXq9gPh+LDO8v/oeN/FHAVwVxtmvJMDgm1aGHQ2nneRnze+sZT65ZRW0q5cO7ERXv/vEdfZn87rK1/jMt0FOircIgHjT0Rovz+OcOnqwf+06hnl9JpS70oMREjOZAMmqC7LNNDjGT2QJgrUNhsMfSxD8rPt+l7t8efz8V++SC/9GSg2YrORHkWJ2clqCIyeK9av/Y6AXnkIQtBmOOUVtwRmm/1+44iuixom/imWcIy7ZlbLlhN/g==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SJ0PR02MB7470.namprd02.prod.outlook.com (2603:10b6:a03:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 11:42:16 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 11:42:15 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task()
 faster
Thread-Topic: [PATCH] audit: use pid.is_auditd to make auditd_test_task()
 faster
Thread-Index: AQHZbn8n344LVLDuMEy/S3bz9SY/4K8q4koAgASD+YA=
Date:   Mon, 17 Apr 2023 11:42:15 +0000
Message-ID: <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com>
In-Reply-To: <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SJ0PR02MB7470:EE_
x-ms-office365-filtering-correlation-id: f077223f-78b8-4c48-ca3d-08db3f38cac4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThqxfmEK/YWQqpvpKflDuHE+pE39GeSg05NdBPu+0pxCRsV8W5fvvJ+oTheAdqh25WQ5W2T79rWOB+7oWxsCXBAC40aHnaj6zhGvZVly8E5sqfmqoj40tQJjnL6iLGVD2MCO9leg58FCQ06AmQHtiCBlwctWOvzle61h+fKx55wttgnkPP0F+Vcz2WYvWR2mnbDc4Zw+mYy6+nPdaaGJ6HxGQheK/gwvIweLXRNJMFLOFRjFAJG7V1YwnmEOuwvNLLbiS/Tks8f3nn4Ph45rCxW4dLZKB1RbMFhOFoJGMaooGvZIMVinXcWBNDxrZwb5OKLEhHJ4HV+sprfHcm/xR8PCKIUgi1Tm5XHv3RWmKjU5ek5UEaI5kKA3z6CRVKKeGOXDfauxjVa600wuFobsqAwr9JpZuRxAZp6BkXFocXMoqOKQgmT+ghCfHD0m55UkRrroH7UDJdkj3W9IlEtb2EFodkXZ0R3pYEBLcxhRt9IYJ5ATYI1FImCPI/OPoWp1COX8aokEo8qf2Az8guez5T51V/WMzr0BZBs+5ZYfedg1dS4bUf3piphRM5um+MShZ08kVb2j4ZNEv/MSuVbAWol09de8XEqS9eYQ+RY7hPVA+tRWcTY9kD/yydh6R4yU/77Z6DR5dCZzJyb+x4KtLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(36756003)(33656002)(6916009)(54906003)(4326008)(316002)(76116006)(91956017)(66556008)(66446008)(64756008)(66946007)(66476007)(6486002)(71200400001)(478600001)(5660300002)(8936002)(8676002)(41300700001)(2906002)(44832011)(38070700005)(86362001)(122000001)(38100700002)(2616005)(26005)(6512007)(6506007)(186003)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlNiaitrb1Z4N2Jod3p1SmJBcHpENXhwL3g4R0w2NHFPN3pYQjc4bVl5UFVC?=
 =?utf-8?B?cmFlUlNsSTEzQ3NVb3dTNmlnZ1YzQU11SEprVjV0TnlPSEF5WHFadm8vdEtj?=
 =?utf-8?B?SG90M0xtWndQTmp6dVlWcVlrcXVhM2xscWU0bHlpZitOSkRibElOeElzd3RD?=
 =?utf-8?B?Tk05K0Voc0dtbDZSR3BZOEd4SkhiZkxLS2ZNVDRsUG4zUDhFbjFqZkMyVEQr?=
 =?utf-8?B?TjIwamFMcHQ3MzZ0QUVscjBmdnVKVWpRVmtWVDdRZUZ5RnJPNUFhbzFMZG5q?=
 =?utf-8?B?K0wySm81SE1TTnJROEl4NkE5bWNqU0sxdEVOaUJSUnRzbWJwV0pFR1JMTjFD?=
 =?utf-8?B?Qm5HQ20xSjgwekltbHovWDAzYUpsanNxdFVVZ0t1c2tXcExqUTF2WkFRUUlG?=
 =?utf-8?B?YWFmam9XSWwwS1F4TnVPR25pK29oT282TXkwV0hqSjRpM21rbS9WeTI3WWRr?=
 =?utf-8?B?UmZzZ2o1U253YVF0dDBzUi9ZRTM5VDRNakNDOGdRU1F4SjQ4MnMrY0FTRksy?=
 =?utf-8?B?QzRVay8wUFdyc2JTUS9CckNNQ2JxcysrZWZmdHhHUThwMXpVQTQwMEpFWnox?=
 =?utf-8?B?bDFIcmlDdFpScEN3N0lJR2dpelREY1lKMy9IbUFtaW5SRkFmMWMyeTQxbGIy?=
 =?utf-8?B?dmNpS05heEJ4bzZvZWhjRFpMajBzKzNwazREdXhiVnRmRDlsazBsVDFBeE5o?=
 =?utf-8?B?Z3FTRTdvQUtqSCt3bUY4M0p3VnNwdmgyYzQrV2o2eFFEYjdPaHp0RGFtTzdU?=
 =?utf-8?B?c0xtZTBlSEk0VmdSVE9qS3dLdTBGTzZvZE9sUEJveXIrV2pZVlo3RW9yYjJm?=
 =?utf-8?B?S0xVM04xa0hjZFFpQ1gzNVZYVEZheEdZTVd4K0lPUCtRY1Jialpkd1ozeHVB?=
 =?utf-8?B?d0JTd3FHRGFSeU1UTWhuY29FcWNjWGU0VEwzbUc0MThTMWZqTCthS3gzblMz?=
 =?utf-8?B?VHBGOFNJMTYrNU9ORktrcUVpeFRUcVVXSWJYZ3VhNHhSaFE4UFFzTHNtTWUy?=
 =?utf-8?B?K1AyUVUvcDNaajlnVmZIWDdkdDIyZTlaU0ZmL2dmSk5CdHVjWmpxTjJFem9y?=
 =?utf-8?B?UVNrbC9YQnJhZGxrS1d5eU9ramxWY1hCM0dyd2RPSUlncHY0RHNoY1lkRTJO?=
 =?utf-8?B?K2ZNdjkyQlRtUXczVFlpTFdhYkI1MDhZdy9Oby93eFA3NW1KRWdjK0d0RW9S?=
 =?utf-8?B?NlpEaTJYUGh6WUdnVGZqVU84UVoxQlgwVTRSbEE0VFpVaTc5ejBGV2I5Vncr?=
 =?utf-8?B?S1VpYnBUOENQT05VbjRzOE5vOEV0dnl4RTQxTGNjcHU0TFF6dnZnT3NQVENr?=
 =?utf-8?B?V3lLRW1nSXlpWkFycEdmb1RQajIrb3VMRVZNdFhpZ0x6RFY0dWFBUzBobTJY?=
 =?utf-8?B?RS9yWjlVdnFGdDh5WUZ2Y1RlbUI1Vld5NEN5UmEzWG9KNSttVXZ6elNUTHFq?=
 =?utf-8?B?VUwrRm9Fdnlka2JXeW9KZGxGL0hZd3hOcHlDMlFTblJ0VWZQaWVpcDJFOEs1?=
 =?utf-8?B?a2tySitWd0FEY1VTN2hWblh3T0VwbkZycDhRdGF5L1JlSUV0SmVzOURnTzVJ?=
 =?utf-8?B?ZHpVQnFzRC8rZW5YU3hSdWc3cHp1TXArajFlQVNwbUdyY3FBSkUreG9sQ1dW?=
 =?utf-8?B?WVFta3lndDkxSFdmbUpKNVprbmRPR1JwS3RrT0gwZUdPUXE1blArejdzNkRi?=
 =?utf-8?B?VWh1S3ZualNqN1cyTjZUclJ2K2NjOWZKa1E5aVNJWWZUV0U0bmQ1cXJvcjFK?=
 =?utf-8?B?Ti9UNGdGQlRvZ3hOS3BENkEvQUtkdHNMZ3BlWlY0OVFtR1dhbzJsTHhidjZx?=
 =?utf-8?B?SXJRQWwvS0s2ZUFkQmsweUZKNVFFQVlQMnJoemUzWW9iTTlYU2M5dnpTclAy?=
 =?utf-8?B?YmdxTERDdDBYUSsvWXp4aytEazYwS1IwUEVqUUF3blZtSnFhQXV1YXFRUzU2?=
 =?utf-8?B?MmZES0JtcTJmZWhuUVVxb3p1RCtZZHM2NkVIWmxqclRuVVhlS3ZiUEJ4ajMx?=
 =?utf-8?B?UVlDUVBsNnhQQzVIVmN0aTlFTnF4N2hsUTk3eTQ5M2UvZnZWa1NJanpudzdK?=
 =?utf-8?B?R1E0dVI3YS9CaWY4M2tnTkpURFZFL3A2d283MXdjbzloYWhHNVF5ODFmNWFI?=
 =?utf-8?B?N01pakhocDFhbkwyc09UeXFHdzhzYkNQYndrMWp4UldDVWZyRTY5NHFGMEdE?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <601831BE081D9E4FA03414B16652E59F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f077223f-78b8-4c48-ca3d-08db3f38cac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 11:42:15.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Zl7vB+0++STeA9pnaP040Chfpwe0WpYBf3Lv4/giF/dxIhxgAYWH41fkon8DEROf5kE4+2xlACTaCLbgXk0BED8ZKlYd7q86L8q3Sml3Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7470
X-Proofpoint-GUID: JktSJ_iXBuLdIw7fDL46O1Aemsz-XWkz
X-Proofpoint-ORIG-GUID: JktSJ_iXBuLdIw7fDL46O1Aemsz-XWkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_06,2023-04-17_01,2023-02-09_01
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

DQoNCj4gT24gQXByIDE0LCAyMDIzLCBhdCAyMzo0NCwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1v
b3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCAxMToxNOKAr1BN
IEVpaWNoaSBUc3VrYXRhDQo+IDxlaWljaGkudHN1a2F0YUBudXRhbml4LmNvbT4gd3JvdGU6DQo+
PiANCj4+IGF1ZGl0ZF90ZXN0X3Rhc2soKSBpcyBhIGhvdCBwYXRoIG9mIHN5c3RlbSBjYWxsIGF1
ZGl0aW5nLiBUaGlzIHBhdGNoDQo+PiBpbnRyb2R1Y2VzIGEgbmV3IGJpdCBmaWVsZCAiaXNfYXVk
aXRkIiBpbiBwaWQgc3RydWN0IHdoaWNoIGNhbiBiZSB1c2VkDQo+PiBmb3IgZmFzdGVyIGNoZWNr
IG9mIHJlZ2lzdGVyZWQgYXVkaXQgZGFlbW9uLg0KPj4gDQo+PiBCZW5jaG1hcmsNCj4+ID09PT09
PT09PQ0KPj4gDQo+PiBSdW4gdGhlIGZvbGxvd2luZyBjb21tYW5kOg0KPj4gDQo+PiAgZGQgaWY9
L2Rldi96ZXJvIG9mPS9kZXYvbnVsbCBicz0xIGNvdW50PTVNDQo+PiANCj4+IFdpdGggcnVsZToN
Cj4+IA0KPj4gIC1hIG5ldmVyLGV4aXQgLUYgYXJjaD1iNjQgLVMgdW5hbWUNCj4+IA0KPj4gUmVz
dWx0Og0KPj4gDQo+PiAgQmFzZSBsaW5lICAgIDogMi41NzIgc2VjDQo+PiAgL3cgdGhpcyBwYXRj
aDogMi40MTIgc2VjICg2LjYlIGZhc3RlcikNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRWlpY2hp
IFRzdWthdGEgPGVpaWNoaS50c3VrYXRhQG51dGFuaXguY29tPg0KPj4gLS0tDQo+PiBpbmNsdWRl
L2xpbnV4L3BpZC5oIHwgIDQgKysrKw0KPj4ga2VybmVsL2F1ZGl0LmMgICAgICB8IDIyICsrLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+IGtlcm5lbC9hdWRpdC5oICAgICAgfCAgMyArKy0NCj4+IGtl
cm5lbC9waWQuYyAgICAgICAgfCAgMyArKysNCj4+IDQgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3BpZC5oIGIvaW5jbHVkZS9saW51eC9waWQuaA0KPj4gaW5kZXggMzQzYWJmMjIwOTJlLi41
ZmUzOGUyNTRjOWEgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BpZC5oDQo+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L3BpZC5oDQo+PiBAQCAtNjgsNiArNjgsMTAgQEAgc3RydWN0IHBpZA0K
Pj4gICAgICAgIHdhaXRfcXVldWVfaGVhZF90IHdhaXRfcGlkZmQ7DQo+PiAgICAgICAgc3RydWN0
IHJjdV9oZWFkIHJjdTsNCj4+ICAgICAgICBzdHJ1Y3QgdXBpZCBudW1iZXJzWzFdOw0KPj4gKyNp
ZmRlZiBDT05GSUdfQVVESVQNCj4+ICsgICAgICAgLyogcmVnaXN0ZXJlZCBhdWRpdCBkYWVtb24g
dGdpZCAqLw0KPj4gKyAgICAgICB1bnNpZ25lZCBpc19hdWRpdGQ6MTsNCj4+ICsjZW5kaWYNCj4+
IH07DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCwgYnV0IEkgZG9uJ3QgdGhpbmsgd2Ug
d2FudCB0byBhZGQgYW4gYXVkaXQNCj4gc3BlY2lmaWMgZmllbGQgdG8gdGhlIHBpZCBzdHJ1Y3Qg
YXQgdGhpcyB0aW1lLg0KPiANCg0KSGkgUGF1bA0KDQpJIGFncmVlIOKAnGlzX2F1ZGl0ZOKAnSBp
cyB0b28gc3BlY2lmaWMuDQoNCkhvdyBhYm91dCBoYXZpbmcgZ2xvYmFsIOKAnGF1ZGl0ZF9waWTi
gJ0gc3RydWN0IHBpZCBwb2ludGVyIGFuZCBsZXQgYXVkaXRkX3Rlc3RfdGFzaygpIHVzZSBpdD8N
CkkgbWVhbjoNCiNkZWZpbmUgYXVkaXRkX3Rlc3RfdGFzayh0c2spIChSRUFEX09OQ0UoYXVkaXRk
X3BpZCkgPT0gdGFza190Z2lkKHRzaykpDQoNCkJ5IHRoZSB3YXksIGl04oCZcyBhIGJpdCBkaWZm
ZXJlbnQgdG9waWMsICBJIG1heSBoYXZlIGZvdW5kIGEgcmFjZSBpbiB1c2FnZSBvZiBhdWRpdGRf
cGlkX3ZucigpLg0KIEluIEFVRElUX1NFVCBoYW5kbGluZywgdGhlIHZhcmlhYmxlIGF1ZGl0ZF9w
aWQgaXMgcmVmZXJlbmNlZCBvdXRzaWRlIG9mIHRoZSBzcGlubG9jayBzbyBpdCBjYW4gYmUgY2hh
bmdlZCB3aGlsZSBpdOKAmXMgcmVmZXJlbmNlZC4NClNvIHRoZXJlIGlzIGEgVE9DVE9VIHJhY2Ug
bGlrZSB0aGlzOg0KDQpDUFUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IENQVTENCj09PT09ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPT09PT0N
CmF1ZGl0ZCA9IGF1ZGl0ZF9waWRfdm5yKCkgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGF1ZGl0ZCA9IGF1ZGl0ZF9waWRfdm5yKCkgDQppZiAoYXVk
aXRkX3BpZCkge+KApn0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGF1ZGl0ZF9waWQpIHvigKZ9DQphdWRpdGRfc2V0KCkNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXVkaXRkX3NldCgpDQoNCg0K
DQpJZiBhdWRpdGRfcGlkX3ZucigpIHJldHVybnMgMCwgdGhpcyBjYXNlIGNhbiBsZWFkIHRvIHJl
cGxhY2VtZW50IG9mIGEgaGVhbHRoeSBhdWRpdGQsIHdoaWNoIHNlZW1zIHRvIGJlIHByb2hpYml0
ZWQganVkZ2luZyBmcm9tIHRoZSBjb2RlIGNvbW1lbnQgIi8qIHJlcGxhY2luZyBhIGhlYWx0aHkg
YXVkaXRkIGlzIG5vdCBhbGxvd2VkICov4oCcLg0KDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJ4oCZ
bSB3cm9uZy4NCg0KVGhhbmtzDQpFaWljaGk=
