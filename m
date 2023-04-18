Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408606E5A35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjDRHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRHPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:15:42 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841661BFD;
        Tue, 18 Apr 2023 00:15:41 -0700 (PDT)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I3gckJ015316;
        Tue, 18 Apr 2023 00:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=NZD9L6PFACn5ymvK+slp5ZLPLZc2YOxqD6enhdTwb60=;
 b=ZAmuMPNpbcTltDzlLrSx+g2RI129lLOP4LYwilc+KRfGnylTDkbD10ArZhH5oTVySQ2h
 MKeFJeEd0po6/WVmOTzJxkHAS1Nz+CWJ818hxGhe2RrKs7m8NkJCGZeTnvFEU1XpIU++
 aNlhTpWzlwgtBfUp5GsPuqzNCX3HUjPPQ5N5jyTN3uvqoMm9WDPVaJmQLO0dUlW/k+FO
 OUhkN28+z4hEVXm9yBLxQPLOd6Tjm6rYqdTbg1+PMTaVr9Lx5BOI64uY+y3/DOnc/qn8
 EOGoVeYTU7o06SLLoL9dLbk2XSG93Xsc6mdcx/l8xf/DCfe+yBRVNhVN3Tq+uSXBn1do gg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3pyu0gwc0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 00:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4GX//4gK5IvPq6CMmGMEkZEwWJ+3mxdRR9Ug55ab8E+iIoKnSD4M++7G+KagNYiCfaFQgUF4EqJEnjDRzxUtzsxlaAFFLXpkZRLNr+0pbhsrJPunrfGP0X+1tvxZXvWF43eIMu04HiksxNKl/dGQ29GKbZ+ofp6Irc0NG2/aU5nqteSbyOfnA1VGLZBtipzT8l5pqO5jnCD6/wIyQFVeidYOsD1wptbJ0683IjwaRlFvkMRTmCDu6YO2A8g/r9R6pj8VINuP0MucmeoH8NIFJXJWN4YqwEwLuUpi23SoOM+lf/2TXa7iDUaQbkRfJjSfZyW1PAyTiBdzh9rpTSoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZD9L6PFACn5ymvK+slp5ZLPLZc2YOxqD6enhdTwb60=;
 b=hY1Yrew55g60PeSB7igH3eQlxRTnWDD2Kxdlcnv8ySLvOeeCxDWsVB/T/m9fgJkoXmOPKzt8PzTnvDEfT3S8E0wnHKyLCkPGLDC9IA7dyyPlerqsdnwaZZnPmu8Dlrgqqr1zfqD4KTETwQ4VU2IH5Ex4FyOGMzhMq6iUtDke0/O5UoFeiINfyCb6UKKdmllVSqaCPW02nMpBiSgTJrbnhMUAQ0v8qPQs6KIWfAXejRXqd+lJMpUfADe6kvgyib/mUOjWS9DDL12T7qRYIMLCbwR19Ruv7XBP8hh0lnH70LPIt7lKk36L4UVFXuxIahmTmWkA7K+g5fEPMO6J8mO1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZD9L6PFACn5ymvK+slp5ZLPLZc2YOxqD6enhdTwb60=;
 b=BSy6qSb1sFObDzIgXclJ51eVg4JMJiNSoI+judkkW9fRgjYvsy4XXxOQ1Soi4ZdumrK7ODTJLcABjSgSzFLCHz9PWBTwYUEjSUFEogLyHHwVGKIXX16mnfHimUxMDoshh5MIghg1/eQQqAR/qhOVynHpKpwChCE+ADB+w7jE8EJIJ2TiaLbZ1nJhmtrTpRWzxbPYoARWJ6BuZ0y1YxkuTvHCI6+64jnwLv1JCunzBN45cdLZErynqmygPygyorenBQy8R0TteLspMv4FDYZy4EptNSqUJLlGaAryPnd9mTQEUaAnCv3woY2gNykFIGlq6e+GyX96xsp2YOO+uXObkg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SJ0PR02MB8673.namprd02.prod.outlook.com (2603:10b6:a03:3fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 07:15:20 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 07:15:20 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task()
 faster
Thread-Topic: [PATCH] audit: use pid.is_auditd to make auditd_test_task()
 faster
Thread-Index: AQHZbn8n344LVLDuMEy/S3bz9SY/4K8q4koAgASD+YCAAJLagIAAtOiA
Date:   Tue, 18 Apr 2023 07:15:20 +0000
Message-ID: <D3424939-C8D9-413C-8838-A832EC5BCF24@nutanix.com>
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com>
 <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
 <CAHC9VhTRXwrKkXMFJNiVgZbV=ZHExHa2VhBo6DKPEKZ8xcS=iw@mail.gmail.com>
In-Reply-To: <CAHC9VhTRXwrKkXMFJNiVgZbV=ZHExHa2VhBo6DKPEKZ8xcS=iw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SJ0PR02MB8673:EE_
x-ms-office365-filtering-correlation-id: c6e03356-add8-447b-947c-08db3fdcab87
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3lCF133ScGqWdEoILm4DniK3Q7LA/LTpqNyHgSaHh7ztt2mx7uxPbBy3wXwwDUnyY7EsFfZRaK6wWa6COJ0ADqjlqG5XwVQj/V2mwzq0o5KNEPPkwGwvxURnpH001q/7JtkYR0KRxN1D6tm3Ffim8llXuzQoaS9DR3dBaFSHTZ3N1XbB1NNo05ohriiGqalCXzT+i7qXTyt6yH/lHlA0YWRHXWODVAkEg+0FXNY+rjqPnfQVBHwl8iYUmcrMSpiILvoyg6ctdmQtQtNj/SDyYeM5DTrXSdpEk5Iy5RkYA/q6XQGpKrCxdXN2XJUij19VLjgGd/GetVEmZMWqPOmyuwGEmRP1T1mJSf9QIGFfir50F/O0+99Prq5I/CLHdOC/rxeY/nPnYcNFiQmDQx0xHomOH6Sjz2fX6XkguD7Eks5P1elJ1AYn71hNurTc7PbLaI5b36AHqMvKBxc4erKxqi90FfYmZEMW1tVvf1WQQrWOvbbSqBf20AI78o91/10kRkiDYq8wyOu3+078P5yPEuoWvh0df/L785FGvfYBPuVSaZ1HcuP0jcdewXopdO4D0xk/OWtzwkQwfmUMOyh5KN4kAnoW9rhiau19KtADwc7wjZ/NrMxJGfKRB/+E9rSvZeKpA/XQNZtDjLTCVu31OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(66446008)(6916009)(4326008)(54906003)(316002)(66946007)(76116006)(66476007)(64756008)(91956017)(66556008)(71200400001)(6486002)(8676002)(41300700001)(8936002)(5660300002)(478600001)(122000001)(2906002)(44832011)(86362001)(33656002)(38070700005)(36756003)(186003)(38100700002)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkhFRjJEY1RuZ29XQUh5Rk9SMEVoTFEzSU0xQW9OenVKak90L25xNEw1SExh?=
 =?utf-8?B?Ymh0OUVUbWZrbUx4eDVURXhRUXA3QUVSZ28yQlEyZUk1MnJDR1BlVnd0UUVv?=
 =?utf-8?B?NU5EZ00rQmJMQTFqN041TEkvU1JkZW9TSjBzREM1cWZjUXFSUnV0bytQMlBC?=
 =?utf-8?B?ZnlqOW1nVTdQbHdLbTN6eE5mV3hrS0xicG1KTFE4NkhwQnlqeWlXeHpYS09m?=
 =?utf-8?B?N1hQWExPaFdHMExhUGR3bWUzck1TVjhlMG0vN0N1UDNPSmh1Sm5PR3pySVdr?=
 =?utf-8?B?V0xmVUFTWlZHVzJNY2xCdnM5Q3VXd3gzU0ZrS3M4UEJsTjRRWVZwK0Y4aVdt?=
 =?utf-8?B?eDhJeW82SW92NGlJSVF3Vy9YTmhMQ2xxZThlemROdUhDSXNuUGtMNWlYRGhy?=
 =?utf-8?B?VlpjdXFsQ20xcmppWnhUb0VOMHlkRVFRdkRvdjJUWXJsb2dvMlo3MkZqTlJm?=
 =?utf-8?B?UmRFQ1lpZFp1Rk9HKzIxYW4wVTkvR0dObVhJazBXZUZtc0x1K0ZPWU5URU14?=
 =?utf-8?B?UG5LVGFma3JmMTJTU3dCdGhJUDdjWU0zODZNQXZreUNqajN3VDYvdzljRmNx?=
 =?utf-8?B?RUt6MSthOTNKTjl5S1dpdjRzdEl5ZXlUeXZkZ3pCcGUvVVJRQTdRWjN2YVVM?=
 =?utf-8?B?ZlNlRmdSaWxKTjVSMUtkT2xXNG1lUG9raWdiWnQxb0Zkb3UwMmMyZmNYa1h5?=
 =?utf-8?B?WnUxN05pMjRxUkZKVlFzSHhFTDZzT2xWY3FNb1dRZXozc3c4cFJZMVk0Tzhl?=
 =?utf-8?B?aE5ISWl5c1UvUUV4b1V1VkczaWk5enlDbnhyL0hFOG9kRXNsYzlmR29LRFlD?=
 =?utf-8?B?WHUveFhDMUs0TzBJMDZ6MEgyY2lFQ25GbndlbmZlU250Y1duVVlvbm1hOUQx?=
 =?utf-8?B?NnhRdHEyODZyUWI0UmxteXc0YTF2MTZxb1o0ekxoTWpBN3EzZEhjeFh4MlBL?=
 =?utf-8?B?UWljVDEvZDZBQVpHT2FxSHQvUW1jamV3MTNyak8zYjZ2U1ZHTnZrU3NSd2tp?=
 =?utf-8?B?L3AzQ1ZyMHNIOFNOMmRMNWV1dnFYcU9FZEUyVmVBSGpjUkFHa0VsaDk5bFJ0?=
 =?utf-8?B?TFlidU5OT05tYm1ib3NvV1dyTHNrbHFucU5vb2VFQkM0UEozeEo5TE91ZE04?=
 =?utf-8?B?VWxHcVlNSGFCQTNDSGYxdGxjRTNaOW5jK1NibXVYTHZEcENyQ0d2cE83ZE5r?=
 =?utf-8?B?cjM1Mm1mNG1ySEFvSEtScUZDSGlUWDZFWG5GRnZOOUhBZ1FJbUcvaDZ3dU5t?=
 =?utf-8?B?MTV6b2syN21ra3VQK0QzM0VzRkRuWmRFTnJPUjEweUpUYmRYSzNEbHMzdWpq?=
 =?utf-8?B?YkM0czU2aU9EZTVQcFRFQ2hJbmxxT2hDcVpVQjV4eWxwaGNWU2lsbUc5eW1z?=
 =?utf-8?B?cExJMUpRSlpRa0lsZkgyRFFGL2w2dm9xdTFmUiszVC96NHdmYkt5bEJHYllx?=
 =?utf-8?B?a2dEVDZra1lham9qN0hsUzlndWEvaUR3RUhPQWlOZHE3Q0N6T2JUUUVRQzNx?=
 =?utf-8?B?NzM4enhzRno0dFh6NUM0cjd2V2RYT3JSQW1iUmRZNGxNelEyRDFYT0M2aTlP?=
 =?utf-8?B?Y1FrZ3pGbHJLRHdyM3VtQzJXRXpuS1d1ZFpLTkNYREhFRCtxQTRGTHU2QUN6?=
 =?utf-8?B?OG1RRkNuN0FBODUySTZieG15VmpxbGYyRFJZelVlUy90V2ZqV3JQcUl5Wk1B?=
 =?utf-8?B?TFN0RmRQVG9sV1lteXpxbG84NWZoOUlMalNKaVUrQjJ5dVVoaGUrQVNVMUx5?=
 =?utf-8?B?TzErcnh4NkQzSHEyNmhFSUJMZmZ0MERlVGhrMFRxYk5XbmlRWEJ2TjN3dlRH?=
 =?utf-8?B?YlFyVnhjeUtheFZjTWdsR1grWHNJVHdBUXBZTkVqNG5wK2R5YitsbFh5ZFAw?=
 =?utf-8?B?emxrTW5BSnQrUXRhRlYvUk40MzNNclYyWDJURHQramlFWjJrZE9MTlNvQTBi?=
 =?utf-8?B?dkFKMHBneThBZk1QdlBNK3JMZXVDbllINnprVHNoYmlCdFpQbndUSTJxbktB?=
 =?utf-8?B?bmwrcERNTndXRHlGMC84ajh4TE5Hd1ZtNFJwcHp5OS9CUGtLdlhWN2dRQmVY?=
 =?utf-8?B?NFdqTjdQMmpjbC9uK3BOYnB1SzJFdnUwbTkyeENiMDFOcmN2R2NhMzlkY0dx?=
 =?utf-8?B?a2NNemVXVWtpRHRXYjVuNTdsUHpmaHV1dTZtMlZiUXZBWCtKeC91SlFwK05z?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5E28F1922F2584CAB53BB44F22344C1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e03356-add8-447b-947c-08db3fdcab87
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 07:15:20.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBi+hHjQsJ01HWuN+8YjLpJ6x9u1uUlxRhgv/xLJbhNEx9JTDPm4Nu/rieVOpyY/JAcd9vzVmkwmDdowphmeIGaWcyI68EmVw7Gp8cfXH3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8673
X-Proofpoint-ORIG-GUID: HQJCu33mEw26Yf9UeiOSwLgvot_DtjON
X-Proofpoint-GUID: HQJCu33mEw26Yf9UeiOSwLgvot_DtjON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_03,2023-04-17_01,2023-02-09_01
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

DQoNCj4gT24gQXByIDE4LCAyMDIzLCBhdCA1OjI3LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDc6NDLigK9BTSBF
aWljaGkgVHN1a2F0YQ0KPiA8ZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4+
IE9uIEFwciAxNCwgMjAyMywgYXQgMjM6NDQsIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5j
b20+IHdyb3RlOg0KPj4+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDExOjE04oCvUE0gRWlpY2hp
IFRzdWthdGENCj4+PiA8ZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gYXVkaXRkX3Rlc3RfdGFzaygpIGlzIGEgaG90IHBhdGggb2Ygc3lzdGVtIGNhbGwgYXVk
aXRpbmcuIFRoaXMgcGF0Y2gNCj4+Pj4gaW50cm9kdWNlcyBhIG5ldyBiaXQgZmllbGQgImlzX2F1
ZGl0ZCIgaW4gcGlkIHN0cnVjdCB3aGljaCBjYW4gYmUgdXNlZA0KPj4+PiBmb3IgZmFzdGVyIGNo
ZWNrIG9mIHJlZ2lzdGVyZWQgYXVkaXQgZGFlbW9uLg0KPj4+PiANCj4+Pj4gQmVuY2htYXJrDQo+
Pj4+ID09PT09PT09PQ0KPj4+PiANCj4+Pj4gUnVuIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4+
Pj4gDQo+Pj4+IGRkIGlmPS9kZXYvemVybyBvZj0vZGV2L251bGwgYnM9MSBjb3VudD01TQ0KPj4+
PiANCj4+Pj4gV2l0aCBydWxlOg0KPj4+PiANCj4+Pj4gLWEgbmV2ZXIsZXhpdCAtRiBhcmNoPWI2
NCAtUyB1bmFtZQ0KPj4+PiANCj4+Pj4gUmVzdWx0Og0KPj4+PiANCj4+Pj4gQmFzZSBsaW5lICAg
IDogMi41NzIgc2VjDQo+Pj4+IC93IHRoaXMgcGF0Y2g6IDIuNDEyIHNlYyAoNi42JSBmYXN0ZXIp
DQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWth
dGFAbnV0YW5peC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBpbmNsdWRlL2xpbnV4L3BpZC5oIHwgIDQg
KysrKw0KPj4+PiBrZXJuZWwvYXVkaXQuYyAgICAgIHwgMjIgKystLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4+PiBrZXJuZWwvYXVkaXQuaCAgICAgIHwgIDMgKystDQo+Pj4+IGtlcm5lbC9waWQuYyAg
ICAgICAgfCAgMyArKysNCj4+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAy
MSBkZWxldGlvbnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Bp
ZC5oIGIvaW5jbHVkZS9saW51eC9waWQuaA0KPj4+PiBpbmRleCAzNDNhYmYyMjA5MmUuLjVmZTM4
ZTI1NGM5YSAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9waWQuaA0KPj4+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L3BpZC5oDQo+Pj4+IEBAIC02OCw2ICs2OCwxMCBAQCBzdHJ1Y3QgcGlk
DQo+Pj4+ICAgICAgIHdhaXRfcXVldWVfaGVhZF90IHdhaXRfcGlkZmQ7DQo+Pj4+ICAgICAgIHN0
cnVjdCByY3VfaGVhZCByY3U7DQo+Pj4+ICAgICAgIHN0cnVjdCB1cGlkIG51bWJlcnNbMV07DQo+
Pj4+ICsjaWZkZWYgQ09ORklHX0FVRElUDQo+Pj4+ICsgICAgICAgLyogcmVnaXN0ZXJlZCBhdWRp
dCBkYWVtb24gdGdpZCAqLw0KPj4+PiArICAgICAgIHVuc2lnbmVkIGlzX2F1ZGl0ZDoxOw0KPj4+
PiArI2VuZGlmDQo+Pj4+IH07DQo+Pj4gDQo+Pj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gsIGJ1
dCBJIGRvbid0IHRoaW5rIHdlIHdhbnQgdG8gYWRkIGFuIGF1ZGl0DQo+Pj4gc3BlY2lmaWMgZmll
bGQgdG8gdGhlIHBpZCBzdHJ1Y3QgYXQgdGhpcyB0aW1lLg0KPj4+IA0KPj4gDQo+PiBIaSBQYXVs
DQo+PiANCj4+IEkgYWdyZWUg4oCcaXNfYXVkaXRk4oCdIGlzIHRvbyBzcGVjaWZpYy4NCj4+IA0K
Pj4gSG93IGFib3V0IGhhdmluZyBnbG9iYWwg4oCcYXVkaXRkX3BpZOKAnSBzdHJ1Y3QgcGlkIHBv
aW50ZXIgYW5kIGxldCBhdWRpdGRfdGVzdF90YXNrKCkgdXNlIGl0Pw0KPj4gSSBtZWFuOg0KPj4g
I2RlZmluZSBhdWRpdGRfdGVzdF90YXNrKHRzaykgKFJFQURfT05DRShhdWRpdGRfcGlkKSA9PSB0
YXNrX3RnaWQodHNrKSkNCj4gDQo+IEF0IHRoaXMgcG9pbnQgaW4gdGltZSBJIHByZWZlciB0byBr
ZWVwIHRoZSBhdWRpdGQgcGlkIGluIHRoZQ0KPiBhdWRpdGRfY29ubmVjdGlvbiBzdHJ1Y3QuDQoN
Ck9LLCBidXQgbGV0IG1lIHRyeSBvdXQgaXQgYXMgaXQgc2hvdWxkIGxvb2sgcHJldHR5IHNpbXBs
ZS4NCldpbGwgcG9zdCB2MiBsYXRlci4NCg0KPiANCj4+IEJ5IHRoZSB3YXksIGl04oCZcyBhIGJp
dCBkaWZmZXJlbnQgdG9waWMsICBJIG1heSBoYXZlIGZvdW5kIGEgcmFjZSBpbiB1c2FnZSBvZiBh
dWRpdGRfcGlkX3ZucigpLg0KPj4gSW4gQVVESVRfU0VUIGhhbmRsaW5nLCB0aGUgdmFyaWFibGUg
YXVkaXRkX3BpZCBpcyByZWZlcmVuY2VkIG91dHNpZGUgb2YgdGhlIHNwaW5sb2NrIHNvIGl0IGNh
biBiZSBjaGFuZ2VkIHdoaWxlIGl04oCZcyByZWZlcmVuY2VkLg0KPj4gU28gdGhlcmUgaXMgYSBU
T0NUT1UgcmFjZSBsaWtlIHRoaXM6DQo+PiANCj4+IENQVTAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQ1BVMQ0KPj4gPT09PT0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA9PT09PQ0KPj4gYXVkaXRkID0gYXVkaXRkX3BpZF92bnIoKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF1ZGl0ZCA9IGF1
ZGl0ZF9waWRfdm5yKCkNCj4+IGlmIChhdWRpdGRfcGlkKSB74oCmfQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChhdWRpdGRfcGlkKSB74oCm
fQ0KPj4gYXVkaXRkX3NldCgpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYXVkaXRkX3NldCgpDQo+PiANCj4+IA0KPj4gDQo+PiBJZiBhdWRpdGRf
cGlkX3ZucigpIHJldHVybnMgMCwgdGhpcyBjYXNlIGNhbiBsZWFkIHRvIHJlcGxhY2VtZW50IG9m
IGEgaGVhbHRoeSBhdWRpdGQsIHdoaWNoIHNlZW1zIHRvIGJlIHByb2hpYml0ZWQganVkZ2luZyBm
cm9tIHRoZSBjb2RlIGNvbW1lbnQgIi8qIHJlcGxhY2luZyBhIGhlYWx0aHkgYXVkaXRkIGlzIG5v
dCBhbGxvd2VkICov4oCcLg0KPj4gDQo+PiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJ4oCZbSB3cm9u
Zy4NCj4gDQo+IFNpbXVsdGFuZW91cyBBVURJVF9TRVQgb3BlcmF0aW9ucyBhcmUgcHJldmVudGVk
IGJ5IHRoZQ0KPiBhdWRpdF9jbWRfbXV0ZXgvYXVkaXRfY3RsX2xvY2soKSwgc2VlIGF1ZGl0X3Jl
Y2VpdmUoKS4NCj4gDQoNClRoYW5rcywgSSBtaXNzZWQgdGhhdC4gVW5kZXJzdG9vZC4NCg0KRWlp
Y2hpDQoNCg0K
