Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03856FF28B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjEKNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjEKNSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:18:31 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF810A0E;
        Thu, 11 May 2023 06:17:23 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BBs4uL009125;
        Thu, 11 May 2023 13:15:53 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2235.outbound.protection.outlook.com [104.47.51.235])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3qgc4gv5ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 13:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etkN/d+bI8FuJvyq+88HMCli1g2Dpa8MV1B/ISJSZ/dld76mZ1wsMIZSRpKWXbGkEOHV6c6fc8OZT7faRimr9nowu4MrWoNaQWnvFiNVDaGGslfW72+cBvfHiI6a7hD8DIBSwwvVGFqrI3AjZa1BGh+Sarp7vBggwcwGmmWIdxxU/6IVyn+0sg4YxW08Fj7+Yh5/pK+M7+w8p50Vmrtyn7Jo8NGOcM7NCdUwSOQ88p3OFZxXPvnMSBGG0dM7GKalvlFHDylt6VYVeFC2g+EHHhJEysdP/ll1NEA8/WsuxJGXQYOaTYnWh1fXkr41FdiZstKSSf5HBQWmuQy1V0MEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LEC6TAsGVqKHF57P3YP88suQ2Y2XE0x9YzQ6qh+YXQ=;
 b=JpVEFm+mCbzBrDY01iu1kMLnpl0Tec2wpzmBX4m+JxCM/OJubuvCMENbb5PWTI/VNmW0g1PGlhtzsFqCVGoLvqZeUdf/fUf23TsVz9Lfs6oriubqtN0QMDb4xy0/V5MArb8K2Ui3UjzJ4D3FT8qrbjkU2OP+sEd0aRknyPE9+oDQhccOXWPyCy9yKOgAORiJ3ah6rZpKgvujtRow5lt4vUJzASW0Nuxg1dNHHyKX/9kLJ2QVbc0CVqp4i4GKYyiV0fTjKgVgChK6AAx+QmbUUCyWVUUGRUFwDFbzqWqXB3RLyME+34+rQiAnUMZUlhdfzl1nzfN0j5Mz842hPNogVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LEC6TAsGVqKHF57P3YP88suQ2Y2XE0x9YzQ6qh+YXQ=;
 b=YM73rMhIe7Ro7EwzgHpflQjXRKUIjGgbzF3zy/ZGUiG+WiP4/2bQmLilyIfdHFI3+1rJZ9fCDKt30hBEPpsn9rFroysaw5I5/ycgV2VuA7/hFSks5Ta3Mx1YwZw8mta7tMT8cJEBGlIg4BBORBstmxiYA14u6JJhoqQ9Z5UKf1rA1qhOifCK7T8WURA8WK/jiZaKNeqx5FWtDA4DoudzOVaV/wSAAsEmuTbo0naR+6U60rOud8Fv3zBPeQIzzOlymAyZVGG/l1aubIO/98UtyzK7HJmbga2TK4kGtalJLZV2TKd3scakL63VPQWAMhOInsBlXJMHRVC/KHQMAwi+2g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PAVPR03MB8971.eurprd03.prod.outlook.com (2603:10a6:102:32b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 13:15:47 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 13:15:47 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Index: AQHZeEK66Y+E4GsA3km+qVBMGvAGK69MMbOAgAjzKoA=
Date:   Thu, 11 May 2023 13:15:46 +0000
Message-ID: <152bbad1-a759-df18-1efa-4e25c54847d9@epam.com>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVoiWnvq7UXSBBw@surfacebook>
In-Reply-To: <ZFVoiWnvq7UXSBBw@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PAVPR03MB8971:EE_
x-ms-office365-filtering-correlation-id: 19bfe7f3-4387-435b-8d0d-08db5221d54d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BkBwLIyNyMZmgcjKpKHKBSMUOtnnFvbCyY9l8/MwfDisQBJLcpz8KBsNLGzZnmOs9IAg/3vW/ZeRprgSQrwWXWNpElNmF+ropA5tzdV+KwRvPRJ8ax3oExHuTnkfSGy7Mq6Q6gV8qu3Y5E+WI/TsXg3ZDoWTNVOhD/7zoNKAFs9+E6SwKLB/Fqj2ao36zbHD9L6LEgfpNMMHm7lr7+PvsTVk7mIE3yw51qOl9ksgMuZV/I3HlBufGJmA2p9UGd4j/xcdqoX1fkFEOuKjBmEaUvSfUwWX+q4yj9q5WfR1U7FtXxYPOqB/xq9fH0LGy/HOMY5AEZc181tREwc+562LBCXYQNOwrtV42x52VR8EfHCBNd8pLaxZvtX6jzIz8HHW3FDNBndjELgM1a2I72ScseM+GcMLfhV0YKwLUL+dsNFfzIG8H7B44Q0ENFkSXRatZGvWhUeygQgrEznwp5+mCGeJy+BtVcV5CvKf62gaAOOMEFh21aNNwf0ngBrzX0uvPIncqXlG39+Ik9MYhF6q1M6kJLn3F+WHh7yE5mQsf7MoaQpcwoPCWy1R8HheTOPqP1iKAS+i6RhkrYl+UsHza9i0e4PaUf1bpXt5mv/5S09f8f0aQtNOYlT6i5ukNQAcgn0yRe4O21oNzVQux0AJAqrgVPdAuvM+xq9b+unyOo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(122000001)(41300700001)(26005)(186003)(2906002)(71200400001)(53546011)(6512007)(6506007)(5660300002)(38070700005)(38100700002)(8936002)(31686004)(6916009)(316002)(54906003)(478600001)(83380400001)(2616005)(8676002)(36756003)(6486002)(86362001)(91956017)(66476007)(66556008)(64756008)(4326008)(66946007)(76116006)(66446008)(31696002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REV2WWpra2N5Zk11VG5qcHRBRkplQm1JMVpxb25iRDNBRmViTmdYZDA3endE?=
 =?utf-8?B?ZmhSV0haYWRKWkNCYUpqY0lYUHhlNjBmb1IrcjNweGhHZVVueWxiTUZBdU51?=
 =?utf-8?B?WXZ6dDhyOFR6b3Y0cWxQUTRmRDBTamdQTUJlUWVGMVFuOG1ON2F3WjMzdDdz?=
 =?utf-8?B?YllJOFN6eUltUEsxMGNLd0FsQmY4bkI3VG9EZXNybnFWeWRNQzJUanRWV2Ns?=
 =?utf-8?B?SmQvWDdPOEs2azBUMFNMYU9aRjY3eGZyVUNOaDd0ZFkxZ24zVGtpUGNpR3dG?=
 =?utf-8?B?SDNhY1JmRDVBQUxKNDk5blhEbmg4SU1lQzh5eGxYRzRDUDR6dlRtemV6VC9H?=
 =?utf-8?B?M3g1UU80YTdrTWovOWd5Z3FXLzBJRC9OMVJHeWc3bTBHWG43bnVYeTJIRlNq?=
 =?utf-8?B?bkgxWXlOWlF3SHR2cVRVaUJpTnk2TnJoazk0R2F6Y0ZyY2RoKy9idm82ajlI?=
 =?utf-8?B?ZjB5YVUwU3dWNmgwSTRkNTNOTzh4OGxEdlRyOVVLNm9MSm53ZnRCR0EwUUJZ?=
 =?utf-8?B?bElGUVhreVlEczdvaUF1TmZaWmxFd2pUU3RaMlZ4ZDM0MnFsUFB3Z21zVWJy?=
 =?utf-8?B?SVd4bmxDL2JLcUhVT25qbGFjQzc0d0FXOTBkVjFTaUJrTUFpb3lyUHpkRTNU?=
 =?utf-8?B?cnQ2REpacWNmd1ZFN0VEeXhXOENuazF4R2xCaFRjUFozVHVoaTd3NGg3RWk1?=
 =?utf-8?B?M0RwM0Z2NjR0RmxhSlNNS1hJWjBrZVpGQlZsT1o1Y0JCOFFZc2cvbzBkUHZG?=
 =?utf-8?B?TVluQUVBVnJZUGFCMy8yeHk2ZTFwUWJsUlBGQ0hvaHRQRk83cHhXYmVaa3Zl?=
 =?utf-8?B?S1N2MExxKzJPN0c0Q1l0UVZqM3RpeThpQTYzdmZMeldvWWNqSm5SQnRKVVBR?=
 =?utf-8?B?VHQ5aVlMZk1wT2FaWkdVbVhHTEViTjQzRTBDeDh1NjhpaUcxYXNKVDhIR054?=
 =?utf-8?B?cEFSSkh0K0VvMGdEZGVEaVVjRHVWRmdpbmNPVWt4ZWg0aVpNeEdrQklwR0FI?=
 =?utf-8?B?NzFkZEEyRUVncDRnSHpabjFDYVlveEp0LzA3TmRjT2dLRVpXWTBPcHZSV0JV?=
 =?utf-8?B?NTJidmFwNVdWYjZqQ0E4UThKU3FBN3VGUWpLM29TWDNmQTJLNXhNbWxQdk44?=
 =?utf-8?B?bDEwb3d6Rkt0bXE4L2ZZbVVFSnVFc29xbEhkZzY1bzR2QThJNC8wQ3k2bE5p?=
 =?utf-8?B?eXEySlVzbzVVNGZFTHZFaWl0REtWSjBiZkZEaFVtaUl0QUtWS0NXaHRucGxJ?=
 =?utf-8?B?L0lGbnMzcHVlcG0vWUdQbVZrSU5ZOHJYa2JOL2FVQ29JWDN5ekV6ckx2V2c3?=
 =?utf-8?B?RVRlN0FEVlIyM3pFM1Erc0tWdTZESDVmNEp1bE5ub0pHeUVvZnBEUlFyclFx?=
 =?utf-8?B?MXk0TGJQOFdSbGIrRlRhSWVkdUdPUlBId3RHMVExTFNUclpaWTEwdFNwRGoy?=
 =?utf-8?B?eEdqUHRsdlZxRXJMVnY5Z083WU91VkRqY2djUGFzbDRuMzBkZjhVbDUwR1ZB?=
 =?utf-8?B?akdiaytaQ01oVEtmSlVuT0FSTkJoL0w3Q1RZM3QvcUYrYkUyd1k1Qm8xdXly?=
 =?utf-8?B?TUFoN0QzR3djMm5LNW9hMitIeHh3eUtYNUdld25ZTFdIM0kzaVpadS9qSzBa?=
 =?utf-8?B?RW1YSmc5VENZalM0NkQrcmhRQnZwb24yYnZyaFFDY1QyMkp0cGUvYnA0VXRO?=
 =?utf-8?B?a0hZVGZvRzFSS0lsbmV5dGhjMkMwa2tSYytCVUJ3RUNjQ2Q5RnY3cTh0NkJL?=
 =?utf-8?B?aWFCM2M5c29IcHZpdWkrNXkwQzVTZ0RrTHpnV1l0elJ4ZlJvbkVsVDRvQkNP?=
 =?utf-8?B?NFZSTSt3NmVCd3FMYmQ2R2dVTVVQbG5BTHZTWlZoYWtBY2lKYktoZ0YzRFFq?=
 =?utf-8?B?bVhJY1BsMk9MOW9CeXp5dFVIL0JEUEc3Vk5wYWNFKzNqRitqUStHcjk4Rkpi?=
 =?utf-8?B?b0V2bDlJSnlwREk1cW1ZNFhacW1Bc2YySFJVL1RWOTVuRlpzYjFYTE5MbXFj?=
 =?utf-8?B?NU1BUFpnSWN2OW4yQjlEaVB3c1JmbGtxRWhnY1hwQjZ1cXcyOUpJbngzTDcz?=
 =?utf-8?B?WkhMTHloMW82NFBDeWY1ektRdUE2TkxUZkZWdEQvaWRBK0tpMDVVZ0lHQnY0?=
 =?utf-8?B?U2dwK2hCYVJ2dWkranhoZVdidVFHaGY1TGJ4VU5GR0Y2dTBNSHh2b3ZkTzZq?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8EB1A017870D149B40C6FCBE4B746EA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bfe7f3-4387-435b-8d0d-08db5221d54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 13:15:46.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YGnStrE5leyNlqifuP4PSz5e2tOwh8AHSDTjkQ91+gfVd0j7HRn009qoB4uRF1D5Up3lLARLNFNP50QgEuc2+C9xvRU/i26Nl8nnhGEXWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB8971
X-Proofpoint-ORIG-GUID: DjKrNFZI7RjJghELZug0QX1BsWe7oyOC
X-Proofpoint-GUID: DjKrNFZI7RjJghELZug0QX1BsWe7oyOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5keSwNCg0KT24gMDUuMDUuMjMgMjM6MzUsIGFuZHkuc2hldmNoZW5rb0BnbWFpbC5j
b20gd3JvdGU6DQo+IFdlZCwgQXByIDI2LCAyMDIzIGF0IDAxOjI2OjM3UE0gKzAwMDAsIE9sZWtz
aWkgTW9pc2llaWV2IGtpcmpvaXR0aToNCj4+IHNjbWktcGluY3RybCBkcml2ZXIgaW1wbGVtZW50
cyBwaW5jdHJsIGRyaXZlciBpbnRlcmZhY2UgYW5kIHVzaW5nDQo+PiBTQ01JIHByb3RvY29sIHRv
IHJlZGlyZWN0IG1lc3NhZ2VzIGZyb20gcGluY3RybCBzdWJzeXN0ZW0gU0RLIHRvDQo+PiBTQ1Ag
ZmlybXdhcmUsIHdoaWNoIGRvZXMgdGhlIGNoYW5nZXMgaW4gSFcuDQo+Pg0KPj4gVGhpcyBzZXR1
cCBleHBlY3RzIFNDUCBmaXJtd2FyZSAob3Igc2ltaWxhciBzeXN0ZW0sIHN1Y2ggYXMgQVRGKQ0K
Pj4gdG8gYmUgaW5zdGFsbGVkIG9uIHRoZSBwbGF0Zm9ybSwgd2hpY2ggaW1wbGVtZW50cyBwaW5j
dHJsIGRyaXZlcg0KPj4gZm9yIHRoZSBzcGVjaWZpYyBwbGF0Zm9ybS4NCj4+DQo+PiBTQ01JLVBp
bmN0cmwgZHJpdmVyIHNob3VsZCBiZSBjb25maWd1cmVkIGZyb20gdGhlIGRldmljZS10cmVlIGFu
ZCB1c2VzDQo+PiBnZW5lcmljIGRldmljZS10cmVlIG1hcHBpbmdzIGZvciB0aGUgY29uZmlndXJh
dGlvbi4NCj4gDQo+IC4uLg0KPiANCj4+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+PiAr
I2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiANCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
DQo+IEkgZG8gbm90IHNlZSBhbnkgdXNlciBvZiB0aGlzIGhlYWRlci4gRG8geW91Pw0KPiANClll
cywgdGhhbmtzLiBSZW1vdmluZw0KDQo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4g
KyNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPg0KPj4gKw0KPj4gKyNpbmNsdWRlIDxsaW51eC9w
aW5jdHJsL21hY2hpbmUuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcGluY3RybC9waW5jb25mLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGluY29uZi1nZW5lcmljLmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGluY3RybC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9waW5j
dHJsL3Bpbm11eC5oPg0KPiANCj4+ICsjaW5jbHVkZSA8bGludXgvc2NtaV9wcm90b2NvbC5oPg0K
Pj4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+IA0KPiBQbGVhc2UsIG1vdmUgdGhlc2UgdHdv
IHRvIHRoZSB1cHBlciBncm91cCBvZiB0aGUgZ2VuZXJpYyBoZWFkZXJzLg0KPiANClRoYW5rcywg
Zml4ZWQuDQoNCj4+ICtzdHJ1Y3Qgc2NtaV9waW5jdHJsX2Z1bmNzIHsNCj4+ICsJdW5zaWduZWQg
aW50IG51bV9ncm91cHM7DQo+PiArCWNvbnN0IGNoYXIgKipncm91cHM7DQo+PiArfTsNCj4gDQo+
IFBsZWFzZSwgdXNlIHN0cnVjdCBwaW5mdW5jdGlvbi4NCj4NCkkgY2FuJ3QgdXNlIHBpbmNmdW5j
dGlvbiBoZXJlIGJlY2F1c2UgaXQgaGFzIHRoZSBmb2xsb3dpbmcgZ3JvdXBzIA0KZGVmaW5pdGlv
bjoNCmNvbnN0IGNoYXIgKiBjb25zdCAqZ3JvdXBzOw0KDQpXaGljaCBpcyBtZWFudCB0byBiZSBj
b25zdGFudGx5IGFsbG9jYXRlZC4NClNvIEkgd2hlbiBJIHRyeSB0byBnYXRoZXIgbGlzdCBvZiBn
cm91cHMgaW4gDQpwaW5jdHJsX3NjbWlfZ2V0X2Z1bmN0aW9uX2dyb3VwcyBJIHdpbGwgcmVjZWl2
ZSBjb21waWxhdGlvbiBlcnJvci4NCg0KPiAuLi4NCj4gDQo+PiArc3RydWN0IHNjbWlfcGluY3Ry
bCB7DQo+IA0KPj4gKwlzdHJ1Y3Qgc2NtaV9waW5jdHJsX2Z1bmNzICpmdW5jdGlvbnM7DQo+PiAr
CXVuc2lnbmVkIGludCBucl9mdW5jdGlvbnM7DQo+IA0KPj4gKwljaGFyICoqZ3JvdXBzOw0KPj4g
Kwl1bnNpZ25lZCBpbnQgbnJfZ3JvdXBzOw0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgaXMgdGhl
IGRpZmZlcmVuY2UgdG8gd2hhdCAiZnVuY3Rpb25zIiBhYm92ZSByZXByZXNlbnQuDQo+IA0KDQpU
aGUgZGlmZmVyZW5jZSBpcyB0aGF0IGVhY2ggZnVuY3Rpb24gaGFzIGEgbGlzdCBvZiBncm91cCBu
YW1lcywgc28gd2UgDQpoYXZlIHRvIGdldCBuYW1lIGZvciBlYWNoIGdyb3VwIGluIHRoaXMgZnVu
Y3Rpb24uIEknbSBzYXZpbmcgYXJyYXkgdG8gDQphdm9pZCBleHRyYSBTQ01JIGNhbGxzIHRvIGdh
dGhlciBncm91cHMgaW4gZnVuY3Rpb24uDQoNCj4+ICt9Ow0KPiANCj4gLi4uDQo+IA0KPj4gK3N0
YXRpYyB2b2lkIHBpbmN0cmxfc2NtaV9waW5fZGJnX3Nob3coc3RydWN0IHBpbmN0cmxfZGV2ICpw
Y3RsZGV2LA0KPj4gKwkJCQkgICAgICBzdHJ1Y3Qgc2VxX2ZpbGUgKnMsDQo+PiArCQkJCSAgICAg
IHVuc2lnbmVkIGludCBvZmZzZXQpDQo+PiArew0KPj4gKwlzZXFfcHV0cyhzLCBEUlZfTkFNRSk7
DQo+PiArfQ0KPiANCj4gV2hhdCBpcyB0aGUgdXNlZnVsbmVzcyBvZiB0aGlzIG1ldGhvZD8NCj4g
DQoNClJlbW92ZWQNCj4gLi4uDQo+IA0KPj4gK3N0YXRpYyBpbnQgcGluY3RybF9zY21pX3BpbmNv
bmZfZ3JvdXBfZ2V0KHN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4+ICsJCQkJCSAgdW5z
aWduZWQgaW50IF9waW4sDQo+PiArCQkJCQkgIHVuc2lnbmVkIGxvbmcgKmNvbmZpZykNCj4+ICt7
DQo+PiArCWludCByZXQ7DQo+PiArCXN0cnVjdCBzY21pX3BpbmN0cmwgKnBteDsNCj4+ICsJZW51
bSBwaW5fY29uZmlnX3BhcmFtIGNvbmZpZ190eXBlOw0KPj4gKwl1bnNpZ25lZCBsb25nIGNvbmZp
Z192YWx1ZTsNCj4+ICsNCj4+ICsJaWYgKCFwY3RsZGV2KQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+PiArDQo+PiArCXBteCA9IHBpbmN0cmxfZGV2X2dldF9kcnZkYXRhKHBjdGxkZXYpOw0KPj4g
Kw0KPj4gKwlpZiAoIXBteCB8fCAhcG14LT5waCB8fCAhY29uZmlnKQ0KPj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+PiArDQo+PiArCWNvbmZpZ190eXBlID0gcGluY29uZl90b19jb25maWdfcGFyYW0o
KmNvbmZpZyk7DQo+PiArDQo+PiArCXJldCA9IHBpbmN0cmxfb3BzLT5nZXRfY29uZmlnKHBteC0+
cGgsIF9waW4sIEdST1VQX1RZUEUsDQo+PiArCQkJCSAgICAgIGNvbmZpZ190eXBlLCAodTMyICop
JmNvbmZpZ192YWx1ZSk7DQo+IA0KPiBFbmRpYW5lc3MgaXNzdWUuIFRoaXMgaXMsIHdoaWxlIGxp
a2VseSB3b3JraW5nIGNvZGUsIHN0aWxsIHVnbHkuDQo+DQoNCkZpeGVkLg0KDQo+PiArCWlmIChy
ZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwkqY29uZmlnID0gcGluY29uZl90b19j
b25maWdfcGFja2VkKGNvbmZpZ190eXBlLCBjb25maWdfdmFsdWUpOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICt9DQo+IA0KPiAuLi4NCj4gDQo+PiArIGVycjoNCj4gDQo+IGVycl9mcmVlLg0K
PiANCkZpeGVkDQoNCj4+ICsJa2ZyZWUocG14LT5waW5zKTsNCj4+ICsJcG14LT5ucl9waW5zID0g
MDsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4gDQo+IC4uLg0KPiANCj4+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHNjbWlfZGV2aWNlX2lkIHNjbWlfaWRfdGFibGVbXSA9IHsNCj4+ICsJeyBTQ01J
X1BST1RPQ09MX1BJTkNUUkwsICJwaW5jdHJsIiB9LA0KPiANCj4+ICsJeyB9LA0KPiANCj4gTm8g
Y29tbWEgZm9yIHRoZSB0ZXJtaW5hdG9yIGVudHJ5Lg0KPiANClJlbW92ZWQuDQoNCj4+ICt9Ow0K
PiANCj4gLi4uDQo+IA0KPj4gKwlwaW5jdHJsX29wcyA9IGhhbmRsZS0+ZGV2bV9wcm90b2NvbF9n
ZXQoc2RldiwgU0NNSV9QUk9UT0NPTF9QSU5DVFJMLA0KPj4gKwkJCQkJCSZwaCk7DQo+ICA+IENh
biBiZSBvbiBvbmUgbGluZS4NCg0KRml4ZWQNCj4gDQo+PiArCWlmIChJU19FUlIocGluY3RybF9v
cHMpKQ0KPj4gKwkJcmV0dXJuIFBUUl9FUlIocGluY3RybF9vcHMpOw0KPiANCj4gLi4uDQo+IA0K
Pj4gKwlpZiAocG14LT5ucl9mdW5jdGlvbnMpIHsNCj4+ICsJCXBteC0+ZnVuY3Rpb25zID0NCj4+
ICsJCQlkZXZtX2tjYWxsb2MoJnNkZXYtPmRldiwgcG14LT5ucl9mdW5jdGlvbnMsDQo+PiArCQkJ
CSAgICAgc2l6ZW9mKCpwbXgtPmZ1bmN0aW9ucyksDQo+PiArCQkJCSAgICAgR0ZQX0tFUk5FTCk7
DQo+PiArCQlpZiAoIXBteC0+ZnVuY3Rpb25zKSB7DQo+PiArCQkJcmV0ID0gLUVOT01FTTsNCj4+
ICsJCQlnb3RvIGNsZWFuOw0KPiANCj4gSW50ZXJsZWF2aW5nIGRldm1fKigpIHdpdGggbm9uLWRl
dm1fKigpIGluIHN1Y2ggb3JkZXIgaXMgbm90IGEgZ29vZCBpZGVhLg0KPiANClRoYW5rcywgZml4
ZWQuDQoNCj4+ICsJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAocG14LT5ucl9ncm91cHMpIHsN
Cj4+ICsJCXBteC0+Z3JvdXBzID0NCj4+ICsJCQlkZXZtX2tjYWxsb2MoJnNkZXYtPmRldiwgcG14
LT5ucl9ncm91cHMsDQo+PiArCQkJCSAgICAgc2l6ZW9mKCpwbXgtPmdyb3VwcyksDQo+PiArCQkJ
CSAgICAgR0ZQX0tFUk5FTCk7DQo+PiArCQlpZiAoIXBteC0+Z3JvdXBzKSB7DQo+PiArCQkJcmV0
ID0gLUVOT01FTTsNCj4+ICsJCQlnb3RvIGNsZWFuOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+
PiArCXJldHVybiBwaW5jdHJsX2VuYWJsZShwbXgtPnBjdGxkZXYpOw0KPj4gKw0KPj4gK2NsZWFu
Og0KPiANCj4gZXJyX2ZyZWU6DQoNCnJlbW92ZWQuDQo+IA0KPj4gKwlpZiAocG14KSB7DQo+PiAr
CQlrZnJlZShwbXgtPmZ1bmN0aW9ucyk7DQo+PiArCQlrZnJlZShwbXgtPmdyb3Vwcyk7DQo+IA0K
PiBBaCwgdGhpcyBpcyBzaW1wbHkgd3JvbmcuDQo+IA0KVGhhbmtzLCByZW1vdmVkLg0KPj4gKwl9
DQo+PiArDQo+PiArCWtmcmVlKHBteCk7DQo+IA==
