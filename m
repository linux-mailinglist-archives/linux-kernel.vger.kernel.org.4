Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E56203D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKGXd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKGXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:33:25 -0500
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 15:33:23 PST
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA23B2E;
        Mon,  7 Nov 2022 15:33:22 -0800 (PST)
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7NCxA6016109;
        Mon, 7 Nov 2022 23:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=Oj/X65zC9E6CTB/BK/moA/W/l8CzIgVgzZj1IKlyOXQ=;
 b=GL4l92+g+UOUahk+/QmGYxfLX66upXI7qB+HimtGKS7MyXjYzVeCuSnODqPSgPOESTNP
 sy7axD616y0G7cet2aBlEjsc3wG3t0a7BwQE1uRCTf3CFrkZ5g7K+IJgmrpG0cLZ+l6h
 4goXEyftgim90aqDDfmHw4GpoXJq0fW4a9m9eRgD8fmCBddUGzlvhhB5RFDQvJMxq4cT
 BGvNFbFuGrjCnA0N7IfwZY1hwlGPnEt9t/2Qm4CzUa9xo8ln233+KeWG9CI2nUGx3fn2
 WMC3NiZp/JaxAboCSsjrjrbKwPb8FY3kLUNYJ+b3wEWeVsc2t/bS70Kj7cAq77iJsva4 /g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3kngk4tvs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 23:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy8aMCDFpGuQFoswC3XiJlNHOK4gsnT+1D5yHW/1orv6Xy09+Rsvbr15bEbV1y/FRYjpaL9ea8SOrtg1CY7k3JV6rl/raxiLDt6k2ttfdVfYyCDiG/lKRhIw2dVCxn1YLyiRzXSLiYEinsKLohsCeqBpRK1kR1Yuc2TtH4xw9gdA+/G7J1mRFSw2hw/6tObX36CfVZUC88/e3UFHUbFv1C89Fv8IYhOmTOsrMuRIX0+9Lja5dEIgu5C64YcCFwK98aKXBdccW0HYvwk3onJ0fwnvoZ68sZqLOlAKiErBmbSCejbf6MuFHi7GsMHEGzNiHCuko6+yMtQIFr9VpgINzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj/X65zC9E6CTB/BK/moA/W/l8CzIgVgzZj1IKlyOXQ=;
 b=Iw21R1S/Yt3UuX8V+uhMgSi+ohp7t5rXb1sw9EW3FZm09ruwFPh/rKr7QYwcz2hiPwCDFPcW2/iPaTZS85qihP5DFICHvZkjDNAqpbSYhRDiwV/DdM/JZCW4Gsv4rRYW1gYOi0Ng1SMY0/NMoCHPAD3TqfQblUPiF5T0t/OqT5O+Tvu3EsCq5RlSr3PjyFmYYuWN1gJ6pgnqGjyoVV98FtQodk6CADbMxrsKht/lHdNGTzYG1L7WDkIXD5D7IVFStfbC1Wqh0Cdx4KGvwRlVA0fIEOC4Hd8XQ9WwsLD49ElgBM40obVkZA5PtWFJ9exoj1kUfCmG/gR1DVl691zlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 23:25:13 +0000
Received: from SJ0PR11MB5919.namprd11.prod.outlook.com
 ([fe80::3cd8:f7b8:c7df:5d7e]) by SJ0PR11MB5919.namprd11.prod.outlook.com
 ([fe80::3cd8:f7b8:c7df:5d7e%3]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 23:25:13 +0000
From:   "Rawat, Arnav" <arnavr3@illinois.edu>
To:     "ike.pan@canonical.com" <ike.pan@canonical.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rawat, Arnav" <arnavr3@illinois.edu>
Subject: [PATCH] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga 14ITL5
  laptops
Thread-Topic: [PATCH] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga
 14ITL5  laptops
Thread-Index: AQHY8wAv76cQY3rRy0iDoZ7VASP7KQ==
Date:   Mon, 7 Nov 2022 23:25:13 +0000
Message-ID: <4785687.31r3eYUQgx@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5919:EE_|SJ2PR11MB7518:EE_
x-ms-office365-filtering-correlation-id: bf1ebfa6-2812-458a-d19c-08dac117527c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5BBrfI79/UaWvFzaHyCcVzZIDu4SmfFAU+7jv0856rjvqq8jBxkOMiHpfuR6Yt68eVGCde96lxG2idbrAAMu0dmdYLkBg1j37N0UX+aP1+pjmg/IxYXbueE1E5NR0R3IimgabInorBBGSymhAUQ4E6flgq8jSdgYora/mXlz0LbK/WjSbc0D+tP0a0DgyUgdY+pG7r6CRQt7AU1q9U/aB6yWArhONUDSZv5c9qsBAkjoloKePV+dINeqIdnhXXCWeSbp1u8xypD5pnhrPNgfkyajV4srDdP37lracA7G0fv9+j+f+yBeYeh9jkMZN/QwPhK4vUPhsRoPlma1C+QkChX/yNql09mL8OK4o9K2/9s952q79d8pkvjKT3wpTWypvz8uQVoxmLOfEVBV2RsaJYrbIg79iV4075IwKKe/CTVv13jtXk+nMqf4brgmEdTm23KhJgHUvoUuV2wgXKgwHt7Bet1HCZ9YK1ZwE8DcMDFlzaSHWYl+3vAYwrobB+IufI8zmMCQzJJN65h8GhQYv3E+i+mMf4q99TIR+oC/n7/BOivaZ2cjGnlukLim6/ixFdcv6grpI+nYVcSYlkxIckxjarYjM/G7fZE7JOdL+pcm4wMeY85y45gcy3AnN5UEHYbWpnuawxsj3fbA/YWwksj7zhGt8B7nRdoOCN470Wc04KvOBWyaTP0ROn733F7YMvl2//dC+MlFwjHunNE8fmOiEyO2BAJuQmW7llWPXZC4JpLFdi6d29JTAzxN5vMQrq/J8wsRL3MsSpXulFhvSeV51t7uVsJ+rigIc9iR4k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5919.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199015)(86362001)(38070700005)(75432002)(41320700001)(2906002)(107886003)(186003)(53546011)(26005)(9686003)(6512007)(122000001)(83380400001)(6506007)(66446008)(66556008)(66946007)(66476007)(4326008)(8676002)(786003)(71200400001)(54906003)(478600001)(64756008)(33716001)(110136005)(316002)(8936002)(76116006)(91956017)(6486002)(41300700001)(5660300002)(38100700002)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bkrzjHx9WqPvVqmmYE418fnyavc5zBNIetj/UwkKsQ2MOAjwtFr89i/avY2J?=
 =?us-ascii?Q?WdBnBbudu1oFvnU3FRVXUB79Tz9nQIYHDeZhCdiz8468h3cM+kkn/EA3FLBK?=
 =?us-ascii?Q?PabuqOIi9LVwfBSLviKNqNneiAX51RBAg5ZQcb+Zh01RUR9iEIUGfs8X27Xr?=
 =?us-ascii?Q?2jgiKVI3er5o4ukbf7ppMtyGmUuoMbqTMTJqhgv7EhHCsLM6lNyoVY5EFN0z?=
 =?us-ascii?Q?qnwp6egSG5UtJpwGZsjfzwuxlnrLstWifwcbilWa8DNcTgbfVgt3hsy13N4O?=
 =?us-ascii?Q?lRvSlOPeK/ci5oWSz1VXmEi7zireZM0yY2TeSAdD5AOFzYHHMhi5i7u0xx0i?=
 =?us-ascii?Q?Sm1PQ6ohapSgmOwgI5LWsyHHKOeBEoKd3XLffalZ+ZOWZ1sx7sio/aLAR1/i?=
 =?us-ascii?Q?B3FEnqw8M77rgsk2uqGRj1jaxSVCa0mPyLwJeB67Ede1wv3SZW89v7ylCP77?=
 =?us-ascii?Q?Cc5xECvu01m1vK0s7DV3XmIVCGAv0BDDbwzSRCJ3vH1m4xM0Lu78Y7tVu3LD?=
 =?us-ascii?Q?ynMw9PSONfD83480LLf19PuKiUZ4K1UMBwMUmPzx6fry2k+jHqJgb+M7T/d6?=
 =?us-ascii?Q?pYV8uySk9Pdbh0M8AI1gfhwSnINvEVU7J0VMFi12dCbKQ2CHvz8+RKnwvSop?=
 =?us-ascii?Q?CwnXVeemPtcm1sjbPfPg/Go3/TPpvZcd/cfqwceWYFO2BjjU6pGKdamoWpcW?=
 =?us-ascii?Q?0Ro1OgaNGtDjPod/Xp5GNHDrYsIeqzkNnRMKKZk76O+NJsI3sI0XWDTKUNa5?=
 =?us-ascii?Q?AUjIClNbywsZSN/RvLFoW67X0Uuiw6nL1yE7EgJxx5bvRJ9e2RpFxltx7Vkl?=
 =?us-ascii?Q?yd0yEY15T+lNi5uJt+gv/jPrDMDemSzSXXrVFPx7scpxIryqqyJAf00V+wkE?=
 =?us-ascii?Q?dFBuxOaMGQ3Yl0mDYJvJWY2wSFaEKvxD19f77STEW/JJj8Vve4idazVpuT3a?=
 =?us-ascii?Q?BI9GQa/zjZlXtumP4y7ZuVuH3jh3vFvB3UXsN9/OQXgqT6CprpLjdrq+vOjQ?=
 =?us-ascii?Q?9AhzvWxjQPeBrol/h6+ceLiRN6ErCB+GScAIeYal26GEkgwnv09bHjjSKxgD?=
 =?us-ascii?Q?V494AkO4m0UsvDHr1TJ/JGC5ssVN2ledBU4hSDSGnjnWyn0sAgbh3FWPkc9j?=
 =?us-ascii?Q?pWA/cRFS5sb7BL6AlFjv6sGT0z5yxrl7HJ5WjuVYegM5k4RyltZw2zf0/+MG?=
 =?us-ascii?Q?OZgFC8GFqoq1DkRm4aZNpBUNXXIlGoeOUGJl3hV458BbJq6USdVETvNOji3b?=
 =?us-ascii?Q?QFth3njYIgz7Dm0Oz4cz1J4KOBZXoEwUrqoRHcgHiQowFBbTjMTqNwHxvolN?=
 =?us-ascii?Q?s/wzgTdZGxlEqJT1bYI0WGnw7t0trbdkfULPvrPhThG2aeGLBR9JbJyK6Se8?=
 =?us-ascii?Q?RxyPShhLeJ3Q+pqcBBHQK+PLgM1tACce5Ke4CXV0SR9tyBp+1cS8VJcWIWAC?=
 =?us-ascii?Q?Rj4f2QcVExDzUPec2SO6Fu0QwEI2mgWs5NnNHrHXhmndMVrGYEMH7v8w0R1T?=
 =?us-ascii?Q?wAlJvz5PeI4OZVaHMSn7icFQoNJmkRG3Qfz9sikUGIy96Ltk6Csb//QWPeNk?=
 =?us-ascii?Q?nLDeFrdJL8NehGOqLGBHGSa050ogS4CINewZANxA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B075C22E410A5345A660EDCEEEDB2788@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5919.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1ebfa6-2812-458a-d19c-08dac117527c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 23:25:13.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNHZg2A6Go5FlCoFeZ9gI1nAmnegydrFgPK9CxZkaD5zxiEVR4SIvL44TLSouDCAKezgZ8wLEaves8xta56drQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-Proofpoint-GUID: M3csJso8DdF9xg2Ar0X21gCfvy5iQJgN
X-Proofpoint-ORIG-GUID: M3csJso8DdF9xg2Ar0X21gCfvy5iQJgN
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211070175
X-Spam-Score: 0
X-Spam-OrigSender: arnavr3@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 5bce4f5860d54e125715d896f144add831d19483 Mon Sep 17 00:00:00 2001=0A=
From: Arnav Rawat <arnavr3@illinois.edu>=0A=
Date: Mon, 7 Nov 2022 17:12:41 -0600=0A=
Subject: [PATCH] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga 14IT=
L5=0A=
 laptops=0A=
=0A=
The commit 3ae86d2d4704796ee658a34245cb86e68c40c5d7: Fix Legion 5 Fnlock LE=
D=0A=
set the WMI id for the fn-lock event on some Legion 5 laptops. However,=0A=
the same WMI ID is also sent on some Yoga laptops. Here, setting the fn-loc=
k=0A=
state is not valid behavior, and causes the ec to spam interrupts until the=
=0A=
laptop is rebooted, so include a check for this line of laptops.=0A=
=0A=
Signed-off-by: Arnav Rawat <arnavr3@illinois.edu>=0A=
---=0A=
 drivers/platform/x86/ideapad-laptop.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/=
=0A=
ideapad-laptop.c=0A=
index abd0c81d62c4..f529410d7015 100644=0A=
--- a/drivers/platform/x86/ideapad-laptop.c=0A=
+++ b/drivers/platform/x86/ideapad-laptop.c=0A=
@@ -1501,7 +1501,7 @@ static void ideapad_wmi_notify(u32 value, void *conte=
xt)=0A=
 		ideapad_input_report(priv, value);=0A=
 		break;=0A=
 	case 208:=0A=
-		if (!eval_hals(priv->adev->handle, &result)) {=0A=
+		if (!eval_hals(priv->adev->handle, &result) && =0A=
strcmp(dmi_get_system_info(DMI_PRODUCT_NAME), "82BG")) {=0A=
 			bool state =3D test_bit(HALS_FNLOCK_STATE_BIT, =0A=
&result);=0A=
 =0A=
 			exec_sals(priv->adev->handle, state ? =0A=
SALS_FNLOCK_ON : SALS_FNLOCK_OFF);=0A=
-- =0A=
2.37.3=0A=
=0A=
