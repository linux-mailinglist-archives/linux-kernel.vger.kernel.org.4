Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F866B33F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAORlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjAORlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:41:17 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1EC17E;
        Sun, 15 Jan 2023 09:41:16 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FDngTQ005019;
        Sun, 15 Jan 2023 12:41:06 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3n3t6bcxg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 12:41:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSH19R9SxhN6NrSZoYSPn9EDGAkeeSQ8PNaTOdn7uuqlyBQqHFZQvvqWbzuaFIrAahCLZwnQKTnkVNOjCTx9U29GalBPTrxwNtCYaEzBbJBpl2FYWsuj+aMCwRwsbp3TQSYxBZLWuI5R5+SAuUsb+N9Eh5WDjnpGlmYxgW66kqaLbAj8t+3Y1qUDhzv2XOXasjU9jhLnGMa/3Os1fEOkrpzT9LEVG5t+BnjngHLQ8guVrUrRsF3cyLHxWyOGI2RdFXhllZxQ8XeIzQRH0q1TBRBRsjdS/+CXoe40SIM74kE2WwWUd4ZVR7gtHCh8BBZJDnMF4NT8v/5zr7LzbfY54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpyIzx+1RLydPa2U2gbV2G/NCZceldxeqlkNfcn6IP0=;
 b=ZvdV1Hep5sdphLL7ceus+U0dN1I30Sei6xsXRKIwAaJCXFEnEywNBINcGxEyDtENKcplRCXQDsT5b48HhsTwNyIZDe4s/LiIyQsac7d0ruy+/g9hfhVQXnk3jMpsoT04ybTrlk/X/MvwjWVB0IVfPlAgLd5VZ+OaJT9BktMbRJrBgoJS/24N3LTZYcAGF14hhjQY17G6Gcc/hTSpImwp68t5AwAqqBlkfaIxKEQGxI/XunpmXZH79pzqKea0iQbqjcRFxgup8oceUjUgTppt3O5aRRZvRSCQG6357ZcpjxOt+bUCpUCXwth3dcw4n6hjvXViBj2LxM7eqYjuQhGDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpyIzx+1RLydPa2U2gbV2G/NCZceldxeqlkNfcn6IP0=;
 b=i5fqI+SRx/bMk2FEE/h4s4PB+R41QQ+Eax5ObzNI1QrmWY8Av6bZOQGUXHZbCFlT1grbK6OfMVCpzha9vIn8AxOZmV4s8JUGAOB3S0p8a8ZCDYqB4H8QHdk4sVfjj6o0fd+mVo7bbkAWfwNZnr+nTcGql0RSgqXkJwW8h23Ft2U=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SA1PR03MB6532.namprd03.prod.outlook.com (2603:10b6:806:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 17:41:01 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%3]) with mapi id 15.20.6002.013; Sun, 15 Jan 2023
 17:41:00 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:MAXIM MAX77541 PMIC MFD DRIVER" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] dt-bindings: mfd: adi,max77541.yaml Add MAX77541
 bindings
Thread-Topic: [PATCH v2 2/5] dt-bindings: mfd: adi,max77541.yaml Add MAX77541
 bindings
Thread-Index: AQHZGXrkC62bruN7tUqRwbXPu776mq6BXbkAgB5m/EA=
Date:   Sun, 15 Jan 2023 17:40:59 +0000
Message-ID: <MN2PR03MB51689EC83FF462C5CE903567E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-3-okan.sahin@analog.com>
 <88ba15e1-ee03-bd61-fc7d-d00c8c6ae72e@linaro.org>
In-Reply-To: <88ba15e1-ee03-bd61-fc7d-d00c8c6ae72e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWMzODljMjJkLTk0ZmItMTFlZC1iZTkyLTkw?=
 =?us-ascii?Q?MmUxNjI0NzhjNlxhbWUtdGVzdFxjMzg5YzIyZi05NGZiLTExZWQtYmU5Mi05?=
 =?us-ascii?Q?MDJlMTYyNDc4YzZib2R5LnR4dCIgc3o9IjU0NjYiIHQ9IjEzMzE4Mjc4MDU2?=
 =?us-ascii?Q?NjgxMzY4MyIgaD0iTitqYUFnU3hWSjBUZlhRc1phdTlBcU5LZjhrPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFEek8rS0ZDQ25aQWR5V3pOR1oyNTBIM0piTTBabmJuUWNEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SA1PR03MB6532:EE_
x-ms-office365-filtering-correlation-id: 94314423-eaef-41a0-d879-08daf71faa46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzliCZ2Cwl/Trr+95T0iknqimsFBBLDZ3diNT4jnHeaip5nxV+JRPW2btRmzSk/Val8BJLU6h3P6VkFBWX8t/BaKTbC+n2GwoM9luDJYeX1R8V06dBtI7yExpAWZ6iBu4R75+Z7AHdiHgVDQ0IUtf5etUsqNdxbIjV79l0axSf5zr46M95TLEfn1U03HK8VDmBqNPh/A3E5k83Gw7jyVfu9xeviLYo2wL7nngbC0WEb5x9Ykw8SEYTsDQfLn9GMcqJB0Nu/MqYe+IwsSj3cRSg6k/AOLOCVTTRDVG3criM8Mpjj96F4IW36ig58WTXrsIvAoVD1n/rxVIr42E/Cz3x9DaqDmJQa5SEUiWz7eYoze0edgvx6Q3/fzvQ0UVxJydsa5rdqvYkBAi89AAqVWQvHSbBjaDj2VcZwMQbW9yWVFJOtdGhFq8iSvl+qmNjM15eA3YFJMr6AsIMnYQ2BrC9DSaNZNoJWWsUw5tHPGlVpEZrb9RttgXMcX401uom81igcuKZmHjqVhgLofOOD9wjwduqYddlldJXNKIV/66ALMONp67LEHr8UqBRwDblKkk7RcjgJIb313CMiGAcZXwtgP3QPe0X1W2qMg51dSQ65gasDI8vfaMwKroOTIhBWO4eUlX2b5mTfzHy19jIfAYhEUCm+pcytcg32juj7IuLJ52pzEK5K0a795EhHhH50Tk2o65bjzeAWiY4T/VTqcqRkMOOVzQWy2wvu1TPSBGpal2iDQuQghsUkGLoQ38d9Y6xaNg/aTbYbJxhTZTEeAVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(451199015)(38100700002)(122000001)(9686003)(33656002)(86362001)(8936002)(52536014)(5660300002)(41300700001)(66446008)(64756008)(316002)(66946007)(4326008)(66476007)(66556008)(6916009)(76116006)(8676002)(2906002)(55016003)(7696005)(83380400001)(38070700005)(71200400001)(54906003)(53546011)(478600001)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cJEe3YzoheqzzANfcnFGujgdAEWRK8+LkRll689PNIXLoIw2In0KOSsUhUdt?=
 =?us-ascii?Q?TnPK5xVanaIQKLRkHbnyavXsDRsjpK5oGDgefmQGp0NYvUM0WkwvDHH357/U?=
 =?us-ascii?Q?hnoF5Kyci92zFolq0ZpsDf/g320lcjpeGyNUkgNUvI6M/f40hrQfWG2vMZhw?=
 =?us-ascii?Q?QGjc6HbS2yRUJFRHGF02gpmbJfqlNz7rQXFoYz9GloxzE6zoXaHLlvHb7E9r?=
 =?us-ascii?Q?R2DkqhL4pkFPRGvMD5NW6/17k6/Ry37dhK8HAeandhHWZMCmqP28fV7xSuHB?=
 =?us-ascii?Q?ykvBTZDUG4o7DqdWe1yoVr/MN+iweEGdyu/1xInk9ON8/TTWfMiri+IKSwjh?=
 =?us-ascii?Q?UAB/D+NAM5X0R2uUefk8JxlZJlXn1dOfaMRJBLyxkyIeri/z/ykWZYQlSH9j?=
 =?us-ascii?Q?zRKmao9sEdjWeSALHZ3IL7HfX2rq9FQyTXvWSbdTRFS1pl72XTXnIWwdierY?=
 =?us-ascii?Q?6DzFMBkAnk6DNshUlpBRDLBwvnpjh/Ej+dYPMQ9TnhD5j+MDRS70VxQoQpep?=
 =?us-ascii?Q?FwCf61QD0ojmccuydqs8J3mLjf46Va+XxWnqypkAMaWcQaZqq0KG+cw6ML9B?=
 =?us-ascii?Q?C+fwKRkeaj52mhp54yE9828aKWFZuPSmWKDn45s401dow4XHRDRqj6omUF4u?=
 =?us-ascii?Q?Gz/jB5LgC76OxH77C8QSFyFJsbp7ID7f9+FlE0nTgIBYlDyQIp+4Deu2AU1T?=
 =?us-ascii?Q?GxstydnFbPRRx6QPEXLP+QFfpKMjfPytChhub9nbu+kn3iUYHr1Qh+RbG/hr?=
 =?us-ascii?Q?pPNODbzXE7b7fYiSSWaTHGtkecqA2730uG7wEaqxq0FAnZQtBuF6jLziq/eY?=
 =?us-ascii?Q?cMq3ajIoYFUrZYsYmI+gRPrOHzYuloKj+is9shNeg7V+wRc/SPgLJ76EtwCn?=
 =?us-ascii?Q?GOYh3W7+VzBlAncg3vl0Z9jPrcyE4tPR6ICFhvogqGoSy13NS7OOFg6G6tsR?=
 =?us-ascii?Q?S+NAkrHLA2isT5RSEagYX0Gx0N8hMCbX0hhRjDsDBPNYNjFFSpk8MaeuW5gz?=
 =?us-ascii?Q?8xDFTrhDbeHSMhlDroZpar1XmP62inoTS86ul24qlX+YCySqytZtNTp5dxF1?=
 =?us-ascii?Q?UPptdUQt0qZMZtvTdTh2lOAjDVPRb4epxUgAg+dFGDC5llte1cIHkS7ha60E?=
 =?us-ascii?Q?RmLG69wTh6nE1iInkZJOCEWXKuzNocV7dQaFIcUoCUCw0cNHGKEXZRa8tQg6?=
 =?us-ascii?Q?oZ7o6vV3Utyxa6YibzH6MjRSXkbh9coyCpw2EgLr84Q+9CytfrSzclSUXxAX?=
 =?us-ascii?Q?Cr5XsdLUw5eQEVVy4Ay+xPhhrUOxXTfYkbmZxuQ8w9mjGvekbujx8A+Iwqh/?=
 =?us-ascii?Q?egSqHVt7sVQ836PVeGsPXNe5aDE7zyu3Co8gKQSj4yxPHZG9DVk1Ha8DGqM6?=
 =?us-ascii?Q?34hOrU36Uy+o7FUYxzydG4rzh05DGXzWoPLhTVRsBbcsENFO8gVGz/dJLK8k?=
 =?us-ascii?Q?F6eunXnoMdzqnIIPt8HRRKODBMlPtLXRuPvQWPfvCy9Rn9W7F9m+d1OKfbGo?=
 =?us-ascii?Q?TKZnZJTCNtXAzA+8TuDFyiQ49h3Ck2w0CzzfuukR66N6/pRYPtKwD4VvLJSd?=
 =?us-ascii?Q?2G1cGthGbJ3TrAdJxSsuv5+YUW7rQ0D8UFkieVZM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94314423-eaef-41a0-d879-08daf71faa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 17:40:59.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66+7SqZxWgT8SsB21lCwL++UBzJ+HtN2zc//OC+drNa73g4MLkzFJM81gFiHdhBwu/E/a5qVN6XccBgOFdHWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6532
X-Proofpoint-GUID: CkI1rqko2i76AFxCBl9ZSIvjmfVRQZ4s
X-Proofpoint-ORIG-GUID: CkI1rqko2i76AFxCBl9ZSIvjmfVRQZ4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_13,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150138
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your feedback and efforts. I apologize for some missing point=
s of v2 patch. I tried to do my best. I will be more careful to fix all fee=
dback before sending new patch so I want to ask a few things before sending=
 v3 patch

On Tue, 27 Dec 2022 10:54 AM
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/12/2022 23:38, Okan Sahin wrote:
> > The bindings for MAX77541 MFD driver. It also
>=20
>=20
> 1. You did not follow entirely my advice here. Read again what I asked yo=
u to fix
> in commit msg.
>=20
> 2. No improvements in subject - ignored comment.
>=20
>=20
> > includes MAX77540 driver whose regmap is covered by MAX77541.
> >
> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> > ---
> >  .../devicetree/bindings/mfd/adi,max77541.yaml | 102 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 103 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> > b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> > new file mode 100644
> > index 000000000000..50f93cb0bb66
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/mfd/adi,max
> >
> +77541.yaml*__;Iw!!A3Ni8CS0y2Y!5i9A0O1bNDHqRib46J285KCGbVLbqULqRRa
> 153Q
> > +XIaclV3BEUrMbK0XAuXk3meed6XG3y7HigRu81P9dqjnUsb9S3g2t$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!5i9A0O1bNDHqRib46J285KCGbVLbqULqRRa153QXIa
> clV3
> > +BEUrMbK0XAuXk3meed6XG3y7HigRu81P9dqjnUsRlxWY6o$
> > +
> > +title: MAX77540/MAX77541 PMIC from ADI.
>=20
> Drop tralling full stop.
>=20
> > +
> > +maintainers:
> > +  - Okan Sahin <okan.sahin@analog.com>
> > +
> > +description: |
> > +  MAX77540 is a Power Management IC with 2 buck regulators.
> > +
> > +  MAX77541 is a Power Management IC with 2 buck regulators and 1 ADC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max77540
> > +      - adi,max77541
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  regulators:
> > +    $ref: ../regulator/adi,max77541-regulator.yaml#
>=20
> Wrong path - it should be full path with /schemas/ just like it was last =
time.
> However such file does not exist, so again as I said - you did not test t=
his patch.
> It's non-bisectable patchset. Order it properly. don't ignore the comment=
s.
>=20
> > +
> > +  adc:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        const: adi,max77541-adc
>=20
> This is a friendly reminder during the review process.
>=20
> It seems my previous comments were not fully addressed. Maybe my feedback
> got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all reques=
ted
> changes or keep discussing them.
>=20
> Thank you.
Honestly, I don't quite understand what you're suggesting regarding the adc=
 part. I thought I should add the adc as an object since it is in the mfd d=
evice. Do I need to remove this part?
>=20
> > +
> > +    required:
> > +      - compatible
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,max77540
> > +    then:
> > +      properties:
> > +        regulator:
> > +          properties:
> > +            compatible:
> > +              const: adi,max77540-regulator
> > +    else:
> > +      properties:
> > +        regulator:
> > +          properties:
> > +            compatible:
> > +              const: adi,max77541-regulator
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        pmic@69 {
> > +            compatible =3D "adi,max77541";
> > +            reg =3D <0x69>;
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +            regulators {
> > +                BUCK1 {
> > +                    regulator-min-microvolt =3D <500000>;
> > +                    regulator-max-microvolt =3D <5200000>;
> > +                    regulator-boot-on;
> > +                    regulator-always-on;
> > +                };
> > +                BUCK2 {
> > +                    regulator-min-microvolt =3D <500000>;
> > +                    regulator-max-microvolt =3D <5200000>;
> > +                    regulator-boot-on;
> > +                    regulator-always-on;
> > +                };
> > +            };
> > +
> > +            adc {
> > +                compatible =3D "adi,max77541-adc";
> > +            };
> > +        };
> > +    };
> > +
>=20
> Stray new line. Drop it.
>=20
> Best regards,
> Krzysztof
Best regards,
Okan
