Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4D67FABA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjA1UIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjA1UH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:07:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49491C146
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:07:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso5697017wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsd6EWf4HXXkWoxwYarvtcDdBMgP1ysZ908RsyhTPEo=;
        b=QRd4Aa9WhmGgX/bfVDZM4zN7W3z7tKZdn3XfSH3k1ftuIU9XMOgr2W2Zlthl218TdQ
         zv9wrbZJnqAzR0U8Eig5PEl7nofOCHx6+OSl+jPpmP3dw3tgTCaT/QxOmPDHBWy1vsa+
         aF/TU5UIGFxidgHNEnpdnYFJLdBYXob6gPxbPK6zeCLWoQhDm2WImji4t66mozXL26wN
         ZsG3L0aFQy67Bsv+TrZee5f8QXyso0cbAHNk3A+SrdJCwhwDDNI4H2ggcwVVZcBzFD2L
         L8DHw5vPLG7U+xS2jRNzo1Q5nQ3DZWzAF/m3tV8Zut5xDsvhidQP0IWPeAIqjR5FjB0T
         CJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vsd6EWf4HXXkWoxwYarvtcDdBMgP1ysZ908RsyhTPEo=;
        b=bglYE7dIRrdFqgOAIl9JWZp1+f3wWOr/KfoyvixddPN+/xKCFq93+8yXitKaLPjaZp
         BXfmjv3TyUNS3Rwt48fYOCz2zSBv3DcZWTZBmVVBnZ48pryUBQ4h9mE7Vng+zDNYlGDG
         DP60JdOqimzsGyX5l6U5UubD1XqI3dusjt1nRE3q1rTZ0rfbJGnsecAOnzGzCh3YDs44
         z0Z5VMoWBdUz6RFQyxilmwmIyjxHfLl09lGp7ZAhr6pCXXy667oRTAYtFJW4o2ZDv4G6
         eXILvyUoxKzZm71B/NGUrRS0rhrjKCrS0JhPfaTm1iPqaC8q8WKMCZsg2ECe+EPmMJ3U
         3dqQ==
X-Gm-Message-State: AFqh2kplLtbOo+mBmAcnY8oN66drsOnEQ8yM/2UHEsZHjpCUW2ivlQxE
        Xfy1VmBErD39mvVD8zILwh7Eh489gA9neBvUFCk=
X-Google-Smtp-Source: AMrXdXszrJhQ4vU7xLK483OZOPtw8S+R0H5IEtv3NSTO+AX5OVpyGaQ5USSydNsSQQX9ofOsnT63uqGkcTLaLyba1yA=
X-Received: by 2002:a05:600c:c8c:b0:3d0:4fcb:253b with SMTP id
 fj12-20020a05600c0c8c00b003d04fcb253bmr1913439wmb.199.1674936472544; Sat, 28
 Jan 2023 12:07:52 -0800 (PST)
MIME-Version: 1.0
Sender: dw1052886@gmail.com
Received: by 2002:a5d:5a8a:0:0:0:0:0 with HTTP; Sat, 28 Jan 2023 12:07:51
 -0800 (PST)
From:   Elizabeth Sayouba <elisabethsaqyouba@gmail.com>
Date:   Sat, 28 Jan 2023 12:07:51 -0800
X-Google-Sender-Auth: s69aMIjGMgEwZYzJPa7h7Tm04k4
Message-ID: <CAKiYHBkcYV0LLTJ2xpySaXE0Tp8bqJTbtGJKB4u0ysuKtwPguw@mail.gmail.com>
Subject: =?UTF-8?B?7JWI64WV7ZWY7IS47JqULCDsgqzrnpHtlZjripQg7Jes65+s67aELA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7Lmc7JWg7ZWY64qUIO2VmOuCmOuLmOydmCDshKDtg50NCg0K64iI7JeQ64qUIO2BsCDriIjrrLzs
nYQsIOuniOydjOyXkOuKlCDtgbAg7Iqs7ZSU7J2EIOq4sOuhne2VmOq4sCDsnITtlbQg7J20IO2O
uOyngOulvCDsk7Dqs6Ag7J6I7Iq164uI64ukLiDsoJwg7J2066aE7J2AIE1ycyBTYXl5b3ViYQ0K
RWxpemFiZXTsnbTqs6Ag7KCA64qUIO2KgOuLiOyngOyXkOyEnCDrsoXssKwg7YKk64KYIO2MjOyG
jOydmCDtlZwg67OR7JuQ7JeQ7IScIOyXsOudveydhCDrk5zrpqzqs6Ag7J6I7Iq164uI64ukLiDr
i7nsi6Dsl5Dqsowg66eI7J2M7J2EIOyXrOuKlCDsiJzqsITsl5Ag7KCE7JWV7J2EDQrsmKzroKQg
7J20IOunkCDrsJbsl5Ag7J6I64qUIOuwqeuyleydtCDsnbQg66eQ7J2EIOyghOuLrO2VmOuKlCDq
soPsnoXri4jri6QuIOyggOuKlCAyMDE264WEIOy1nOyihe2VmOq4sCAxNeuFhCDrj5nslYgg6riJ
7Kad7ZWcIO2CpOuCmCDtjIzshozsl5DshJwg7YqA64uI7KeADQrrjIDsgqzsmYAg7ZWo6ruYIOyd
vO2WiOuNmCBNci4gU2F5dWJhIEJyb3du7J20IOqysO2YvO2WiOyKteuLiOuLpC4g7Jqw66as64qU
DQrslYTsnbQg7JeG7J20IDEx64WEIOuPmeyViCDqsrDtmLztlojri6QuDQoNCuq3uOuKlCDri6gg
M+ydvCDrj5nslYgg7KeA7IaN65CcIOynp+ydgCDrs5HsnLzroZwg7IKs66ed7ZaI7Iq164uI64uk
LiDqt7jsnZgg7Iuc6rCEIOydtO2bhOyXkCDrgpjripQg7J6s7Zi87ZWY7KeAIOyViuq4sOuhnCDq
srDsoJXtlojsirXri4jri6QuIOqzoOyduOydtCDrkJwg64Ko7Y647J20DQrsgrTslYTsnojsnYQg
65WMIOuvuO2ZlCA4NTDrp4wg64us65+s66W8IOyYiOy5mO2WiOyKteuLiOuLpC4gKDgwMOunjDUw
MDDri6zrn6wpIOyEnOyVhO2UhOumrOy5tCDrho3stIztgqTrgpjtjIzshozsiJjrj4Qg7JmA6rCA
65GQ6rWs7J2YIO2VnOydgO2WiS4g7ZiE7J6sIOydtA0K64+I7J2AIOyXrOyghO2eiCDsnYDtlons
l5Ag7J6I7Iq164uI64ukLiDqt7jripQg7J20IOuPiOydhCDtmZzshLHtmZTsi5ztgqTqsbDrgpgg
7YyM7IaMIOq0keyXkOyEnCDquIjsnYQg6rCA7KC47Jik64qUIOqyg+ydhCDrtojqsIDriqXtlZjq
sowg66eM65Ok7JeI7Iq164uI64ukLg0KDQrstZzqt7zsl5Ag7J2Y7IKs64qUIOq3uOuerOuNlOuL
iCA36rCc7JuU7J2EIOuyhO2LsOyngCDrqrvtlojri6Tqs6Ag67Cd7ZiU7Iq164uI64ukLiDrgrQg
7IOB7YOc66W8IOyVjOqzoCDrgpwg64u57Iug7JeQ6rKMIOydtCDrj4jsnYQg7KO87Ja0IOyGjOyZ
uOuQnCDsgqzrnozrk6TsnYQNCuuPjOuztOq4sOuhnCDqsrDsoJXtlojsirXri4jri6QuIOyngOqw
keydmCAzMO2NvOyEvO2KuOulvCDsnbzrsJjsoIHsnLzroZwg7IKs7Jqp7ZWY6riwIOychO2VnCDs
i5zquLDsnoXri4jri6QuIOuPiOydmCA3MCXripQg64+M7JWE7JioIOuCqO2OuOydmCDsnbTrpoTs
nLzroZwg6rOg7JWE7JuQ7J2EDQrsp5PripQg642wIOyCrOyaqeuQoCDqsoPsnoXri4jri6QuIOq3
uOumrOqzoCDqsbDrpqzrpbwg67KM7J2064qUIOyCrOuejOuTpOydhCDrsJjrjIDtlZjshLjsmpQu
IOuCmOuKlCDqs6DslYTroZwg7Kad6rCA7ZWY6rOgIOqwgOyhseydtCDstZzshowg7Iuc6rCE7JeQ
IO2VmOuCmOuLmOydmCDsp5HsnYQNCuycoOyngO2VmOq4sCDsnITtlbQg64W466Cl7ZaI7Iq164uI
64ukLiDrgqjtjrjsnZgg7IaM7JuQ7J2EIOuTpOyWtCDqt7jroIfqsowg7ZWY6rOgIOyeiOyKteuL
iOuLpC4g7J20IOyniOuzkeydgCDsoIDsl5Dqsowg66eO7J2AIOyYge2WpeydhCDrr7jsuZjqsowg
65Cp64uI64ukLiDrgpjripQNCuyCtOyVhOyeiOuLpC4NCg0K67O07IOB7J2EIOuwm+yekOuniOye
kCDtgqTrgpjtjIzshozsl5Ag7J6I64qUIOydgO2WieydmCDrsojtmLjrpbwg7KeA7KCV7ZWY6rOg
IOydgO2WiSDqtIDrpqzsnpDsl5Dqsowg7KeA7Y+Q7J6l7J2EIOuwnO2Wie2VmOyXrCDqt4DtlZjq
sIAg7J2A7ZaJ7JeQIOyeiOuKlCDrj4jsnZgg7ZiE7J6sDQrsiJjst6jsnbjsnYQg7ZGc7Iuc7ZWY
64+E66GdIOyngOyLnO2VoCDqsoPsnoXri4jri6QuIOuUsOudvOyEnCDrgrTqsIAg7Jes6riw7JeQ
7IScIOyduOyngO2VnCDrjIDroZwuDQoNCuu2gOyduCBTYXl5b3ViYSBFbGl6YWJldA0K
