Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF79C6A9E18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCCSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCCSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:03:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4151A977
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:03:54 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3237sBKE032356
        for <linux-kernel@vger.kernel.org>; Fri, 3 Mar 2023 10:03:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=7zPanc6WR47HEkt8qNnh5Xl6kBWoiLgvkDOm4xdvTms=;
 b=UR/Mbl7Xli+3jMuR+fBE2viFBMdwIRdVJ9QaasN8oVZTYnFmR/OCLsJN+yK0IVRA1xQ7
 TDUCetTjJG+B5C8SOw1L1IEqM/SQQ2QTgjT/ggtnBDvv3PnPYW08A2wQlveDtN2FD5nO
 6k4BiGX6vYMiwDyrP1kKEWX3Hn0Gn3q/zpg0ERx9LzVEWUjzFq+jVJHvCys3d1XVy/l9
 /JZl/xqR0Jp6OiulH8RdbKzw/DrMc0Hu/2emSJAxJYZznBNvTcniRkzxY5Fbl0J4wYwN
 HuqCl7xsD+Udr7ZtM5jo1m3JDR5TnqNJsbdjFv9OmizwxvagpbYXkAYRjKtzSwIHkIRT TQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p33d0e4g1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7AFFCswxNTxy9R8CyT8w6P+pbD3n6tdzSAQ+jGvfU3LzWdJfhnnRbh4Iu7BS9HferKr4f6WNM1Qhk90ynOcTqJURHd9OeVJtJNC0cN4rLjrN+P3tyZReJ3RqOIZ0cTsSLSpIs73vdP3tbrbdyGjPlYKLI9cGDYRWbSIA+OPMtZ9pNA6Ukrr1T5UKAJZaAasIGfBVJ81izdaW/eMtPg3ZWJeJSZeOz8f4v2ezdbl4rGAF2Bt7+v/ABYJY4XNQr2K6D3GqFd/jGCJvhGNt1dLkLF2rrqmNR0Hnur3XeZNT5QzQuh9wj3fipS1egzASItAbS6lLDYWHM3uVT21M0VBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsru+lPwpw0rr4zlXxKuDLmyJU8nUaZRaIc6TQBEWQA=;
 b=k1Lw6Vtjj2EmF+19tGWCw4JW4CdNzXnprR1PmxI9OzCcEUD/Af/wld0nlCM752xf9923tVFz/qqi011qToxf77h1ieQJRAGsd17FsIveDTbG9KZO2h+UObjArGpnHsXVu+d5tUBou32Jwetlu6cdszhX4jLyfD/3sXTKitnZ0JAYARECZ3NFGXoswFchXNyFbtAQLzwrKmA1elzkE49zAl+6zIeBlBA+LrA7fzAtLHWtGi4eBq+JcqzLpjr9QtIl3CyTSXkXc8684V3gv6wTNpzd/EurZEMrFwxULLVaA2HCskOlFDtFGieDcdHHZUgj+9psfeU2Ru5gJ8OT088oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by CH0PR15MB6249.namprd15.prod.outlook.com (2603:10b6:610:182::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 18:03:50 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 18:03:50 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.3-rc1
Thread-Index: AQHZTZizamXiGRhPv0GWaVIL9zubi67pT/wAgAAHCYCAAAF7gIAAAUYA
Date:   Fri, 3 Mar 2023 18:03:50 +0000
Message-ID: <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
 <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
 <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
In-Reply-To: <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|CH0PR15MB6249:EE_
x-ms-office365-filtering-correlation-id: 2d0e7117-0fe8-48bf-5897-08db1c11a49d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64LtgEtZVKhf/z+/gndd66bqkb7uBlHTgpXpgVzf7mpGUjVOs6h+trUtiDrbx2Kh22ej57BXwHtzn+fLbSbscK6asqfwejxNX58GjBMNAXQqhr6V4X25/1qm/zmFHTZmX8mBJi6Y2wDLiv8sY1ypm++ntiZ2OnFT460zHwH4sUA48o53VFSlhEKXbThvU88oE69CgmiyOIREDxmjMN026mwpgb/i4mt78RN5ak06vOjUG4D6Cb2XCdTAUKkr6DDhJBzU13Nmt7I/onrPZbMttTVNC9ovPeZKRjhbL9OXaetvdJr8dsh8PGhtVMrWle4iJrpcTiuY0vISpzj2iqVJfvVwNgcIQqODng9qhHr+sAxzMm7P+Aqz+9FunjIf0CJl0OVm/PHH9qZ4I3/UIfF2lIhVZ0al0M1OoIpJZGNSkuBJYsPTZu0a9xSGJSGkAd9L3S9NfQKOKgppjxczES4f0e+5PXvCc/ZnyUAnOr5g5r43Nr9A2vqPZuKQCvXFiefUU9LdniEvzyq8eWAJ5LbZqX3gtDv759kRDdXRuN3rLfNFGbzmZZZ29OJkAoESfxAHTSZFtsvy+fEjWVcCy3ceGDQy+urHRhgYjYlVTwA0QMLCs8z/7crZ75KfIFHmO/rOxVUSSuovqlMNRLkBb1BkSB2UGBXF6ZV9D0+ZahcQkl+Ur4cCiXfVgJbqEi/qh2k5SOewv+iM/Va9u5iBqHUzkouVFBSlnG/OJV4PdicoaLpJKmm6BT6u8xZdatqiBgdWQoTj0ZlruGYOdrO0M95aQaZjd2WocoeQnha876FW39g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(33656002)(122000001)(2906002)(71200400001)(38070700005)(38100700002)(6486002)(478600001)(53546011)(6512007)(186003)(6506007)(36756003)(86362001)(66556008)(66946007)(76116006)(8676002)(66476007)(66446008)(4326008)(6916009)(316002)(64756008)(54906003)(83380400001)(41300700001)(2616005)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wlczd0J3NXBCUHBJejQxVThPSVFMaU45bmdvdUd4Ym5Lc21PMFJNUFd0eXlO?=
 =?utf-8?B?RXY1bm91Rkk3RTd3bVMrakNrZlgweGUvdkFUQmhQZllzY3Y2Wmd6N25VYzJo?=
 =?utf-8?B?K0V2WDAwV1czZThxUGdUTjV1dWMrZEFHWW9nMGwwRlF0cmYwZ05vK2hvZnV2?=
 =?utf-8?B?VU5VOWlvcDk4cE55czhQUlZDaCtOODFTQzNqb2VZanNuWnlLdGQ5SWxyalVa?=
 =?utf-8?B?TklXaktmSDk4WHlIQW5LWDhvcjBvMjhUWEtSRlYyNjUyNTNDZkhXbFNOajlo?=
 =?utf-8?B?K1hDYWRuRVNjMGh5dEI0dnZjK3FpVnBoOW5GL2ZCYVhGUlFTYzAzbWZoODkw?=
 =?utf-8?B?MG9HTzFmbm9LN1htajNqNStBZkFvdDYxb08rVmF2elFXb0EyWlRFck5NSWh3?=
 =?utf-8?B?eWw0cVQ0UzlyY1JvbHJCazZpWlRRK1V4ekNOdzBBRUpjbUY1NHVJRk42Sm9E?=
 =?utf-8?B?ZklHUzdSYjZUd0c2cHpidHFlN0YwOTlBVW5sRnZZUlpIaWZLMkJnSUtaTHd3?=
 =?utf-8?B?QjJRQlcvaTJpUk90a0VyVGgxRDNGZElrc3BCSjFHOEFkS3NWYTR3elhrZ2VS?=
 =?utf-8?B?U2NNbUVnakx3TFJPbWcvODljUkd1VnBnNW1FcFRBeW9waElseUM2TE8wdFRs?=
 =?utf-8?B?V3pZbmYwbWY1Q0pmZ0RqeHU5dEVMenhYWmx6YU1YOHcxeDJ2WjFPRWZnbEVI?=
 =?utf-8?B?cC9rZDFOaGVYaUdRYnU5YUNhWlBCWWl2U1RsZkhzd3UwcmRDTGN3VXFkZ3dH?=
 =?utf-8?B?N2NzdzUyV1plSEhBMDM0c2FCSElYS0FyL1VOczlQL3dqdm5rZjEvVW5ibCtp?=
 =?utf-8?B?aGlQQ1dwN1d5ZGl5RzF3b1BrNHhhMEg0NU4wU1hRajBqdkdyb2hUMFM1N1Aw?=
 =?utf-8?B?ZkVibnlYZzJTMENSR0Y1R1Y0MnFxVGtTZVEzT0lPbjhWMXQwMUpmWnZDY3ZJ?=
 =?utf-8?B?TGFwYjU5bXZNdGg3emwrcS9VOGlJQ1ZjKzRwUFYydHQ3bmdwTWFVV1N0Q0Fq?=
 =?utf-8?B?RGVReVdEQlJtbzJaL0l0a0NDWVA0Y3Vqc2NWMit3aU9jVGNNbHMyaHdKQ1Vi?=
 =?utf-8?B?RUVvb3kydy91TkN5NGJqMTJ0YVFDRUNqUENuZW1rbG9lZENmT3hMOEZjRGZD?=
 =?utf-8?B?M1BxbHFiTVdnOG9HOU9rUUFZZWNBdGExdVpScXZOeklGL3FySnh6YTMxTXk4?=
 =?utf-8?B?RWQ2cXNiNlNMQXNzNUJXNmVsa0huMzlWUW5PK2lQeWJDN2lZdk0rNTZROFpB?=
 =?utf-8?B?MjFSK013NTAvdlVwbmRqQVRmaEVtNXg5WmZONmU3bEdGc0JEb3BNRWRKS1BV?=
 =?utf-8?B?WlFwWFkvZ2w0dWVnSlZ5bDZoalRJeGx5a3UvQUlkaE9jWnZPZFduRnRROTJV?=
 =?utf-8?B?aVZmUTJTL3dzYXZlMi9la0ZBMW43N3BZZlpJLzZvWG9RSldjd1ErV2VIbVRS?=
 =?utf-8?B?U3ZmWkloQTRqY1JLem80MzR4UUJlaW5OZnNuL2pJM0F2Sjlxa1RvZFUzLzkw?=
 =?utf-8?B?aWRDVGJhb2dEMjg0WkJTaWpqK0NDODBDYXRvdEQ2cy9ZNHZQdHNpMGNyVDZB?=
 =?utf-8?B?WFVXZ0JZTDllY0ZSNEdKT2llTllwVlY2WXkzaDRlYW9mMHZISEI4d3FSaFU2?=
 =?utf-8?B?YjZ4QjFyY0lSMWwvM0N5Q2RkaDA0dVVXTW15SHQyVUwrbFpaVFFJMHV4S2Nu?=
 =?utf-8?B?K2lBZW42QitDZVNxeDRCcCtoZm82eGt4aUhQbVhWd3gxQnM3NFRnZ2ZnTkZK?=
 =?utf-8?B?NWVvN3dmSkFUejdmM3BTTU9LQXNndXdSczJvTlZ1NzhSU2U1WDRXeHdVbHZH?=
 =?utf-8?B?YmhEaGtnMzQ1ZTNPNTZQcndZOCtsbnhJMFZZZ3RUTlV1bnR4cWlxakZaRHRp?=
 =?utf-8?B?WVlqempEUnlvNFM4dkY3bVY2QmNsZGRDNEt0OG1FNWNZSmFIeHVNOWhuK2U3?=
 =?utf-8?B?MS9qMVk1SUNSdHVVSzNQS25mUjByNzRLTmFyZ1pKQTY2UW1OVGhIdnZRTHNm?=
 =?utf-8?B?MVlFcHRSbnE2RlQ3a3MxVXY3cDEyU1NQZ3B5b2MyemM1eVltS1J6UVRMWTdL?=
 =?utf-8?B?ZlNYNURUa3VDWnA3TGR4N0Y1SUExUXlyL3ZVWUpRczdwUHlzQVMwd1hqbC9x?=
 =?utf-8?B?S0FSSHprOTQrdGcyTDB2ZWM0cXRMbUdrRTJUd2h6cHh5SVFDZ0dFRWd5SitI?=
 =?utf-8?Q?zW/x75bi/4I+yR6sf0v99Qw=3D?=
Content-ID: <F766407492B94243866CA9BFEE52F834@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0e7117-0fe8-48bf-5897-08db1c11a49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 18:03:50.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lV5QTyH/K7V8SOcRoOb4y5UZedTD8EzEyooFSXJpDxhkCrBZdDgXE+gpfMq4FeDqhfVE1W8IyEiFyuzr8rD3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6249
X-Proofpoint-ORIG-GUID: xbpu9tQIoMdElDexZRxgi9dUtAufp2gk
X-Proofpoint-GUID: xbpu9tQIoMdElDexZRxgi9dUtAufp2gk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 3, 2023, at 9:59 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> >=20
> On Fri, Mar 3, 2023 at 9:54=E2=80=AFAM Nick Terrell <terrelln@meta.com> w=
rote:
>>=20
>> I=E2=80=99m sorry, I thought this was standard practice for merging in t=
he mainline branch.
>=20
> Absolutely NOT.
>=20
> I have harped on "DO NOT DO BACK MERGES" for closer to two _decades_ by n=
ow.
>=20
> When you do zstd development, you should normally have absolutely
> *ZERO* reason to merge non-zstd work.
>=20
>> I=E2=80=99ve been following this article [0], which recommended not reba=
sing my public
>> trees, so I merged in the mainline kernel instead.
>=20
> Half right.
>=20
> You should not rebase your public trees.
>=20
> But you should not merge mainline either.
>=20
> Exactly what relevance does <N> *thousand* driver updates have to zstd?
>=20
> There are reasons to merge, but they have to be real, explicit, and
> MENTIONED IN THE MERGE.
>=20
> And no, "update to latest" is simply not a reason.
>=20
> When close to half the commits are pointless merges that have no
> explanation, I will not pull (if I notice).

Thanks for taking the time to explain, I appreciate it, and will not make t=
he same
mistake again in the future.

What do you prefer I do with my current tree? I guess I can either:
- Leave the merges in and keep a stable tree
- Fix up my tree and clean up the merges, but break the stable tree

Best,
Nick Terrell

>                 Linus

