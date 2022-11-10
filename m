Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE256247E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKJREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiKJRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEA642F;
        Thu, 10 Nov 2022 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668099812;
        bh=x2t1WEHSv/Xobd4JFvIWEfFa5FRwPCsm+v8kpN8OtL4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qbQJb8LsfyFmehWDtMO3aS428gTw8gO+ub3zsckAX0LZpPX4f29zVXvCbI6svFrtG
         m/fVu6hF3CvPJXllPP0f1E3j8IRCHy8PolvTDLRJ52nMM59l948+36TjORgeDMvhZA
         rVp/wLJz8HOFiikqJh9qAye8dg/oUDtQrZBoNnEpI49QAhUs6Oit9muRBmPfz0sxpe
         IYxb0rVZn/Nxwp4ON1MZnYbaizbP69DqUrv6ZzIwaBTeXHgsqh3FDpkbheXPyjXAV+
         qLtM6SxkZDFeMM8MmMWyBbKOmFmlLTZ7RS9ADqXnfCciKgIxTpRsuPaDpu4xMJ1Rn1
         Uc8GAVPPQmOwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.199] ([80.245.79.199]) by web-mail.gmx.net
 (3c-app-gmx-bs29.server.lan [172.19.170.81]) (via HTTP); Thu, 10 Nov 2022
 18:03:32 +0100
MIME-Version: 1.0
Message-ID: <trinity-e9c6aa94-6656-4d9c-9d9b-90ede6c8e6fc-1668099812662@3c-app-gmx-bs29>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Wunderlich <linux@fw-web.de>
Subject: Aw: [RFC v3 00/11] Add BananaPi R3
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Nov 2022 18:03:32 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221106085034.12582-1-linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:VQN4MP4prAKaeyQLdo2F1bcNtu4aIBSNXUEd5DaVlqlo7iiDfD3e/MRde1CxmvKyslJ01
 irslpCjv+U51lb0D6pDTYdwkEr9/Vi0BMF+t21Y+02yh83JcDo+32werxADltPtMgbeZV/J/ymQO
 lcvuVTh3t2XadeBpqIsfdCSrZ+sqsWmiLgSk6JhLfcUX6a2iNIcblbRMNynXCNQa2zRdgtphq876
 FC+xZJlSQVAdlVY/jZ7QDMa+soZRCtQWFHm6ZEdXCpgtzXXBTWyrzVYeReiQQAqpm9AFETsGq9hS
 L8=
UI-OutboundReport: notjunk:1;M01:P0:d/Krjwy8YxE=;BwTpPoAIASDm2UbdYKTFs+Zjp6R
 H9PD04o8pce8Sm0YsxBjQBLgwa9Y3sorQIw+8Zi75ZiWntaG24sLVoH8HA7bbotlgFVs3jtbI
 lm5+fbMVAKYVgXVxg+q3WM6+sS4ZBuoD1P7Hh36cW3Ey9kQ/FLVxCE+EEesTcTt5kHGskdhkM
 GVg6Ys1LfcRGpXw6RegvoAiSvBezHlTI9wi2lejCG9jeGhGRVOuSje/tBQIzns9WlMwkYN6gB
 Tq6YTOH9VM9iuy1tMAVF/q2Yb2iCGr4vvbKk+W5+6sGpr8amSuVfY9ZyoGTr72gybnqmTr0qI
 cDKJwX2mRE2cnfqYBj9oIKO9CUu6ZrBO7p/Ap/16LpTHM53v2YDn2kjKZB+oYhTqyWQLL96zj
 kwoNTA3P4s2ehnDfQYdsCQ4pVS3tP7Z6OV87b8V12k3EpoboCK3Kr68xW+/SQDv7RhOoyj+kS
 TaV5b58TkeGUZkjQ0jbVmxUzRhAcPyuWyvMV6YxUA9h+jhFZlIIt2O/lXaUb6e54asJsEOtYQ
 m2RtVqIPqWWsHbfjPqQapzAhrgREZ9lQrTZWggF1qSOULrVbJpnXKFWdiEsRhkcCNM8XUF2Ak
 s0R9g3ycbbigNtx9pQsFDflI0lm9M7674Vv1ALmGVmsQDdLYMm/TkrJL4RPmGQD7RlTXg+l/G
 2hUH9MrnscaIgGer3JyOkYQxAUV/GDomqQpnArQPDlDIxCbpieDHi8uoe1pwsHkTiepTq2a2Y
 7oCc8zlLKIFNLdq8fwvyKiCjE+uf6d+5I6GnOCH3q6hwnqlsqLeftP9qJr81nOCbIMJ0jVJBn
 lfBG7EVBlRZOJi147aR6osCXt9SGxqsJ3YcGwuEBmMCxk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

can you please take Patches 1+3 of v1 into your tree?
due to reordering in my tree i missed them in this version

https://patchwork.kernel.org/project/linux-mediatek/list/?series=685798

pcie-bindings are here:

https://patchwork.kernel.org/project/linux-mediatek/list/?series=690172

i found 1 error in bpi-r3 dts (properties from sfp1 not plural) which i will fix in next version and will drop
the compile comment in dt overlays.

also i've found this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2

so maybe i need to rename my overlay dts files to dtso?

maybe the others can be applied (at least the mt7986 nodes)?

regards Frank
