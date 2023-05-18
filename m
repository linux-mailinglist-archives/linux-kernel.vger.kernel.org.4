Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB8708B54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjERWMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjERWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:12:20 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37029121
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1684447935; i=spasswolf@web.de;
        bh=eneJwTZD0TVjPoGCSTsIZPTkcncoa+dBB3vE2mgjA5Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TvD4qT5pdggq6uxkcnE+BGYn47I6TItFz9Zv+MMnYINMYAR7z1V9mnZtLGSUXJAhr
         ewMuDNoyWR7SRk7RGXCUioQMT+qL8z99B30imdGUxjnBQvlTt4cAQie357oiFlpcr7
         ZyWV0SbCy8Hbg2+ABPj8jh0p+C1xHF8DXcNX2qzeBkOS459+1LcZ8G+PxKLGyvjkSu
         0tofhyeSLzYwXYSC1V5TuXqmwu7lGIcNGHdeGE44c3JFE+64QrvDMRc6Y8ev+0KPqF
         GyE9e/QD1iQ8y2A0qn7cg1xnR9cWHjcHoY6P2dRqAugc3KvU6IUjsfRQh6tHikbCpO
         NpMCh65aH+TBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1paFAu1ILP-00ULhb; Fri, 19
 May 2023 00:12:15 +0200
Message-ID: <f936f513a9239e8d9824e964db2f84f232daf3e7.camel@web.de>
Subject: Re: IPA_STATUS_SIZE, commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
From:   Bert Karwatzki <spasswolf@web.de>
To:     Alex Elder <alex.elder@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 19 May 2023 00:12:04 +0200
In-Reply-To: <e8391577-3883-9e31-b5a5-b407927a56d5@linaro.org>
References: <8a1beef0bc605756f8a45acf86f6bb58c188ae21.camel@web.de>
         <e8391577-3883-9e31-b5a5-b407927a56d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:n3ixjA7x8BrAFzzSdFw8KKqhKb7sx5AHO/FDLzAJu/3qld6+I1/
 /jLswfFj8dPqKGssagAgQ/+qiQLxdW2zRaRmNzpEYGVgPoDr133k9peWYqTM7IJtt4UJUGm
 qivsJZeE6gmn8x+93yeS3d6PyTh9V54BqKpNaFUglrUGUGcIzIY73wb/2CZUl4DELGEWeRn
 ifx6lhXVvZLv0uOnUfPsQ==
UI-OutboundReport: notjunk:1;M01:P0:Pd+g2YGLu1o=;hX1q3gL0cTNRE7fOqBFTsRDYP6F
 ZDttDlY8xESl8bh7lkOIrIxmEcim/kI0LTJbwstEX3J/X727WLe3SelM+aE4Ykue1THOT7KRQ
 KmJ5QuPESCKeJtsoQtomQ1Phlivc8tOdZ1rC3Hya9jYwQDaA+rQvIHKfD3YSuKGk3wnJkUUDr
 ldHFIgfhOUTVhdueF2f3wWs8KdSGvHchQIhUcUhMLf1soGwnQEdBQOdGn9WYIsSPdFznXGDfp
 /JjM2/4PA/+ow6OS18GDb7ux3Vv9RmJfLHStdgOwqsT7/AV/j/N4QqbqIARTV4FBjTmOnNDWH
 jxIXDbKNFVi/u8ybPs7/7bnX2ihgEN2Csm/KEgtxo6OBtc7cn7xZWelykLxYiZhH05TdJS1No
 AJQmXrJYXGrb8stz6iq2bWiIHM2cUqvAMoD/S/3QDTYN1LLlRuUDGX8kj4L+AUHfVw5uBuKbj
 R5Ks2EoPtZR09bcsQfoOnnMX+9T04FzZlBpdQaQ4o/oS/32/6CV7obR5tlMwdCf+5Rh6gWfFG
 IVsM+5zT+z0a6KM/JNe0Cdt/AveTffWecUryoGRI7NsfCIUssVERD7khPYQ4pmC6DZkO9Tw0p
 TdjEMMbrwHWywoCDPg2Ag76GugT2+MazKOPe47qzBQ7LK2wfdVajuFkNqXpdVymLGRuMXdv4+
 cm5OOg0Z4L5Nvl13hRwvAbk8vUdodmnR2Qcv5uhrTAIrq8hSYryNnK/pfFi7SFNmXXl0vcMSm
 L0zACUqu/F7jX2YXHNxrY4phtWeferpn7c5v9ffa63srvAsvhH8l4smCcQlbOrfDxuSBpzj8j
 JE5V+yhfe8tZgB69+9XIi9Hc/o5ST3tjihxXi5SPmO3qk6aF7pBbCgYEvCHZiYqkuMOPY2fRo
 7/5Km/fQt7oOUq+VrlUqoyPQTn1w7eGoSPoHWNNh27D3zOOJtDaAXY3OLQPNOTRzpAYw6h8Mn
 5IYHcqG1qH3lCUeN7kAyLOIY8tM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 17.05.2023 um 16:35 -0500 schrieb Alex Elder:
> On 5/12/23 8:04 AM, Bert Karwatzki wrote:
> > commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
> > Author: Alex Elder <elder@linaro.org>
> > Date:=C2=A0=C2=A0 Wed Jan 25 14:45:39 2023 -0600
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 net: ipa: stop using sizeof(status)
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 The IPA packet status structure changes in IPA=
 v5.0 in ways
> > that
> > are
> > =C2=A0=C2=A0=C2=A0=C2=A0 difficult to represent cleanly.=C2=A0 As a sma=
ll step toward
> > redefining
> > =C2=A0=C2=A0=C2=A0=C2=A0 it as a parsed block of data, use a constant t=
o define its
> > size,
> > =C2=A0=C2=A0=C2=A0=C2=A0 rather than the size of the IPA status structu=
re type.
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Alex Elder <elder@linaro.org>
> > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: David S. Miller <davem@davemlof=
t.net>
> >=20
> > introduced the IPA_STATUS_SIZE constant as a replacent for
> > sizeof(struct ipa_status). IPA_STATUS_SIZE is defined as
> > sizeof(__le32[4]), but sizeof(struct ipa_status) =3D
> > sizeof(__le32[8])
> > and the newly introducded ipa_status_extract operates on 8 __le32
> > words, so I wondered if IPA_STATUS_SIZE is correct.
>=20
> You are right to wonder about this.=C2=A0 I think you have identified
> a bug.=C2=A0 It is a bug that most likely almost never matters (because
> the status size is always proper--and not too small), but it is
> a bug nevertheless.
>=20
> Would you like to provide a patch to fix this?=C2=A0 Otherwise I can
> do that, and I'll provide credit to you:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Reported-by: Bert Karwatzki <spasswolf@web.de>
>=20
> Please let me know.=C2=A0 Thanks for inquiring about/reporting this.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0-Alex
>=20
> >=20
> > Bert Karwatzki
>=20

Here's the patch that addresse the issue (if there's a > in front of
the first From, that seems to be a quirk of evolution ...)


From 583f35b3d91f048d413fc4f6a3b9237fc9d7efb2 Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Fri, 19 May 2023 00:02:55 +0200
Subject: [PATCH] Make IPA_STATUS_SIZE equal to the size of the remove
struct
 ipa_status.

---
 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c
b/drivers/net/ipa/ipa_endpoint.c
index 2ee80ed140b7..afa1d56d9095 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -119,7 +119,7 @@ enum ipa_status_field_id {
 };
=20
 /* Size in bytes of an IPA packet status structure */
-#define IPA_STATUS_SIZE			sizeof(__le32[4])
+#define IPA_STATUS_SIZE			sizeof(__le32[8])
=20
 /* IPA status structure decoder; looks up field values for a structure
*/
 static u32 ipa_status_extract(struct ipa *ipa, const void *data,
--=20
2.40.1

Bert Karwatzki
