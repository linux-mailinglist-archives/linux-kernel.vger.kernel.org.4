Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88169AE28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBQOf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBQOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:35:56 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8664B07;
        Fri, 17 Feb 2023 06:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTitLonJ4X8V+G7hrnaNnkKHDaZRiJFh5w+OrYjfTZHxfcM3CMM8+q7efXxILJCRl7jU7qKvrrvRCke7l2DSoDMIhtLMyoaDwxwWwdm+0lqXetlemEfL4eoWeXfe0RlPG9TAe5RGrvAQ2/pv2QpLwNCEu7u3c82TD+t+ir9Ka7tuuNGWz/5VhT6zo5IECWtqJ6vDmDBFEJsZJ9RGVgIrDGPqSJqakXsWNjwFs0cIuxBFJ02g8GQzk3WdV6aud4WwwlojJg6Swpl8ZpIdnM7ZDGy5XL14cTCPjoz4UXf46lYAom/SXo/B7q63PYmj7xuvSKdOwxPcHVxSJjyrLFYcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeuIiU8wkUaAfrruKZ+2yX3RoY17OhAwBFH/FOZSo0M=;
 b=QPaWXdZ9CPgt9PDlF4kuX81WS9MRcJY9mhp/Vg2rjlWmquytGC+PrMOHLeokh/8M44Bj6vR/DCcWBiyAQX31ZWKNGJeUFV3FJNWCQI2pO1IEVEw1k9084dTHljDxwGnq/zlGPaLxOrnXvXc5OaoMV3ugr3VO0fC6xDXwmKxGpTeW4r4wte2pzRwpphfb8Okmwm8ZB0m2YN3Pkpztcewlebw4aZlp4DeFHS7nHPEEBhrbk5hH0P61eAKOurOpYSfSlrLRaEzGeZOP0VWdmYwzlN00C5GDq9aciR3FB0FTHFn+toSxc+PqnXedpibRdHJvZm7lZrQtIi174X6zxoKdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeuIiU8wkUaAfrruKZ+2yX3RoY17OhAwBFH/FOZSo0M=;
 b=WBJ6O6bZErucqR66QG+H/RUQax6Gg07uaThV9jmeEY1c+5v3zjSHADgShs8VLl9ytPrasokSrNz3C56cVvskuEbk3OoUesrSyUv70PdIH9yAu9SOIwHsNsE90ihRBBeq8Ak6vACJBN+cGfnkKqnOma6twejvALRdfTof03MsSMETSoSfyyEl2BUupEGUN3EyomBQl6zVscMJi0fANUg0b9wvzFJ9UuMg2klGtEoHYXbvldhfU8FChJD587yhEoc8huQSrro/M4IXalVjYH3Wjc5JSc2EBFi7DMH8SdymaWRU8fZj8y2XWhHfE5lXvFopVBh2evhDOeJ0zAHAznXfmA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1866.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 14:35:52 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 14:35:52 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHZQgM90k2+mVJ2NEqh/LEr0apefK7Rlz6AgAAUA4CAAAStgIABdHEAgAAEMQCAAAmigIAAA2EAgAAAqoA=
Date:   Fri, 17 Feb 2023 14:35:52 +0000
Message-ID: <73f98755-9230-c4d5-0e12-38e6f3b0a189@csgroup.eu>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org> <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
 <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
 <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
 <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
 <Y++NY7iPvNAVbwMv@MiWiFi-R3L-srv>
 <97732d97-06a7-9307-7ad1-ef69d980f3d2@csgroup.eu>
In-Reply-To: <97732d97-06a7-9307-7ad1-ef69d980f3d2@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1866:EE_
x-ms-office365-filtering-correlation-id: 5f2326bd-6184-4d68-b6e8-08db10f44526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/uIs2ujy+A2SSRtJ0vpAaiGFpDCfFxL3NQikkKhz+64m5YIKeF6QES3LJXGF7JMW4Qv36Hbc1njvCCc0OCV2vD7j3vaS1y0/8Qsw6znzDIO02nGgI+I8D0KaH6yUN9kOrtbhaZ15P65hcaLAQKUtBo+oHKJ1rfLPx9JVUy4xtf4EdrWkgAVPeQfViOlQk7vjR51lsV6qbHq1jMGPK/nVN1LRzQYfmMYymplA1+sWT3x++hbVBUURz4Au8nfomF5YyUROTTXeZ/G7G5yFp+bO1ph25Gr2kQWJfN/8Oc/HYF2ArU0gOoylBIvoF1VuS5XcSdO5GyYxKfs9FFm8viL9XDuRQSoGhiQGZjWQ5XvdbQvrsZqJEjQcLhjFtl2N9idUtNp759gkYkx6g/cSzsnzdq63CgXpTZ6z4oiT84ncAGemwp2DmqKBNLU5zjC4iwy1NZzAhlGh149eC3qOX0+uuwq2aO+rzzHXCZ7JHx44jn+3M7O8cPQz45I728FHIRCpvBzZXnZxP+x7PZOFGREBdMRHcbg6DWfUNUCy7fUXu43H/CVQRncIWzMhec3tuXd76HR/hEkDMM4hCKXBt+4nIDM3tGUSmcuuwnClNuXJiwfZ6kCs+QsdozgZkDd6Nd/4KqTiptXQAYhU8q28bWaL7d7xGcWplksJscxMSf33QqRjr3/a8uOnNljCdk+qD0qapQwYHXM8E9dyo8pRdJL63JZf7/D8ayBUZgNCOS8xEy+pSzzVVXNV4sLJiqey+g65WOmJ8DYO3SWnJfYRoIujE/Ec/3MB/V3bMVoUywMYWfI4vKHwoSbooNPz/8EI/yx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(451199018)(31696002)(122000001)(41300700001)(66476007)(66446008)(64756008)(66556008)(6916009)(8676002)(76116006)(66946007)(4326008)(6512007)(26005)(186003)(7416002)(44832011)(2906002)(5660300002)(86362001)(38070700005)(38100700002)(8936002)(2616005)(36756003)(71200400001)(478600001)(6486002)(31686004)(6506007)(316002)(91956017)(54906003)(41533002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBxMXB0NGhWa29ZR3daK3BVenF4VlpNams4a2lTaDgrYVNpcjVpWktDcmsv?=
 =?utf-8?B?MExTdFRCRzFZUm9HVUYrMHhUSjFuL25YYlZZQ3JxN3ZIU1FqMXk0MlFJYkJM?=
 =?utf-8?B?NkFULzBPUFNsbmNsSDVLYXBEVkxXUkdJRnZPS2lJbmFhK3VlcjJVOVdyd1NC?=
 =?utf-8?B?dm8rQzhxZllrMnJGMDZUcGJGendPNXNVZzV4WVdDUzFLaFRmTE96S3I0UnhP?=
 =?utf-8?B?TTRXRTFBUi9EMG9iaktYZlJySktzL2lvSW55aFpyUkJrN2lJMlBsV2xPYmU1?=
 =?utf-8?B?azkwK1ZtWUhQUG1jcUZKK3pSYyt6NkdJeTYzQWUvR2ZNOUNGSHk3d1M2clhs?=
 =?utf-8?B?RHVMVi9LU3VMbFg1MGtLTDh4M20wbnFIQ1F3a00yVitWdGRraXdEZHpvTFFT?=
 =?utf-8?B?NE4rcS9VdDRvb0JSNk5sSE0yMFd0SXBNT2MrL2ZXOGRtd1JUU0VkelRNdlJw?=
 =?utf-8?B?RGlGNkxuS0kydUtrN0lFcDZ5MTk4QVFEMWcrSGJzbVgwK3JsZnR4ckJSdG1z?=
 =?utf-8?B?WXJsR3R3QWdKNEkvQjNSeDlzNVVmNUsvc05XaEl4bWwzc242emVHVXVDeVc3?=
 =?utf-8?B?STc3dkNNbEdxSkFjME5QT1JQMlZ6dFNaUklhcUpJaUh6SDBLZmpKRGtodXpZ?=
 =?utf-8?B?T3E5dCt3WUxrSVhLbnU5bGEreHhVbzhtYlJ6N0xsN0N3SElpZllJSnVod0Ir?=
 =?utf-8?B?Z2IzemlDbWQ0NlpJOWVPV2RTVUd0M1hvcnNHdmZOL2NQRVFKclN0ZFk1VVdD?=
 =?utf-8?B?bE1DMEgrVFNkZE5uV0JYTzg2dDRBYUJIUGVoQ0laMm5kV3FBcEg5ZjgrMkN1?=
 =?utf-8?B?eENOa3lHU242VWNqTlRhUjJ2OGJwOStaWTdLcTVMWHBiUnc5SmpiMlJpejl0?=
 =?utf-8?B?Mk9vZ0FsTU13c0JHd0MzNjBlS1IyeVJBT1pRaGVUbHQ2NXJMUmc2NGx2cmox?=
 =?utf-8?B?cTl2UUhaai9JbkZ1Sll4b1gyR2pJYmI1UjhWRFVBcmtGYkNmQXp5MGxOSDRU?=
 =?utf-8?B?RTQyTGxYQWRFeEZTSmVSMjJ6UjR4RkloRDhJbUpTdVJPeEJGZUpmd3N2Nmh6?=
 =?utf-8?B?eExFK2MwNjIvcjlsVDJ5MmFRSlF6c1BVNjdvTjI3bjVEcWxmdzRxQldSbjg3?=
 =?utf-8?B?MWp6TUR4N0w0UEJ6bXlHLzNUSDFGMTJtdFVWYnhuZ0lRdEhSam9yTkVHVlJ4?=
 =?utf-8?B?QURjZkh4eFNuVis2aWxhdHlkdUdJL0U4cVAycVhUUEFkaU0yODZHYTZPdmY0?=
 =?utf-8?B?dmRhTVJLQjAwdFZIQjltR0tFL25odHVYSmh4elMvZE9zNlNsQTEwMWhUR240?=
 =?utf-8?B?aFIyWGJOQ1cvcEFzN1MzT3RJLzlRQXdaSVBZcWFhd3dUYnBSMm9TVDN5eXFV?=
 =?utf-8?B?Y1V6aEFkNXYzOFZsVEhoTTFraDdwaWdyQWlZdXozRFptb1NUdGppSG5Rd1pa?=
 =?utf-8?B?OElSMzRGK3YwWUxaSU1sM01EdmpWSUpEazFrOW54KzZIajB3NE9rUFk5Y2hW?=
 =?utf-8?B?eEl1R0crOWIrb2pXRlBWYVFpN3AzUDlla0dmNG9xZ0czQjRNWk5kaDJvc1Bi?=
 =?utf-8?B?b1NVc2pDZUhFMGVwRkZyVjZqVjgzNzRYRFM1bHB3S3RVdWJTSzEyZC8yYVI2?=
 =?utf-8?B?cC9nWm1Uejl2TXNDSXROb0N1N3BENDRjSmZLZTZZZmhJbno5M2hiSHExMWdL?=
 =?utf-8?B?UExrcDlyZlVHZ3BqbldLZDZQbkhYSlNkNzlLQUFLWGVOR0hlTTVJOEdEbms0?=
 =?utf-8?B?M2RSa2NBZjVESEdrSFErRFU5N2x6OVJSS2x2ZTZzYndGWlB6dG16RVVycWZF?=
 =?utf-8?B?cy9Pd25OQVVTSWM4eUZqRStDc2g5ZjZ0dXE4Y2N2Zk9FYVEyNXo1ZWQ2MkNZ?=
 =?utf-8?B?TTdwbUc4ZmdMS3VJZVF2NUVYUzcwR1Vyc2YxbkZDUHE5TmRhR3ZGTzF2K0Nj?=
 =?utf-8?B?cGpkV2Q0Vm1PY2FpRTZjSENmR05RcXRTSlRJMnFBV2FRQS8rb2NDakxBT3lZ?=
 =?utf-8?B?KzF0dThIYmp5dmlhbmRRaUpGeU5rVTY1WmNhL1hUUVBOTmUrM2F0eUhuZUll?=
 =?utf-8?B?TTlJSEliQk1oVmlOZG5NMCtiY0pCMkJ2c3R1ZkJvRzRFbTNSaTVzN3hUSkJi?=
 =?utf-8?B?dHBGUnpkUVRNV0Nxbk9XbDFwbmQ3RzFiOEVWL3VFNE9jNjFqN0pJcG45YkRC?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F05058EF1F5F45B1B7055EFD55285E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2326bd-6184-4d68-b6e8-08db10f44526
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 14:35:52.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzZQU7L6YqssclEynkZIJEYRIxld55jJzJvh88wcXeMXaDmCZq4VPmtc7EMDzsZsFrZ24e33EGFDfjXfYi8093sOqx7nQS66gZiHd3cCD0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1866
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzAyLzIwMjMgw6AgMTU6MzMsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gDQo+IA0KPiBMZSAxNy8wMi8yMDIzIMOgIDE1OjIxLCBCYW9xdWFuIEhlIGEgw6ljcml0wqA6
DQo+PiBPbiAwMi8xNy8yMyBhdCAwMTo0NnBtLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+
DQo+Pj4NCj4+PiBMZSAxNy8wMi8yMDIzIMOgIDE0OjMxLCBCYW9xdWFuIEhlIGEgw6ljcml0wqA6
DQo+Pj4+IE9uIDAyLzE2LzIzIGF0IDA0OjE4cG0sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+Pj4+
PiBPbiBUaHUsIEZlYiAxNiwgMjAyMywgYXQgMTY6MDIsIEJhb3F1YW4gSGUgd3JvdGU6DQo+Pj4+
Pj4gT24gMDIvMTYvMjMgYXQgMDE6NTBwbSwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+Pj4+Pj4g
SXQncyBub3QgaWYgaW5jbHVkaW5nIGFzbS1nZW5lcmljL2lvbWFwLmguIFRoZSBBUkNIX0hBU19J
T1JFTUFQX3h4IA0KPj4+Pj4+IGlzIHRvDQo+Pj4+Pj4gYXZvaWQgcmVkZWZpbml0aW9uIHRoZXJl
Lg0KPj4+Pj4+DQo+Pj4+Pj4gaW5jbHVkZS9hc20tZ2VuZXJpYy9pb21hcC5oOg0KPj4+Pj4+IC0t
LS0NCj4+Pj4+PiAjaWZuZGVmIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4+Pj4+PiAjZGVmaW5lIGlv
cmVtYXBfd2MgaW9yZW1hcA0KPj4+Pj4+ICNlbmRpZg0KPj4+Pj4NCj4+Pj4+IEknZCBjaGFuZ2Ug
dGhhdCB0byB0aGUgdXN1YWwgJyNpZm5kZWYgaW9yZW1hcF93YycgaW4gdGhhdCBjYXNlLg0KPj4+
Pg0KPj4+PiBOb3Qgc3VyZSBpZiBJIGdvdCB5b3UuIEtpbGwgYWxsIEFSQ0hfSEFTX0lPUkVNQVBf
eHh4IGluIGtlcm5lbD8gSWYgeWVzLA0KPj4+PiBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4NCj4+
Pj4NCj4+Pg0KPj4+IEF0IGxlYXN0IGtpbGwgdGhhdCBvbmUgYXQgdGhlIGZpcnN0IHBsYWNlIGlu
IHlvdXIgc2VyaWVzLCBhbmQgdGhlbiB0aGUNCj4+PiBvdGhlciBvbmVzIGluIGEgZm9sbG93LXVw
IHNlcmllcyBtYXliZS4NCj4+DQo+PiBUaGVuIHdlIGNhbiBtYWtlIGEgcHJlcGFyYXRpb24gcGF0
Y2ggdG8gY2hhbmdlIHRoYXQgaW4gaW9tYXAuaCwgdGhlbg0KPj4gcmVtb3ZlIGFsbCBBUkNIX0hB
U19JT1JFTUFQX1dDIGRlZmluaXRpb24gaW4gYXJjaC4gSSB0aG91Z2h0IHRvIGxldCB0aGlzDQo+
PiBwYXRjaCBhcyBpcyzCoCB0aGVuIGdldCByaWQgb2YgYWxsIEFSQ0hfSEFTX0lPUkVNQVBfeHh4
IGluIGEgZm9sbG93LXVwDQo+PiBzZXJpZXMuIFdoaWxlIHRoZSBmb3JtZXIgaXMgYWxzbyBmaW5l
IHRvIG1lLiBUaGFua3MsIENocmlzdG9waGUuDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
YXNtLWdlbmVyaWMvaW9tYXAuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvaW9tYXAuaA0KPj4gaW5k
ZXggMDgyMzdhZThiODQwLi41ZmExZTljYTk1MWMgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2Fz
bS1nZW5lcmljL2lvbWFwLmgNCj4+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvaW9tYXAuaA0K
Pj4gQEAgLTkzLDcgKzkzLDcgQEAgZXh0ZXJuIHZvaWQgX19pb21lbSAqaW9wb3J0X21hcCh1bnNp
Z25lZCBsb25nIHBvcnQsIA0KPj4gdW5zaWduZWQgaW50IG5yKTsNCj4+IMKgIGV4dGVybiB2b2lk
IGlvcG9ydF91bm1hcCh2b2lkIF9faW9tZW0gKik7DQo+PiDCoCAjZW5kaWYNCj4+IC0jaWZuZGVm
IEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4+ICsjaWZuZGVmIGlvcmVtYXBfd2MNCj4+IMKgICNkZWZp
bmUgaW9yZW1hcF93YyBpb3JlbWFwDQo+PiDCoCAjZW5kaWYNCj4+DQo+PiBbfl0kIGdpdCBncmVw
IEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4+IGFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL2lvLmg6
I2RlZmluZSBBUkNIX0hBU19JT1JFTUFQX1dDDQo+PiBhcmNoL21pcHMvaW5jbHVkZS9hc20vaW8u
aDojZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4+IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2Fz
bS9pby5oOiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPj4gYXJjaC94ODYvaW5jbHVkZS9h
c20vaW8uaDojZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L3NmYy9pby5oOiNpZmRlZiBBUkNIX0hBU19JT1JFTUFQX1dDDQo+PiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9zZmMvc2llbmEvaW8uaDojaWZkZWYgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPj4gaW5j
bHVkZS9hc20tZ2VuZXJpYy9pb21hcC5oOiNpZm5kZWYgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPj4N
Cj4+DQo+IA0KPiBOb3Qgc28gbWFueToNCj4gDQo+ICQgZ2l0IGdyZXAgQVJDSF9IQVNfSU9SRU1B
UF9XQ8KgIHwgZ3JlcCBkZWZpbmUNCj4gYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vaW8uaDoj
ZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4gYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lvLmg6
I2RlZmluZSBBUkNIX0hBU19JT1JFTUFQX1dDDQo+IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9p
by5oOiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9p
by5oOiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiANCj4gQW5kIGFsc28gbWFrZSBzdXJl
IHRoZXkgZGVmaW5lIGlvcmVtYXBfd2MgOg0KPiANCj4gJCBnaXQgZ3JlcCAiZGVmaW5lIGlvcmVt
YXBfd2MiIGBnaXQgZ3JlcCAtbCAiZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV0MiYA0KPiBhcmNo
L2xvb25nYXJjaC9pbmNsdWRlL2FzbS9pby5oOiNkZWZpbmUgaW9yZW1hcF93YyhvZmZzZXQsIHNp
emUpwqDCoMKgwqDCoMKgwqAgXA0KPiBhcmNoL21pcHMvaW5jbHVkZS9hc20vaW8uaDojZGVmaW5l
IGlvcmVtYXBfd2Mob2Zmc2V0LCBzaXplKSANCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2lvLmg6I2Rl
ZmluZSBpb3JlbWFwX3djIGlvcmVtYXBfd2MNCj4gYXJjaC94ODYvaW5jbHVkZS9hc20vaW8uaDoj
ZGVmaW5lIGlvcmVtYXBfd2MgaW9yZW1hcF93Yw0KPiANCg0KDQpCeSB0aGUgd2F5IHRoZXJlIGFy
ZSBzbyBmZXcsIHlvdSBjYW4gbWFrZSBhbGwgYXQgb25jZToNCg0KJCBnaXQgZ3JlcCBBUkNIX0hB
U19JT1JFTUFQXyB8IGdyZXAgZGVmaW5lDQphcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9pby5o
OiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KYXJjaC9tNjhrL2luY2x1ZGUvYXNtL2ttYXAu
aDojZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV1QNCmFyY2gvbWlwcy9pbmNsdWRlL2FzbS9pby5o
OiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2lv
Lmg6I2RlZmluZSBBUkNIX0hBU19JT1JFTUFQX1dDDQphcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
aW8uaDojZGVmaW5lIEFSQ0hfSEFTX0lPUkVNQVBfV1QNCmFyY2gveDg2L2luY2x1ZGUvYXNtL2lv
Lmg6I2RlZmluZSBBUkNIX0hBU19JT1JFTUFQX1dDDQphcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5o
OiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XVA0KDQpDaHJpc3RvcGhlDQo=
