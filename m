Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22C364066A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiLBMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiLBMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:09:35 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58ED290F;
        Fri,  2 Dec 2022 04:09:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BatkSqOM64yprHis5qmODyfgw0nSFCgLQyMU3qj+kfPYQGqq8zm6cR49BaRchq7dcNnF4LYYpp5mSWFwo/jTl9vEBvttp7rKmNW7UBAa5vM0GVn8WA8NZPhQOUt5hgxZWmMVR+hH1d7oZn5YZY6BO7A28QPqAcNfCjiYqxYkkbYhfZH98T5vgrpFo+dy/65GgzqDJtU3AZOY5hwIAc7Z+ptxwkDlKmNAo+CGP+1rEsKRRTKQkF+1ONs52ERE72xkEpBl2C0UBhv1/IxLOKmCIt22XIsAf99YuSu9t0f8enST4tF4YYR33ddq1ADUqs9ShUBe7myzRzMBWIsiEuKE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDXjTGjlMnodrPakueu0nVcuXCzvv2UOGq+MGvvaJ4A=;
 b=eXH/ea2uBjzI62CGN2NFHfcoRhWJXrlVxqQJUpU5nXy+MeYpv/4CN5hFRsepOyVwEAIBXQTqo5Fr5gVA0U/MqbD2HhzeqWbV9YGlfsuYl7+maHwhVCScyHE51lilvWKm/mPs9f3DvIadvpnOE2xsLipiTu/DJH09OVs3E5xxjIDQcoLMhgMvWiKjp/HSxAbN2iO43okzKfJfIF2zwXTj8JiiMiHFqnYzNL7dmgwRvG63l0NWibXLCz2z7DZ6K2t4v/Mp0iunPnQlJKGU7Os0xhzjk0h7vhQp2C1/vHWlhoYj8TUuaxpMCe3bDsLf98ezYRwramw2oe0+tJpZg+rHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDXjTGjlMnodrPakueu0nVcuXCzvv2UOGq+MGvvaJ4A=;
 b=P50nMfSEMFU9ZJjJlnsgrUAfpO/LgZ6uds70t7ePCog3vdE1Rti3fSNT7Agaanp47XmsOQXEKy4EqkHQAbPcs/sCvtwlRB/DpsnWMbtuzoxkFCqYyhLObKz/FOPSgoCKEDEIPUVUcopu5yBKb/rTEBkWrLrSkj/HvG3KAYbGgnQ=
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by VI1PR09MB4317.eurprd09.prod.outlook.com (2603:10a6:800:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 12:09:30 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::707e:3312:93f6:f84f]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::707e:3312:93f6:f84f%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 12:09:30 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>
CC:     "jeff@labundy.com" <jeff@labundy.com>,
        "nick@shmanahar.org" <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "giulio.benetti@benettiengineering.com" 
        <giulio.benetti@benettiengineering.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSCB2M10gSW5wdXQ6IHRvdWNoc2NyZWVuOiB1c2Ugc3lzZnNf?=
 =?utf-8?B?ZW1pdCgpIHRvIGluc3RlYWQgb2bCoHNjbnByaW50Zigp?=
Thread-Topic: =?utf-8?B?W1BBVENIIHYzXSBJbnB1dDogdG91Y2hzY3JlZW46IHVzZSBzeXNmc19lbWl0?=
 =?utf-8?B?KCkgdG8gaW5zdGVhZCBvZsKgc2NucHJpbnRmKCk=?=
Thread-Index: AQHZBfrTblKfCCV2rUKZmnorTq+cy65agdmA
Date:   Fri, 2 Dec 2022 12:09:30 +0000
Message-ID: <C2D744D5-0DB6-4396-953F-9322DDDDA6E2@kococonnector.com>
References: <202212021104265067026@zte.com.cn>
In-Reply-To: <202212021104265067026@zte.com.cn>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4884:EE_|VI1PR09MB4317:EE_
x-ms-office365-filtering-correlation-id: bb33e008-5235-4d8d-5292-08dad45e10ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LiiEqlIWIbpbFlamL72fxOYqLXmfG0WYUjy4HiBOWVxZ+Bque+DjM6bz+llv43ODfythtcu9jshZBpb8OB+wzZSQ7/tmw3UDpbMYuv4l5jEGwoaorVe1vxPTYhpEt+jJ72Sth2bzd529mp5K/e7Cfae0AU+cQuOygNjtaibynexztdSmqJ4rHscIjCO6OexoFsuMHF70Ul2a4BQx/pknX17bf8LY9WEznT9+fhS3Tcc7OHFqCdzgneNM5ltXQVh2iaFEmftff6+nsdhUi4EYk4MmrgeTIYZsmmo+K3JNMvYVdqw6cHz4rrTYXFAbcORw+owzX53eq9OYrEsj/W2otR8AEkzMQ/gsoYL4u//M4MAh6F7RrabUcRN5LlRE9fMlhRXPM1zolOLJt4DlRpqzBVFgDWqm0lTjwLjyKHRGnx2ARFSDCqrnHwWg88xcMXrafs9Di692JWxpGsZ8xuh6+Z4bRGjRYce4V9MNcGZT0nH0kWX7K4w6rHVl6qrtYR1UkwFvhN0gmvZJ4zzahx60Xv1o1Yhv+U8GIPEIacp43xvmwUnQGVIOn/BnykGd7LWA2dkh4yLwir2lDn4x2h51zLx3FYyoWImEouH/ecx0gG+NBtSI4MgUCgTaaBVJAu3G4fnEeW7cFXImHcTD13yAMHU5Y+mk0D4qESKN7+i+1+oqJn53E5fpmHZz7KkfJzR5soPb0SZb8dBDDa9QxbvSEt0cvt4mGQ8EjT2nhR3guss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(136003)(39830400003)(451199015)(6506007)(66946007)(6486002)(54906003)(316002)(26005)(6916009)(6512007)(478600001)(4326008)(64756008)(71200400001)(91956017)(66446008)(66556008)(76116006)(66476007)(33656002)(8936002)(2616005)(5660300002)(44832011)(186003)(2906002)(36756003)(41300700001)(122000001)(38100700002)(38070700005)(7416002)(86362001)(558084003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWxNKzJYcm1JWFVQcXVzMUxkbFZsT1lYcWhhZHorNXo1d0NuNTNDTEdBWW55?=
 =?utf-8?B?WlhKMTV3ZXRtQjFsWmNCNTRPallkQWhaeXBPL3dxcmZrdUFUWTZoaVlUR0to?=
 =?utf-8?B?ekJvQTRlMUhjb05zOWI4TTdiTGdyWUcrRnFNbHFLaXc5dXFybFFtbzRCbSsv?=
 =?utf-8?B?anVlNFpNODJHcEQ2L2dmYi9mS3M1cG1IQkNGM0kwc1A0L2JEcnI3SEk2ek9X?=
 =?utf-8?B?TTZkVks3YUNOcHZONkhVcFlvbDU3elFTaHVEVUZGaW91cXRIUU1xdEF6YnBB?=
 =?utf-8?B?SGY2em1hTjRaUENYQ085VzlKeUM1QWJ1ZEJCcjR0RUNReDROMTY1VG9YcGZt?=
 =?utf-8?B?cUhpRzhjbTJ3aGRrUFl1Mk1Rb0Y3ZVA2eWpjMWVOdUs2cE13S0Y0WDFJdHdH?=
 =?utf-8?B?YUFqMVo0Y24wcXJ1Tm4yUzR3aENPWDBicXQyZ2xUem1qcDdNcTdpY1FpeUNk?=
 =?utf-8?B?R0dJaFN0ajJpNGRwN2J0dzR4SjZtTisrM24wUEE0UWQvQXdacDFmVHY4Q3BN?=
 =?utf-8?B?c0s2b3ZKK1FjTkZYZXhCNUhWWlI3R3NpVTJXQ0xja0ZPbHMyWkJ2bHNscWtU?=
 =?utf-8?B?WVhUVWRKMW9uVC85cEl1V09OSEJsMHBSNmlXWk8rbUFFTlQvT1l5Q0VGREpF?=
 =?utf-8?B?RndyM24yRE4vbFNkZW5UTmdaR2VIOXJXMWt3Q3BwMUt4Zk51Wi85MVJPamxy?=
 =?utf-8?B?TDBFb3QzcVFqdUlWZXYzZklmbE0zSjByQzQveFNrZ2lXbjRPdFpkaUF3V2Ra?=
 =?utf-8?B?MXptRiszMXJOYTAvNzU3NGloZmcxRnpGZ3Y5N3Q4RS9HMlI4aUtnMHdoK2dm?=
 =?utf-8?B?cWkvNnZJV3NKNGZZN3VKK0FpKzVrMmlGR0RsZU9KT2R5NGNOME1HODNPRmdu?=
 =?utf-8?B?YkJhRUQ2TS9kcEJld2NaYVZUeWZSVDhUQ1MyUEQzUWp5WENOTlYrWC9iMEhw?=
 =?utf-8?B?UnhIV0tNY0NiQU41R3owcXcxQWRvc25KVjU2b2xTWmtaMzEwOGhxQUIzWVV1?=
 =?utf-8?B?QWpGdUppdkNYYkJ0Yzh1WmsyMHBBRjRESW9rREtZb2I0TWw4NCt5VGc0TzVX?=
 =?utf-8?B?YldJa1E0QUUrTlhCQ1FnSGhVeEdkeEZIR3VEdjVncnQvK21zTTFwaDlUdFJk?=
 =?utf-8?B?djVjRzg2anlnV0M3OEVGcXFVQU5nQ3VMZFUxamxnY0pHT1YxMkErMTlxUERQ?=
 =?utf-8?B?Y09UVndsQVhIeWNWNHJ2amlRNWNNMnU4Q05tRUsyY29yaHdWaStwVGt5YSsv?=
 =?utf-8?B?R0gySEtZYTBVdjdJSUtYeFQ4UU9qNUFPOWIxRnIwRStYbUsrVkNkc1M2ejBk?=
 =?utf-8?B?K0lOM0dOeGFlQnV3eFRMQlBFdzZvUVFDNWM4SEdaR0tXWmZJRldycWtuYVJS?=
 =?utf-8?B?NE5hSEFMVGpSdWRDTWpuVUFPYlJHZHAwZFlrZGF6NU5CaUc2VTl5Q21pQ09a?=
 =?utf-8?B?eGg5Ym9BdnRQWlpVSjVTYmZFS01wQzY0TTE5YThQWEdGNG56VU5vMmxodldD?=
 =?utf-8?B?NXQwekQxUldDZFBraks1bElhVFpUQ3U0bG9LV0NodEJ3YUN4d05pTFcrRmNK?=
 =?utf-8?B?K251Y1lmRldKQSszM29MMGNOZ08rQmRIOG1UODJ4SnJkeGtVTzFxOGhVWWdh?=
 =?utf-8?B?RitFc01RVWNSREl0S2NBUU9peTZMWkNWNWlsdURrMHcvNVkybjJlUUIzU0Jv?=
 =?utf-8?B?K1paSXZsRGl2MlczTWw3ZGxJQk8xYlgwN1VFbyt6OHJlOXZtRWxFb1J3UGFN?=
 =?utf-8?B?OUlIYUdiSGNBTGtGd2trcUxNT1ovdElXa2pzamtpSzBnd1prdGNzeHlLbGRR?=
 =?utf-8?B?R2lZbkRPVWxBSHJvU2pjUmx0M3hlVG9ralo4cS8reUttY2h1MDNFZjY3aER6?=
 =?utf-8?B?SEU4NUo0YkhZUXB2ZDlzVGhvWFpBblRJS1JlZGV4MHFIczUrT2xIK0JGZFpa?=
 =?utf-8?B?NTlkM3lpUjdBbFNVOW9WNE9IOGJJU1NsR0VUYmZwTXlJNzAwWnJSV0M2Unha?=
 =?utf-8?B?K2ZtY2h4M0luaVFySkNLdElEVnFSbTNETCtyMHg4OXNBT2Z4UU9iWS92dWVY?=
 =?utf-8?B?SGVkRzlJeVZwaVBVdGNjakxEMXpIUHBPSmlJR0tMVXMralVyVWpvQkVrWEt0?=
 =?utf-8?B?M3UrTUNvL3pWdC8zNkUrRnFMTVY4ZVVGb2d4T21rbmFnTzlyTGxxVlhKVUhw?=
 =?utf-8?Q?9iI3H8NnQvhBsqXD6TnYSlM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <007D4CA75B1DAA4581814D66B0F1972C@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb33e008-5235-4d8d-5292-08dad45e10ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 12:09:30.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM6M52V8q//BS9gqnBAxLF2PguNhE+Gxsu/Wb965+Yg3msIeLyBxVV8fg3qcsfSx0nZh7uuIzjSkkQhewXvNGeOY8xIZLWNn2fek1hQZjN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4317
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbSAwMi4xMi4yMDIyIHVtIDA0OjA0IHNjaHJpZWIgeWUueGluZ2NoZW5AenRlLmNvbS5jbjoN
Cj4gDQo+IEZyb206IHllIHhpbmdjaGVuIDx5ZS54aW5nY2hlbkB6dGUuY29tLmNuPg0KPiANCj4g
UmVwbGFjZSB0aGUgb3Blbi1jb2RlIHdpdGggc3lzZnNfZW1pdCgpIHRvIHNpbXBsaWZ5IHRoZSBj
b2RlLg0KPiANCj4gQWNrZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGU+DQo+IFNpZ25lZC1vZmYtYnk6IHllIHhpbmdjaGVuIDx5ZS54aW5nY2hl
bkB6dGUuY29tLmNuPg0KDQpBY2tlZC1ieTogT2xpdmVyIEdyYXV0ZSA8b2xpdmVyLmdyYXV0ZUBr
b2NvY29ubmVjdG9yLmNvbT4=
