Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D815FB9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJKR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:55:58 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEFD62919;
        Tue, 11 Oct 2022 10:55:56 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BGrqh1017271;
        Tue, 11 Oct 2022 17:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=6771/YNI9Y53OtCxCvattwjspBRfRI6zeap7bVdVEf8=;
 b=kCHSe+jC4FwSepe2jtrQi9WWz0zjpdV6yKSu1CQETjcEmg9Rgbms/kDs1UbdfiBZDVKy
 6E5rtM6CrrTVEVsEluO2AwdKesLp813u6nDxwg60LROXi1pKkLD4TJIVsfVgH3vs2W+l
 aofS6RSlx9VVWZX3+AOQDcmWqK/HY1o6T8lnOxtaLIqYv+krrubGUAR/wfFKAQTlzpvt
 MdwZYQrhhkUkQnZuSwzJcB36dC5UAwKV/Hi0CqRadw7GYVKHPSTUI/Qf9ioxGWb0G4x7
 PS1mQsY8W8J9ImF+nc0j1VEeRMceNyUFVZetpIYNgL1lVr2CSWrmrBiK7IsPK09Q2Hlp gg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k5cdggh9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 17:55:54 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 461D2B2;
        Tue, 11 Oct 2022 17:55:54 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 11 Oct 2022 05:55:47 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 11 Oct 2022 05:55:47 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 11 Oct 2022 05:55:47 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpEBmAjZKGzpJcjTAcjBGb0XO54OUiu2lF+Ml0hEpP2X96B0DoI4iBQGLZQlBHE1goo2a1BCjYVtRmR5B4i4DkREArxRWLGpNo1Vbz2D+CVyWDBqA4XvUxfIPa7HZsp5YLEw4QVK4Ej9TdRSrHcz7IxW/g2QZucq6Xw5YpdC2LE4fg3TmvenwIBuZ0cWj6sNn+lNE5gGNrEGGSonl2XEWmSf9hD/pP1lXc6QQ50mTYKgsrTQqyea3bpUCbeubmDovgND6b58O21RzD74wfl5C7mNkg8X0B+aj81nxVRGidlLYFp77y3tcDA4MwxZoRNAq/B4wRVwe43ZDfmIPTh3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6771/YNI9Y53OtCxCvattwjspBRfRI6zeap7bVdVEf8=;
 b=MSVB5kTHSmsPM2MUNnSJMlN5ml+FE8xvt5/eC6JNV/Ctv/i74QiQkxEj+kT8zxMtS/5pcmpluR7622lO1Fx50NAtX0y9LMECLiu6rIixMb+8Ary/DcbhKHus+ZOR/bM4QTBTSpbfWP78PG+eQH4Oyz+vVfn5ltcqMezYnw//8HFhdHBNva493LPo1E4UoJ8z093Qv0KatKpKSjBvHzAD1G/G/rlG3CPjuHxrZE4a8cxmiRKFUYJXcaGN/JRjFvv0i8YQivgVgAcsMyVqk0g+ABfDWvIe7O5KcMWFvT221CfODMKn0bTcPPuIbiOGl3tLATGr+KBm6tet2G+L9dD+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 17:55:46 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5676.032; Tue, 11 Oct 2022
 17:55:46 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Aaron Tomlin <atomlin@redhat.com>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Unloaded tainted modules list with tcrypt
Thread-Topic: Unloaded tainted modules list with tcrypt
Thread-Index: AdjcuQahMl2C8lRIQDeORTZxmzyv4AATEgAAACEBFwAAA6j/UA==
Date:   Tue, 11 Oct 2022 17:55:46 +0000
Message-ID: <MW5PR84MB1842AD39D409C79F67E7CB01AB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221011155128.k27rsgevfwyawvbh@ava.usersys.com>
In-Reply-To: <20221011155128.k27rsgevfwyawvbh@ava.usersys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1590:EE_
x-ms-office365-filtering-correlation-id: faf5ec8a-d67d-4a4d-d40b-08daabb1d2db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqfFU8HjY6lujPlweeJrrLY/cAQULusemvUaDXWyaPM4SwfAyybwju3MgR5oF6xOUQSY194z+iwJHk/bhSeT/4C8GO0xNvXIYTjbOVPFx+jE/GLNTvieaOObe4KJqxPDT9NOxQwAkR8Q/9jWUzd8/u+/BZDGpzuCzVqWAM+m1liIm1e0aYZxt+kXpeCohfKti6aG+16u7Lzf7PjkVRtpaadT9pa5LCmtqrsnD3PoGzGHPgDgoyO4dn9fgWD0gNr/s7zfRrcGeEDo8nS0aOtX819dzO4AFRnlokVd+KUEFh/SzYIUY9qIpkTUqDJ+W+bwVK/lhGgf9+XHzQm0n/Jv8+u7SftYMCR9q4SnmGU20M8sCZO+AXWNH8UuGesFvlPqz4ARW966zyKifcgdhIILtRGXF6KhJNApHmHw/WNyG6rW6YZk98QxLgHp5AHZfYVkqVcYAGrrSUDrpbBLTRLpCp0wI7mRdnFVbWVEz1Ctx4qrM8m+xL1U8ymuJp8dezSZMJzBT+IA0xnheVkZy7VbHdgMA0cU9cpdvfkEtIroqHdMG0oXHM7red5BvArh9zd2PRWwFpCGjcf4UVcNPMMLscnehFxEuD2ki3kqfBEgNFSEsYmyuvdrFJtopmm77QSGLXNmuMFMa4aG63nNn/sOR7YVl/VFCbO1rMj1MxvdNyzs0m6wR2Ck0a84656QfAm5ryGdclwbQX8jV0bps/ccXmIKZvVl0yrkgBxJYIt3ltITZILXnHR6q0pAMU22VK34U8mvbG4hmDQ87yG9YZLAjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(26005)(9686003)(55016003)(316002)(122000001)(38100700002)(38070700005)(71200400001)(8676002)(54906003)(82960400001)(33656002)(6916009)(83380400001)(6506007)(7696005)(186003)(53546011)(478600001)(86362001)(5660300002)(52536014)(2906002)(8936002)(66446008)(64756008)(41300700001)(66946007)(76116006)(4326008)(66476007)(66556008)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlUTnRFbDc2eVV0OFZLam5jVnNlcCt0REV6NGRidm94SW1HNU5JdjlBVlVm?=
 =?utf-8?B?aUtwdUo2RzIrVlRrZFdXRUVFMFZyNWJ6UWtheDNsRHFZN1FQSVRiZ1hlVmpT?=
 =?utf-8?B?Yzl3S3h2MWY2NU1uOHFhd0x1WEViSFRQQlBleWVqbkhCOWdKK3NRR0ZVS0dk?=
 =?utf-8?B?UzFZcEpHRFRXVTBNdHJmQXdQMWk4U2pHS2U5dUpUNm1jU3RXU1hFTXplQWE4?=
 =?utf-8?B?ZWVhUGNid0NoUWhDN2JOeWt2UHBOKzA0Yi93RXdscWZGL3ZvK2ZpZFJPUS9F?=
 =?utf-8?B?eFlyS0xSa201QnVObEw2djlvdCtXdWlaSU1RUVRCQ2FnNXoveFBURWtDY0RY?=
 =?utf-8?B?RXd5RXM4dG83QmU1TnM3Z0NIRVh2RVNhTFFaRTFDbnFxbStoMjRza2ZVYzUy?=
 =?utf-8?B?cVh4YkpjbTg3ZFpmRkhHSzdxU3l2YlJ0Q2NMTWxncGtnd3d1MG12MHdISjBP?=
 =?utf-8?B?anVFbVF6RDN2WldHc1htMWdaZVFzOUVIb0NjNjhxZ3dydjBYbkJtTEYrRkQz?=
 =?utf-8?B?MzhZd0ZSSElETW5FeCt4aDdSZjNUUnVocGsxUndsdTZhdFFsTkYvR3V6YnpM?=
 =?utf-8?B?aHlOOHpSSStHMENVSFl4dlJ0ZE1tRW91bjk3cnNqSGw4U1ZDV2p2VTFXQzBx?=
 =?utf-8?B?YTJoWWlieUZSWVJDN0tlWVNyVENNZ29tc1hza01JdjlwOXRkaHpENGQzZFFO?=
 =?utf-8?B?VTNXOFV1a1FVMEQvQm5PemFwKzA3SDQyVFRNamRpb29rVjNxTFF2ZWF4R0dH?=
 =?utf-8?B?eno4bWdTY25tbmhDQ2Q0aWg2ZUsySFQ2TGs5VVFwd0pZUWRVR3dWTjhBQjBv?=
 =?utf-8?B?c1RxcjFnRHpRVVk4dEhETXpYaDV6T1ZsOUN3Y0JqUENRbUJBQ0lyYVBLUzJy?=
 =?utf-8?B?S2tsajR6SlpvSEVkcEtidFRoMDVicFRLVWNCMi9Pc29pZVFwdFlFdGhwcEU0?=
 =?utf-8?B?TWZadWVJNi9wSVozQy9JeEdYbmdEWG5SZ3VpRXR4YXhHZXh3UC9lUVlaSHRI?=
 =?utf-8?B?Q3Axck53ZVdkMmpra1ArWFBDYUIvaXl6d1J2TjBEVUJaN0tOWVk2NGMvUnZV?=
 =?utf-8?B?OVM1czZ0YW9OMEVRbXFRTnhOYUdLVGxKN2x3dmtZeUxDRGFYdjRXc0ErM0Zj?=
 =?utf-8?B?NG55TjBwc3lmRGVWaHVCYlo2U3pDRENPZ2VsS1Z1bjJSK1RTYmVmeWllOGJI?=
 =?utf-8?B?OStZNkNXai95V2J1NWZuajNCTkFZc0ZqTFMxcjZxaGsyRWdIOVh1bThsb1A1?=
 =?utf-8?B?YzZ1bkNTNGZqYVJTZGgrOWhiNnJYTWlQOHBmTDdWblRvOFl1WHJXcmlWTVpX?=
 =?utf-8?B?UGl2U1RoM2x3YytiWUUwZ1ZIQVpTL05pVzNza3Fra0ZiaGI2cHU5SmZkYzlY?=
 =?utf-8?B?dW94b3V3WldRVUpFY3k5OGhDajJJdElta1k3ZmlLcWh3TXltblBDQ0s5c1pM?=
 =?utf-8?B?eEtqQ0lCdEl3WGxzRzBXKytIWGlrcVhQZXk1UFFxUTNKcXlpQVpLQldHcGFh?=
 =?utf-8?B?bEFDZW1QQjd5bWx4eWd6dU9QME4rYkczUWw4QU0xMWpSelB5YWY3bUlOQnhY?=
 =?utf-8?B?aXdaZ3UvT1MzOThqcEN3dmdWMU54Yzc4RVZmZ3pXNWNWYTVsYkZmbk1TSElt?=
 =?utf-8?B?bzlteFE5d3VwZUxpZXp0UE90QmZxUHNNMnJFSTF0OFNPclQzb3NuZG50RVJS?=
 =?utf-8?B?QUdQNm43Y2tGT2NldUlDa2Q0c1pvN2NESGtpVDBZeG9VZzg0Z2ZETXVMK0Nh?=
 =?utf-8?B?SDUyS05lTGh2eFIyOEh6amR2aDdOdzFtUVBwZ0N4UWlRVXdIZFVXN25BRFJ5?=
 =?utf-8?B?YjBmdmVKQ0VNdUpPUitueGIrdkJhdU55SW1KWUl5Y0RjU1BjbTU4Umpnc0Vr?=
 =?utf-8?B?cXRPNWVPWVRXSGJVZDVPQ3JpVUpwQjJlc0FyS0J3bm1oSE0yd29ZMkdkVjBn?=
 =?utf-8?B?bVZVZFp4VGFIZG5uclZoNElqZWJVdVpMR2wzbTV2MGRvNkFSUC9HdkpJeVdt?=
 =?utf-8?B?cWR5MjZwYVRzWlNwWmFGSXFRZ3BZd0xEcTVUU0IrNFZ2VFE4VlYzdDZWTmto?=
 =?utf-8?B?ckFsR1I5MWtZZFFpVHM2NFNXRTJtK0ZiTlo3aDBVL1UzU0QvZ0l2QTRkY1F5?=
 =?utf-8?Q?ZFjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5ec8a-d67d-4a4d-d40b-08daabb1d2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 17:55:46.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWY912wHiTjMyh/syYG0BrklSBDSjaCudg5KdrGxALP+cpAcKAZQb13mq3BRR5DI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1590
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: H5MoglDs2VScnU8IHLT_3BpkNMdIqROH
X-Proofpoint-ORIG-GUID: H5MoglDs2VScnU8IHLT_3BpkNMdIqROH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110103
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWFyb24gVG9tbGluIDxh
dG9tbGluQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTEsIDIwMjIgMTA6
NTEgQU0NCj4gVG86IEVsbGlvdHQsIFJvYmVydCAoU2VydmVycykgPGVsbGlvdHRAaHBlLmNvbT4N
Cj4gQ2M6IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBVbmxvYWRlZCB0YWludGVkIG1vZHVsZXMgbGlzdCB3
aXRoIHRjcnlwdA0KPiANCj4gT24gVHVlIDIwMjItMTAtMTEgMDA6MDkgKzAwMDAsIEVsbGlvdHQs
IFJvYmVydCAoU2VydmVycykgd3JvdGU6DQo+ID4gQ2hhbmdpbmcgdG8gPT0gc2VlbXMgdG8gd29y
ayB3ZWxsIC0gdGhhdCBzaG93cyBpbmNyZW1lbnRlZCBjb3VudHMNCj4gPiByYXRoZXIgdGhhbiBu
ZXcgZW50cmllczoNCj4gPiBVbmxvYWRlZCB0YWludGVkIG1vZHVsZXM6IHRjcnlwdCgpOjQwIHBh
ZGxvY2tfYWVzKCk6MSBpc3N0X2lmX21ib3hfbXNyKCk6NTYNCj4gcGNjX2NwdWZyZXEoKTo1NiBh
Y3BpX2NwdWZyZXEoKToxMTINCj4gDQo+IEhpIEVsbGlvdHQsDQo+IA0KPiBQbGVhc2Ugbm90ZSwg
YW55IG1vZHVsZSB0aGF0IGRvZXMgbm90IGNhcnJ5IGEgdGFpbnQgc2hvdWxkIF9ub3RfDQo+IGJl
IG9uIHRoZSBhZm9yZW1lbnRpb25lZCBsaXN0LiBTZWUgdGhlIGZvbGxvd2luZyB3aGljaCBpcyBh
bHJlYWR5DQo+IGluIExpbnVzJyB0cmVlOg0KPiANCj4gY29tbWl0IDQ3Y2M3NWFhOTI4MzdhOWQz
ZjE1MTU3ZDYyNzJmZjI4NTU4NWQ3NWQNCj4gQXV0aG9yOiBBYXJvbiBUb21saW4gPGF0b21saW5A
cmVkaGF0LmNvbT4NCj4gRGF0ZTogICBGcmkgT2N0IDcgMTQ6Mzg6MTIgMjAyMiArMDEwMA0KPiAN
Cj4gICAgIG1vZHVsZTogdHJhY2tpbmc6IEtlZXAgYSByZWNvcmQgb2YgdGFpbnRlZCB1bmxvYWRl
ZCBtb2R1bGVzIG9ubHkNCg0KVGhhbmtzLiBXaXRoIHRoYXQgY2hhbmdlLCB0aGUgbGlzdCByZW1h
aW5zIGJsYW5rIGFzIHRjcnlwdCBhbmQgdGhlDQpvdGhlcnMgYXJlIG5ldmVyIGFkZGVkLg0KDQpU
aGUgY291bnRzIG9mIGZhaWxlZCBsb2FkcyBhcmUgbWlsZGx5IGludGVyZXN0aW5nIChlLmcuLCBj
cHVmcmVxDQphdHRlbXB0cyBhcmUgYXBwYXJlbnRseSBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mIENQ
VSBjb3JlcyBwcmVzZW50KSwgYnV0DQp0aGVyZSBhcmUgb3RoZXIgd2F5cyB0byBvYnNlcnZlIHRo
YXQuDQoNCj4gICAgIFRoaXMgZW5zdXJlcyB0aGF0IG5vIG1vZHVsZSByZWNvcmQvb3IgZW50cnkg
aXMgYWRkZWQgdG8gdGhlDQo+ICAgICB1bmxvYWRlZF90YWludGVkX21vZHVsZXMgbGlzdCBpZiBp
dCBkb2VzIG5vdCBjYXJyeSBhIHRhaW50Lg0KPiANCj4gICAgIFJlcG9ydGVkLWJ5OiBBbGV4ZXkg
RG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+DQo+ICAgICBGaXhlczogOTliZDk5NTY1NTFi
ICgibW9kdWxlOiBJbnRyb2R1Y2UgbW9kdWxlIHVubG9hZCB0YWludCB0cmFja2luZyIpDQo+ICAg
ICBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBUb21saW4gPGF0b21saW5AcmVkaGF0LmNvbT4NCj4gICAg
IEFja2VkLWJ5OiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4gICAgIFNp
Z25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9y
Zz4NCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL3RyYWNraW5nLmMgYi9rZXJuZWwv
bW9kdWxlL3RyYWNraW5nLmMNCj4gaW5kZXggYTEzOWU2M2I2ZjIwLi4yNmQ4MTJlMDc2MTUgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvdHJhY2tpbmcuYw0KPiArKysgYi9rZXJuZWwvbW9k
dWxlL3RyYWNraW5nLmMNCj4gQEAgLTIyLDYgKzIyLDkgQEAgaW50IHRyeV9hZGRfdGFpbnRlZF9t
b2R1bGUoc3RydWN0IG1vZHVsZSAqbW9kKQ0KPiANCj4gIAltb2R1bGVfYXNzZXJ0X211dGV4X29y
X3ByZWVtcHQoKTsNCj4gDQo+ICsJaWYgKCFtb2QtPnRhaW50cykNCj4gKwkJZ290byBvdXQ7DQo+
ICsNCg0KT25lIG5pdCAtIHNpbmNlIHRoZSBvdXQgbGFiZWwganVzdCBsZWFkcyB0byBhIHJldHVy
biBzdGF0ZW1lbnQsDQp0aGUgZ290b3MgaW4gdGhlIGZ1bmN0aW9uIHdvdWxkIGJlIHNpbXBsZXIg
YXMgInJldHVybiAwIi4NCg0K
