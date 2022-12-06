Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306E7644A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiLFRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiLFRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:13:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A298326EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:13:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6GxueZ012891;
        Tue, 6 Dec 2022 17:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VEp7ICahPishXn55isWWC2VMYyILyBqHKOUqkOsm5UI=;
 b=zQF21u+H4FjjBEP0W8Y+y3TFprBXT15Jbwklv/O3wK9QzD3E/Ho+bwAygWTcFuySyEWD
 MPN/3P9qxUGwr2d5nSiD8LJViS0yqZwc2zYXDC6TZiMxVyPOrMQzXxqIoBXHe2BqcDLQ
 7chDbmyZizUHmXf6B2yq8ioAuvh25E1swblMJbCCDyn7Lb4aKm4OPjThKEDx0OsU+krn
 nTjx4kHYKhRwtNiezYIBOefzuyRg9/GZsSzf6eRJHDrFbud6hQYXLRksJUNXIEAYYBz0
 vtHAO4DADdkz3Q3BM7yex4EdeKrSExgZKdcCjeeu9W6DEODnV+Sz171PteM0svc15hn6 cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ycf86mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 17:13:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6GpQJF017602;
        Tue, 6 Dec 2022 17:12:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugg6752-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 17:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFczFf0R1muu8sdDablvUFy9VzIngbvGOHnTQX2tPan+vYAnlX4r+SMlMkXdph3cPZEq5j9e+RNmDWQS6yKHDEdcQR/O7/eV4y4sDS1gpA25ogbaChEq9EPCEtxbZxAfGLFr6mnNZ/OnTMlum7FgxrJvaPOa4Zjp+M0BNQGc80E9Ug1jYW1XQkmBbyb2VizZkMSdgrAH2i4R3b5Ymr75wrToF3GKwg7C6wWbhth19bCbfA0KVC5gaG5Xi22MvTI54S/Y6hQReY5Y2CzDpkzmCVaWhjmqwh+T95IKNu7aI0CZaZD0N44wbShL3XJh+EpfH+GhydznsIHRiRPTIuLckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEp7ICahPishXn55isWWC2VMYyILyBqHKOUqkOsm5UI=;
 b=YsE3SzhqV5ry0hOIfOE6j4247fS47vt3DIbDN4qyC7nX1I2hcKS64oq4BE/CckbwOMoJB03ePr5LGnZ4V2w1OQ3qUVLOPeMmc0Cxpa9Ortqo9grSo1p2TBdm2b0KKKj0qUQ41rKk8uNrmtrkdsuSpUKaI2lgnfI6nneeDnIYp9taInIDZlfVltErBOu+5ao55ArcXisqjuLhB4eCDXFhyM87i42fWnOx9sKNnLmjaRQxviuAs4lK1aKKyxySbhG5XOZptQ6Pz6rnx1LJaM78XDg8dTgzp+xmSvJp8A44V3Vuq2Hchae2oheFVZRTRIEsJ6kqx/jx58EiXHJcYyEJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEp7ICahPishXn55isWWC2VMYyILyBqHKOUqkOsm5UI=;
 b=BfiYjHaTfRGMEJBrbh2N6UMVZbYypV7dO7eFgOOa9eQnJ/ZBdpIAz6EDppXsYOzAUWnAil/k3UvpeoLXflrrQB5l4O3isGSrMEmvAWX15r3dzXPcT2SJgLMO9ON7faYJSJBWin0p8l9UrNWNvLHJYPxxw+QTGgfeiBcHrRWdFF8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7360.namprd10.prod.outlook.com (2603:10b6:208:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 17:12:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 17:12:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
Thread-Topic: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously
 incorrect VMAs
Thread-Index: AQHZCN8GtZfVbzYk1k+O68Wup8Rcdq5fv74AgAAXFgCAAAT1AIAAA6YAgAE6wAA=
Date:   Tue, 6 Dec 2022 17:12:55 +0000
Message-ID: <20221206171248.e2fnxrdhh2cuqq3n@revolver>
References: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
 <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
 <CAG48ez26s0R6DsPKJ1dUomwSwCfhWcpQD6Zb0GU0rbYcFD1hww@mail.gmail.com>
 <b1b80402-2c90-8006-bcf8-716e6ef719c2@suse.cz>
 <6eb002c8-0e31-7c9f-bb3d-81c4430b296c@suse.cz>
In-Reply-To: <6eb002c8-0e31-7c9f-bb3d-81c4430b296c@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB7360:EE_
x-ms-office365-filtering-correlation-id: d4b1b0ec-172b-4611-e13f-08dad7ad1db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qts3BjwRQOy0k3i6AUf204EFr/u6DQbAStflIEQVcrb+vJWHDObdXVBfxXJbfdUJc2IoUXPmkMCWBl0oI1CCnYLNug9KCoRFYwkF2wnXNRcWUWa8tAfK1lMvZyMD2ZqYFXO8MBjM7BRFCkEehn94vsvxxyyD5QqKbxK2X447x+WsewUNiTW25L551QjB3nafMvlcH849glJrdnUGCaobUJnOPf4XQ4yENbtLl+e1k33e+HWoyTWV1FJaLXCFo6sjHYj0B+1qo4c1IbuBC7MAiPPiy98D7lbamV3Gx5ZIV8GaQOnTgW3/nemHuVt8zXbTqbrQr6OKBFkl2EhW82aqfNMmEeHkBjwspcE6hYVimUWIG8Aw+9oegqMJ5RyUtTl9eRO8kP7OkZVP98La9iiusQ1UCgcPzNuncPBdZA6YWiBJSaXcwDKHaNRVY6O2FPv4TEN7QWbiuwqR/e50pQ/8S51EpygX0Xu1J6rqAjdTYH/oMsIjEtfwnURgWer5rf5noX0Fei537PHk7SxK11uRYaTw8fz3Ewg6g5/eHAg6WOJHYqJ8xDm4kIlgOuoiMFZEoV4/Db1lYoDn4/fz0dHmkc9fzFikL34eI4jLLXl3yloBbUTsX5mqek33oGkTw5F11GKBhcX8uf1ulCunEuEYp6YXryRQ+4dgYhXeNmkigR90T33hKp+5moW66o5f2PlGGORD7T/40hJ/qlFIWsJOuHUr9z/fbHE3E/PzycYrQsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(2906002)(66946007)(91956017)(83380400001)(66446008)(8936002)(66556008)(66476007)(8676002)(4326008)(64756008)(5660300002)(44832011)(316002)(6916009)(76116006)(54906003)(41300700001)(53546011)(71200400001)(33716001)(38070700005)(478600001)(6506007)(26005)(86362001)(9686003)(6512007)(6486002)(186003)(1076003)(966005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MOV/0ABByCjerQ4Nc+U631Ub62NBjKue83ArF1TF1ytuDAd1gtdrF6QsQQWV?=
 =?us-ascii?Q?RjRPp9uimSlxfqLf9nt3MwcoFU10xu0Hkc3AlTCpaxDWs8D1MT/aYolEmq9T?=
 =?us-ascii?Q?5e/NGy2L7e8cQOTjW+zkS+OJmruUwN3l/eijc+eZfdj/jJqZJFc6FLw+w5kS?=
 =?us-ascii?Q?YZYyePIJit4D3ldusjO//kZCCOg6DOMrfDN+kW23otyyrdkgMktt9WgDQrBs?=
 =?us-ascii?Q?CcQUjPvGKbbDx2BvQegD2uKtDUA5WrgHTeFl9pybotswMt11Bpqw+WCeigjr?=
 =?us-ascii?Q?TYJWo/VDMYAxQjf77hGYAbubZBdFd1RT6c+YVrGM9D0o7rzkNmmgGcjLEtTl?=
 =?us-ascii?Q?HEPdKO0UW8Ex7VTBHb2E96XBgm73mIO70yr4Wsf1HKXmHor5sj1SZ6jSppRi?=
 =?us-ascii?Q?hHd4mXUFu4l3Z72vR7OplBPOLbXkxEk65Wl3Qbv5NPYVWtdnrBmxpCb9HvT8?=
 =?us-ascii?Q?/ftYiz+J8mjHVynkj7S/YlfRQTrMa3/CcZUPCzMRQlgHOZpIvsRGJMpjfYWx?=
 =?us-ascii?Q?BofzCuIOXjXZMhIA//f1R4iOS/ESMl6OxdhshaP5oDE+geqSWyc2NEI6l7qN?=
 =?us-ascii?Q?DEtv0/xML09oRGoo4I4Oxk6djVRyfZBUS7D/DJf+J4xwfpc+g6RFo9upmGWR?=
 =?us-ascii?Q?NZpj+zQcgI172PWhcWX7nznD6/0uCiYHv/jAygrmjqu3omFgP1hsdIu9ALod?=
 =?us-ascii?Q?zWi/DTSQxnKQeV2j/OmBiyqzfwKtcft3AxqnzhQVUnMRswmQHupmz50YuAmq?=
 =?us-ascii?Q?uvIByHJXLYEKHUoUNQkv0vEEGar4AH10Nf0blBg8N76ViZH3UwD8DxYo1MLl?=
 =?us-ascii?Q?Z3imQG7LTHRkYgQG0KcbSW+qRxl3m6DwDw5qsImLme8b+phJhw0cpxcetOs4?=
 =?us-ascii?Q?jm6hoOUXZ0GBc983Oy92jWPpJjCa1nthqA6IqSyQgJaGgdKhgHOOOq6dH9d9?=
 =?us-ascii?Q?EKGalSiikCsObUx9EHrF1GZpnNMYHv2dKb2WjSCMx+Zv4ELBWzu55IKBHz4E?=
 =?us-ascii?Q?hkxcSwA1D32vWNZuoBK/87nwqckCUqw2uwn1mcKp8mrmhNqcs6z0sxiDX34L?=
 =?us-ascii?Q?DJbu1k9VRoIjCMEo3Xh+GJaesFRUf9hRRbAPeelg2vas2CS0ebQS0iJ2/K4H?=
 =?us-ascii?Q?nQUvO0TF9Wz20rshWWJtnN/gO1bEkwrKRgnOfoI2G0Kvf5hpJUiB0kyBlANP?=
 =?us-ascii?Q?TTmLTB/vwKw3dv2Ezi5NL7gisVDAu4L/uBWyGEOdmKnP4dTi/RklK9onDatj?=
 =?us-ascii?Q?i4x04FG4OaIhckBlov7Obn60gb8Ib/useiZb176TQd6Zbj9Ho+s+roP2Wmor?=
 =?us-ascii?Q?R28RNjwm8JYUeTri8TAAUTScOcdWw8uItee2rDrcZorknK6xsmpZC94KW1L8?=
 =?us-ascii?Q?J8GdKRqml2+cfsuMnGZ2UaAWjM7Yz5mAIR/VO38V8FwvXgs3SPWW6Y9sSQRp?=
 =?us-ascii?Q?kTqzSvCX40A8ydN1pj9yY3xLYiMkvFFSxXg6Oo9sopHLW+tApENwtcvE8RpX?=
 =?us-ascii?Q?Pyfr25+9NZwvg9bjXvQNwVVFtwALUXw8cNsFb4AKAbaiowHoMsPrsGci9gSu?=
 =?us-ascii?Q?zwoiGxMQQA9jc7+8I3E8YsF0QA1OYswYSPIXz9uIi0h4WhEdMTCOYY4eTxC/?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3800C1D3CBF90E45B36421BFCF18D0E7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?t3tNdlZh41iZsqS6LGLcI4c0NBtPnH+jfNh5lMrVYZtWtVOudc0NONjoSrqw?=
 =?us-ascii?Q?n2Aqzb0r/nWND3dYhNtk27U2dsA3P7CDUgn6QRYeOa79/lz0CbpS+luY0l9M?=
 =?us-ascii?Q?W0mhAIvT5SbHc0gO/FPr239Do+uzECw4/BdGJH7wquXIFaCvBbOEro5ez9Z3?=
 =?us-ascii?Q?A2FsOHCqPXKV1rm/m2INlUitIiv38Vhbw3CZ5MzhC7oiuopMrK3cyZEc6YTF?=
 =?us-ascii?Q?xMhNP8t3QmpID84/k0pUvK3jI3FlE2BSfSQlkBVLkd5p5MnRosDkUiNyBVsI?=
 =?us-ascii?Q?CtQnYWUaQp3RNUweEZzyAKiKdkjq2mN+C4arNNKvq+A/h8lAqFtxIxRqAozb?=
 =?us-ascii?Q?HLuQTr7WXyaaygIQdDhb0hGaDho9e9Py/1DGNRLDKZhMToLsA63gBvYsc53e?=
 =?us-ascii?Q?3a4iYmS+cpqukj1V+ru9ui000gH91hZuzr4Sny+/J+Pt+ZmyaJ9W/2saFZdj?=
 =?us-ascii?Q?P6ZmjunxVuXnT3G5xzaMDcXp7hVorVmtMgosjrLa6jRlOXj1nmsiz9rVcXYJ?=
 =?us-ascii?Q?PL0RHy2j1azAjMQ23Rn1fOxjOS4Sba+zS+Jo5sGmEp7yd7MNSzl2BUaxF+0G?=
 =?us-ascii?Q?qIYqtHbmCw4rSWsp1uDPG1JUA4PYo6MIQASXXAVa4VxerlIu7IMlsOubU8Fr?=
 =?us-ascii?Q?LenR9XEzio5lnB1r46KhE+75f+66PhdIRxj198IX6B7OKEuWZ6USej5jpbDY?=
 =?us-ascii?Q?r9LC0tm3zgGo1c6jb//LzMWGx1YQJdnWQN4VVXR2dx+rymasx6qwCBju0u9O?=
 =?us-ascii?Q?nr86DCNJdaCz6b+psgcdE5I6b8g04yi4VSojmD5k7nIUCKczcvItvtRls8AG?=
 =?us-ascii?Q?aztUnk6x2JXADgsQmErkDbOElC3csXzsPG4z/ibRbqhbaCejS+YPO5m8AtMB?=
 =?us-ascii?Q?bvjK6B4w5YH3q9pREm+vsFOb7U11YHEpHZNTm9f8u8T2EwnLv5n9R7b+Rhvn?=
 =?us-ascii?Q?TGmXvPcqeRlV71yxIv2oy72Zdge66xsWRCQ8G4lBt0unqa+bc+XNbMnKp/vq?=
 =?us-ascii?Q?tYSeQXd2xpvlyoCPtBKNPlXv/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b1b0ec-172b-4611-e13f-08dad7ad1db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 17:12:55.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDzEHm7pjCFFpYd4IH8cMMLWPYwu9AzfmXic/u0BDJ00PHKqSZb7qduh9KCeulEFQjebShJiDTO0KpVPKWDEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=593 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212060143
X-Proofpoint-ORIG-GUID: AcfQwraF3LsdnPD3tqU75bTh_uwFrwPC
X-Proofpoint-GUID: AcfQwraF3LsdnPD3tqU75bTh_uwFrwPC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [221205 17:26]:
> On 12/5/22 23:13, Vlastimil Babka wrote:
> > On 12/5/22 22:55, Jann Horn wrote:
> >> On Mon, Dec 5, 2022 at 9:32 PM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> >>> On Mon, 5 Dec 2022 19:23:17 +0000 Liam Howlett <liam.howlett@oracle.c=
om> wrote:
> >>> > Add more sanity checks to the VMA that do_brk_flags() will expand.
> >>> > Ensure the VMA matches basic merge requirements within the function
> >>> > before calling can_vma_merge_after().
> >>>
> >>> I't unclear what's actually being fixed here.
> >>>
> >>> Why do you feel we need the above changes?
> >>>
> >>> > Drop the duplicate checks from vm_brk_flags() since they will be
> >>> > enforced later.
> >>> >
> >>> > Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand exis=
ting VMA and add do_brk_munmap()")
> >>>
> >>> Fixes in what way?  Removing the duplicate checks?
> >>=20
> >> The old code would expand file VMAs on brk(), which is functionally
> >> wrong and also dangerous in terms of locking because the brk() path
> >> isn't designed for file VMAs and therefore doesn't lock the file
> >> mapping. Checking can_vma_merge_after() ensures that new anonymous
> >> VMAs can't be merged into file VMAs.
> >>=20
> >> See https://lore.kernel.org/linux-mm/CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8=
PEizPDwMGFd_ui0Nrw@mail.gmail.com/
>=20
> And yeah, that URL should have been a Link: in the patch. And the scenari=
o
> it's fixing described in a bit more detail?

Yes, sorry.  I should have made a better effort in describing what I was
fixing.  It seems I understated what was happening.

>=20
> > I guess the point is that if we fix it still within 6.1, we don't have =
to
> > devise how exactly this is exploitable, but due to the insufficient loc=
king
> > it most likely is, right?
> =
