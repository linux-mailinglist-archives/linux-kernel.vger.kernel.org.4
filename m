Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1345F6B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJFQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJFQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:05:19 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3C64D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:05:13 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EHMrR028393;
        Thu, 6 Oct 2022 16:04:25 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3k20nb0mjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 16:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq0yF/fq1wMmjxLljiGoirzo56NE5eAGvNXbPaex/1uCAEh1YeSjTE5S1kVAAMcYYmC8QZz4o+BCs3Ahf8wJmu0Si/WMn+MV1hePWmxS8iq+ER8VTm3O4EaP7UepOu+OTQ/qzS1TIWv0EJkEuXsiM7y29Vne3L2ERHFDfbetRxGi7EpVvfaaOStvd931Zaim0c7fHxWYbXyWztU6SR3WyShYeH3aMEiv+L5LQ8yBgr4bvDju6mFWrqFCUiaavJjaMsJjeXUYBe1OlB0P6HMNoO9SEiAbAa2hWBCfGbsS6leL8HglKKMfXLq8mgqmvJeW/6+wv4LzogFFlxBJwjsEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN9GdqSpyIcWpTpv0Hlo0Kb5r9g35AmeSIZc8LEYq7M=;
 b=a6kERcP2OESxntJ7MaT9LTGza4v7zbDZ90jIDYC5t9G+ZcowkEJYEChG6jsDUQ/s0T3QewGOpfnXqNCd95ylpCgYEGtnUwZW5X1n5+M4s08KEvOfls7LGHAJQd/2V2weesA2hsg65O2OP0WzoEF2DscD5sS9JGegTRuoIiUTc4PmuZFXUwx2weRiu2jJKQ7uHmYT26P33Z8pFuugz8itZj46Wa72qKZ3XVRyuNCzdszsWXnzTzgC7Z7bjBxzhwvbSDff7j0z0UYB+mUFb2ucE74A2c0ao5vxFvV32vL33/sVNOqwqBq0iYAS20+b+4aJCphbxReFIUv1EUHSo00TBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN9GdqSpyIcWpTpv0Hlo0Kb5r9g35AmeSIZc8LEYq7M=;
 b=AYDHT7WzhhPUjEa+E3U6hIYRfFwt7G8AKbmRmtPCT18hZ4eFpWnRJL6aplobwbLolnPtAX/Jqaa9KoDB7HmJo1dNj+yGgmr1IBDl5oZDGKffkh81+ZLDq5JvrdPzucj2/AglEc+B1KUqh18+Qc8ucIzJEBuTpXsAHCfQlKyw64dUEDQOp7HZ1boP5EJaI88ELNwm1dZ4fvok9yKo+nKfTyP48fyeghNj6GM4Yz4/1F+H9jVfKwtxwogkt67oJAyKechQ8/cdD/ZeZ9XBo8eOm9iDg1v3PYeEfKdaDHFvC8ZF2OfXOB548DClymo6c001viCnJchOvvkvhYiMAATuNA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by GV2PR03MB8875.eurprd03.prod.outlook.com (2603:10a6:150:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 16:04:21 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 16:04:21 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/3] xen/virtio: enable grant based virtio on x86
Thread-Topic: [PATCH 3/3] xen/virtio: enable grant based virtio on x86
Thread-Index: AQHY2VNniYYD6wnM6kOJwr1p2x51Wq4Bh+oA
Date:   Thu, 6 Oct 2022 16:04:21 +0000
Message-ID: <2e721170-6035-90e3-f929-79b0a07e1891@epam.com>
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-4-jgross@suse.com>
In-Reply-To: <20221006071500.15689-4-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|GV2PR03MB8875:EE_
x-ms-office365-filtering-correlation-id: e20e52a5-0149-4e4a-75b2-08daa7b46e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uSrm5bsZrHeGAYl2l44T773hZaVrRnYeAvl+XLu3ZweTE2ble00iLtwnJurL5E1A8LfaxDwLhLN4x+nbrfjzxlT4pJuyg0KhtrNIoHcfFrWU/tqVjbtdBdW06j7rnhEuduYeYf4HIqDmeFSgD2Kyq5xYPJC/5VN/y5QIF2bFvWdWxkOHKt0y/w49BUthxq0Fr9OcRpIuHiO1FUz0jSmZdSGJDN1NLjc3Ml0aVv9aJWZBngYmtpW9ey5XIPECw3yKiVD2shFLRNrEbD05oAMssPdrwx+4kWmAex1/w68tthcuKb2rVEvtpBa1RJz7ENyLU7ehIoargvUu25u0/Mwa/tAomiqQk/qIczdu+EYWY5MbzZTMiJAxktNYnF1M2ZbNbT2gGkgJx+J4lD9CSOeX8FkvYNDHvZDiPn5Sl6h1bhaz2kj0cx7i5ABv460M0oKA6bECgdw0dcXBI0SxaxNWxdU4QztdpleZTFB/Sz9Ms/sMqpKLZCZ36x5Zj7/HmVmPagJIa3XOU3d1rapIPZUIA3Z+h9Urd2vgTySPgKSyKvwBBAvc2l4DhaTYM9iQsn1ays1iF2rl0lV2W8oVfO1mKlTuRsjZ0p7chb9zDQsQyCIkD4MvgUyOYgz9INjVhjHGLoBVftyOQ53yq882hGfIH9SLtnXy33jRStli59zyOWfR0lh7Arp1GsTqWJO9hRv4O+/7vNcvLI/OsdWq+rVxRJMYrnVE2LvUgZMH1NpKUpZUY5FG7L4BBWtUFhLQaSBXc5dAUSBpJnXIRtLGjG+RecrRlx9CLm6mBHqI2k7FkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(7416002)(5660300002)(8936002)(83380400001)(2906002)(38100700002)(8676002)(2616005)(55236004)(53546011)(41300700001)(478600001)(36756003)(186003)(66946007)(76116006)(4326008)(66556008)(91956017)(110136005)(66446008)(6486002)(64756008)(122000001)(316002)(54906003)(31686004)(6512007)(66476007)(38070700005)(71200400001)(6506007)(26005)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWw5c0VDdy84R05ya3R5YkRHVlZWQkVNK1pWSWlsY0VZQXhmU2tnalFMc2Y0?=
 =?utf-8?B?dE9yemlnYjVsL0t3WkVqaStaaHlOT0xTR1JwaFBCaTNvQkQ4bjdTQTVrYjd3?=
 =?utf-8?B?dngzUTNteWdLekFiS0Q0Qno1dk5FOUdFeE9reUFwcjB5N3hCR3lBcEpDQS9D?=
 =?utf-8?B?SFJncmtta1VnVjN0SUpSOHZlb0lxa0ZYQS95WWp2Q1dwcTVVWW1iWU10TjNT?=
 =?utf-8?B?UXBhRTFuemsvT1JzQk14bHV4em5vb0NPT1AwTy9TdmRrUkZ6VkZHRWZhK3RN?=
 =?utf-8?B?M1dSa2NIdUxKRVpmb0UxSU1FTWlPbmwvY1VYRmRRb2xmN1JOVFpFbXN3WHpv?=
 =?utf-8?B?U0svdi9sbTlkdGF0Rm92WWJkT0pXMjgwbm5WdzkybWVkdmJ1bHk2a2R0ZFZN?=
 =?utf-8?B?dXVMZUJXMC9uZ2sycStxTStnWHhyQ0FNOVlDamoxSUdraFZCdnZ2NmtFK0Fz?=
 =?utf-8?B?UkEzOFhNeWFxTzRacWJjd0YwTDZCVlRZd25XdHBrVWtCN1NtMENlWVVmNlJ2?=
 =?utf-8?B?UWU1aXN0cGV1MWFHSUdKVzJ4S3gxWVpFbXhpKzc3NFRKWDlyMGtSV0x0dGlv?=
 =?utf-8?B?N1Eyd3QzUTBsK2pOT2czanZEbEpZWENrMURKREFKZjd5c200aTNBUVowN3A3?=
 =?utf-8?B?elZraDlLNWdlOUpvek9tYVpCbmRjSHdPVW9vWndPay9BRXpDckVIdDE1aHNv?=
 =?utf-8?B?aW1FNEpRVkY5a0VsM1VuNHAvV0lEMDc2MnZiT3NZY1k2dTlJK3JGQXBObzM1?=
 =?utf-8?B?c1I4WEdYcjBjQkZXRUwvMTdUL2syRU9udmtWSlNNVmFoVjZ3N0xVU0xOc3ZO?=
 =?utf-8?B?QzJjVXU0VmZ5NlNaTWo4MGxTRCtrWThBb2xZbnR3eko5NEZ5R0lEYVF1TzI4?=
 =?utf-8?B?aHpORlpZU1lDREFYNElPN1BTMUI1bThwWk55VnRidzR1UjdGWFkyd0JZT0dK?=
 =?utf-8?B?YWErLzlwVUdNcHlwMC8xMExJWXJCa0NrVkVxYW1UN2pxYnFVeVUvdEU1Z3BQ?=
 =?utf-8?B?RlYrS0I4djNVcGU2UVA2RTUzUVY0UHFkZWtjVEIyRnFrUVd6VnZBZGE1dVdG?=
 =?utf-8?B?YnAyeTZoRG5ueVlNcVhnRGFES3k1Qk5McXFlY24wVG1ybkVmVkhhRWFJWUxL?=
 =?utf-8?B?Z25pb1dJejU4bnAwSjhQNCtlQWdYU2VEUFN6YUcrM3JBQTJ3VmJLUUdxY0h5?=
 =?utf-8?B?UmdHWUtzem0rNVNLZ2FSTzNBdzJIaTZFb3lOTWk1dkpEenBoVkxtODdCenBt?=
 =?utf-8?B?VjNtWTRlWHZoRlJYZHQ4cmx3OGh3SEhmaUVwMHNLSTdmM25BNk50blk3MFNK?=
 =?utf-8?B?aFZ5ZGlmTEcxYW15VUtaK3JwbmcwdUhpbUc1QVk5ejhuczRkWnM4M2tJZ2Ry?=
 =?utf-8?B?a0Y2ZUhmM0JZR2R4cndHaDdRUUNRbTVIL2ZMNmlIT2lOejM2T0cvZk1qeVBV?=
 =?utf-8?B?Sk5UMktlQUlid01WWjVBd2IycWtRMVBOZ2RCVU1Jb254SldGVmF0ZjUzN3pH?=
 =?utf-8?B?UXJTK0RrUHkvRmRNL3FGV3gxLzduZlVvSFE2REZaMzBzM3ZLTExNM0dVRGdM?=
 =?utf-8?B?dEpHa3BxRlEveG84a0tJNk1tUjNodzh3aFg5VUxSVDI5dkQrL0dQTE5kUXdU?=
 =?utf-8?B?VVE1cUlCRU1hdGdxU0FsL0YrL0cxelQyb1RGeTdTK3Nrak5ZL3JidU1VS090?=
 =?utf-8?B?OWJFWEJocGxrdXQyK0VtcTNrWnorRmd4QWR5SjJFdWhySWNKTmhiUk5tcVpr?=
 =?utf-8?B?OWdGTmxtR3laRS9jcEJZL3NZZVlkR3FtajdWTVAzVzViYWxYdXdpcWpva3d3?=
 =?utf-8?B?SnFZaWFQZENPSEx5V2czMmtCajZ5NXNud3l4eTAxclFCc2pQUmNVZWZ3dmhQ?=
 =?utf-8?B?VjFlOW1zMDdnTUVYSTdUcjNrck5xTXIyd3RoSCtPejNiM3JuT1h0NWhOT0Q1?=
 =?utf-8?B?T2UyazUxOGJJREdud0V6dlNkSVAwWUJtTGdheWZZOE1PSTNSQTgzUTQvWThw?=
 =?utf-8?B?Tk9VRmI0cEJQRWV0Y3VHd2JRTjFkZlRyS2RYM08yUnUwZ0FCTmVXQVB1bG84?=
 =?utf-8?B?VStOMWM3dDlRZXJUVDAyY0hzQmxFNXd1RGFraWQ1cUxwcEpTMHdEWkdrbHhs?=
 =?utf-8?B?ckNaUDlzY0JwRWZmQjZnR0FnZ3VCTmUvQytpZmlLZ21wWS9pbzdlR1E1dXhV?=
 =?utf-8?Q?/+KOMW8jPsvXCNVRuF234PE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <898A89F318143644A91134F73E8283F8@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20e52a5-0149-4e4a-75b2-08daa7b46e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:04:21.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpFMz549rx2bhlM8HmKVjpC+wvBTnZ2QOiygCXXxZjISUKVY0FVRtgnQ6EgTiKAQFpzOrEnlhGvRXZwLq/RfycQPGerLrC3hvl+VfKAAYYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8875
X-Proofpoint-ORIG-GUID: Z7CIxC1cqpqdPoj5pgTJG55FMgidRLMv
X-Proofpoint-GUID: Z7CIxC1cqpqdPoj5pgTJG55FMgidRLMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNi4xMC4yMiAxMDoxNSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCj4gVXNlIGFuIHg4Ni1zcGVjaWZpYyB2aXJ0aW9fY2hlY2tfbWVtX2FjY19jYigpIGZv
ciBYZW4gaW4gb3JkZXIgdG8gc2V0dXANCj4gdGhlIGNvcnJlY3QgRE1BIG9wcy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiAtLS0NCj4gICBh
cmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jIHwgIDIgKy0NCj4gICBhcmNoL3g4Ni94ZW4vZW5s
aWdodGVuX3B2LmMgIHwgIDIgKy0NCj4gICBkcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgIHwg
MTAgKysrKysrKysrKw0KPiAgIGluY2x1ZGUveGVuL3hlbi1vcHMuaCAgICAgICAgfCAgMSArDQo+
ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9odm0uYyBiL2FyY2gveDg2L3hl
bi9lbmxpZ2h0ZW5faHZtLmMNCj4gaW5kZXggMWMxYWM0MTg0ODRiLi5jMWNkMjhlOTE1YTMgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMNCj4gKysrIGIvYXJjaC94
ODYveGVuL2VubGlnaHRlbl9odm0uYw0KPiBAQCAtMjEyLDcgKzIxMiw3IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCB4ZW5faHZtX2d1ZXN0X2luaXQodm9pZCkNCj4gICAJCXJldHVybjsNCj4gICANCj4g
ICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpKQ0KPiAtCQl2
aXJ0aW9fc2V0X21lbV9hY2NfY2IodmlydGlvX3JlcXVpcmVfcmVzdHJpY3RlZF9tZW1fYWNjKTsN
Cj4gKwkJdmlydGlvX3NldF9tZW1fYWNjX2NiKHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNj
KTsNCj4gICANCj4gICAJaW5pdF9odm1fcHZfaW5mbygpOw0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5j
DQo+IGluZGV4IDliMWE1OGRkYTkzNS4uNDViMjRjMWI2NDZhIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni94ZW4vZW5saWdodGVuX3B2LmMNCj4gKysrIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9w
di5jDQo+IEBAIC0xMTIsNyArMTEyLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHhlbl9wdl9pbml0
X3BsYXRmb3JtKHZvaWQpDQo+ICAgew0KPiAgIAkvKiBQViBndWVzdHMgY2FuJ3Qgb3BlcmF0ZSB2
aXJ0aW8gZGV2aWNlcyB3aXRob3V0IGdyYW50cy4gKi8NCj4gICAJaWYgKElTX0VOQUJMRUQoQ09O
RklHX1hFTl9WSVJUSU8pKQ0KPiAtCQl2aXJ0aW9fc2V0X21lbV9hY2NfY2IodmlydGlvX3JlcXVp
cmVfcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gKwkJdmlydGlvX3NldF9tZW1fYWNjX2NiKHhlbl92
aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gICANCj4gICAJcG9wdWxhdGVfZXh0cmFfcHRl
KGZpeF90b192aXJ0KEZJWF9QQVJBVklSVF9CT09UTUFQKSk7DQo+ICAgDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3Bz
LmMNCj4gaW5kZXggYTAwMTEyMjM1ODc3Li42MGE3YWNjMzM0ZWQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEt
b3BzLmMNCj4gQEAgLTM3Miw2ICszNzIsMTYgQEAgdm9pZCB4ZW5fZ3JhbnRfc2V0dXBfZG1hX29w
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCWRldl9lcnIoZGV2LCAiQ2Fubm90IHNldCB1cCBY
ZW4gZ3JhbnQgRE1BIG9wcywgcmV0YWluIHBsYXRmb3JtIERNQSBvcHNcbiIpOw0KPiAgIH0NCj4g
ICANCj4gK2Jvb2wgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2Moc3RydWN0IHZpcnRpb19k
ZXZpY2UgKmRldikNCj4gK3sNCj4gKwlib29sIHJldCA9IHhlbl92aXJ0aW9fbWVtX2FjYyhkZXYp
Ow0KDQoNClRoZSBncmFudCB1c2FnZSBpcyBtYW5kYXRvcnkgZm9yIFBWIGd1ZXN0cywgcmlnaHQ/
DQoNClRoZW4geGVuX3ZpcnRpb19tZW1fYWNjKCkgc2hvdWxkIGFsd2F5cyByZXR1cm4gdHJ1ZSBm
b3IgUFYgZ3Vlc3RzIChJIA0KbWVhbiBldmVuIGlmIENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dS
QU5UIGlzIG5vdCBzZXQpLg0KDQoNCg0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJeGVuX2dyYW50
X3NldHVwX2RtYV9vcHMoZGV2LT5kZXYucGFyZW50KTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+
ICt9DQo+ICsNCj4gICBNT0RVTEVfREVTQ1JJUFRJT04oIlhlbiBncmFudCBETUEtbWFwcGluZyBs
YXllciIpOw0KPiAgIE1PRFVMRV9BVVRIT1IoIkp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNv
bT4iKTsNCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3hlbi94ZW4tb3BzLmggYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gaW5kZXggZGFlMGYzNTBj
Njc4Li4zZGQ1YWE5MzZmMWQgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUveGVuL3hlbi1vcHMuaA0K
PiArKysgYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gQEAgLTIxOSw2ICsyMTksNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgeGVuX3ByZWVtcHRpYmxlX2hjYWxsX2VuZCh2b2lkKSB7IH0NCj4gICB2
b2lkIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICAgYm9v
bCB4ZW5faXNfZ3JhbnRfZG1hX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgIGJvb2wg
eGVuX3ZpcnRpb19tZW1fYWNjKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOw0KPiArYm9vbCB4
ZW5fdmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2FjYyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsN
Cj4gICAjZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fZ3JhbnRfc2V0dXBfZG1hX29w
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgew0KDQoNCkFuZCBwcm9iYWJseSBzdGF0aWMgaW5s
aW5lIHN0dWIgYWx3YXlzIHJldHVybmluZyBmYWxzZSBpZiANCkNPTkZJR19YRU5fR1JBTlRfRE1B
X09QUyBpcyBub3Qgc2V0Lg0KDQoNCi0tIA0KUmVnYXJkcywNCg0KT2xla3NhbmRyIFR5c2hjaGVu
a28NCg==
