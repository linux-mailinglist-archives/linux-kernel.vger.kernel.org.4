Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476A5ED459
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiI1FxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI1FxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:53:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B9B10CA4E;
        Tue, 27 Sep 2022 22:53:02 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5X113005044;
        Wed, 28 Sep 2022 05:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=l3xLuPaUrp0fnEJRQGSlcbCQKma7BlNlKWoLqBbC1tw=;
 b=I0Wq9ZJPFextviUQKrqr24eqgIgiLJSOzJkUm1ct12MXl+Kg1CTm3WC+3gTokxZOtyWl
 iOM6hOdyuzuqjoYcvFS/D34vf+acyAbkNKNT24Pl+U0ArTEupc0smhM+14oKDjtAK+uM
 wON2Gkew5Ry4WzZ6umnd80V2w6M9RmwkIrWZYUEoLtfiaEWkaNEchkH243wT/UcZJ2kQ
 bXQSxi26W240g335wcjbePwj+72pH0P/zBhG/71PyjFGY3eaOpr6Dxx/CtQFhLpaApSA
 EADzhjwx6Nokt0xGQpAPejylVfbrklIZsgVnUApmokecgxz6zuctkA5Es0JNabIHHVUu tA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvep6ra79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 05:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kddQzwFJ2++kOv/SwADHltjggtsw6UrW7B9hCmTwxBhkv+Lh1VhIa6NlZ1ec1jGqTUhqC9vT51ZklPp7TVZVhIpk5kbSChaICXheIFgupOI1QagNffAcwUiv1S9QcJ2DIJSug7WEPZC2m3KmzE5VnwuZOycIuYi2IevmTPmcXahjZEcTAj8WzBkUKJ/+rbiA+trSlR4q5cCB6W+60DYnkHYsolDHNxnC7kE5F4/0omUz2k8+eBmGiopUc7dFMhUopYIQ8lRE3WcOKDiP03z18dEAaDC4Tt6xhr3HD0VR2rWyGOIvCYji1WUZ2jLpCvFlTiRe6UP8SVY7NIrasU1vzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3xLuPaUrp0fnEJRQGSlcbCQKma7BlNlKWoLqBbC1tw=;
 b=UVxKmUYX/q7M68vdcrKslVLIYHVsMEzpj1Kwz+XlMpIyY0barLl6DtzJhHffkObh+tkrWgzkqxoX8qfJhWy3+laFeFHEg+nFfa5+DSWZkKmNZd0tsDdcyJUeePrESgAKpF+ceH4zmi9sEg3NS4MQc5WiiwEaJrf4i6h9Ihooqf8HmvTISGgiGibearWmw0DiEwjX5eQXHPewvMSv1Z2lUixWCqjBbxRfFJoVKlNIaBkeX6VtsboiMHEL1+qWkmx7pWiBuDBD2/T6xpUePzrFT/N/+lpyNercA0oTZVtgI93KbcxBLrbPi8/Him51Ddp87z7h6l3GDfaDGAEeJMy66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BN0PR02MB7950.namprd02.prod.outlook.com (2603:10b6:408:168::20)
 by MW4PR02MB7251.namprd02.prod.outlook.com (2603:10b6:303:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 05:52:55 +0000
Received: from BN0PR02MB7950.namprd02.prod.outlook.com
 ([fe80::3513:42f7:adb6:55d0]) by BN0PR02MB7950.namprd02.prod.outlook.com
 ([fe80::3513:42f7:adb6:55d0%5]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 05:52:54 +0000
From:   "SURAJ ASHOK MAGAR (Temp) (QUIC)" <quic_smagar@quicinc.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "SURAJ ASHOK MAGAR (Temp) (QUIC)" <quic_smagar@quicinc.com>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-bluethooth@vger.kernel.org" <linux-bluethooth@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>,
        "Sampath Nimmala (Temp) (QUIC)" <quic_sampnimm@quicinc.com>
Subject: RE: qca: Update firmware files for BT chip WCN3991.
Thread-Topic: qca: Update firmware files for BT chip WCN3991.
Thread-Index: AdjJlfiAvcjn/tJrTqyLjAFWwmKZ2AIHauaAAFK53KA=
Date:   Wed, 28 Sep 2022 05:52:54 +0000
Message-ID: <BN0PR02MB7950C26D723F0468E7FC5F3CF9549@BN0PR02MB7950.namprd02.prod.outlook.com>
References: <DM8PR02MB794335113A0327A554F7F3BAF9489@DM8PR02MB7943.namprd02.prod.outlook.com>
 <CA+5PVA7BH+996vpThH5OJpHy_9agpaLxJSc9vqZA5JVV4ATuew@mail.gmail.com>
In-Reply-To: <CA+5PVA7BH+996vpThH5OJpHy_9agpaLxJSc9vqZA5JVV4ATuew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR02MB7950:EE_|MW4PR02MB7251:EE_
x-ms-office365-filtering-correlation-id: 27e2c116-c9a9-4cb3-76d7-08daa115affc
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFAvGqkBVxieemlmxQjWbzrdfhMntiR6HbrVz4BKYE8hRdZPElTpbIosPugMS09UdsUgI5aOOOvdAaVu/XS0E0CBBDQbTPMTsaWGJLU54FK22GRrs2190rh9C6Q6D1fLlRmJ302CBhfdQQyRAHt/YDZbqAXipOBogD+R4QNkN+48SNjYBTVju6Lc7itY2pmaFtR/lnKz3iiQx6TD4C8h1rySt9kcjBF3QYR+Z5apB3mm94Lp2ok7yWUB4lcQgu62abOmHmoQf3qlnQt/G2DZ4FZ9h0Zt7c1MyXieRh+wiPDmVhdR5YdKp6caSTwSL/F8ccKgi97YqEVaTAOtbmLCrJMgPoPb8ZzOsO6m8mjOki0IKHhIQhDv3uX9QdkOAjb4h9L9zdl5aAL2kmWwyCllaaUiXB94VsDxICQsUHOLKaRP+SsvDjkqdEjTgcR603UkdANH0zzc2kNKKclfDsK8bWjH3dNG5FvGBkMXW+e1CQZObwhoNlYQUp+CyVjgFbz9sfB8+ueoSGvyDLG5Riwc1MyKibnz8TbqFJ/5WsuwK753xfKmaxbaZCerOlB79oq94753Fz4Knjno2tiErcdBCSQ3DnoScgklTusde1jI+obMqGmnKTdgQiSVkCOsmp7gEelyRp3bfwYU58JYlm25uioCiKfhndteXTfFMo5gWiQar0BXfPePXHOc6KqoB2pCj82mMLD61ucZ02z0xRdN3H0N9OnFwgesn/CejoUTrOjpFJnk/QJ8TeU7OK6yQTS3FswsJufak1fZShL7aZ9Fhx7HcQ53aA5DwwWlDAlbXzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR02MB7950.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(54906003)(122000001)(52536014)(110136005)(33656002)(186003)(5660300002)(2906002)(8936002)(15650500001)(41300700001)(66946007)(66476007)(38070700005)(8676002)(76116006)(66556008)(86362001)(4326008)(9686003)(26005)(66446008)(316002)(6506007)(53546011)(7696005)(64756008)(83380400001)(478600001)(107886003)(38100700002)(966005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFE1YU1QTzBBMTlhaWF1d0FISFp2NVdkdmFxazdnWTcxbTQwbytZMHNPQ1FX?=
 =?utf-8?B?RlJVTnI1QUFZSGEvRjQ2UTBPYU1UR1AwN2I3QzZFMVdZdVE4TXJTTEk3cUZO?=
 =?utf-8?B?YjFyejk1VGJidnNzNEs5MWtpNnE2TjQ3NHJzZGdZTFRIaGIxcHNVU1VvRTlo?=
 =?utf-8?B?Yjkrd2xhWjVIZ0hIbFdJbEFiVjRMbko0cm05aEZBVXVXWkM0TGI1L2tPcHU2?=
 =?utf-8?B?TmJ5MVpBUW94ck16d3FxN2kzVTBXOVVnVTlONDdrWVdkcTlZa3dlVUdZRms0?=
 =?utf-8?B?OUdFQVI4TlBkeXplQzBIa2hwSkYxOGpCbFB3N1hjZW9DNXVnckQ2am1tKzJK?=
 =?utf-8?B?VE5YVmQvVlVnbmZEaFJUbUhQNVhCSTlFMnh3TDBXQWwzWFprNVQxQjN2dUFJ?=
 =?utf-8?B?aXdua25vZWt3T0tPWldVSzZsc1ZMSkl4aTJUM2V5UHA4V0NHS3NFWjVIMzNI?=
 =?utf-8?B?aHg4a211L3dDemVacHJNMHJUNitKWGcvUzRyc3Z1aW1GR3Y3K0d6bEVBdXBw?=
 =?utf-8?B?emcxYmRPTXhUNHlPUlBybmhvRVVEeUxZZ04vUVhOblUwNlk0N2xhdFAzTTZO?=
 =?utf-8?B?R0xVc0hXc1p1RW9vYVErVXRESE5BRnZqZHl0OFZFOGNOcnd5bEJTdDM2OTU2?=
 =?utf-8?B?MmxxcUxGY1NWNTNYZy8zM3hkdUVublJWeERjZkh2MjFHZWF1MG9JQ0Zra2ov?=
 =?utf-8?B?bzBhbFVaQnlqOXhrRzVIcFI3eWpnVmtiaS9qT1IycllGaU12STFDbS9hS3Rv?=
 =?utf-8?B?SnBVdTZCaFFFQUR1UVl1TXFLelRlMytLNlhMOXhsaExVQXMvZkxlN095OEQx?=
 =?utf-8?B?YytWcXFpWmp4VG9hbkJnaEgxQ3I5RGIzSEZYUFpZVysyREZzNjNjV0p5dVg5?=
 =?utf-8?B?UUNta1lHOWNWTHcrajdMSzh6SHdkVzFPbkVqZmdBRGtKbjhEcFhxRnpNd2x0?=
 =?utf-8?B?YUM4OTBiUjVBa0hBUHg4bE1PTlJUT2FxV0NhM2pXK3JyTFFpbUNvcmdONlN0?=
 =?utf-8?B?aUpKT1IvbmtFTGk0aHBwaXRubThSOUFuOWZGYWVoRFhXTGxseExqL1dnZHY2?=
 =?utf-8?B?NDJYZnE0K0t3TVdsQ0NKcmtvU2xCaHBHQXJFRm9CblVaTmNsRWVZaTN2QUFE?=
 =?utf-8?B?RkRBRW9zWDY5QjBWU1RPN0FjWkdGeGdpeG1TYWFqajRqMFVSazNhUXFBcGs2?=
 =?utf-8?B?dkVxaG9YTTdxWEhMellScWpoUDN2R01rdWxmOWxjSnFCWlRpSEUvWG11M1RG?=
 =?utf-8?B?YlVtbFhILzIvMyt1RExrdUFSb0lxL25CSTF4dXk4a05tbkxreFV4ckNOTUp4?=
 =?utf-8?B?OFRNQWthVzFVNXh5MXRJdG9PZENnZ1ljSjJGc2tZbkd5MzRPSmdhMVRCaHFp?=
 =?utf-8?B?dTJGbzNpOHU0NkVoMzF0SmxKMmtKQU5nWkdubW1JUGJiSU8vQkVBNzJoODdM?=
 =?utf-8?B?WE1XQWNrT0ZHQWZ3UlYwUGpFRGhreWpmNlVwQi9KVzFCN3g2bGtMaDBYNVRI?=
 =?utf-8?B?eFlsYmhzekxkUk9vTW85c3Jid3dvRE1NTHZiZmNSNG5aeXZOZUFuWVl5Sjdw?=
 =?utf-8?B?dG1UcXFacmlpU0dTTTVaWS9Pc1ZhQnR5MEV0RVVLQW5qa1BCUDEzTUhHV0dL?=
 =?utf-8?B?S1E1WThxUWFYSlM2VFlLeFE2QjJ2RnV3UGlhV1FYTnpBUFJ5bDMycG1KOE5o?=
 =?utf-8?B?QlRlcVR4ekFFWVZuUi9JWGwvVjBnSXNTY0tsZk9JQWN4VnUwTUd0R0p6aEdZ?=
 =?utf-8?B?cXBoZXlGNE9mZjc0dmtINUN3QlpZdXdJNHFQeFFhVzQzUE1OMGJCcVRCYWpT?=
 =?utf-8?B?T1BuMmZGbkcxK1hJWk1pbHgrSmkwVHlWcjcycDh2L0pHSHVuWm4vY1lpNjVO?=
 =?utf-8?B?dC9YRHJ2Lzc5Nmo4ejZjWjRRVi9aUVpDdDlIaWEvazRZZmpCKzVMMmhpUUhT?=
 =?utf-8?B?TkY3TFR6eVVGamYrNmZnbHFyVkV5dS9LUzdVQy90aE90YndJMlcvL29PQ0Vq?=
 =?utf-8?B?MEl6bUk3R083Z2RoTDRISW8wU3dCUGlXeFJ4dnhxeGhlcGlxU1MxQ0pqMVox?=
 =?utf-8?B?OWtTNjBPc01Qd0dNazltMzBPVjRvOW9YeWVlSHFEajZYU080ZnFrWEh4WFRY?=
 =?utf-8?Q?MeSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR02MB7950.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e2c116-c9a9-4cb3-76d7-08daa115affc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 05:52:54.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzZenCur4QGko/yl+QsB8Lvx61qt8MLkdI6nYArTQV0PS0gkktSn7mHTKIB4xMGETb4kOQsmJSgjO+Npbi0Bbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7251
X-Proofpoint-GUID: 0YzM_7MXDiGcDlUmiyEUnDxWlLzLjwtq
X-Proofpoint-ORIG-GUID: 0YzM_7MXDiGcDlUmiyEUnDxWlLzLjwtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLA0KUGxlYXNlIGlnbm9yZSB0aGUgcmVzdCBhbmQgcHVsbCAwZThmNTQ2YzRjNjZhNjE5ODFm
ZDAzNDFlYzBhODQ1NjNkMWNmYWFhIC4NCg0KUmVnYXJkcywNClN1cmFqIE1hZ2FyDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb3NoIEJveWVyIDxqd2JveWVyQGtlcm5lbC5v
cmc+IA0KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjIgNzo1NCBQTQ0KVG86IFNVUkFK
IEFTSE9LIE1BR0FSIChUZW1wKSAoUVVJQykgPHF1aWNfc21hZ2FyQHF1aWNpbmMuY29tPg0KQ2M6
IGxpbnV4LWZpcm13YXJlQGtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0aG9vdGhAdmdlci5rZXJuZWwu
b3JnOyBta2FAY2hyb21pdW0ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEgR29kYXZhcnRoaSAoUVVJQykg
PHF1aWNfYmdvZGF2YXJAcXVpY2luYy5jb20+OyBTYWkgVGVqYSBBbHV2YWxhIChUZW1wKSAoUVVJ
QykgPHF1aWNfc2FsdXZhbGFAcXVpY2luYy5jb20+OyBBdHVsIERodWRhc2UgKFFVSUMpIDxxdWlj
X2FkaHVkYXNlQHF1aWNpbmMuY29tPjsgU2FtcGF0aCBOaW1tYWxhIChUZW1wKSAoUVVJQykgPHF1
aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogcWNhOiBVcGRhdGUgZmlybXdh
cmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NOMzk5MS4NCg0KT24gRnJpLCBTZXAgMTYsIDIwMjIgYXQg
Mjo1NCBBTSBTVVJBSiBBU0hPSyBNQUdBUiAoVGVtcCkgKFFVSUMpIDxxdWljX3NtYWdhckBxdWlj
aW5jLmNvbT4gd3JvdGU6DQo+DQo+IEhlbGxvIFRlYW0sDQo+DQo+DQo+DQo+IFBsZWFzZSBpbmNs
dWRlIGZpcm13YXJlIGJpbnMgZm9yIFdDTjM5OTEuDQo+DQo+DQo+DQo+IENoYW5nZXMgaW5jbHVk
ZXMgdXBkYXRlZCBmaXJtd2FyZSBmaWxlcyB3aXRoOg0KPg0KPiBCUVIgZW5oYW5jZW1lbnRzDQo+
IExFIHByaW9yaXR5IGNoYW5nZXMNCj4gQnJha3Rvb3RoIGlzc3VlIGZpeA0KPiBSU1NJIEZpeA0K
Pg0KPiBTbmFwc2hvdCBvZiBwdWxsIHJlcXVlc3QgaXMgYXMgYmVsb3csIGxldCBtZSBrbm93IGlm
IGFueXRoaW5nIGlzIG1pc3NpbmcuDQo+DQo+DQo+DQo+DQo+DQo+DQo+DQo+DQo+DQo+IFRoZSBm
b2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMzU5M2JiN2Q4ZjZmMThjNDQyYTZiMGIzZjNk
NDNlNGQ1ZDdmYzJiZToNCj4NCj4NCj4NCj4gICBSZW1vdmluZyBjcm52MzIgKDIwMjItMDktMTUg
MTE6MDk6NTAgKzA1MzApDQo+DQo+DQo+DQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBv
c2l0b3J5IGF0Og0KPg0KPg0KPg0KPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zdXJhajcxNC9CbHVl
dG9vdGgtdXBzdHJlYW0uZ2l0IG1haW4NCj4NCj4NCj4NCj4gZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDBlOGY1NDZjNGM2NmE2MTk4MWZkMDM0MWVjMGE4NDU2M2QxY2ZhYWE6DQo+DQo+
DQo+DQo+ICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NOMzk5MS4g
KDIwMjItMDktMTYgMTA6NDQ6MTcgDQo+ICswNTMwKQ0KPg0KPg0KPg0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+DQo+
IFN1cmFqIE1hZ2FyICgxKToNCj4NCj4gICAgICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMg
Zm9yIEJUIGNoaXAgV0NOMzk5MS4NCj4NCj4NCj4NCj4gcWNhL2NyYnRmdzMyLnRsdiB8IEJpbiAx
MjYwMzYgLT4gMTE3NjY0IGJ5dGVzDQo+DQo+IHFjYS9jcm52MzIuYmluICAgfCBCaW4gMCAtPiA1
NDA3IGJ5dGVzDQo+DQo+IHFjYS9jcm52MzJ1LmJpbiAgfCBCaW4gMCAtPiA1NDA3IGJ5dGVzDQo+
DQo+IDMgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPg0K
PiBjcmVhdGUgbW9kZSAxMDA2NDQgcWNhL2NybnYzMi5iaW4NCj4NCj4gY3JlYXRlIG1vZGUgMTAw
NjQ0IHFjYS9jcm52MzJ1LmJpbg0KDQpUaGlzIGRpZmYgc3RhdCBsb29rcyBvZGQsIGFuZCB0aGVy
ZSdzIGFuIGFkZGl0aW9uYWwgY29tbWl0IGluIHlvdXIgYnJhbmNoIG5vdCBtZW50aW9uZWQuICBT
aG91bGQgSSBqdXN0IHB1bGwgMGU4ZjU0NmM0YzY2YTYxOTgxZmQwMzQxZWMwYTg0NTYzZDFjZmFh
YSBhbmQgaWdub3JlIHRoZSByZXN0Pw0KDQpqb3NoDQo=
