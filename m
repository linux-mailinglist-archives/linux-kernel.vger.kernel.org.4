Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE35693747
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBLMdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBLMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:33:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180FFF25;
        Sun, 12 Feb 2023 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1676205191;
        bh=mfAdWlTjwfH3+nbkJ+Eo3z223mI2t25YvKplATELZCg=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
        b=LSu98A3PnyIOMpVWltOiGOe7kDBOmvwPKPdDzC7BbP3w6y89RWXsRjLQ9Bv6SWAsx
         F+AMUStMG/rIB/5dMeqtqRU2uxHabKyfumtLhImNZKUHIAN68bAiJSdLiSAnXUoyTr
         5lfgVz8/NvvzigRg1XCJubEyZJkWe2G8dIaq+yh3R2yvgo2VIdNI2L/th8nAqn+AYC
         NAKu0TNDNYWemI5RPVTx3Iis1uWcOlkcST2SX6T0imk56lbR8x97u38VIDWJDAOdJQ
         uuIP2NJRMnpEOXr+26TIz8pHoGQvPasEhg9ADK3n50iqSSvhrdrOUZ4NRvFQOHuc/K
         Ko6ahi7aeiSjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.147.13]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6lpG-1pV0Uz210g-008GgB; Sun, 12
 Feb 2023 13:33:11 +0100
Date:   Sun, 12 Feb 2023 13:33:10 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: Re: [PATCH] arm: dts: mt7623: disable home key on Bananapi BPI-R2
User-Agent: K-9 Mail for Android
In-Reply-To: <20230212121354.44590-1-arinc.unal@arinc9.com>
References: <20230212121354.44590-1-arinc.unal@arinc9.com>
Message-ID: <C18B89E3-7B54-47B4-98B3-B2D74AB29A54@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3v1Q0P2cM0SvTy/PY8QCQf/wi4JtkA7j6Mx04xrx2ALTl8Wi53i
 lgYIJ8+mPhkrWdz49Fq4lS48iPxOm9ytmTDYqBDmlyGVS1a2IiNiBPyb4RJ+b9O/Q8Teuit
 vhkIr+f6w0aHU/R1UBLNvuAFEAzEgCVx7BppKgsvABifOSwUeHacW7oLaYj2gBsmbCfQRFr
 NiX/DvDj1pHSacJgtZfTg==
UI-OutboundReport: notjunk:1;M01:P0:kJHbSfdxVZU=;Zmqx7cMp7mXYWAwrv8kftavGJZd
 0yYsnF7Xsm9b+kSicIf+rvVxdx3h2WPVe8Lkj5fBi+Ewm8wAcKh00KaDHL2i+I7nOfNrtXzG5
 /CeZ3q06BwYCV9lrJPvAXvSEAqhcDaGNGc/O3OWe/zz33s51CMFo4KaLuJ5fgafAsJ90Z2Thc
 lxUScrUFp5g7TjvEZGSbymGAjmWCDUA043NNDsdP/gFXvCR2dYOxzYWYFzDJbH5htvZa1N6SZ
 e+tEuWPmyiGQUp5YqoB7GuYAS01m6AZ2yMUvpdGG9mRjgtlI2BUqu4P7QhvgzRUKCOjZvgAFi
 upFs6CGy/ih7b6VVmuTS9MLLenGOO7zZBs5vFDkm6qPNONKpGrgZB5MrrttLx3pfzNn/KOz+R
 reg1dVc7FCW895a2+Ee9KWneLWaoBMN5pMAeUOJzd8hDk4bovQMJ16EdASKBI0pPVM96DJwHR
 qXOFJm+qgYywlFIpZmbbysNb1a7sFocnH7Sex0J8yJ6D4IftB66NZ8nV5lj+HMjovu6Sj2WHU
 a7nLz7zsImDSu7lp3U3w/9wc+kIQC3fTasHyyWfUQO9wvuxqE/DB/nAJHoHmB/m/xmmBgGxTI
 d1oQCbw4HVSDrFtc54+n2MFJ64y/nFXYIRnmzOPr7SylY2FBqx660ibKcaoBdWMbT0Me+KCCs
 3Y2yB6CmllpC+cFq3LsAXgNlEiyh4cAfqtib5obK8DLrkgXQCX0dFXG0Am3Z43FQUabX3t37s
 cOAMSEGEHEJ8RIuuQDmTxN20xOYB/USFVZBhhVlLiKVZ5ic9F0YXiv6hu2upZ2z4DqwprufJj
 4qEar5pvIhkxVYFj5lUm0sI8VFnZmXVaMYKPwHJMjdhYKsfUfI7RUnyZ2Hwk9LPra/QOvr6lW
 7eiKNUVfJsWFXI4eN2ZtR7JbusnMl3N6eiB0uF9lHPVx3+HfAdcnN1dCpI1UfSi9W6Ib0ogRC
 yLGjfguf3Yo2Aht6tCWzdVa67tI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12=2E Februar 2023 13:13:54 MEZ schrieb arinc9=2Eunal@gmail=2Ecom:
>From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc=2Eunal@arinc9=2Ecom>
>
>There's no home key on Bananapi BPI-R2=2E Disable it=2E

>=20
>+&mt6323keys {
>+	home {
>+		status =3D "disabled";
>+	};
>+};
>=20

Acked-by: Frank Wunderlich <frank-w@public-files=2Ede>
regards Frank
