Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34563BDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiK2KXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiK2KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:22:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287AD2C9;
        Tue, 29 Nov 2022 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669717356; bh=MMa4AO2sLZOUO1ZQc5/iouT+dUCNR9+JoyIz9Fi7pcU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WqPCkIiJP/IZKyV2Yb9zkuL5qt/lFO/oGo0PD1O8e7lU6IZkXTnEtNKd7lTQ47rT9
         JkNUUGJG38ouiafaXahd9V78yBIf6aL9wrkE8oIwiZYL81tUc58YqkQpLJZgL6lPqa
         ydk+CONlDoO4ANx8DW196//YueWLMARvzYYhcP/+ssNzMSySaZWw0xrDSZ34zT71nD
         Aw5RGr64rW/+wxS9P6ndkHnUVjMMsmNKEgxrUI8+LhIe9euSpoGlp1BSeHyKm3WCo2
         JhrXGNZbDtNEk1cIpaNVY/clQOi4X5a2HQrDBuxlmxNyBP45f0WsdhIR/n837t1ilM
         DooVHza9gY7rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1pOcQ22Kba-00OnzX; Tue, 29
 Nov 2022 11:22:36 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/2] nuvoton,wpcm450-fiu binding example fixes
Date:   Tue, 29 Nov 2022 11:22:23 +0100
Message-Id: <20221129102225.3598044-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FiDZAdVgDwpknp8WvU7HBvgO8DkgRVuEb0Gpdheq9J8nULoSy0v
 bibH1XDidAcRaWDy67Wlg3JBdS4UHH55TbrRqJP5J1sNP1BnpkqIDlahjVVntK1FDckhFdi
 UeUlL1EB3g9rnNBMYredwfkGFVHnaDsYiorBcVUrXKJaDahHoNX2LU8wJtyJXqDdk6Vdrol
 N9vfFrx/URnuAIdjP5fww==
UI-OutboundReport: notjunk:1;M01:P0:qsYyjdY6MEI=;0ejfVFts21PTOpAao7mXCEz8Ch4
 l+4iG+o0n32gYWBxTOPJJNJXGenmBp76V931/iTJ94t6m5AO0fg34oxSsUVEKQI4J4tgJAhRT
 0ALq0thQ54bD2aWOfpyJMrRvz1S0wvChh4h4wFnmvcv68e723HBD8AiayTRS8OZXcaTOs8I2Q
 o+TKbonNEALZ2gElrNTf6ABpHI6ZVI5+NzwlX7aqI4Z7h7nqJFF82qYSlGyZvAMp+UrtLLNjF
 //+5kGi8qFxQxAb23GtFRty/oDJeCsHWD4berEE8XmauLC03MEflpwn6Rjt2M9zxeOdEM3o+T
 ICTSbx1i0YmwJGi+lBI2bYdd9e4f6Kmcs6G5rjXsujB4KhPe9g6Nl5KvK5xhsD4QUsI9lsOiy
 zYixI8JojvOMbnU6ZcfhVgcBiZvauYjMzfyLITRToaB9irVzKFQ2DvbGIeNbvW1wu6pNlr5NO
 zgSNVv80FqsUEuxrpnt7LUqNy4V8GttB7L4B+INv+99phvMZjLDRbLPdexhvzQzFaHKLy+6m+
 2bUXyiytC6QGn63r5pTlZ91bn5OfkFK7IkFr2gUTO6Ss1oCXXhtLhK0RfdQT0JIobQW+u03/h
 cWs30ovINjgapTqtb9eXZgOpKObNQNbInbjg7+/rNdUZAWHMkr5Mpd8CD5hE3dXN2tQ1yfd5y
 dha9oi9jZYubO0bxJAhwJR54LNXKyZHTq0Np7rliUTzyTg8PB+WOxNuoNHZ6Y3bQhg74sF837
 Ajg9rkA3hYAWzvz9m8C9cqRlA1yaQBt/M8+PJExB22e1+hyAA4bh+DmfFXZpt7++ayiw0UiEe
 o59d6WikYVmBaNzLtpGzHsbJGZ/ayd9tlRP/Ct05oyraLWGzamXiqrNqA9hErTkaaZAgygDc+
 sMs4enQWZNsdZsOKqBUeeEi0a0rmIlGtlAGzPnhJUNwDQv2e3r+s7cH17BqyrxBo9w1WdvcQ3
 +thpualLAMtPsyn9y2Ce5e6RkzM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My recently merged nuvoton,wpcm450-fiu DT binding caused some
dt_binding_check issues in linux-next. This series attempts to fix them
before the breakage spreads any further.

Thanks to Rob Herring for running his dt_binding_check bot, and Conor
Dooley who notified me that the issue has reached linux-next.

v2:
- Some commit message improvements, as suggested by Krzysztof Kozlowski

Jonathan Neusch=C3=A4fer (2):
  spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus
    include)
  spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing
    reg property)

 .../devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

=2D-
2.35.1

