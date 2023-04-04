Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F36D681D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjDDQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjDDQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:00:17 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C983444AE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:00:10 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334E34CU009007;
        Tue, 4 Apr 2023 15:37:01 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3prnabrcac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 15:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi8KtCpTfwUune7wIX/QAE4BEQFpCNh3rzeu2BOTZIATozlX0m6N2HUQLtu7QOm1jAFebugUMMtx3vMXcOVIbW0RMyqTVvZskEnKcuFMuVOgHSSHban9LNa1Bc+d6cHRDtLtbv0qZSpYFOJoIEVfoGZyVvUls6ftq4hMjx84DRPd2Y4l93NTCP70uTDYTi1owYosILU6Pqbk/M7mIYLhrum6yoCldQZqJF5oNOkLZISBIY7UXqKiwhxlryYr70ywlBUjuns0HXkK24uwN0GxQ8ATEmiGaknXX6IE1ovO14w/vwyoJab36MJ681aQZ4T2jWQblgiJo6y1aoboBY+G5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKocZPDzP6zaQ8YHNKIM3Zxni4FGkO63dFSN+bSbAcI=;
 b=XeIuYHJ+2YvxozHs3wLpoGwpazeDCImpnUX6mve2efRBXjOD1n8KW8hoKHfS6AEFboefL4ycbGzgKpJR0uJShIE49eZokyMSyspNWgXRiTZyHtIspg2KNOX9ST3Ob3gBCK14iimnEo1IurmkPhfXiZhKyeeLZ2xt00s3hpFqpcsNNBRKkL0N7e53nbsw7YBsgoHnnFNML4+GbpeFhZwKtMR7puyAdtRLZms3/Zfe8/H0xGbzGV2AsVxy2jZgLnlzn5SU/Hm8E8nB8ZgoNhdc/Kb6cHKXm5+EmwZt0ILGvA/jYLORB4iK1Hho9x7O/0tftI1u2g8I3Rh+ej+98hl8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKocZPDzP6zaQ8YHNKIM3Zxni4FGkO63dFSN+bSbAcI=;
 b=kcKyWQn+/AvvdxoDRYVzcjAmAyqLDAxzjC9wX/xwNXV7Ti9bSxCVRmHd0saO+hsvy5HO7LsHEGlEDg8kHUvEsXEyevk/wYHFIouuyHtTYypPrU2iMv3oPy3pLj1FEQmRMftiVht7tucpmotLVGQZL8pD6anZrFfbuhpoCj6+FbG7ARoe5FwHFn45ROWbu5ojRQ89eEa4nvAt4yslumEPJSYBatO9QVlfjUNlraPJh8K4GwlUtqnIgvom5puXE5By7EgNploIUM2Fwbz0Cpqn8JK2F2RG/GNNj7aiDLiNJq6WNy7ONCdKwUVIjmVzz+aJagOgKRKEGL9Cx5L5QIufeA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM7PR03MB6497.eurprd03.prod.outlook.com (2603:10a6:20b:1be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 15:36:58 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 15:36:58 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Dan Carpenter <error27@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xen/pvcalls: don't call bind_evtchn_to_irqhandler()
 under lock
Thread-Topic: [PATCH v2] xen/pvcalls: don't call bind_evtchn_to_irqhandler()
 under lock
Thread-Index: AQHZZg59s4tqkaRFM0qaTjkzIaVOrq8bSm4A
Date:   Tue, 4 Apr 2023 15:36:57 +0000
Message-ID: <9c0b195d-181e-f34c-6b42-7d7e75da901c@epam.com>
References: <20230403092711.15285-1-jgross@suse.com>
In-Reply-To: <20230403092711.15285-1-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM7PR03MB6497:EE_
x-ms-office365-filtering-correlation-id: ff1414c5-0aad-4191-ae65-08db35226d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1Lsuo6gRzWGatT5cniIW8jID8dsTDsOrvA5vmzYgACLvLH/jm79dh9F6vGMsvuIjkxXgEbSS9VDyc63eysEiNMi7/BRGNroZytDLhRj3WkHEPtDdH1FbFeJ3hsqjY8AtWOdoYnWiR2qOXAhbl3WY4MyUE55Ddcx4tK4bS43JK80wYzMavkkCPYi5i1P2A8d5xBucEI0f/rKAV1GryUR/xN+/vXWuAXX06euXtkGBNoEzKSxy/cjChzP6f6fUflUkRpNdMS5JnkXVVna5mC3VJPveLlXE65naZVGHvC623xGWcsTyIWMmS2uJunNC2Z3xVgBUv11hCDT23KMXnrY0fKybuos01VG9HHmCjfFcU1MVmgQkjIXtJ7HLISgpH7fOZTPl2GEWUcL2tIxDOX9xTfr74ZTojN0RWyTDyAl0r9BVf6S/+UCXM+T3CLV7K9S6VnwNf+TSP1NYSx6XaYiLdfQ1Ie5M6ngTfYLYcnemJ4643w+1EegXD2fLMJTiJGX0/F9C9wp2WUbFbW3A3ij3Z0XrrwiyZE8NrWCAQH/fbtTT6xydRrEhgtv2eKpKjEToN1xMfYB9yB/fHPuzpDK0xbqoM6esZ3kWXsAb4XMa6bnlYt6wxDUgs352B/5aYLm4JvaqEYo6KNtDj9lVV9hhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(66946007)(6486002)(6506007)(53546011)(6512007)(26005)(83380400001)(2616005)(966005)(122000001)(66446008)(66476007)(66556008)(38100700002)(41300700001)(71200400001)(31686004)(186003)(54906003)(316002)(478600001)(2906002)(31696002)(86362001)(91956017)(4326008)(64756008)(76116006)(8676002)(6916009)(5660300002)(38070700005)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUFWUEFSWGRaa3N6eWNaNXhCT0w3RDhJOFE2Z1ZBRVBnenphTFBGS3lvVVls?=
 =?utf-8?B?Vkh4YVNmNlZEZE9RK0djUC9VUVREWTU2RWExRUNQaU9rZTJISkdwSVh0ZUlV?=
 =?utf-8?B?Vk1YaEZjZFhVWmUxMEIxdkI4bnRCSWFkWmxmb0lJRlp3SC9mT3lTZnZleXNu?=
 =?utf-8?B?Um9nRFpNejQxTzFPcllBNENOTDBLdjN5UnNLaTE1d3VseU5JVDFwbExlSWxa?=
 =?utf-8?B?b2pweGE0Tk44a3VPeitOeVU5cVJVOTdmajBJV0NZSjlWWXZJWWVZaVhrK25k?=
 =?utf-8?B?RndmM1RuNzMxZ2tFWjVHdCtycXJoRGRzVUZvcFY0RDlldGYxWnlzV2JDNXlv?=
 =?utf-8?B?U05TbFEwY2RESEVGdENGRG9JeUdlZmRhcEllUHRkaGp4K09IOGZMYjd5ZWVL?=
 =?utf-8?B?eE9acW9telVBYitsdEZ4dVpsRXp2RWRQMVNscU5iVk1mbkhFUmZ6OFZPbEVN?=
 =?utf-8?B?YzJHRFQwWHdIMWtwaCszWkV1NVlrR0FMcmVyU00xTG8xRzBjYzNqbHZ2bVNn?=
 =?utf-8?B?MkZoRlVVNnVyWWN3OE52L0NzbUVQNk1adTlMcDNxU0xqSktZdWFMVWFNRVVM?=
 =?utf-8?B?T2J1WjR0ZVFsdHd4RDZuL21SUkpqNFJPR1FNSDNrTStHNTM4b1hFWmxoOGhh?=
 =?utf-8?B?TkIvMXhyZ2E4R2wvbFNkb21YdFk3dzZBSk1qRXlBWHBlOXVPTGJFTkhEMkRT?=
 =?utf-8?B?TWc5WUlOMld0RWtibnB0RXBXcVJrTUt6UW9UOTFuTkdrVzg0VW95NjF6bkc1?=
 =?utf-8?B?aHJjaWtzZUNkQnJhOUhCWXZLVVFMSHorUGIraENlTlZ2OVdJZWd3NFFQWFdK?=
 =?utf-8?B?WDNqN2s2Q3l1Zm9KdnNEcXloV3A2bFdCRmYwVldBOUVVZnZvL3ZteVErenRo?=
 =?utf-8?B?L0hzdmZ2RzAvRG1JYUpqckZDdTloV0ZkTlFOOTdRaWZMQVo5eGJtN1RldVRZ?=
 =?utf-8?B?dXl2UjMydXk0Y2ZLalJCenFSRG5CWjZVVitmRnJwdmt0ZnZQL2twOW1VV2s2?=
 =?utf-8?B?Q3R1L3ZNY1RPNkh0Q01xbkVJOXh5Q1ZpQXg2Y0o1R2hyTzlENi9Ld3pTUU1u?=
 =?utf-8?B?dk1sRm1YZ09wRjRCUGxvWHNSVmQyT0EyY3BtOFo2ajk4S0xwSGxDUzUyM0o1?=
 =?utf-8?B?UVBYc05xakRJemlNZCtsOVNHVjNnWVBCdkM4U1AzNmVUamFRTWRIekRiOXgr?=
 =?utf-8?B?U3BERlpYemJuNURPb0N5bytwbWtCdHlkN0tnVDZJYWE2NnoxSzFhWHBuUkZv?=
 =?utf-8?B?NmtxT3dqTDY2cS82eXQ4czY5SmU1eThObllrWG5aUmVhWXlPcEkvNVFxcWJE?=
 =?utf-8?B?VlZQNGVVR0R1cGFNRkp5WCtQQ2VyL2tWTEFRR2JUOUtjdStJZS9qMWFZOG5a?=
 =?utf-8?B?ZytYYXNERUd5ck8vY25zNnNMVVlUSDdwQWhjUmgyYTRicVh5VmFYRU1KdEdH?=
 =?utf-8?B?SHJvUGZTSjNnQU4zblVpVmkxSHRjd3Ira29EbXp3TC9hK01QYldxVmVSUE9F?=
 =?utf-8?B?MEJsUXBNc0lBclZZd2RBNjRMbkczVURSZkwzZm5FSHVzbHNnUHljNTVWUGhV?=
 =?utf-8?B?a0tGVVlIekw3N0wvTmdKdnBMQVdxY0hEL093bFhUamhTcXQ5VGFDdmkrNVlC?=
 =?utf-8?B?ck5lWStST0pCZldibGNSRW12Vld5Y2tBa3lxWXdLb1FvN1ZEMXNSWVppbkov?=
 =?utf-8?B?eUxWRk1OdVZ2NW1EMmlEcnlOWURWcHo3ZklEZk9BaGtlVTBNdVVTL2hTRFNm?=
 =?utf-8?B?QXJkMXo1MDRVVEM4MjBmWE15cldELzFqK1VhRkhaM25KSUhZOGMvbFV3UGJt?=
 =?utf-8?B?bTUwWE1MdFQ1VFdXUnNBa3p2bTV4cnprUVB6ZUF4SlE0eTYrdzhuUEEwb0ZO?=
 =?utf-8?B?L1lvZXpEVEJqTUpVQkNEWkZHSTA3bnorYklPNXArcWd5ek9nUDBVc1V1T2U0?=
 =?utf-8?B?OHByZ2YzSTFjUjYzUHcwY1FleE5BRHZrSTR0bzBnQkZ6VHdIc3hWcGlRU3F2?=
 =?utf-8?B?RGpXRUVpSnhWSkFWQzY3K1JDbDNBSi9mMXZseTlnbDl0S3drSXU0cmd4ZVIx?=
 =?utf-8?B?Y09KL2RCbzJQQnIweDVNUmViSkdWbnBxVEV4SnVoYUl0UXVLcUdidU5Lc01q?=
 =?utf-8?B?QS82ZjcwY0ZVbm8yOGQ4T1dZRkVwQVlndDdzbjlYN3RXZ0VhbE1kZzBHaUhS?=
 =?utf-8?Q?OgR1sj3/VJJGxZ10EO7xG1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79D6B25CF8F4024C906AC9FE71CB979D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1414c5-0aad-4191-ae65-08db35226d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 15:36:58.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heFIkc22fH/IuXh4nrj466lbfx7hM1xyKvNw0Nbl7mck+r3PePMDcUmJY+NqNJ+vLgXYG4oIXBLigLA2qySVJrM8AdXmZX2GlMJI2ssZRJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6497
X-Proofpoint-ORIG-GUID: YrqL6bX1DrWCmLv2kdDaV9yGdaEas3wu
X-Proofpoint-GUID: YrqL6bX1DrWCmLv2kdDaV9yGdaEas3wu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_07,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=769 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040144
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAzLjA0LjIzIDEyOjI3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBiaW5kX2V2dGNobl90b19pcnFoYW5kbGVyKCkgc2hvdWxkbid0IGJlIGNhbGxl
ZCB1bmRlciBzcGlubG9jaywgYXMgaXQNCj4gY2FuIHNsZWVwLg0KPiANCj4gVGhpcyByZXF1aXJl
cyB0byBtb3ZlIHRoZSBjYWxscyBvZiBjcmVhdGVfYWN0aXZlKCkgb3V0IG9mIHRoZSBsb2NrZWQN
Cj4gcmVnaW9ucy4gVGhpcyBpcyBubyBwcm9ibGVtLCBhcyB0aGUgd29yc3Qgd2hpY2ggY291bGQg
aGFwcGVuIHdvdWxkIGJlDQo+IGEgc3B1cmlvdXMgY2FsbCBvZiB0aGUgaW50ZXJydXB0IGhhbmRs
ZXIsIGNhdXNpbmcgYSBzcHVyaW91cyB3YWtlX3VwKCkuDQo+IA0KPiBSZXBvcnRlZC1ieTogRGFu
IENhcnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1kqSlVJbDY0VURtZGtib2hA
a2FkYW0vX187S3chIUdGXzI5ZGJjUUlVQlBBIXdUeVUwMzJQUVB4cWxwSWZ1V1J3Yi1EWUUxSzhQ
MGJSV0p5SklDYTdJRWJBd1EwX2FlWndrbkFXd3hKX2N2X3RXR1k0MmY1TlBnbjZKSHRac2lHUCQg
W2xvcmVbLl1rZXJuZWxbLl1vcmddDQo+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4NCj4gLS0tDQo+IFYyOg0KPiAtIHJlbW92ZSBzdGFsZSBzcGluX3VubG9j
aygpIChPbGVrc2FuZHIgVHlzaGNoZW5rbykNCg0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5
c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KDQoNCg0KPiAtLS0NCj4g
ICBkcml2ZXJzL3hlbi9wdmNhbGxzLWZyb250LmMgfCA0NiArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIw
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3B2Y2FsbHMtZnJv
bnQuYyBiL2RyaXZlcnMveGVuL3B2Y2FsbHMtZnJvbnQuYw0KPiBpbmRleCBkNWQ1ODliZGEyNDMu
LmI3MmVlOTM3OWQ3NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vcHZjYWxscy1mcm9udC5j
DQo+ICsrKyBiL2RyaXZlcnMveGVuL3B2Y2FsbHMtZnJvbnQuYw0KPiBAQCAtMjI3LDIyICsyMjcs
MzAgQEAgc3RhdGljIGlycXJldHVybl90IHB2Y2FsbHNfZnJvbnRfZXZlbnRfaGFuZGxlcihpbnQg
aXJxLCB2b2lkICpkZXZfaWQpDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZnJlZV9hY3RpdmVfcmlu
ZyhzdHJ1Y3Qgc29ja19tYXBwaW5nICptYXApOw0KPiAgIA0KPiAtc3RhdGljIHZvaWQgcHZjYWxs
c19mcm9udF9mcmVlX21hcChzdHJ1Y3QgcHZjYWxsc19iZWRhdGEgKmJlZGF0YSwNCj4gLQkJCQkg
ICBzdHJ1Y3Qgc29ja19tYXBwaW5nICptYXApDQo+ICtzdGF0aWMgdm9pZCBwdmNhbGxzX2Zyb250
X2Rlc3Ryb3lfYWN0aXZlKHN0cnVjdCBwdmNhbGxzX2JlZGF0YSAqYmVkYXRhLA0KPiArCQkJCQkg
c3RydWN0IHNvY2tfbWFwcGluZyAqbWFwKQ0KPiAgIHsNCj4gICAJaW50IGk7DQo+ICAgDQo+ICAg
CXVuYmluZF9mcm9tX2lycWhhbmRsZXIobWFwLT5hY3RpdmUuaXJxLCBtYXApOw0KPiAgIA0KPiAt
CXNwaW5fbG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+IC0JaWYgKCFsaXN0X2VtcHR5KCZt
YXAtPmxpc3QpKQ0KPiAtCQlsaXN0X2RlbF9pbml0KCZtYXAtPmxpc3QpOw0KPiAtCXNwaW5fdW5s
b2NrKCZiZWRhdGEtPnNvY2tldF9sb2NrKTsNCj4gKwlpZiAoYmVkYXRhKSB7DQo+ICsJCXNwaW5f
bG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+ICsJCWlmICghbGlzdF9lbXB0eSgmbWFwLT5s
aXN0KSkNCj4gKwkJCWxpc3RfZGVsX2luaXQoJm1hcC0+bGlzdCk7DQo+ICsJCXNwaW5fdW5sb2Nr
KCZiZWRhdGEtPnNvY2tldF9sb2NrKTsNCj4gKwl9DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkg
PCAoMSA8PCBQVkNBTExTX1JJTkdfT1JERVIpOyBpKyspDQo+ICAgCQlnbnR0YWJfZW5kX2ZvcmVp
Z25fYWNjZXNzKG1hcC0+YWN0aXZlLnJpbmctPnJlZltpXSwgTlVMTCk7DQo+ICAgCWdudHRhYl9l
bmRfZm9yZWlnbl9hY2Nlc3MobWFwLT5hY3RpdmUucmVmLCBOVUxMKTsNCj4gICAJZnJlZV9hY3Rp
dmVfcmluZyhtYXApOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBwdmNhbGxzX2Zyb250X2Zy
ZWVfbWFwKHN0cnVjdCBwdmNhbGxzX2JlZGF0YSAqYmVkYXRhLA0KPiArCQkJCSAgIHN0cnVjdCBz
b2NrX21hcHBpbmcgKm1hcCkNCj4gK3sNCj4gKwlwdmNhbGxzX2Zyb250X2Rlc3Ryb3lfYWN0aXZl
KGJlZGF0YSwgbWFwKTsNCj4gICANCj4gICAJa2ZyZWUobWFwKTsNCj4gICB9DQo+IEBAIC00MzMs
MTkgKzQ0MSwxOCBAQCBpbnQgcHZjYWxsc19mcm9udF9jb25uZWN0KHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4gICAJCXB2Y2FsbHNfZXhpdF9zb2NrKHNvY2sp
Ow0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJfQ0KPiAtDQo+IC0Jc3Bpbl9sb2NrKCZiZWRhdGEt
PnNvY2tldF9sb2NrKTsNCj4gLQlyZXQgPSBnZXRfcmVxdWVzdChiZWRhdGEsICZyZXFfaWQpOw0K
PiArCXJldCA9IGNyZWF0ZV9hY3RpdmUobWFwLCAmZXZ0Y2huKTsNCj4gICAJaWYgKHJldCA8IDAp
IHsNCj4gLQkJc3Bpbl91bmxvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPiAgIAkJZnJlZV9h
Y3RpdmVfcmluZyhtYXApOw0KPiAgIAkJcHZjYWxsc19leGl0X3NvY2soc29jayk7DQo+ICAgCQly
ZXR1cm4gcmV0Ow0KPiAgIAl9DQo+IC0JcmV0ID0gY3JlYXRlX2FjdGl2ZShtYXAsICZldnRjaG4p
Ow0KPiArDQo+ICsJc3Bpbl9sb2NrKCZiZWRhdGEtPnNvY2tldF9sb2NrKTsNCj4gKwlyZXQgPSBn
ZXRfcmVxdWVzdChiZWRhdGEsICZyZXFfaWQpOw0KPiAgIAlpZiAocmV0IDwgMCkgew0KPiAgIAkJ
c3Bpbl91bmxvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPiAtCQlmcmVlX2FjdGl2ZV9yaW5n
KG1hcCk7DQo+ICsJCXB2Y2FsbHNfZnJvbnRfZGVzdHJveV9hY3RpdmUoTlVMTCwgbWFwKTsNCj4g
ICAJCXB2Y2FsbHNfZXhpdF9zb2NrKHNvY2spOw0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJfQ0K
PiBAQCAtODIxLDI4ICs4MjgsMjcgQEAgaW50IHB2Y2FsbHNfZnJvbnRfYWNjZXB0KHN0cnVjdCBz
b2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQgKm5ld3NvY2ssIGludCBmbGFncykNCj4gICAJCXB2
Y2FsbHNfZXhpdF9zb2NrKHNvY2spOw0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJfQ0KPiAtCXNw
aW5fbG9jaygmYmVkYXRhLT5zb2NrZXRfbG9jayk7DQo+IC0JcmV0ID0gZ2V0X3JlcXVlc3QoYmVk
YXRhLCAmcmVxX2lkKTsNCj4gKwlyZXQgPSBjcmVhdGVfYWN0aXZlKG1hcDIsICZldnRjaG4pOw0K
PiAgIAlpZiAocmV0IDwgMCkgew0KPiAtCQljbGVhcl9iaXQoUFZDQUxMU19GTEFHX0FDQ0VQVF9J
TkZMSUdIVCwNCj4gLQkJCSAgKHZvaWQgKikmbWFwLT5wYXNzaXZlLmZsYWdzKTsNCj4gLQkJc3Bp
bl91bmxvY2soJmJlZGF0YS0+c29ja2V0X2xvY2spOw0KPiAgIAkJZnJlZV9hY3RpdmVfcmluZyht
YXAyKTsNCj4gICAJCWtmcmVlKG1hcDIpOw0KPiArCQljbGVhcl9iaXQoUFZDQUxMU19GTEFHX0FD
Q0VQVF9JTkZMSUdIVCwNCj4gKwkJCSAgKHZvaWQgKikmbWFwLT5wYXNzaXZlLmZsYWdzKTsNCj4g
ICAJCXB2Y2FsbHNfZXhpdF9zb2NrKHNvY2spOw0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJfQ0K
PiAgIA0KPiAtCXJldCA9IGNyZWF0ZV9hY3RpdmUobWFwMiwgJmV2dGNobik7DQo+ICsJc3Bpbl9s
b2NrKCZiZWRhdGEtPnNvY2tldF9sb2NrKTsNCj4gKwlyZXQgPSBnZXRfcmVxdWVzdChiZWRhdGEs
ICZyZXFfaWQpOw0KPiAgIAlpZiAocmV0IDwgMCkgew0KPiAtCQlmcmVlX2FjdGl2ZV9yaW5nKG1h
cDIpOw0KPiAtCQlrZnJlZShtYXAyKTsNCj4gICAJCWNsZWFyX2JpdChQVkNBTExTX0ZMQUdfQUND
RVBUX0lORkxJR0hULA0KPiAgIAkJCSAgKHZvaWQgKikmbWFwLT5wYXNzaXZlLmZsYWdzKTsNCj4g
ICAJCXNwaW5fdW5sb2NrKCZiZWRhdGEtPnNvY2tldF9sb2NrKTsNCj4gKwkJcHZjYWxsc19mcm9u
dF9mcmVlX21hcChiZWRhdGEsIG1hcDIpOw0KPiAgIAkJcHZjYWxsc19leGl0X3NvY2soc29jayk7
DQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAgIAl9DQo+ICsNCj4gICAJbGlzdF9hZGRfdGFpbCgmbWFw
Mi0+bGlzdCwgJmJlZGF0YS0+c29ja2V0X21hcHBpbmdzKTsNCj4gICANCj4gICAJcmVxID0gUklO
R19HRVRfUkVRVUVTVCgmYmVkYXRhLT5yaW5nLCByZXFfaWQpOw==
