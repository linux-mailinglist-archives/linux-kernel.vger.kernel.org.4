Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FFA612A66
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJ3LnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:43:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF24B7FF;
        Sun, 30 Oct 2022 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667130195; x=1698666195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S98G+QlWj3/2J0d8CtM+UI4q8yOW14fPkRCsZR5NUs4=;
  b=m+QhOdAnuRmHd1tM7/2JaPMkZlPT0wjfGk6dPRT3PywhuTRAjLUoXCdN
   03FwlnwM+zNB4fZ0o7Zrz0Jw5UtWfFpqKrvRUEiNEvgGOsmwciXPYsXkK
   ga+ARMA7uuceNmlJww9/r1jDvnmOwGlLraQWx9yWiHPEpp8ktgw/uMRVe
   qcLeZYoxG0TxSZy7G4TxYy2oVwm043TnZuOViMqjMNdGFeqSo7tCi8jxr
   XVCDGG0cUlDEBXhbI+s84Gf5y+YnRPLJpbdvXXwsgaREov0gK/WO/hQPL
   bmfDzC6RwNZQK2auOVhZxtEh4RZTycgcATDYhwd/fNUhOYSsn6esF8JDB
   A==;
X-IronPort-AV: E=Sophos;i="5.95,225,1661788800"; 
   d="scan'208";a="215419269"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 19:43:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7hBWxmvTrbTr/ccxM+0q8OS4o0QM3+kxovWMWg7pncoXy77XFx06zhuSufX7g1kjOxX5YB2wdhbeaxSx8UJNy2Yl5/wx6sdke9OPLDt9roiFLSbJGqWyG9k8etLGunxAZskibFbSqIkQQ5EcJ4vD9wgF513drcDYgSgo7tah5u1buW/OLenyeh0u82CNNxFRHrIuqpp8K3r3mbQA+7NPbWq0kX7Xfpe9lG8oE9bcN4yKHi8lT3eNb0s+BUsd+bAZSJWT43ODonX5t8ClV+nHrH8r1M771lhCwxirvA91jKIDKtEdyElS6KAaao0aDxuH69sy9oarEEzpGl5c5+9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S98G+QlWj3/2J0d8CtM+UI4q8yOW14fPkRCsZR5NUs4=;
 b=EEV/grKsvv5/yFffPE2tGACTXc4SmqVxdQOq+FX1tQDi/Bc13gBi+dNVMSS3oKgDnrpw8otjfqIWzK4jDl3RTxWFpf6osBcM+/oMaBauPuaQWXUJUP6T5Ncb/3XWggE7uchRyMgxpkw6Rc3w5eMckgEVadg2CFP4q62M/frPefOqz2l/t9eEE6gBrAjl5eFq22wrPUPii/uGQzC5lO7U9gt8FFFGvOErhjT4vLQiREAOsXnaUebgjrgf5xUctEWcWWrwwyT5QuUy1klj3/8o8/hWHaMbxMll23pDedcdHB//2rsJQl+omyHw0nDzlAv+xO1tO0Xf38wCvTYiHiYoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S98G+QlWj3/2J0d8CtM+UI4q8yOW14fPkRCsZR5NUs4=;
 b=r6Fql3j4ofJS+OMQbthtdVgDsD77KOkALKVfX8fGz6fRS4hkU+TMIGo2vOAsmm/6uhkBAkRsk+B0rjET15yJoP4SYN6ViT/92d6aqB2wJmRsFvWYjPQj6Um/8tQrD1bkXhPgmAuDRnC2S9MOK0B/WbzEz8zThvo81Ncehe0YrcQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5601.namprd04.prod.outlook.com (2603:10b6:408:a2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Sun, 30 Oct 2022 11:43:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151%4]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 11:43:10 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Thread-Topic: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Thread-Index: AQHY5K6rndcpzlodjkGA4xYfvgUpFq4i01SAgAQMRoA=
Date:   Sun, 30 Oct 2022 11:43:10 +0000
Message-ID: <DM6PR04MB6575D8A39219420494192B76FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
 <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
In-Reply-To: <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5601:EE_
x-ms-office365-filtering-correlation-id: d671d9b5-a274-4ed8-ac54-08daba6beb88
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0TxafUxUOsHcfFh/weDkOq2Ys+Leq04FOe+PQ0p6QHsMgoKRdM40IPYQVSs2T+PN+/KSVAXRJcvENfw17+RZkkO2Bq5WP/p5NXMM97qcmJUYWyk3rwdR8T/jO4Xc0T+Crwq+YUnp5c4AQdmaAjHjojBlH7HKREqO41Ceku09qXRri5QT7gqSHk8lf9x+5TTwjB0BiOCloq4+wzJk8sEqJx5XQaWQoxathRVKAdazeRaDEgFiOKMxqklAim10UKxW7wXyJfkNLsVYdv027e1ftxT6QbbflRE6y13xSTW5RHHP+lOWhZSclZBx356YHdUB5dprWUNaGVGmaiQD8GIKl1kyzm12/b0llkk+4W9UnOO/JCjArHkMC9zLK7HAlA/zNvZyF3kTKwf/S7m1zi5q8PfOMHBOSk6nH/7PJrjiWnFID86y7u1k+tgUcK+A1MO8wbQOCPYHrjVcXIbbIGjhZKU5/ip1X6ga3GdxEE78qrVmM/BHL5CGpV4snn1AQcA50gkp9aHdcR92wwNqs72Q8YNoWzPjrv7pzdIGOwg/wd5HliA9YdiQ2Kvtzl7fAx7hKZPOMp8wQ6DE8lxOQzdyWvtA3Y5sOSPvT9iZSIYgFaY/au93tX/0u6o/QM6DXlRq0SS7Nuke7PAOp7SjwfH6jVuFkc05NK21E1RV7y4P/N3Mop8IT/uEgCvbDVRyMHvtL79o1eFaQwUNPIrUPK4YLE32kxEWm/2+l7cbqI1uW1gU0i3iV+Vycr3O8kOOeaNxT9kguygrmablBFZwcJS0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39850400004)(451199015)(53546011)(7696005)(6506007)(26005)(186003)(9686003)(478600001)(2906002)(71200400001)(38070700005)(122000001)(82960400001)(38100700002)(86362001)(55016003)(33656002)(7416002)(66446008)(110136005)(8936002)(52536014)(41300700001)(316002)(54906003)(66556008)(66476007)(5660300002)(66946007)(76116006)(64756008)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBIajVNTUdOUGF5V3VUVTZ1aEVUeWllZEVNL2NFdW9Jd2M3cEZQNnN5VGov?=
 =?utf-8?B?YTFGQzRKb2ZHaGZnalVsL0NaRmsrZUllUTdya3MxRjZNREZ1LzZDOUZjbEg1?=
 =?utf-8?B?V0N6TUZFWDZtYytrTjlZdEZybSt4T21SWDlsMmdVNHVlYUlhQmM0di9uYWZZ?=
 =?utf-8?B?aWlrcDBZOUVNSDkrTFo3QmZoaVBuMWJYSE1ESmlvRUFaNW5vUWY2R2JxWTNU?=
 =?utf-8?B?WSt5M0tsaFdueXg5VFpCVHFqVEh4d3NwN0RhT3RzY2N1SXMzRnFYYmZ5dDVH?=
 =?utf-8?B?T1Fqdm55WU9YQzJFN2ovd25nbUVMUDUvYzR0VUFDWjRlVjdNV2d1TXlIYmlp?=
 =?utf-8?B?UVZWZDhGRHk0cEQ5TFFXbDZGSFN3U1lTNVp1b3dyaThReWtkdFBNSjFudnMx?=
 =?utf-8?B?OS9kZ1cxbzBQQktJZVJ2VWhIQllrTlArZVg3bHdMTHFSaXJBSFUxUVhVRjRP?=
 =?utf-8?B?SG1jb1dUT2pWT2ZzOWhWSlJrUlFWYU1PVlZDOW81L2pBUHpsSE53RWl4dXNI?=
 =?utf-8?B?UHlvUjlkajdVTFNuMXN6aGpZM01GNGJVd2lSendBTmJOV1BjS2s5NklHenhI?=
 =?utf-8?B?QVdtZVVKRnJlT1BoUXdUOGdDZTlGdHFLSHFrV2s3RVZhM0pjb1ZCcUlwNlN2?=
 =?utf-8?B?bTdtUlRsaVE0emYvd1FHeWY2UmdubVBNVERSTDMrbnpxemp0UXVHTjRvSFBH?=
 =?utf-8?B?aGV4MHBGNUNIQnFPeVlkQXJjZmlPWDlXdGduVThCWS9VYlA5bitCS1RVY0k1?=
 =?utf-8?B?NFhUWGZrR3YzUktUdnNPd0RMWm9maU1SKzBNYjAvdkZBdGlQK0FjNFY3ckky?=
 =?utf-8?B?YXNKTFNSb3krQUxaTXhYcTVQVXVnc0FmU3R1Uy9xSEY3NmdueGF0Q0tyWmo4?=
 =?utf-8?B?UFdTR1pmOUFaWURqblJRdHlWeTMrV0dETUtwUDYydDVJaUVzajdHVlh5bnJK?=
 =?utf-8?B?NXVSQ05aTER5dFdyc3FVQjN6Q295U29Ld1VRdGVudHdxM1ZCTlBnRjVGU041?=
 =?utf-8?B?c2hDb0NyRzBZQ2psaVplRi9iMkNKbmowdm9vbXM2SEpjdW1nTVJURjNuc0tQ?=
 =?utf-8?B?a2Zpa0NTZ0tlbHlLUXNKZ1M3VS90ZHJNSE5yekpzT1JsUDcwNFFuZkcrMFp6?=
 =?utf-8?B?VjlYWmlXakJLT3A3VG1WWnlDZ1J5d2ZUMzE5SjNVaGpib3pLMng4V1pyeEJK?=
 =?utf-8?B?WnFyUmVSWEFaRkU0Ry9NUnFFNlRWV3FYV1dWOGQwWVhSTDZBUU5PMWdMZVhY?=
 =?utf-8?B?UjhKWHp6bmVPMnUrTmpGUkx4T3l1WW1NUTBLNnRtVEcxMGlFemNLOHhlcyti?=
 =?utf-8?B?eDNUak94UmxndzNXallYam9MTWIxZzU0bkExZEVtUzRTcGJwdy9kaUhMNHVK?=
 =?utf-8?B?dzlwbERHNXB5V2s1SFBleHc1TE45YWh3V2RMVFJ0T252M29ZVlJ0UTlHWVVI?=
 =?utf-8?B?OWU2TCthOTZFUzNnd01yeEV3OGpuZmRXay9tZ1JzYS90V2ZxZFZOWUFYRmF2?=
 =?utf-8?B?Z1FNeUNrdHBKSnJxNEFBb2FEN3UzcXVrR3VBRWZJcE5oSkxSemhyQVNZK1Fr?=
 =?utf-8?B?R0YzdVc4NTRLSUpIZGZpd3hROGkzSzlpd3VOT2V6ZXJ3ZEc4cVBhZUUySnpv?=
 =?utf-8?B?NjBXa1hhc3JoVlRoR3NxWGkzRGVSUDN3R3p3M0JkbWJiNnk2OTlxMk45eHJR?=
 =?utf-8?B?eWpZNm5VTjE0QzFtMm1oOWFIVENxKyswYktzbFJ2cUxuZFhhQWlXR2RRUVVp?=
 =?utf-8?B?SFRzR1hVZC82SDVwREVUVlJpUTc5enBaRFRwNytlWVJRWWwyOHAxak55L0hP?=
 =?utf-8?B?TWxmaUhpbmZwZ20xK0pHc0wzTWhocmZnR010Nks3RUR5U0doOUtReTN2WjNF?=
 =?utf-8?B?WTZ6RzBraG9nZ01wUWJvbFNpM3kxMnlMREIvTUpGVXVMT2hGWElsdFJRcFZ2?=
 =?utf-8?B?ZnVXelhQZURzaEhENWFmcDFKcklYQ2d0TUZpZ3F4M1VSV3ZORjNKNjNsTmRK?=
 =?utf-8?B?WFVpMHRnS29xRlBHZ0tRNG5JcDVKaGZUaXpzTDZKZ1kvbWZocHdQc1ZWczYx?=
 =?utf-8?B?cWphSzBadFdYSCtuZkJ5alhEc2xKamc4a1ZNRlRnNm9IMVN1dWlvdGxhazNr?=
 =?utf-8?Q?Vg4+RhWN7QBI39xveCQ/1Ht7r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d671d9b5-a274-4ed8-ac54-08daba6beb88
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 11:43:10.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4iHEBV5iTfD2jbFYxrBUArMfkUJlAwTavJffFnUg71blytN84oIlgxon7ErYfEWLUwD6BAEskQvbcEgo6K0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5601
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMC8yMC8yMiAxMTowMywgQXN1dG9zaCBEYXMgd3JvdGU6DQo+ID4gK3UzMiB1ZnNoY2Rf
bWNxX2RlY2lkZV9xdWV1ZV9kZXB0aChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiA+ICt7DQo+ID4g
KyAgICAgdTMyIHFkLCB2YWw7DQo+ID4gKyAgICAgaW50IG1hYzsNCj4gPiArDQo+ID4gKyAgICAg
bWFjID0gdWZzaGNkX21jcV92b3BzX2dldF9oYmFfbWFjKGhiYSk7DQo+ID4gKyAgICAgaWYgKG1h
YyA8IDApIHsNCj4gPiArICAgICAgICAgICAgIHZhbCA9IHVmc2hjZF9yZWFkbChoYmEsIFJFR19V
RlNfTUNRX0NGRyk7DQo+ID4gKyAgICAgICAgICAgICBtYWMgPSBGSUVMRF9HRVQoTUNRX0NGR19N
QUNfTUFTSywgdmFsKTsNCj4gPiArICAgICB9DQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIFVGU0hD
SSA0LjAgc3BlY2lmaWNhdGlvbiB0aGUgTUFDIHZhbHVlIGlzIHNldCBieSB0aGUNCj4gaG9zdC4g
Q2FuIHRoZSBhYm92ZSBjb2RlIHJlYWQgdGhlIE1BQyB2YWx1ZSBmcm9tIHRoZSBob3N0IGNvbnRy
b2xsZXINCj4gYmVmb3JlIGl0IGhhcyBiZWVuIHNldCBieSB0aGUgaG9zdD8gSWYgc28sIGhvdyBh
Ym91dCBsZWF2aW5nIG91dCB0aGUNCj4gY29kZSB0aGF0IHJlYWRzIHRoZSBNQUMgdmFsdWUgZnJv
bSB0aGUgY29udHJvbGxlciBhbmQgbWFraW5nIGl0DQo+IG1hbmRhdG9yeSB0byBpbXBsZW1lbnQg
dGhlIG5ldyBnZXRfaGJhX21hYyB2b3A/DQo+IA0KPiA+ICsNCj4gPiArICAgICAvKiAgTUFDIGlz
IGEgMCBiYXNlZCB2YWx1ZS4gKi8NCj4gPiArICAgICBtYWMgKz0gMTsNCj4gPiArICAgICAvKiBt
YXguIHZhbHVlIG9mIGJxdWV1ZWRlcHRoID0gMjU2LCBtYWMgaXMgaG9zdCBkZXBlbmRlbnQgKi8N
Cj4gDQo+IGhvc3QgZGVwZW5kZW50IC0+IGRlZmluZWQgYnkgdGhlIGhvc3QgY29udHJvbGxlcj8N
Cj4gDQo+ID4gKyAgICAgcWQgPSBtaW5fdCh1MzIsIG1hYywgaGJhLT5kZXZfaW5mby5icXVldWVk
ZXB0aCk7DQo+ID4gKyAgICAgaWYgKCFxZCkNCj4gPiArICAgICAgICAgICAgIHFkID0gbWFjOw0K
SXNuJ3QgaWYgbWNxIGlzIHN1cHBvcnRlZCBicXVldWVkZXB0aCBjYW4ndCBiZSB6ZXJvPw0KVGhl
IGRldmljZSBtdXN0IGltcGxlbWVudHMgdGhlIHNoYXJlZCBxdWV1ZWluZyBhcmNoaXRlY3R1cmUu
DQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gSG93IGFib3V0IHVzaW5nIG1pbl9ub3RfemVybygp
IGluc3RlYWQgb2Ygb3Blbi1jb2RpbmcgaXQ/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0K
