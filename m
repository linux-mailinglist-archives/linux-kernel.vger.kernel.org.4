Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A121A6D0787
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjC3OCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjC3OCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:02:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9344EC6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:02:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t10so76751689edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680184922;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zprVqURmoIr8Yjxlxe5JE5AiP0aq2hBtyHd/myx7ajE=;
        b=QLKQXBahF2ITMq84r0Q6nmjqbgt6GKoFY7x2lSKY6hyNqtjVC99dgSgDC+BgwobBXP
         UJvoBdyd16qrrR+JZ/haUILOY6lEC2kEXQInCUzSSX8r8PbYYw+X74rp2PJdCGbDixkY
         cbUfvnUJ0eDHybU53nIBeGxbm8bb8pyfPSKjPoC4gB4qpLGWvWSni2zBWflfoNHIz9fT
         54WjzYSjs/1GwFM4Bcj/8+MnBnyW4bVFmVqerQzQnUUxN6rNsdJ3rcExpvuQr52gvTnd
         k3S0pAFmkQI54pqr5MyO1pckk/v8ZkSFMggEawocoM9oyCOCg7gQvZwBb025SVf2vdFV
         HWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184922;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zprVqURmoIr8Yjxlxe5JE5AiP0aq2hBtyHd/myx7ajE=;
        b=rnohh8S+tl1N2T+MBALVFskJba0y12+DCw6BzvlJ6PHf9nejubdFv7URVwI6Qe3bbt
         O8i6aNlYo+9BHGnvAsUXXomfk76e9a3BRglklriVIy1Vb42tMZiQmCVPU68xQmRmYGif
         HlJL9FJ92P5iNBChlwsxiJ6MTn019YvXzBaLqtooqm9Vz1+MzSXgMZNMOT+F1+9XJ6zF
         /LJ1PSErPPq9kDfGl9unAjBtR8jLt4t+c4pyQr/1Zdmw/evh9C2WyNDBORRdheHDF4q8
         IpyZyIcFEiflLeo9YUp1G2P1gYymaoWlYuPnPHMZfbcx2XoPJOvM8O749WyeYvFkgTiG
         FNtA==
X-Gm-Message-State: AAQBX9e1/UuDKqtmobcFacXp8k8oDdpRm2vkemr4IMX6qbGZwJeQujwQ
        ATQ3GF4OsViRdh7UFQL3aBGecuHcZLjrPq78lbY=
X-Google-Smtp-Source: AKy350aSo5k1iU5/O40DGLfkS2FKNLFXD9noE38a8J2MW2gNBMR1lZYXrAjG056k7+WA2UGB/T0a66wBmiMxPXxRT1A=
X-Received: by 2002:a17:907:720e:b0:947:46e0:9e51 with SMTP id
 dr14-20020a170907720e00b0094746e09e51mr1372549ejc.11.1680184922043; Thu, 30
 Mar 2023 07:02:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:4282:b0:65:6bd4:9c4e with HTTP; Thu, 30 Mar 2023
 07:02:01 -0700 (PDT)
Reply-To: mrspatriciawilsons@gmail.com
From:   POST OFFICE SERVICE <mrkelvinogene927@gmail.com>
Date:   Thu, 30 Mar 2023 07:02:01 -0700
Message-ID: <CA+SUeDFQLxt-JEr0PGhi0XVXu3HAcGJyE_YbLP4eBvvbqfxfFw@mail.gmail.com>
Subject: =?UTF-8?B?7Y6A65OcIOyImOy3qOyduCDsnbTrqZTsnbwg7IaM7Jyg7J6Q64uY6ruYLA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrkelvinogene927[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrkelvinogene927[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.8 UPPERCASE_50_75 message body is 50-75% uppercase
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7Y6A65OcIOyImOy3qOyduCDsnbTrqZTsnbwg7IaM7Jyg7J6Q64uY6ruYLA0KDQrsmrDrpqzripQg
VU4g7J2066aE7J2EIOyCrOyaqe2VmOuKlCDsgqzquLDqvrzsnbQg7IaN7JWY64uk64qUIOyGjOyc
oOyekOulvCDtmLzrnoDsiqTrn73qsowg66eM65OgIFVOIOygleu2gCDrsJTqtazri4jsl5Ag7Jik
656r64+Z7JWIIOyngOu2iO2VtOyVvCDtlZjripQg66+47IiY6riIDQrsnpDquIjsnYQg7KGw7IKs
7ZWY64+E66GdIOuMgO2GteugueqzvCBVTiDqtIDrpqwg6riw6rWs66Gc67aA7YSwIOyalOyyreyd
hCDrsJvslZjsirXri4jri6QuIOyhsOyCrCDspJEg6reA7ZWY7J2YIOydtOuplOydvCDso7zshozq
sIAg7Y+s7ZWo65CcIOuLueyCrCDsi5zsiqTthZzsnZgg642w7J207YSwDQrsoIDsnqUg6riw66Gd
7JeQIOuUsOultOuptCDqt4DtlZjsnZgg7KeA67aI7J2AIOuLpOydjOqzvCDqsJnsnbQg67aE66WY
65CcIDE1MOuqheydmCDsiJjsi6DsnpAg66qp66Gd7JeQIO2PrO2VqOuQqeuLiOuLpC4NCg0K7Jqw
66as64qUIOq3gO2VmOydmCDsnpDquIjsnYQg7IaN7J2066Ck64qUIOyLnOuPhOuhnCDrtoDtjKjt
lZwg7J2A7ZaJIOyngeybkOyXkCDsnZjtlbQg6reA7ZWY7J2YIOyngOu2iOydtCDrtojtlYTsmpTt
lZjqsowg7KeA7Jew65CY7Ja0IOq3gO2VmOydmCDsuKHsl5DshJwg66eO7J2AIOyGkOyLpOydhA0K
7LSI656Y7ZWY6rOgIOq3gO2VmOydmCDsp4DrtojsnYQg67Cb64qUIOuNsCDrtojtlYTsmpTtlZwg
7KeA7Jew7J20IOuwnOyDne2WiOuLpOuKlCDsgqzsi6Tsl5Ag6rK97JWF7J2EIOq4iOy5mCDrqrvt
lanri4jri6QuIOycoOyXlOqzvCDqta3soJzthrXtmZTquLDquIgoSU1GKeydgCDquIDroZzrsowN
CuqysOygnOyduCDrp4ztgbwg67aB66+4LCDrgqjrr7gsIOuvuOq1rSwg7Jyg65+9LCDslYTsi5zs
lYQg65OxIOyghCDshLjqs4QgMTUw66qF7J2YIOyImOugueyduOyXkOqyjCBBVE0g67mE7J6Q7Lm0
65Oc66W8IO2Gte2VtCDrqqjrk6Ag67O07IOB6riI7J2EDQrsp4DquIntlZjquLDroZwg7ZaI64uk
LiDshozruYTsnpAsIOq4sOyXhSwg6riI7Jy1IOq4sOq0gCDrsI8g7KCV67aA6rCAIO2YhOq4iCDr
sI8g7IiY7ZGcIOuMgOyLoCDrlJTsp4DthLgg7Ya17ZmU66W8IOyCrOyaqe2VoCDsiJgg7J6I64+E
66GdIO2VmOuKlCDquLDsiKDsnoXri4jri6QuDQoNCuq3gO2VmOydmCDsnbTrpoTsnLzroZwg67Cc
6riJ65CY6rOgIERITCDrmJDripQg6reA7ZWY7J2YIOq1reqwgOyXkOyEnCDsgqzsmqkg6rCA64ql
7ZWcIO2DneuwsCDshJzruYTsiqTrpbwg7Ya17ZW0IOq3gO2VmOydmCDso7zshozroZwg7KeB7KCR
IOuwnOyGoeuQmOuKlCBBVE0NClZpc2Eg7Lm065Oc66W8IO2Gte2VtCDqsrDsoJzqsIAg7J2066Oo
7Ja07KeA64+E66GdIOuztOyepe2VqeuLiOuLpC4g7Jew6529IO2bhCAkODAwLDAwMC4wMOqwgCDq
t4DtlZjsnZggQVRNIFZpc2Eg7Lm065Oc7JeQIOyggeumveuQmOyWtA0K7ZWY66OoIOy1nOyGjCAk
MTAsMDAw7J2YIOyduOy2nOuhnCDtlbTri7kg6rWt6rCA7J2YIOuqqOuToCBBVE3sl5DshJwg7J6Q
6riI7J2EIOyduOy2nO2VoCDsiJgg7J6I7Iq164uI64ukLiDsmpTssq0g7IucIO2VnOuPhOulvCDt
lZjro6gNCiQyMCwwMDAuMDDquYzsp4Ag64qY66a0IOyImCDsnojsirXri4jri6QuDQoNCuydtOyZ
gCDqtIDroKjtlZjsl6wg6reA7ZWY64qUIOuLpOydjOqzvCDqsJnsnbQg6rWt7KCcIOyngOu2iCDr
sI8g7Iah6riI7J2EIOychO2VnCDsnbTsgqztmozsl5Ag7Jew65297ZWY7JesIO2VhOyalO2VnCDs
oJXrs7Trpbwg7KCc6rO17ZW07JW8IO2VqeuLiOuLpC4NCg0KMS4g7ISx66qFKOyEseqzvCDsnbTr
poQpPT09PQ0KMi4g6rGw7KO87KeAIOuwjyDqta3qsIDsnZgg7KCE7LK0IOyjvOyGjD09PQ0KMy4g
6rWt7KCBPT09DQo0LiDsg53rhYTsm5Tsnbwv7ISx67OEPT09DQo1LiDsp4Hsl4U9PT09PQ0KNi4g
7KCE7ZmUL+2MqeyKpCDrsojtmLjsi6DrtoTspp0g7IKs67O4OiA9PT09DQo3LiDtmozsgqwg7J20
66mU7J28IOyjvOyGjCAvIOqwnOyduCDsnbTrqZTsnbwg7KO87IaMLiA9PT09DQoNCuydtCDsvZTr
k5woUmVmOiBDTElFTlQtNjAxKeulvCDsnbTrqZTsnbwg7KO87IaM7J2YIOygnOuqqeycvOuhnCDs
gqzsmqntlZjsl6wg7Iud67OE7ZWY6rOgIEFUTSBWaXNhIOy5tOuTnCDrsJzquIkg67CPIOuwsOyG
oeydhCDsnITtlbQNCuychOydmCDsoJXrs7Trpbwg7JWE656YIOuLtOuLueyekOyXkOqyjCDsoJzq
s7XtlZjsi63si5zsmKQuDQoNCuyasOumrOuKlCDqt4DtlZjsnZgg7J6Q6riI7J20IOy2lOqwgOuh
nCDsp4Dsl7DrkJjqsbDrgpgg7J6Y66q7IOyghOuLrOuQmOuKlCDqsoPsnYQg67Cp7KeA7ZWY6riw
IOychO2VtCDsnbQg7KeA67aIIOuwjyDshqHquIgg7Ya17Iug7J2EIOy2lOygge2VoCDsiJgg7J6I
64+E66GdDQrsl5DsnbTsoITtirjsl5Dqsowg7IOIIOuyiO2YuOuhnCDqsJzsnbgg7J2066mU7J28
IOyjvOyGjOulvCDsl7Trj4TroZ0g7KGw7Ja47ZaI7Iq164uI64ukLg0KDQrslYTrnpgg7Jew6529
7LKYIOygleuztOulvCDsgqzsmqntlZjsl6wg64yA66as7J247JeQ6rKMIOusuOydmO2VmOyLreyL
nOyYpC4g7Jew65297LKYOiBNUlMuIFBBVFJJQ0lBIFdJTFNPTiDsnbTsgqwg67O07IOBIOq4sOq4
iA0K67aA7IScKFVuaXRlZCBCYW5rIEFUTSBWSVNBIENBUkQpDQoNCuydtOygnCBNUlPsl5Ag66y4
7J2Y7ZWY7Iut7Iuc7JikLiDtjKjtirjrpqzsg6Qg7JyM7IqoLCDqsJDrj4UNCuydtOuplOydvDog
KG1yc3BhdHJpY2lhd2lsc29uc0BnbWFpbC5jb20pDQoNCuy2lOqwgCDsp4Dsl7DsnYQg67Cp7KeA
7ZWY6riwIOychO2VtCDsp4Dsuajsl5Ag65Sw6528IOydtCDsnbTrqZTsnbzsl5Ag6ri06riJIOyd
keuLteydhCDsmpTssq3tlojsirXri4jri6QuDQoNCuusuOyViCDsnbjsgqwNCk1SUy5LUklTVEFM
SU5BIEdFT1JHSUVWQSwg6rO167O06rSALuq1reygnO2Gte2ZlOq4sOq4iC4NCg==
