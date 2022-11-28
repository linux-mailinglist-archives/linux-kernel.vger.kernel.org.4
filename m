Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286063B47A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiK1Vtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK1Vtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:49:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F092F384;
        Mon, 28 Nov 2022 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669672172; bh=RavA9BgbtnCpfeKmmttPqt2PspmEONxNtyxh+bEyHGY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FiCHopUi8isfJcjoqIRcYiTVhvDZbqsBprPbgZDifRwu8O+81IUsS5gDgP7VzRyST
         0vxffhH5pccWgY4yVqxIY/bYm/i9KZg6txf+ZOuz2FmHqHP3UUJlM29ltwfiEfvK+X
         k7YFm+BJ7NN12fIWmLpE0Xjn/RM6PdUf3y1qjFgrtAxxbSDrzPcOCm0KBn2rxWOUIV
         edc7hjh6b+x2XbMFOq2jFwDosu61M0Bd2ogxlEtLLtaLtmDiELFGmCV2fui4VLaVEy
         NaR2iaQ3Z0w45VL0imjqH6srmdIcg9ubvxC5Fq2U6SVLyDwcEv/OHosmUE6bozRmpi
         c0bUWgQYaMIwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1ocn3A282e-00nid0; Mon, 28
 Nov 2022 22:49:32 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing reg property)
Date:   Mon, 28 Nov 2022 22:49:28 +0100
Message-Id: <20221128214928.3531463-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
References: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xqpXGQO6+Yu9CpVnDs/FsvdtqBSW0zviiqNAGW1LyN1QXQsy2sV
 rkeT3S34+2FPR4ENe3qT6bwgjlZLVbjzuB/luKAryE9oTSUrHreIpBrX4CpCQO1ZtCBK+x4
 TLEKu2zSqb3tpUa3pmxxoYW6ypWooTQr8jaJYmhOLslezcId22OTlZWVGP/+1IylxpVLv8V
 OgwGk7IPofuu8MaFENCuw==
UI-OutboundReport: notjunk:1;M01:P0:NBafmIHXHOw=;wowX/cO77OjqVFSZ/t9Wu8lndi7
 D33OxbkdnLBrxFAr1HLZ0N+U3+jOK87yCI+pta9ehud0IfK0CrPq2vHHZHDtVHKROZ4sXBPrC
 MvWjpc9Z/uL4mG90PVt9L1Y1XieFzHrigTEvUjmexpcFxl0lIcaJO4PX9lGVw57wKfRdl6ri8
 TgxgXgVS3viJkJywlyvzsf8gJlhpvh5FOESxIgeQpL7ONMi7pVuXw73XqHRnCXlU2Af4CNO9h
 GBA2a7rV8iQEZ5vB8zsepUMyXxz1uK2CabSBG5oWHI13aC58pFiYaCVNh5cCNZ4ZGr/rNG5c3
 V0hcmBeYkHr7e2L+fxUFzDjngI45Izuntzy6fjV5Pf28yHre399buh/Q16zDb7lBnix/gd/q3
 j1iZPm6UvnTyjFnTiFTVzkdAeuGchJtrqldxypct0gGfJnUnesVjqJax5BsXzgldGcENYSam+
 8P9NDqzpjXKBXS2SX7BZppKt8Rq5Z/wRc5TkCFTGRauHf19ZuJktWTEFnrKxHCuBdV0+gi7jK
 hakOdCIlJkI/w2uwnKEaXQZ0nAA8ER3Zp/6/7TOYqiS0kBkORQ0ZYD1FIOdzi0EodXh6wTHQG
 7xJh2ckxK2vrlzDgRDSQ+mPnvx0+EPW2wybwEpCQk4hsYgmUmL8x7CUpjd3CNaN9HvRByXf+1
 zoaxyCutlmV34hoAxbZcd9W47cFGXKGKHsskeg/FESFturRWLx9BCN2A0leuUUaJ/w8ghio65
 1LwkzxMZZU2i7kZthhOkP/uaAUTScBgUo9CPBrbwUFq/XbSEFR+ZN10c7D8LNj3WKhhqfW4uc
 kfxDDwJn/zxGFyiFIS3uqSn97+2r+Swun1KS4HS9w3xT9AcT1+VBwrJCLK2vwDHfjMqreSYSF
 XinSX/LRDqmKuARQYbFwBIib9+ILPsZ27M7fbjSfut7q/+NGPu5XVrQjclgOnZg4+h6dZrotV
 LNcuvQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to add a "reg =3D <0>;" property to the flash@0 node while
writing the example. Fix this.

Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)=
 bindings")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yam=
l b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
index e4162845fcc1d..4e0d391e1d697 100644
=2D-- a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -56,6 +56,7 @@ examples:

       flash@0 {
         compatible =3D "jedec,spi-nor";
+        reg =3D <0>;
       };
     };

=2D-
2.35.1

