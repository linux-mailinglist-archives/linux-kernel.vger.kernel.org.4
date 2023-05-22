Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B3B70B40C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEVETe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEVETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:19:31 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE3B0;
        Sun, 21 May 2023 21:19:30 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2N65C032249;
        Sun, 21 May 2023 21:19:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=etgHLnQ4umzhDICQVOCCb1fzPnsd435uh0AchNiw8Uw=;
 b=owC/ffhHshxaLlBdkmLoAzt1OveqXR5Dz9s2OvhIP54z8T8wAd69lsLNnL7Gdqy0crCa
 Ztq1HeJIWJBvWsRpJVPRKMbQxFM0FykPj15Ys7IThF53BMa/THAKHJx6gRb9/xF7J+AE
 ShHglTy2Qvk85+iNvO5xWzh7hYFtoxmUBLlTSDZKlcue8CLl1yHuu4VgcgCEKjmdrqPM
 9kzEh5w2pVnqdo7u233OBTmYkHKlnXv9gCzzzdqeu+/XxQNYG/5dx0s4xcswbjdRcvW4
 sjQzlfEIk0Y8167X4h+ikHFFU0TiS+2Me9jCjRIrb/DoDkyUd69fobB5Ahc7m321QLgT WA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpthragt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 21:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDuNsfgmUPImzdrkP9P9I51k+pG+GDOaWQnokbCzivWR3qvqIGdVX/JndggAUDJmmULy49khJdjKEm2M+tz5UnZiyMHTyzrSsaKpzulxX0mq5qkLyNhmtvDSAR6GAbyGErlJRa6udk+LWS5ap5Jy2NpCv0f4SRv95lhKshnachJHDi2rJejlDksikwpG26p4687dViKyH4wEE3PBnjUyyezfBkTwcX3EFNmE4siz2GAq+d8RDNWDRa9tn+IdPRu/0KjAsh04oE/Z99lgebHHSUCDE/WGLNxg5tIhIu2bhKp5m3bL/zL8pe/kMZkw2MgM0ZDXXcu2RPu4yd7SguzUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etgHLnQ4umzhDICQVOCCb1fzPnsd435uh0AchNiw8Uw=;
 b=WrfcaOMLIJ/ZBoxEWUuTpND23ixBNE2thj7hVtcOtDvfgmL43XgWYok0qQBwDS9T8czxPqEflzJtFxAygj93XWYwyfgXypgzzzfrLcr6BZwdN8T+eeZ/q+OZ/fnC7L4qPvIe4JG/Yt3Zocq7lPYJ+H+xfyKSA/UVjQWWJDzkb/NgjfCz+ItH8PcGkB7M32gAxVqHRPHt9IfwLUlV/3s+XuG5bQiPulSaFDIASCdR1yk56+ZVDF91y+UxcdNL3fu06Pth8owQe2c54mojUOewzVjkr2Jyyx0t3H2qT71Bt2scKM4C76I7C3vuhFKj5K/KLbH7XE5wF6I70cTS6Q3Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etgHLnQ4umzhDICQVOCCb1fzPnsd435uh0AchNiw8Uw=;
 b=M3aODd5nSnNdhNkyg2a5SDK9KSE1RqQaqjX4/zqSealskr7VQwAYdq89i9d1ul1BAfZKuk+gj6q6KFg2WeqHq5UM0xHFXM2OgVqKJ9fDnDdhKqrfKz26cv9dfOll1kNA4HpK1NxgeTUFL0ZDhLMkp/ugoD9VGudY5rA5yfQCnVc32CeA6ajmzppgU9pRRVaauxJd4mkvUtvmZaqG1tP9uh0rK+Omu+/yjIIS0a1jv6fwKm+DuI8Ef6xmGJS4BxgaGHeX5aO8NrOrPbmOopd6IpesMwrdnSs0dZHBg2Gj7IRU4rMGCjBSeOc2JtdnOMOH4jZQ7GLYfXIyjhFRjXh4qg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SA0PR02MB7434.namprd02.prod.outlook.com (2603:10b6:806:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:19:24 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:19:23 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] audit: refactor queue full checks
Thread-Topic: [PATCH v2 1/5] audit: refactor queue full checks
Thread-Index: AQHZg8hx4GQx7Y4VTUKTyKrSfQfRZa9iIKwAgAOg4gA=
Date:   Mon, 22 May 2023 04:19:23 +0000
Message-ID: <416541D8-EF38-4586-99A0-A7372E4FAEDD@nutanix.com>
References: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
 <1be99c1ede70b5c385acc16b59347d02.paul@paul-moore.com>
In-Reply-To: <1be99c1ede70b5c385acc16b59347d02.paul@paul-moore.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SA0PR02MB7434:EE_
x-ms-office365-filtering-correlation-id: 36d1f4ac-a53d-4edd-cdc4-08db5a7bb908
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yv1jbCth+vH2HWK0tTdlvQzMoyKYwVNmx8nDQ7g0WDguFwZxluQw6Kus2icXDR/OYGIbsdbAmLYvc4dC/HIseCoNGGY6bfTairIIDVWiwtOxLFAV/A35gpHysPLmZbd3byg8GXgSCWuSrkIc/06K8stVcFHkKnHPcP/rFje3+pIhNdiiVf4TUV1maNrQ/q5mn0jB5yRui6dl+WSqBrxulpoVaffvy6+ZE793iGXXgfF1LVHx+89LK2RAeHHrYgG5RJa9aMxyNspQkZztsyArm6qqXR/QfQ8D0H0YBSkUxF2x1Kkktu7gAQ6DNFJToaN7yb3Tu+AcXvLc2ZAlksfIUa0C7iLUdOqkaj50l/Dfk6Ixvh6efurMTXEms+aYoWEH4K4q6zvG33Ye2/gVgjLsUPE7AA8bEHR4UUQy8J4XmsSM2V838icV4LufDbTcvFUwWzWZmv3jv1L+T40IBVqLMIJy5Jsx+73BG9LIXcfRSYdS/OUnGdUQs1u7eYV9zeQ5w8MnGlYTjNWyBGwYsSwkI9F+fJdwDvCxhItzcW8CnQ/+8XJnzXtuyzy3xn8dogFMC/O28Srks86lzrUxdb7rZa+R02wtIPfIGZYyCMqjctiG2lwfqvdl2r2L4mf/zKwPn8VYn3S4gLDpJee2ONS3SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(83380400001)(186003)(26005)(53546011)(6512007)(6506007)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(6486002)(33656002)(71200400001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(91956017)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(4744005)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SeBJo0holHbjWvfFhx6no0/sTBsy8brwiHrbKlSqkyhZqsNKWWWLr8NBgWkD?=
 =?us-ascii?Q?enT/p6FY3KWm2ttMYuNHvzClua2HtLEoEDD/n4O/FGRm6+5ZloQkQrNmbvbd?=
 =?us-ascii?Q?kdGI3gmadQ9CH8Yc49G50cX1klKGo/N7ySDFMNj0rdK0ST+6hTVKt9yrlKW4?=
 =?us-ascii?Q?WLuXxLTI5bkbpMx77WepAqu3BB68Is8eYt+P9eDO9NjaehOB7tIQBCCpaZuw?=
 =?us-ascii?Q?08NM+EeDrBk2ZZ6xmNWK3XUjYqQnwfEJqY+beeM5tCZGiwqjo5YvHbP8N9KM?=
 =?us-ascii?Q?1iXcHikXJvBz74CO3IeIyxUKAMMVvxy+bQuFwskRbmtRp8SUbrlxLx5S1WMN?=
 =?us-ascii?Q?qhsliQ5ul8xE83F2rioMOinj1SZ0uYcF9w14/GC1LaLPupErSOLdqElflVHz?=
 =?us-ascii?Q?m+Ulevj7c2WOq5vdZiZ6MGJ9siOF122FwamvR+jN86TRZeC3keaXR4vwg4U3?=
 =?us-ascii?Q?q9aQrEqQ6NCnEHtTo1M/b6ts8BmsongIQlggo+WAM3MU0OIgf1+r6RsJfnM5?=
 =?us-ascii?Q?tTYLkunG2CaajrZXmZZGDu4vrfCaT40DtlKyTyGyr9WyUkM6gdmx6qE3m9YZ?=
 =?us-ascii?Q?IghV3NbBau17cbobMrNU0NSXmLPo7SFUeG3GSLAky7dWICYOP6Jmi2WgVjR6?=
 =?us-ascii?Q?tQ6hF8suEaDE5uwKS0vBCvTpfFxgVI11SDNcCZRB35tIVWicD+3oYzE4nXj0?=
 =?us-ascii?Q?laBeUwqPg0ZUEI0zk2j9YyV56BKJTVimStXlfRNVAWCybGqZTaSpbxuBKqU7?=
 =?us-ascii?Q?FxTkGCQyxsBIsI7NS5w6HbYx+aePTZ8utNDfFQy8EwVZskeZttdJuDIp24/t?=
 =?us-ascii?Q?PY2N5/zvo+GTOfCYng144yFhNJkwXn9Wi0Ifs7R8Di2fAw2xrZtWV7bCO/TI?=
 =?us-ascii?Q?KjvClDvmuAgqbvZ6Fd2d5h8t9R/Moxk7VfAgLkAVhKoky5YcZYdoZiwkvIF/?=
 =?us-ascii?Q?hxI6EhFuM6nQohsJoAckoZ8W53J20E3kh8NUAvohD9UkiRDT8c09a3cbW+qt?=
 =?us-ascii?Q?tqVcJw0BHji7u4IT04vpZF+F9ltUzs/unGx7S7Mdb8u9wSub2NcgO6z70wCC?=
 =?us-ascii?Q?DKGPJIBfVLZEk8L1ZftwUY9CU6vW0D6jRmRDMsq564FOdtmX4N+2Gke7eo9P?=
 =?us-ascii?Q?qxlXqMbh7Xc7ZzGA0g8abH3jamlVzMTqBHKS6cOW5dVB445DOH1bngVu15nN?=
 =?us-ascii?Q?hSH5lpraTqoqj0gMk2lzrB6J6tqgZkt6JzGT4gYttih8ETO7Tnneoab3nSoE?=
 =?us-ascii?Q?8AcsYuiy/UHwQ5kU7D8OMgYAU0KPPNopdq7Xmj2nQJf2FdVD8phSNWSVXc+R?=
 =?us-ascii?Q?7Yj7XNbq01L17RZV3d68rLsYStxyBQXt4+pTfxd71A6WnvfO08oeD5D352Gr?=
 =?us-ascii?Q?+W76DMtAmu4NPGjRivo5+72M9LcFAQ7ITzO02021nSHX3EhSFCk2sQy/KRq/?=
 =?us-ascii?Q?ueaNyJEzDrC7ceMwq7mKIH5qozOzHQhq6Z5POX5uIRLiiGGoMH2U0rz8Bp2a?=
 =?us-ascii?Q?xDiXVZI8PcNHT9uLQIK7xv2lgKqBaU+4+xhP8Hp/58h+7hJcE33S9NNp5MsB?=
 =?us-ascii?Q?TyNnl3buYrwt35DlJ1OFxqoIdjrQH4B7yZb+YOAjKuGGmftOyiHpNvYUJaSJ?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8F5CED41E3DFD47A81E38B751AE84A8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d1f4ac-a53d-4edd-cdc4-08db5a7bb908
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:19:23.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZwWuFOLxbT7cQTtUQMkL7qeOuD5G9NdlM6vBjpA/KyfyfGEjH+Bv546rTg+33pThiO9JWO4ZnEqWE3y/OXIV1Cb39KB3pJJBu0O16gp0Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7434
X-Proofpoint-GUID: oafxGzveo1y2LqShCteMR75oL2Dsvv1Q
X-Proofpoint-ORIG-GUID: oafxGzveo1y2LqShCteMR75oL2Dsvv1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
>=20
> On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
>>=20
>> Currently audit queue full checks are done in multiple places.
>> Consolidate them into one audit_queue_full().
>>=20
>> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>> ---
>> kernel/audit.c | 21 +++++++++++----------
>> 1 file changed, 11 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 9bc0b0301198..c15694e1a76b 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
>> return retval;
>> }
>>=20
>> +static inline int audit_queue_full(const struct sk_buff_head *queue)
>> +{
>> + return audit_backlog_limit &&
>> +        (skb_queue_len(queue) > audit_backlog_limit);
>> +}
>=20
> Regardless of the other patches in this series, this seems like a
> good candidate to merge, but could you make it return a 'bool'
> instead of an 'int'?
>=20

Sure, will fix it in v3.

Eiichi

