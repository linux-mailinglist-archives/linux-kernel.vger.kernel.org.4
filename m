Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AE55ED50B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiI1GmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiI1Gln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:41:43 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461B1F34BA;
        Tue, 27 Sep 2022 23:40:40 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RIkkVv019688;
        Tue, 27 Sep 2022 23:40:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=jgWbInMcqJPuSkSZiGvIuBgqvVWayUXYnPtIhm51Tf8=;
 b=cJM5fdI0AFobeM2kAW5fUXuzqFPGfgd9KwTdU1heDqT93qfVse+uRWIWPacukY5nnsk2
 TtMBtnQbJRcX+3KWLtFyVlwNTQv4HUw/10u4gzKck3PtDGRKCQDjwdAMsU7NRnlFSvcr
 3VR0PTqyoOQ0qF95fvohzzpW0yHXIj5kIyW4K4IvbRdJEbefl8Dl2aUTgFmrE3+sLe3c
 PgGaU14xhH8V9Xktrk2rxoTxuhY9BqMvS7+Pz0RjngbzQRUQAAtqJqErcJHqnLAAvtm/
 ba4qjDM1xgEDq7oa4Be8SrDOA5ubx3kvS8GRNgNeV5rDaH7UDReywuCRZyDKFjJECkVq 4w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3jswg1r2he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 23:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PljRuEj7I3ipF++M0Q+m1QOjQrCYX9+fv7c1sj/mal9l5jgBzG33a9eRD2s3U5CyEY97/7sDYoUOhWEV5KjvG9jIZLiMl6ARZ5HOwAqse4L4EI3b/p4/byxbXrH9DWzPL1LHgy67BJfyChwK34ebie0uvfSD96pfBBR/qkvx3UDbG+ejcJRWr3TDE/M41uaF+bpKRmeuVylSHvrbulE7cKFkJOZLxogkgL6pu+p7GXqkVrjIniNx0tPzCM/bJYY+VyOYcyh52+4dQqpK8EqjLHuWye0vNLQ0n8Eh9EPdAyJ3MGY6365K15nMIiJwzSdN6VQfRp8jQ3mW8a9UW3EQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgWbInMcqJPuSkSZiGvIuBgqvVWayUXYnPtIhm51Tf8=;
 b=YaV/3+AhYEwv5ARmUglQiubtyUbfqLZhFDUmm/gGUEE42RenZzCig6/hjtsBDMvgVz+wN1G7W9G6Cpxj9wleOdxYbT/mGND5bN8Uwd18gwBd1zc/bdqPeThZho3QxqwmFIqj/YM8UsLSWwOqgM95+MfNC7BaZJDqIdxCVDk1LFcyN2gwgS4j7HMihvZYyjxAJgmaJgVIWSx/6WZydLBeMGs+rpvCJ8xdZODf5Ch7QLYfisXblcv/9PLIQ0HeDUKLFyI3Wt7+Xj2VtAm9uRxFutHfH8AjB08meq6ekUFIGr9iPjYfB5DPd+lU/Zl5JJDBx5FHVzknXNnStsvXcjwo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgWbInMcqJPuSkSZiGvIuBgqvVWayUXYnPtIhm51Tf8=;
 b=xTMITSAeYSicG9zzdghnnX2R00PK4VrK1cs91NeF4FG5JWIC1zW150mSirrVdnKHmztmjg7oRAjb72zH9Y/t7zC0pxsLSKRTO5RZcYu/XPvw5GasX8s05jnkgF7fQlFX1mKom3EnFqbNyfbdhIKDidMdzA5A3FsInbcCxr+YjzQ=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB8693.namprd07.prod.outlook.com (2603:10b6:a03:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 06:40:04 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c40d:f149:5438:4f75]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c40d:f149:5438:4f75%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 06:40:04 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: remove dead code
Thread-Topic: [PATCH] usb: cdns3: remove dead code
Thread-Index: AQHY0bCHte+aLqZnNkqFcyKRL76j+q30ZqHQ
Date:   Wed, 28 Sep 2022 06:40:04 +0000
Message-ID: <BYAPR07MB5381FCC10ABD4F92E47CF6D9DD549@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20220926135922.24541-1-dzm91@hust.edu.cn>
In-Reply-To: <20220926135922.24541-1-dzm91@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjE1MWY0YzMtM2VmOC0xMWVkLTg3YzgtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDYxNTFmNGM1LTNlZjgtMTFlZC04N2M4LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTQxOSIgdD0iMTMzMDg4MjA4MDM0MDY3MjkzIiBoPSJicDJOL1Z1UmFOQlBxNHpTZG1YaFBhb3d0TVU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|SJ0PR07MB8693:EE_
x-ms-office365-filtering-correlation-id: b2122460-3bea-4a88-9fae-08daa11c46ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aD/FjcerbbC2OxL0mCuvjLfSCA3EIiWrhTUciF/tq6eFYEnApzsrd8U6QFyDuzoyUFmlRdrXakufZi1+x9zWsu8nX3Bf0hNPCFAt/Z9esp22leGAEnErv3w6Yo02zlZYRUpuoHnREi41J5GzZf2YhymJCewSo4e779i+/yBI/1f59K91OXXb0VyyojL8TVLRDUcakD97wikC756pst516Qca/7O51g6YdCDjl1T7p5IKPQKnbzEL3HzSCKu4LI1CXgyOpyph+AqTQRMJvo9AqBAJl/kuRMXdewsmhU6Unj+MAxhbbr0Jc+kJ0jE4GlliMc40N+3sUtaQKnqierkLcFfJ4MgZ9r6hxIE8iRldJgmw4Woxoxdk8Ex9pr2phidHopN4A2RsKhC8W/YT1oyzZOEvIO/BNkLT9L8FGnLC3NUT9BbfPNeA97ZtzmAKkUTmbVd182WvsCgI8AW4+pd1bYBdh/ZWSVAy5cNUgMCYBCC0PxSIH4v8bg711p+JvTTQu2BUg9lORk8OV9XNtiXNXLbiNCdNlzvdnbnhaOHPs8vv+ByxI5QhhpHNG6ex3llbqpPDQBs92+oIcF6zwZyzipvyYPLWtzSK/fMhH9mwZwu3s9xEnJ5zOzg0qv5bhKenn6aloiftEbTN4xAhebzaD98KsumiZAwuOHI7T2qGeBuqHAzyleiBYQqnGjeNOvMb7uFOops7favOoExmozwrYkVTZBa0r1glbu6IjsGVufcfnWm3/naYgNTFOdGYu4Dq0BSLpjiJJq+7LKbILbpohg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(36092001)(451199015)(86362001)(38100700002)(33656002)(122000001)(38070700005)(186003)(5660300002)(7696005)(55016003)(71200400001)(26005)(6506007)(478600001)(9686003)(83380400001)(41300700001)(8676002)(54906003)(2906002)(66476007)(316002)(66946007)(66446008)(110136005)(4326008)(8936002)(64756008)(76116006)(52536014)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SD1OZI4sBuEXN4jCdi2m78U2O1ui3h6w98c8jcoTek6jCHhsTKU93FSoOYtv?=
 =?us-ascii?Q?NK4HW2Vr5ybxClIRmHxbSl3E8jjwP63ELdfVrOdys255MMVUvCuSH+YZBzCU?=
 =?us-ascii?Q?vF4vdCqUUfEt0LWUSiYiSLq51QvRfYLxMnGPxiEw1BKXtrmK2L3E4swxLQIU?=
 =?us-ascii?Q?f7GL4DeAh1HmpDDsAVPzyYTz2OW3Nfh32nZuhAqy4ZUlYoyi/9uOj2pse2Gj?=
 =?us-ascii?Q?/qnkOxXB2OBbXwcZPNk7EVIiaw3lC2AmvgGFtyzg/0d8mSMLERIXVl2AlIXp?=
 =?us-ascii?Q?2aOiuvQIOG4U3xpz7/csu66eqjJjv98LkiALIBxzd3Xazdy4TFEMolz9n7ax?=
 =?us-ascii?Q?o6OG7PKW59qg1ElxFpSo5BR7vF2uh0E8ykFCKF2IwON/t9fFiCwx0tds6uTV?=
 =?us-ascii?Q?lSuDAeM//Qf0bYrDwgxEw1Kh6/4diXFPe4YbGwonaHxtFaQ56U4Tpdid7Pia?=
 =?us-ascii?Q?lrNY1y0JDWR4LD55bn9oj+SwyaLXZiT6fMcRA+ePTHwdaHTPZWqUu5wfwFHZ?=
 =?us-ascii?Q?6G+an3hjIyWmLPpBZewczj1Xy+iFUeGWOTYjfcQFhnlY8MXBYKFg79EBRzcN?=
 =?us-ascii?Q?SX/TbWW7uWl7I0ZKZjzRH3Sq3QR3AfbaghrCLbI5iZGhtptuq0+ns5IBawVU?=
 =?us-ascii?Q?4ZXwGEyzb1F0yWreFXf7EndaxZE651fdI8cnJcpu9MiRyuesCyw1jH18GlvB?=
 =?us-ascii?Q?Mr3prSSEsRuYbO64JIGUAHz370bmpef2+8yDUKRlKkh1tJyqMvAcZLlByiHs?=
 =?us-ascii?Q?l3Vrkb+PyVkxxp242kCfasjBdVYw7zNQDJofTgozYzg3G4YHKg48fMFXkNVi?=
 =?us-ascii?Q?GypBwcDECa6E2ftJOaFaq4R03W+eqZFkVwvi1eZu0JD6hxjczY6BStWR7/Km?=
 =?us-ascii?Q?xQon9j1Gs2WjudVcfOQuoMXQaQLeo+yBHbgqMH+vefdmvQFAUnDnlwVJSRlF?=
 =?us-ascii?Q?aXZ8RGNxf869yoBBm7d8eoVoOjvFZ5QEOu49c7Gns7c3r0RpLVlKMAGxPf1F?=
 =?us-ascii?Q?w2YGAnro8ytcfcUK7ELkdCFx9jviDN5f7aTzng25bT/9W4iW7PWMY9SNVgL5?=
 =?us-ascii?Q?vYBNjZVsArZAVWrBBQRZSvGv6Od5+s48OYxvG4cELfu0c6+dWjtc0tItvOgt?=
 =?us-ascii?Q?KEdDsh4bRTTwKxCPQqofdtsuwcSIdKaI7MPI53rSlrIflppWgi7VDAGJnFag?=
 =?us-ascii?Q?rfCcr1vdQfLqw6PYabTyj8xxMSfqf0HBYn8cRKtPR+48cQI/V/oWM8Mfyqto?=
 =?us-ascii?Q?FuholKLh2rf8OCE+qwoj1Qxv2h8v1h8LpY2F/Jt0fVjsuHuxS/DKNdUha5Oz?=
 =?us-ascii?Q?oeC7fQbmg8JwM9gEDDZOujZl1+1zoj7nK2fothYR6/WxaCJnd3Of7qBrQeSG?=
 =?us-ascii?Q?Yvyx5Me41hBCPliNpkcZBLhKNYSB7UV2ybtRzjMqSTE542vnjrytNnJMWUFq?=
 =?us-ascii?Q?Caoh7UqP7L9D+tjv3/ZgB2T/LzXirfN52owt9pjoixxdGU3wI5jo0KYlB5jY?=
 =?us-ascii?Q?zLxvIw/kn14v/XpAkbPmG2nUX+WckXK1YAqZQT5b7sD+yJLNslI5kHtgtxVG?=
 =?us-ascii?Q?WHSDdlZ2FwSmX5HYM2EMyZqCD0d+edv95plrkYSabf8G7CaZ9Oj5VsHG8LtO?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2122460-3bea-4a88-9fae-08daa11c46ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:40:04.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kKxObFxHDhV+ga6ncigGiiquIi3lOgUb8JmCSQEstQQBTDbXqF4Ffz+F7t42JLODM9QYmIWQl2IS1FGRiVo9ZNw1lt1gSx2YO/gTQDK8vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8693
X-Proofpoint-ORIG-GUID: d2DMMSiQLQUb2VJkOHS5CzMByXqfkoK2
X-Proofpoint-GUID: d2DMMSiQLQUb2VJkOHS5CzMByXqfkoK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=770 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>From: Dongliang Mu <mudongliangabcd@gmail.com>
>
>Smatch reports the following error:
>
>drivers/usb/cdns3/cdns3-plat.c:113 cdns3_plat_probe() warn:
>platform_get_irq() does not return zero
>
>From the document, platform_get_irq_byname_optional only returns
>non-zero value, and negative value on failure.
>
>Fix this by removing the zero value checking.
>
>Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>---
> drivers/usb/cdns3/cdns3-plat.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat=
.c
>index dc068e940ed5..2bc5d094548b 100644
>--- a/drivers/usb/cdns3/cdns3-plat.c
>+++ b/drivers/usb/cdns3/cdns3-plat.c
>@@ -110,8 +110,6 @@ static int cdns3_plat_probe(struct platform_device *pd=
ev)
> 	cdns->wakeup_irq =3D platform_get_irq_byname_optional(pdev, "wakeup");
> 	if (cdns->wakeup_irq =3D=3D -EPROBE_DEFER)
> 		return cdns->wakeup_irq;
>-	else if (cdns->wakeup_irq =3D=3D 0)
>-		return -EINVAL;
>
I think that here we should have:
	else if (cdns->wakeup_irq =3D=3D -ENXIO)
		return -EINVAL;
 because of function:=20
platform_get_irq_byname_optional -> __platform_get_irq_byname returns
irq number (>0),  -EPROBE_DEFFER or -ENXIO


thanks
Pawel

> 	if (cdns->wakeup_irq < 0) {
> 		dev_dbg(dev, "couldn't get wakeup irq\n");
>--
>2.35.1

