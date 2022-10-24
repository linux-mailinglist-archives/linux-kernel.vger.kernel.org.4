Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C10609FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJXLKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJXLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:10:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EA65C8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtgFw/SvDH87auPIJEGgdGFYifxmTlPqvMkgl7lcXlASew4bLQqWtqiSB1jEWA6Qd61X4rJhIXg5wQw8lxM0Kjo3VHX9pqVPbKeeRWUnS53Xqs0kHw2V1qjQ0g7wNW6uvuimlE0tGC+KiwF2eos09gvmhTCJO1g+Wz98XovRH5l9rGF5FiHmcyyZ/ayJ3O7bN9bTnsNVnGr5TQ5imKeq0QkAPSmWfchf0gddkmk2NqQcJ6TZdYNeOTOL79W2Ird+8Mwo9Sx/pIgV9s0c8A8NDtt1k0QhDOmwZvcEFuJPL2BcIFAYAHphyX0vBKN095TjzXhnqUzGoZDDiqCAYPMDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2YuaZmssFXotjh78rTwVQ5eyM/wtC5Sbz89hZNGB8k=;
 b=ItLzwy78L4WOpf8igE5DfyOJrqAqb2Fw2Gi9sS2c4RFxV68X2bqdwOSq0fegorpZWiKkeUPACdDuVRfgA6S0UcH4q1rYBktuCGpbXxm0g36TueUYyOvBRWclBYdrw9AFB6BCXRKeF310IijvARYrckBy3DQtSRelMlOmMR5HPjzdF1PGPVaplevDrqSuZCODih+go8aEEICE2LKYjO7wTXAdKh670DzoX0r44w44z/04TdTi9fTEN3E3pfqbJw2xtVkzic5FzS5jM+eoVQrfcJkDeq/ul9mbs/eGRBTaOKGxnuDkXPF/+QOBy/Mrq6EbScvBNmpyQMyZ9GIv7D2plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2YuaZmssFXotjh78rTwVQ5eyM/wtC5Sbz89hZNGB8k=;
 b=EGIU+KL3Ciz6E9DNdgj1B5l/0gmBcQVq3HbyvlI4wr7FurKpn7pbMUoZciiTgEDYPtFMMhyqgd8zFcRdcZXL6TazaemtWBzM1D16MpOOlORE5lZlTKXKI0ruFQXESxmbr87EfCiNY6r1x/Oak8c0qcP8Hbh09Pl8OON8bbAXClG5n3pekS+/NhEApNQPSxeehD7DcHZUWulczS8dXdths8ctbV1SOKzTCoQ5R5IdVqV2CxnBmukYRcS3jNsXi2UKdjVhH2g3gFPfs/RXXXHRSZ0707a2seVfheobPO/Dtucj/T0p/K9W9+3epgLc3ZMvf91mrneGLExR/0Z+naSGGw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB5162.apcprd06.prod.outlook.com (2603:1096:4:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 11:09:49 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670%7]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 11:09:49 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Subject: RE: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
Thread-Topic: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
Thread-Index: AQHY50vG98uWpiwLxUepDlRUWf/jUa4cymsAgAACbaCAAAIQAIAAkOYQ
Date:   Mon, 24 Oct 2022 11:09:49 +0000
Message-ID: <TY2PR06MB34248C051B8F5CCE3F47E1F6852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
 <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
 <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEsVP8qwT5aOqvwp-YjswT59Ctu6jDfYPBftzbn_wb7ZzA@mail.gmail.com>
In-Reply-To: <CACGkMEsVP8qwT5aOqvwp-YjswT59Ctu6jDfYPBftzbn_wb7ZzA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SI2PR06MB5162:EE_
x-ms-office365-filtering-correlation-id: 4a6ef501-1d32-4d7e-d0d2-08dab5b04447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WguelbU0jLdSG+pf2MuO70lFQu9W5wyjEnIZ7FM1v6vEw0BDsPn2kjWA/BH+slFfwAGZbMKpp6XE2I9odbSsyeDB6JZhhPndZ30iwhmpmkc5FJv/cLNj2BpmnRKUUNG3zHAjDkmYPu5DjcDEpxYOkf9i5fHZAqGONhJPdezQx9tTY8jd8IxHIEAdeHfBC6uuSq0Dp3VJXgJsHKDweIvRAHMOj/QR8KYJ/zZEnfjU31WYMl8nGtL+EYLlVAfAwwnvRYN9CLeK6d9Bm1hoCtA6MNCnhVBDU68jdrD0iTLDSgSfbrIs72b2HFFSFIJxyQCLIWj59p0SsYXeeBVZjGYGWaZKjhwSDwrqQnAaG013/ZsRnIbNXBBk0flHvovtnvkXArLEaNSMF3mZHB4590vBX5AcAoHaL9Ex0GoGbPRAN2UptfqxhlWzWwwbIaZnAd95sFg9co7Rn700A4AzO+EB+chX2JTTL7Va705tOh4g0VywljPzDHRvIYgyySuUymmNnQ0mC2NT6+AgK2ERXB9jxtLrTfmExgn9MvWibaeCKbGjnKWFE0JD3VBoiJGUhFTRuTU/szGSGGTM26l4ZIU4QWEeDNi0NPjB74vJ4p4DFuSMZrfuMnRx9h64VZiNt84CbiWBKQWBaAJ5GkOvBmYokGAk0VP5L0MFkhZIaLby6SY1MXUFcLQgGG35paK+JLxmllC1N/LPTI95WoGi17q82dznSmn3yWQ8Z6c6J5WmHdFoLwC6LSlDsrxWo1gg+022t2/G7oTO70JCZeZDENPiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39840400004)(346002)(366004)(451199015)(26005)(478600001)(7696005)(55016003)(71200400001)(9686003)(53546011)(2906002)(6506007)(86362001)(122000001)(38100700002)(33656002)(83380400001)(186003)(38070700005)(316002)(41300700001)(52536014)(66446008)(66476007)(8676002)(64756008)(4326008)(110136005)(54906003)(5660300002)(8936002)(66556008)(44832011)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDF0MmpSYTJmeGc3blJEMnRWbERrSXRMK3Vjc2tYVzAra3lWc0JUY2VDcnda?=
 =?utf-8?B?UFNUNlA2NEVIbWRPWVhMb0Nad3VyNVpTYVg0TURiUmVGZ3FjWm9RT1BZQVNl?=
 =?utf-8?B?akN4K05hSUEwb2RLMW91L3ByS1NXVVBRTGpPeUdBMVBLTmJjS2pZSlhIWTlk?=
 =?utf-8?B?bkw3QUswM3RtT1VJcFhTVDNoRWpPUTc2ZzBxZndYREUwbk82a3Z3NDJOcmVu?=
 =?utf-8?B?emNVdk0zaXZQcjRBaUdlK2FpTmxQb2NWbHFjTGpldjdHT2hZMUVzQlljckJw?=
 =?utf-8?B?OGd4alNCaDIzWUN3YUU5Zk9YMmU5R1JuYnYrQkRidmdBbEdISXQrNDZ4ZnBi?=
 =?utf-8?B?V3RSL2JqNnlONTBwSmM0ZEhrK2dDb1loQmRwdVZ3UklOL1RvVWh0dVlJeDJN?=
 =?utf-8?B?ZUltVTYvajZiN1ZVWkxVTnlqbUFqSWRvQi9Jcjg1ckh4dTJRV3l4dHV5aEp6?=
 =?utf-8?B?QzFlMjNlem4yWDVoODZibnFQbG5vQXEyQWVRS2tNUVJmUjVFdGRMalN6VVhs?=
 =?utf-8?B?UVY1dmdZSzJYT3VzOWlNOU5NVUNONDZRR1pjejBZdGJ1eVlpOFZ0THV6S09X?=
 =?utf-8?B?RWx3RFdEcjM1MS96NEpTTEFCcnFyZDVZeGJ6Y0NCbW9tYU0vSjBER2d1SGtI?=
 =?utf-8?B?SHo2ZVcrTUFyMVF0U3JDZmZkdkZQZWFDeEFoeU5nQytKOHhWNzl4TmR0dzVm?=
 =?utf-8?B?RXJlcFZ5WUVTcFpWV1ZUMjArWGJDQ1k2Z0haNkZjNjhPbXJ5bkloSE5RSDhX?=
 =?utf-8?B?U216RGJ0aE5TQ3NjWisxVXdMSkJJczVzN08yN1dLbmNBclk5cEF4YlRadjlz?=
 =?utf-8?B?cVpNSDh4YnNBcURGb01HSFdmTWIwQlBibG9hUkVhdUdER1VVV0FVTVJ4UU52?=
 =?utf-8?B?bzNJdTZ5T0I3c1BmUEN6c0V0MGVUK3Jack5jWndKVmJXVVRqb2lIY3dVSEk3?=
 =?utf-8?B?RjVBS2hIOHVOaFNVVjM5WlV6YnJkR2FmNklMc0ZRRUNjWDV4U3dsZ2x1RXVa?=
 =?utf-8?B?WDFRaEVtaGF5MEdCVngrV3JiU3ZpdTFydStZcXQ3QkR4ZUY3Ym1RK3B6TlAr?=
 =?utf-8?B?S3BDa1JDajB3dmFKQm5CWDVvRDFOcktFb010QTF4aGlZZnozYU8yd2d3RU10?=
 =?utf-8?B?QmQ3NnpvcGlaS2ZyaTBQRlhXOFhjbnBpZkF6TExlbGNLZ2R2VzlYN0NFeEdV?=
 =?utf-8?B?VWt6cWcxd1ZwMGJhZXdJcFRrdW1GZGZNNWZqbEo5N05EM3kvbFptdmgvRmNH?=
 =?utf-8?B?bm43b2VUVmg4aVhIaXdCNXZIUWVvSGVJcy91ckRHOTlVckxpV2tNb1RuLzBj?=
 =?utf-8?B?M2llOTZTU2xqMUxBTk5MaHpzTkhnZUxneVN1aWdKQ084cGV2SFJ4bDZGVWhJ?=
 =?utf-8?B?WTA3UTZiMWFvSW9QcnNJMHI4a2dzR3VkVTIrTmN1VWlyeFJDNkxwenEzRVE1?=
 =?utf-8?B?aVMwVVZVckFGTFlObk0xaS85WjNrMVBjbGI2STZ4THhmaVBybEd6ZWNNQTBO?=
 =?utf-8?B?KzVNaVBFbWUwcVlWY3U2TVZWbDlTcDcxMlhtd3U5bmxnWTNVV0NOTHhxL3hj?=
 =?utf-8?B?YXBMK3BVSEJOR2JxaW5IRFJ6ZzgyT2lMOGhLNHp3SnU5QXlZWlRuOG9UQkVX?=
 =?utf-8?B?ZWpqM0hDejZkUC9LbHM4NGl5ZWRtbEI5VWtlRDl0dWMrZWEra2xmZGZQYWF6?=
 =?utf-8?B?bW9sdmNCSjFVTVZJalRnZ2hsVUNpQUtyTi9abkplS0pheGN6K1dTMENFNnVH?=
 =?utf-8?B?dUlJWGZLNnFzRlZpWCtPMVJYREhuZlpvNjhIRDJLaWVNVUk0dkdmWHV0RzBw?=
 =?utf-8?B?SGJwOU42SVROb21QcE1tVkMyTjkzaDBReG8rN0ZwNnoyalpjUXUxd05KeHJK?=
 =?utf-8?B?SHh0YkY3UGIvRmNzWHF5NHVxd2hWdjlJL2VIOGpjcVhVRFhDa0Y5c0NlRnRk?=
 =?utf-8?B?Q09NeGdjV1VuQnV0RXdqZDQ2Sm9pODhKb2Y2MXAra0EzY2VKbUsvT1Q2amY1?=
 =?utf-8?B?MFFLWVRLZlBaK3lQQWRseklTMkhzckFoTDVnT1RubXJKYjM1QTQyMnVxYkRo?=
 =?utf-8?B?VHB0enpDQlMwNEo0R1pLWnF5UHFJVGtwZnpXY1d3TUxXclc3aE56TURvZXN4?=
 =?utf-8?B?YWpmakcyUm5MQ1BXVHZZcC9QS29hd09sTVFsUXRkWDYxWXlzTmNNaW1SbGxl?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6ef501-1d32-4d7e-d0d2-08dab5b04447
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 11:09:49.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGkS3TDA4ZDk/S5VUpEvJ36pIBzdCILK+KJW0Yalgc8T/YIeHm8p5zj4f5d2rvr+gDATp2y0VJm4uNkoc5ox7/bnCmB5shUqI1zKDLEQUw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgbXN0Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNCwgMjAy
MiAxMDoxNyBBTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbmdzaGFuLnpodUBp
bnRlbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdkRQQTogcmVuYW1lIGdldF92cV9u
dW1fbWF4IHRvIGdldF92cV9zaXplX21heA0KPiANCj4gT24gTW9uLCBPY3QgMjQsIDIwMjIgYXQg
MTA6MTYgQU0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgSmFzb24NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiBT
ZW50OiBNb25kYXksIE9jdG9iZXIgMjQsIDIwMjIgMTA6MDEgQU0NCj4gPiA+IFRvOiBBbmd1cyBD
aGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBtc3RAcmVkaGF0LmNv
bTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW5nc2hhbi56aHVAaW50ZWwuY29tDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyXSB2RFBBOiByZW5hbWUgZ2V0X3ZxX251bV9tYXggdG8NCj4g
Z2V0X3ZxX3NpemVfbWF4DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBPY3QgMjQsIDIwMjIgYXQgOTo1
NiBBTSBBbmd1cyBDaGVuDQo+IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZ2V0X3ZxX251bV9tYXggb2YgdmRwYV9jb25maWdf
b3BzIGlzIG1lYW4gZ2V0IHRoZSBtYXggc2l6ZSBvZg0KPiB2cSxub3QNCj4gPiA+ID4gdGhlIG1h
eCBudW1iZXIgb2YgdnEsaXQgaXMga2luZCBvZiBjb25mdXNlZCxyZW5hbWUgaXQuDQo+ID4gPiA+
IEFuZCBnZXRfdnFfbnVtX21pbiByZW5hbWUgdG8gZ2V0X3ZxX3NpemVfbWluLA0KPiA+ID4gPiBz
ZXRfdnFfbnVtIHJlbmFtZSB0byBzZXRfdnFfc2l6ZSwNCj4gPiA+ID4gcmVuYW1lIGltcGxlbWVu
dCBvZiB0aGlzIG9wcyBhbHNvLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1
cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPg0K
PiA+ID4gTm90IGEgbmF0aXZlIHNwYXJrZXIuIEJ1dCBudW1fbWF4IGNhbWUgZnJvbSB2aXJ0cXVl
dWUgc3RydWN0dXJlOg0KPiA+ID4NCj4gPiA+IC8qDQo+ID4gPiAgLi4uDQo+ID4gPiAgKiBAbnVt
X21heDogdGhlIG1heGltdW0gbnVtYmVyIG9mIGVsZW1lbnRzIHN1cHBvcnRlZCBieSB0aGUNCj4g
ZGV2aWNlLg0KPiA+ID4gIC4uLg0KPiA+ID4gICovDQo+ID4gPg0KPiA+ID4gc3RydWN0IHZpcnRx
dWV1ZSB7DQo+ID4gPiAgICAgICAgIC4uLg0KPiA+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbnVt
X21heDsNCj4gPiBJIG5vdGljZWQgdGhpcyBhbHNv77yMYW5kIEkgYWx3YXlzIGNvbmZ1c2VkIGJ5
IHRoZSBkZWZpbml0aW9uLiBUYWtlDQo+IHZpcnRpb19wY2lfY29tbW9uX2NmZyBmb3IgZXhhbXBs
ZToNCj4gPg0KPiA+IC8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9DT01NT05fQ0ZHOiAqLw0K
PiA+IHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgew0KPiA+ICAgICAgICAgLi4uDQo+ID4g
ICAgIF9fbGUxNiBudW1fcXVldWVzOyAgICAgIC8qIHJlYWQtb25seSAqLw0KPiA+DQo+ID4gSXQg
anVzdCBhIHN1Z2dlc3Rpb24uDQo+ID4gVGhhbmsgeW91Lg0KPiANCj4gTGV0J3MgaGVhciBmcm9t
IHRoZSBvdGhlcnMgdGhlbiBkZWNpZGUuDQpPaywgSSBub3RpY2VkIHNvbWUgZXhhbXBsZXMgb3Ro
ZXJzIGxpa2U6DQoNCmlmY3ZmX3ZkcGFfc2V0X3ZxX251bShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2LCB1MTYgcWlkLCB1MzIgbnVtKQ0Kew0KICAgLi4uDQogICB2Zi0+dnJpbmdbcWlkXS5z
aXplID0gbnVtOy0tLS0tLS0taXQgdXNlIHRoZSAnc2l6ZScgdG8gc3RvcmUgdGhlIGRlcHRoIG9m
IHZxdWV1ZS4NCiAgIC4uLg0KfQ0KDQpPcg0KdmRwYV9kZXZfZmlsbChzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHN0cnVjdCBza19idWZmICptc2csIHUzMiBwb3J0aWQsIHUzMiBzZXEsIGludCBm
bGFncywgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQ0Kew0KLi4uDQogICAgbWF4X3Zx
X3NpemUgPSB2ZGV2LT5jb25maWctPmdldF92cV9udW1fbWF4KHZkZXYpOw0KICAgIGlmICh2ZGV2
LT5jb25maWctPmdldF92cV9udW1fbWluKQ0KICAgICAgICAgIG1pbl92cV9zaXplID0gdmRldi0+
Y29uZmlnLT5nZXRfdnFfbnVtX21pbih2ZGV2KTsNCi4uLg0KICAgSXQgdXNlIHRoZSB2cV9zaXpl
IHRvIHN0b3JlIG51bSBhbHNvLg0KfQ0KDQpIb3dldmVyLCBzb21lIGZ1bmN0aW9uIHVzZSBtYXhf
bnVtIHRvIHN0b3JlIHRoZSByZXR1cm4gdmFsdWUgb2YgZ2V0X3ZxX251bV9tYXggIGxpa2UgdmRw
YV9kZXZfcHJvYmUoKS4NCldoYXQgaXMgeW91ciBvcGluaW9uIGFib3V0IGl0PyBNc3QgLg0KDQpU
aGFua3MuDQo+IA0KPiBUaGFua3MNCj4gDQo+ID4gPiAgICAgICAgIC4uLg0KPiA+ID4gfTsNCj4g
PiA+DQo+ID4gPiBUaGFua3MNCj4gPg0KDQo=
