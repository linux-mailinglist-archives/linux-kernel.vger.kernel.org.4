Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138B682A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjAaKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjAaKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:22:27 -0500
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B53253F;
        Tue, 31 Jan 2023 02:22:24 -0800 (PST)
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V9fh46019306;
        Tue, 31 Jan 2023 05:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=aTXmLvIaEKA9+12jCj1avolNYuikFQrRFUTaULnQOSg=;
 b=Lv4be3MILqQid4kQw1bX9qyqIlXPFndD7PCQa12ZcxkhrQBTFBNdMPvJAkt8fVeRCdy3
 cdoRNeZwXC8olIgJOH08dqR3eFmzm3F8OMXj6xuplPSukbu2jJE5F0jMuHW5kZzWB/1v
 5zU5bxy4OcHuYPM9kD3OBf2lX8sthv191BZYmWwvdoTlLFhzdq5ZUfN7eFp5NG9DL9d+
 Hl4VdIyItbEE2ydWpGNmwFq2rV85yUua9PD1RgSBmM51P61bTtGWSoQdsyg0sAtd21m1
 EQMq1D6iCDOOLD0ma8KFlQw1kzZe8p3ee4kAI30SEG2l/rVu/kPDXUCpCSuduOjPKyS8 fw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3ncygm6gqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:22:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvbTfx+juCb80XIvp1k7/wKm0hGJ+Lx/w+Z6IuhYWE7xD9otnkIHuHo22efCb16pHQVyX6R+Wpcv9fuzML4QI8vE2zN4/Qchz/NJ3RLPi4NiE+f6X49ixCq3Pw7V48E/h0sPYvsJJpC3zQNJV2h4yX8JnTYS6aKmznxoDMo4Wh8JQCaNkULdYVpU/n8TfAjqJJTdcbpjxLXifCYue0XISnijcuyaJPfqLiPMgbxpVC7yVOBbMGptkFxQ/sSe364uUoYD3kbRMHb7Pl0qafBGcZTIvDO+firNzeEmEpEXphQP9z7NvgGS2WMUnhAVwB30Ex4i3UlI91rPT7jud1UVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTXmLvIaEKA9+12jCj1avolNYuikFQrRFUTaULnQOSg=;
 b=f8rPRrMkamd8exLYWJMi1gUQ/SJptMWXlTSu6iAglp+GvH5wZOt2VdrKqozHOGmX8BUbrPgY9cMp4QOWz7od+cL2ACzjIG+SiZHiqVN6eu7Lm5XDOb9bFFYRCCgxppNrX3tPPM3bvuKvpCcx5pzB2qwVhpePq/r06fNkAUeE0dV3Jfk1MyVmgvKMxabzfFeFUUgAyoiexQ8I1f1rRZ3Y4XkwanVDLbfVMd+t2X65H/0oU/cD6GbHXb7YTdET7ht74LUTkbzVYMfyUso0wkjuzh23MWvHAcaacMFAB5UAYomOh1d4Sc49oplQxC85VtxIbpZNSO1Dcaqy1k7macyNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by MW3PR15MB3929.namprd15.prod.outlook.com (2603:10b6:303:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:22:17 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 10:22:17 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] gpio: Add new flag BGPIOF_NO_INPUT
Thread-Topic: [PATCH 2/3] gpio: Add new flag BGPIOF_NO_INPUT
Thread-Index: AQHZMW98etZ8eL/pzUKJYu2Hp2WNLK6yOiMAgAYexgA=
Date:   Tue, 31 Jan 2023 10:22:17 +0000
Message-ID: <3f3e2125-4f41-04fe-0605-7c957c71603f@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-2-8a20ce0e8275@ncr.com>
 <CACRpkda57wNMO20ZGtjm7zOKMk=1D2g6ZBq5aRKnPp=1z5Pr+Q@mail.gmail.com>
In-Reply-To: <CACRpkda57wNMO20ZGtjm7zOKMk=1D2g6ZBq5aRKnPp=1z5Pr+Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|MW3PR15MB3929:EE_
x-ms-office365-filtering-correlation-id: 971cdf25-538f-4e64-440f-08db0375074a
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYDK94ck/E2WswJk//GWNNW2DiMy1ctFAXP4NjX+x7JrrBA9f0dBqTtLUgp4/myrJ1SZDVPPSk4OGHO3qheSVNPdndwJtIbqnd+a2VC7MvQJB4FNVb4cPCsBWIg6Km3E4sp0ps+1EL1aUqnCmxIzhNIIrdGw03NZvSZmzhju26/dDo8KJiQLn1FbMEyneZYUWod462ixluCb7o7FAMTfpOoXxr8Lr9UtlCLSoQkoD3/xmYTYilti0HZFQlnhLAksV1/ILdDFoQyOp1jyVLpIZRDH6uSFzhBHRl1nsknNPAdQ0VFkyni1qkK5QcHH4TM09mtUUm3YoVYYAb64r0H2pTyoKK7dtVYwV/B97nIElGJc3Gd4fqDEW+aowDYZb8JTeNjpEdh3lO5tk2igR/zuuYM84w5Kr/6WwUXKKbVa7HWetVaGKv/y5ujJs0UQ6EKCItiZbBi9DNkRKCgopwQ3N6kekcTNcGRZqJCBkOGjRvwZ+3IpujK35x7WrwiQJX2RMORSpUoUWmncB20tvcjRiO3ghdr4b7lAtsjmOzHfFuun0oy8nKwI12lVzii/edMNAexetk6hi/JimhdMdfmHoKgqjwd5UBWebsx5pLQebR/d1WBlez/RnRunEuaWWkr4IdOFHdKtJcv7cO62W50M+AIXIvxkMs7YOvo6ipxyv0F0Ev9FcBC8S1kjdWQtQeE4W7Mfpxc/kKpWUgxznKpIet4G7ZPKlCq63i+WZmkatX5KXx9qDV82kWH6xktYkj9iF+4TxTm95gIKRJaJ4l+Xiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(478600001)(186003)(26005)(2616005)(6512007)(6486002)(2906002)(31686004)(54906003)(83380400001)(53546011)(6506007)(71200400001)(66556008)(66476007)(64756008)(66446008)(6916009)(4326008)(76116006)(66946007)(8676002)(316002)(91956017)(41300700001)(4744005)(5660300002)(8936002)(122000001)(38100700002)(31696002)(86362001)(36756003)(38070700005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVJoeXBhTSt0V0R6RmpBejV4VVc0Y2xOUHBzNnN0SzYrcldYWVRvdHRhdFFE?=
 =?utf-8?B?T2doVk82QWhFSGtYVWs0RWJmbHc4SWlIc3dsLzVGaEZGa0JwRmpaSUZDYUxv?=
 =?utf-8?B?QlY1NE1hSG5NWENDclRjT1JhckJDTG1hMXhlUEVPd3lxaG1XR0g0MU9JWitK?=
 =?utf-8?B?YnRrUmtWRVY2MGpFOUxESHdDbHRoeitVc2pKRnU0aVd0RTBTemNOTFA0Y3Zq?=
 =?utf-8?B?aE80aUdyelFnN29lWmJDWUhITmd2alo0OEVETmh4aFg3RDZKdjJnWFRocTVY?=
 =?utf-8?B?ZUZmMEpRMHFvUG4vTkRBRUIzK3JJSzh5UjFCai9MWWZKY3lFSGJSWDNmL3RD?=
 =?utf-8?B?V0RQb1d1WGZ0dmJLSitWOHVMTUhGeGlmeExKZWh5ZmVVOE5xdk9RTlk1V25S?=
 =?utf-8?B?ZjNoMFRVREhIQkhFdnJMVzh3NFhQN3JQYzVSV1FnMktPSVpmQ2lnYUpxbE9U?=
 =?utf-8?B?ZDI1SW9RbW5ObGh1cjhvK0R5dlY1R3BpUDRQRGRXSzRBY1Q1ZS9YT2pKVUFQ?=
 =?utf-8?B?cThadGdxaWF4M0kwUFZ3UVdnUWE1SjFwV3B3WTRSWmV1VnpzRGRMNWljN0la?=
 =?utf-8?B?bThTbG5tWDlZeWZsb2dmL2JJM2NKNEh1cHdOMGdEK01aQnp5c0RIelBoVzZO?=
 =?utf-8?B?TXlMTFlvVXdKZ0pyOFYrVFo4aVJFOWRVdUFueC9SL2VnckIrTktqUkNBdnZH?=
 =?utf-8?B?cFRHTE8xYXdHV3orbUQ4UzVjcnhjVCs1dzZuTmswTG9HVWxFSWg4MkxETU5v?=
 =?utf-8?B?RlJOZHcvejlRNGNIYzJ5MzJaRzhhdkxOcGNXYldTRzhOSkJYd3JMa3RIbFY1?=
 =?utf-8?B?Vk9WdHRHSHVpeHBTcUE1UFBXRzhjalVWMGkyM29PSGF4cXVTWFF1SnFCOURM?=
 =?utf-8?B?TURIenFOWC9Xdzk0aC90Rkd1cHlxcU4zTW1UelVJeVdDQjJpSmFtT3BGQVVr?=
 =?utf-8?B?Zmc1MXg5Vkp6UEQwdmtzbi9odGtSbHNxRnJZNGEzc1c2aEhOU09Ec2s1Y2tz?=
 =?utf-8?B?Uy9GTWFGZ0d6S2RaaU0zck55M0hwYXJnZkY2bU1TUzVyS1dyaHYzNWx1SE5Y?=
 =?utf-8?B?ZUorYnJqdU1vcjRGRXNRZUQraERDbE1pUnhCU2IwRG1WSmsxL1F0Z3VHTGE4?=
 =?utf-8?B?R3g5RlpLa2RVbmlERUlLa3VHWllaSGkra3pKWG1RRUgwaFZ6Z1M0eEczWDZj?=
 =?utf-8?B?M292S2FFUjdtK25rNVkwdU93azRKakI4VWloVjRxcFdPeGFPOThCZmFxL08z?=
 =?utf-8?B?VnRISlRFUm02UVk4YXhQWmpxOWVVektWUnZTT3l4SmRkNDRkMHFydWtpb1Fu?=
 =?utf-8?B?cENvbjhpOUlkdHVEcVlWMUVPUldHekVlOHNYMmdsMUFlNDNwNERqVERrV2Zh?=
 =?utf-8?B?SlVqOXpYc3drREJ1UjRZTkU3bVROemRNUkh0NlNZMllWc1MrRE00M3U4UllU?=
 =?utf-8?B?VU92QkYyZ0x3dnpxZUNBajQwSjZZWFRxWjNKRmMrTmNRajJhRVN1ZzJVcFVL?=
 =?utf-8?B?ZkFUc3U5RHlFMzF3WCtjc09nYUNqYS9VYXQ0VGhublg3ckRiYWkxRlc3cUYz?=
 =?utf-8?B?Q05vTGNiaUJvNjV3YjBCZEIyR1JXdiszYUl5TkM4TFBhYUZ3MS9mZk11eGlv?=
 =?utf-8?B?MUlTWkdUMTduL25LSWFhTjZFTzQ1ajUzc2N2Yk9PWUg5Z2daRnozWmZpYkQv?=
 =?utf-8?B?eHBKZVNiUnBRTXkzTHNEQkVCd0YzQXRuRzdFZk9tR0pEaEh2bVRJcGwrL2tJ?=
 =?utf-8?B?WDgxNENnTDdXQmhwNGR0WWhBMWxjQkZ3UjR2Q3FsaHpCV1NqQUdGZzR5MVJj?=
 =?utf-8?B?N0JxZWFwY1R3dnNHNWZjaUFXZ2dCMlJPd1YwbUVaYjZkZFNabm1yMFo4SEg0?=
 =?utf-8?B?eXlNSFk1MDhuOXBjbm0vd0FsUU1HSTdwdXR4TzJpQUdRWW9PUTBBTjRvRkhz?=
 =?utf-8?B?QU5ncWluSXhWN1Fza2pqb2lqa1NLNGliVGthSzRvdFJweExZMS9UMVlCR09H?=
 =?utf-8?B?MkRWWnhaVllrVFFBakw4UFZhbzZYZURYbjRqckZPZGsraXUySWdKSEFMd3kz?=
 =?utf-8?B?c0dtcExwY3RrR3hVL2ZpK1lKakR6dURnMnc5Ulo2SzFnekhOOEJKSWdKN3F1?=
 =?utf-8?Q?uudo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9254751BEB94974C83E1C060178A982F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YIfYZxDrdjNTp2kfUNP1etML0V+C+oCLCP1DKGjZ+0QViQlxWyh3NVZMCIBAHaoMuwgR/z6k16geeM2Cy7Jk9FF+kpuwfSZgwPDVkAmXvYOqquX7yRtEJ4RGF22dr66KFF/HRKVrR825pUOAlUEEW3/WMW+Dv3UijhXfdCnY5qijJfSuqm5rstcwjpkVigc94+9kZ+CMOdGFmar4eQKyc5tCQfC5e6SYPjxpygYfWdlZIECfzpma02Vsuo7N+VSUlyp9NOXd+zLHwRwDS/B3gDyg930JSL8RHWatDNl9L1sDsBBV2yoziY6Lxrh2zfnvKjYcirvWsi+7LxGaFkD1/IXEcT6ZfpkXINf12NbHIwpdKUjSKAp11SkCGiebXxRnIk2mvy1wSvniMGa8Yk+Uf42xHhlURlLmJwe+FP+56EkPcBoKaz8zCIoU4r+9TcwOv5fpyFyKhuCTXvidgBxotbSTiwEa8PQkpczaFhTql1GU643r9cj0b1XmOfqf2w4+IuQ79tYOTVYmUn9IvCSChQ/sttvaJMaZRj1WQGUI6dmzryQcg9iUUOznUS8YHuIzEanB+ZDsytAdEOBunHC1R2X05nssDbGfyO2KdoDP8k7IXqWORLCSiu5X4F9lrzC1YM5vCkZI+mSKVW2nJWDA/KmSerKTk4U2lRdKpQXnXviMQW6zb0Kzm+WKiQ/qCLxxAw0nZOmn98QWBgPKjhJGC0Ewa8E+aOroL4tAPuy926B7zJAsPbEvwyz2jqaCIpVC72bkWxhJAHPg9h2Z/rxhyCovT3kRdNc8ChFkHOc2/QC26aBiHoXYHmH3NDMYQpoFJpvu1I62Uy1ugJR87sAlbWDAmIW8pfXDfh8HI1HDAnA=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971cdf25-538f-4e64-440f-08db0375074a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:22:17.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TknroqZZZwsUxaabhRlvUJbjZ+nBW6mfw5n5cqgcGbFF7A67ZJFduu9sWoWKdIYeieWwwbGNLNzTGGOytbSuMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3929
X-Proofpoint-GUID: a7r9sAlq6GkNKESbXm3HHoTpfPLi8hFy
X-Proofpoint-ORIG-GUID: a7r9sAlq6GkNKESbXm3HHoTpfPLi8hFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDEvMjAyMyAxMjo1NCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gKkV4dGVybmFsIE1l
c3NhZ2UqIC0gVXNlIGNhdXRpb24gYmVmb3JlIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMN
Cj4gDQo+IE9uIFRodSwgSmFuIDI2LCAyMDIzIGF0IDExOjE4IEFNIE5pYWxsIExlb25hcmQgdmlh
IEI0IFN1Ym1pc3Npb24NCj4gRW5kcG9pbnQgPGRldm51bGwrbmwyNTAwNjAubmNyLmNvbUBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBOaWFsbCBMZW9uYXJkIDxubDI1MDA2MEBuY3Iu
Y29tPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE5pYWxsIExlb25hcmQgPG5sMjUwMDYwQG5jci5j
b20+DQo+IA0KPiBJIHdvdWxkIHNxdWFzaCB0aGlzIHdpdGggdGhlIG90aGVyIHBhdGNoIGFkZGlu
ZyBpdCB0byB0aGUgTU1JTyBkcml2ZXINCj4gcGVyIHRoZSBwcmluY2lwbGUgb25lIHBhdGNoID0g
b25lIHRlY2huaWNhbCBzdGVwLg0KPiANCj4gQW55d2F5Og0KPiBSZXZpZXdlZC1ieTogTGludXMg
V2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiANCj4gWW91cnMsDQo+IExpbnVz
IFdhbGxlaWoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KSSB3aWxsIGRvIGFzIHlvdSBzdWdnZXN0
IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClJlZ2FyZHMsDQpOaWFsbCBMZW9uYXJkDQo=
