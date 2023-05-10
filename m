Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EBA6FD804
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjEJHSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjEJHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:18:05 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F45FD3;
        Wed, 10 May 2023 00:18:04 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A4weqn006874;
        Wed, 10 May 2023 00:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=46K6IsiS2ebgW+kWJxZbMRoo1s1l4HI80eBcOJPYhug=;
 b=bP7f41DRg27rv7wLmfFcoHUjUbjBDcf5IASYuQEYB86LC1BvoUadVhyEVvCow/KYLxPH
 QCIYIBkbUdszH8VuMK06UOrNBifwQgOuAOJ6gOjLLv7yO4YiZT9dc8hSghVmJeCfppMP
 nX+awV29Q5bdzdk4oVaIRGzPmFYBgEURJmFDGUVJowREeYhkF1NFB1cmLZTxvqNwK4dB
 E7jkSwmLshAcKsfq3GHoXrK+o5IHtP6AkhsDLpyD2CPC4SccLIt05rSFYYISD8eOQI9o
 YxMaVnzR9PZbymluqxOylf+2cGLfuuKbTCnBAJw8ofR4uEyzdGV3fdOHQ0tBcHLjs2bR Og== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvbchu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 00:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC/byVxEeRoJLHL1MxBtPlJO9YVox5VDhRV6m2ynbj4J/npKmuOqPzWhGgzEIA+XvqDCsWJqpZUixx+bO2V2cIaOPa3GDXuy9/myhdDNNmyHGGFlT/lKYGMEIJDgAINUYuGYyCVTMD79eW5yo4KVVxhp8Qs/FjjwX5YsHtt3e6u2KV8dDyXJ15fUnvB8EapW4O8QCX4+GTSkJSEMwMG3TAh3oTb3mpTm19nstjXMV9Uqi3j8jzqO85I8rFTJiP/5avNJQYLxDD4HB3NNyjKC4B4+d0DV7m1OwDFwUECEiv95P8jMqT6e87v2v8+0/k6e2BE40BiOAkko/KMlOYOvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46K6IsiS2ebgW+kWJxZbMRoo1s1l4HI80eBcOJPYhug=;
 b=a6ubNqQyQwwibRu1X3M8gWf1dP5V4HkOy73zXC2UaWxeo4gIrhl26qarlNl6rrtYjh+HFtKHyRYkXjZ+twkfCt7AvNm+XFb5VgaWHObujBT4MjPmuDbR0jVe2rWukjLtl3vwsiFQ6ayAEB0yVxADc1tkmPK+8jUQRRuXk+wAESuU0keqI/Fz+HtzX74F3sK5V+X/wk/HE6U1tuuUiIyjVpjKLfn12kdz4XMU0OxS3YQ4hOC8QyxiMzkuIf3afCYi/cYgyACUidOvDBo2EVyTPdTy0ogRQgIJv+wsIf5eHcHo8N5h18zJlb8K3l3Qzw37Ih23L+Z8TorIfwV1h7TF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46K6IsiS2ebgW+kWJxZbMRoo1s1l4HI80eBcOJPYhug=;
 b=x3thn6apFTgz5xmCJOCT7Nq/XHwPjrxiiJK5CvM/iADK3EVpfZYkVwvHGEw0NvlTMgQwP/pdem2SCtYgr3UXcQmg247v6xCrhRnsdgqJg0YmadmTGm8jCp1vyUEh5W8APjl2uOISznv5Fk5UWsFrGywtdlYRPdexvvL3VCtyX1w7jAYuLUIBjHNd8+5OYZ7zwTOUYrMYWE8noMSAjWofvU71Y4r4mv9dePR42FEV8urKGtfZ3BPy4fCZvO4ByBjBU6BfvQWxp2BGl9QOH+HgVNfJvCNwy3u4vud4104QWymWcLp/U8Xh532oVTAfdDBmoxZEMcs8O7KuNuBokrdSJg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SJ0PR02MB7438.namprd02.prod.outlook.com (2603:10b6:a03:294::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 07:17:56 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 07:17:55 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Rinat Gadelshin <rgadelsh@gmail.com>
CC:     Paul Moore <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH 1/4] audit: refactor queue full checks
Thread-Topic: [PATCH 1/4] audit: refactor queue full checks
Thread-Index: AQHZgYLqTxykIKmQ4Uicezhpz3TCIq9TFY6AgAAGbgA=
Date:   Wed, 10 May 2023 07:17:54 +0000
Message-ID: <53C78149-AE5B-4554-B08C-AEBBEBA1EA95@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <20230508075812.76077-2-eiichi.tsukata@nutanix.com>
 <527bf278-48a3-1b43-a23f-dd4cbb92ef19@gmail.com>
In-Reply-To: <527bf278-48a3-1b43-a23f-dd4cbb92ef19@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SJ0PR02MB7438:EE_
x-ms-office365-filtering-correlation-id: 3151621f-889a-483b-519c-08db5126ac9b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5CvHTZA4qHhcwATFYaKf7SQzCFZFRHxSyg+qhfAjnKQOihL37NlOnGdjh5H6nAR8XceqYIjtainCF527r2sVWdkoQOZxyaB34I1gZcdehGcKop85vRUYoABkPJH5Q3fV4Qkvrn39iLYtRvN7W9kb0NpUAmW0tk1zmU5x4mHsMPB32IzGwgBApUDX9jvHa+MB22mjTPjnqqfwj5SJCD6ZhFrS1JvKht9Nx/a88pmO9MQ1S4oXvF3F54eOYByxedwAHgJhCbu1o9iujBDdpyl5hSQO79bKI1yhdj/6bE9SJ3eeKdvoaM+0YzsZ5nwR8CWU4tcwnYOLLHxSnSpQbllZmIw/xfrDt/FUz82ikEr/TbhdEmQzqUn8fBaourxuETIIyLrRtD2KfCu/jchLqdIobpuBnPsmRkgXtOkt+XoaJLSA5QL7FnHEATKv0l98gkFs01H7WkVSC3DKUM+4HP82IgZKVK+1ATSDoGuYVxyhN99ArpbjlFOiiY8iVBX7Mp4+6GlP6JxfIallxJvC2satIoxnyZiDUqGbJs8hm2mrfjWaRa+5Ih39wc8hCviDcUvOVcJZTYkBmptajGwJP4V2LtaMEXQNLCgbpT5nyPSm9IbqC3+3AZ5dbFseY0AUmBfGvV8QM7ZAZjGrkHbs6Xs3bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(2906002)(53546011)(83380400001)(33656002)(38100700002)(86362001)(38070700005)(122000001)(36756003)(2616005)(41300700001)(4326008)(316002)(71200400001)(54906003)(6916009)(6486002)(66556008)(91956017)(66446008)(66476007)(76116006)(66946007)(64756008)(8936002)(44832011)(6506007)(186003)(6512007)(26005)(8676002)(5660300002)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlyUHBzNWNCOFNSbDg1MXM0NnB1dW5jbU9pQ2d6MVhhaXV6L0JOVmUxb25O?=
 =?utf-8?B?QUQ2ZXlBVVFIL081MkVXY0FEbDhjQnQxSzhaR3V1WDZ4S1pmdm1Ya3VhSzh3?=
 =?utf-8?B?VkJzenZuRkZMY1U1U054N3dteWYrTGNBR1R2b2M2enROZG0wVE1HeWF0aVhJ?=
 =?utf-8?B?cEQrTmxoL3Jrb1didGEraVAwcGZHaUdXdlRUYmpZWGxRTGJJMEVlUHd6bzV1?=
 =?utf-8?B?MHJlV3FtZXNWVmM3a05heGJTTmlBenVPcjM3Z3RLQTM3TDh4Y0t1OFBsL0tY?=
 =?utf-8?B?YndadVY4V2NRUTdsZmp1MENJWU9RY29oZGNkV0lteTdIRUwwUmNmb1AvVXp6?=
 =?utf-8?B?TUJpbmZMQ3lpMjFjUUsrblFnZDFSN2x2THlsR1dSaXFjbXhXMEd3VytMekJX?=
 =?utf-8?B?bEMxOVRVT2NxOHhPSURnc2JSQ2R4UHFXZTI2Qm9hdktVQjBuVlE5YXRNYy9v?=
 =?utf-8?B?Tng3WEk1bEFLR1piclhTMXozNmZPK1NTZmhZbFgrV1FDWVNKdjFmT3BkbVVS?=
 =?utf-8?B?bGNxV05LdCtxaHoxUEdOZzZHSlRzeWRyODRCVVBUVG8zRWRQWVptaWt2ZUU1?=
 =?utf-8?B?TERjQVhRQ1EyaUlLc3F6S292TVlqMHlwZUlCSEsyc2M4S3FlaFBaR0R2Q09x?=
 =?utf-8?B?dDFKbnpoSkJrelRBd3BxYVEraERlMkx4NVVrS3h2YjJMM05TcGpEckxGU2px?=
 =?utf-8?B?WGV3Wk1mZ2dsSXhzMzNBRXRmZ2tLVjdMU2xyZkhvMlRFMjBxSmx1TG9yeHBY?=
 =?utf-8?B?ZFJxenZ3MVFZTFF0ckt3VkRwa28xN1ByaDdiTjBMbUp1cEZWcE40RU9tdmI2?=
 =?utf-8?B?ZGp6bGdoUkNQemZUK3RPdXAvUytFYVNjYTBTN25kdStGWjVteDNaWStSQWVz?=
 =?utf-8?B?dUh2YTRkK3IvY1JKNXZvZVUxSGdudVpyZXNoT2Yvd1dPMHFKSHJVS0ZyN2gv?=
 =?utf-8?B?Nkt3MGtmMlVBVGl6MEZhN25LdE9mUnFESUZtbFp2YTFvOUFVeW9oUTRTdnd0?=
 =?utf-8?B?SDhJOTBXODFJVVZROW5zYVh5UHF3Znc3TFkzT2gwSW9Vb3pkaFJKOExOZkg0?=
 =?utf-8?B?Y0RpM1lOa3dpQ2F0dThIWFlBbktkTi9QTzRJMjFQY1NYUFJuTTFBT0ZlU1RC?=
 =?utf-8?B?MXptZFJwUUZ0aGlxN2VXL1B0ZFBZbHF4a0x2ZUxKQTRSSDU4Q0VHK0tRMlpu?=
 =?utf-8?B?Wm55MVlub0VoNTY5QU5BZlRzSlk4cXVHUmZ6YzBOeWFLRnZNenpNNnpuSi9m?=
 =?utf-8?B?ZENnQTIzTzFGNWROOUV5MGRPcWFCaVZ1dVIrazJlcVI0bTJjdWoxVElFcW84?=
 =?utf-8?B?QWgzY1dnWURhemduMDlUS2tCbEhLS25LQ1h6WFgyNTJzV2lON3NOdWZuY3hV?=
 =?utf-8?B?bGxKWWpLUk1oNEx6aVQ1eXZZakxLZFBqY1ZlMUl4Z3c3NWtwWFFHOTlwcVF0?=
 =?utf-8?B?eDgrVnAwQzdpc294NTdhZ3Bwa3BBZjlEYWJHWFkxRDkyNG5KOG15Wm0wVWYr?=
 =?utf-8?B?ZGc4anM0bWJsOXdGUGh6R0h5a0VLUHdOb3NRQVhQY1FXTzJZbXJ2cE10VFV6?=
 =?utf-8?B?bG44RVpickRzNUd0Z2NDR3paL0JpT0tySGdlMHoxNk1RY2tGQldvWExueTNm?=
 =?utf-8?B?RnhqOWJWeUUzNVBlU09JMkxGZjcxb0sycHBZTnlYQWZjOVhma05jVG1ITy9D?=
 =?utf-8?B?RTdpSXVpQzhYRnlrMFllTlVkck5QWCtsWWNWSjZ0djJlSEZvWW8yNWx6OFdi?=
 =?utf-8?B?L0h2b3NnRXFFZHBUTnBTQnJVa2g5SGVSOEJBd3BtUys5VFdPMzV0MVJGTlVY?=
 =?utf-8?B?ZG5LTXBYL1V5ajVKZ3E5ODFzcC9NS1RRaXE5dU1FTGFTTzFOVlorMFpEMEo0?=
 =?utf-8?B?OWxleXhwWi9XL3RlY3d3bDVpa1pGYm1icFY2LzNaaElIMkc4T0RsSjdTaUs0?=
 =?utf-8?B?K2lYSnNyY2tUalM0UWdFdTQ4TWE0R3FweXAvclJyU3ZyMWRQbmljZjAzK3c0?=
 =?utf-8?B?NEMwbytjbUw0dU1vMXRPeHAzZktrZm5tL3IxOXdoUGMrNDNUc0hNVEc0aWZD?=
 =?utf-8?B?ZDNaUmM4bmlCQVovbmFRS1Rxcks5NjRXR3V4T3dTcDMvOHZZM0NsYi9VVEdj?=
 =?utf-8?B?NEtKYjhMbjA1M29YTlNSZ0cydEQrN0huTzdiSVdiUlhtNWFKb3BDV2dKNEZ2?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC24C6ACB1E20741BE1D070446704A00@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3151621f-889a-483b-519c-08db5126ac9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:17:54.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLuxc+HhBehho0BJU7gFdsxkHTywINP52xP3J0xgQhXF9W9eT7nvxKsfzs5hi8TKxusQe8zA5GQRZXS775pzDp+oeJtUTjahgwHQ/Tuqz9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7438
X-Proofpoint-GUID: cwvs9Ct2rnD3ZqLJCRR6JGq2bKbChksZ
X-Proofpoint-ORIG-GUID: cwvs9Ct2rnD3ZqLJCRR6JGq2bKbChksZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDEwLCAyMDIzLCBhdCAxNTo1NCwgUmluYXQgR2FkZWxzaGluIDxyZ2FkZWxz
aEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGkgRWlpY2hpIQ0KPiANCj4gSnVzdCBvbmUgb25l
IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gT24gMDguMDUuMjAyMyAxMDo1OCwgRWlpY2hpIFRzdWth
dGEgd3JvdGU6DQo+PiBDdXJyZW50bHkgYXVkaXQgcXVldWUgZnVsbCBjaGVja3MgYXJlIGRvbmUg
aW4gbXVsdGlwbGUgcGxhY2VzLg0KPj4gQ29uc29saWRhdGUgdGhlbSBpbnRvIG9uZSBhdWRpdF9x
dWV1ZV9mdWxsKCkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVpaWNoaSBUc3VrYXRhIDxlaWlj
aGkudHN1a2F0YUBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4gIGtlcm5lbC9hdWRpdC5jIHwgMjEg
KysrKysrKysrKystLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2F1ZGl0LmMg
Yi9rZXJuZWwvYXVkaXQuYw0KPj4gaW5kZXggOWJjMGIwMzAxMTk4Li5jMTU2OTRlMWE3NmIgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvYXVkaXQuYw0KPj4gKysrIGIva2VybmVsL2F1ZGl0LmMNCj4+
IEBAIC0zNDEsNiArMzQxLDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IGF1ZGl0X3JhdGVfY2hlY2so
dm9pZCkNCj4+ICAgcmV0dXJuIHJldHZhbDsNCj4+ICB9DQo+PiAgK3N0YXRpYyBpbmxpbmUgaW50
IGF1ZGl0X3F1ZXVlX2Z1bGwoY29uc3Qgc3RydWN0IHNrX2J1ZmZfaGVhZCAqcXVldWUpDQo+PiAr
ew0KPj4gKyByZXR1cm4gYXVkaXRfYmFja2xvZ19saW1pdCAmJg0KPj4gKyAgICAgICAgKHNrYl9x
dWV1ZV9sZW4ocXVldWUpID4gYXVkaXRfYmFja2xvZ19saW1pdCk7DQo+IEl0IHNlZW1zIHRoYXQg
d2Ugc2hvdWxkIHVzZSBgPj1gIGhlcmUuDQoNCkhpIFJpbmF0DQoNCkNvdWxkIHlvdSBwcm92aWRl
IHRoZSBkZXRhaWxlZCByZWFzb24/DQoNCkN1cnJlbnRseSBxdWV1ZSBmdWxsIGNoZWNrcyBhcmUg
ZG9uZSB3aXRoIOKAmD7igJksDQpvbiB0aGUgb3RoZXIgaGFuZCBxdWV1ZSBOT1QgZnVsbCBjaGVj
a3MgYXJlIGRvbmUgd2l0aCDigJg84oCYLg0KDQpMb29raW5nIGludG8gb3RoZXIgc2ltaWxhciBj
aGVja3MgaW4gdGhlIGtlcm5lbCwgdW5peF9yZWN2cV9mdWxsKCkgaXMgdXNpbmcg4oCYPuKAmS4N
Cg0KDQpQYXVsLCBob3cgZG8geW91IHRoaW5rIGFib3V0IGl0Pw0KDQpFaWljaGkNCg0KDQo=
