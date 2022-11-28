Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810663B47B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiK1Vtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiK1Vtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:49:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF22F392;
        Mon, 28 Nov 2022 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669672170; bh=KZocglb62rgjODaBbkno94BEG+p/TUD9NyE6UtXNSMI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Un8L87AXYW6DcHMDEk2pFW6/XvseeM2hQ0I89dl8O3lniA7Kij4+WwHIFn79ENjtN
         LX3xZENKl6MrzzqYjyXRqhgo/gWQFdXHaYZFQJ73ii+qyV3XX1gqXuVTHoNf5ivTxs
         3B6jgK8KzQHVuB66icHTpYKfciDYWs2A5o4bL38ip08H0f1v0/skQQZVHdWPpV4PHX
         YoJzqfWYQ4cgFqda1Cn56h4moi/G//+zgI3+22WRTVqas08KLgvMVt6bhSdOgK/0Ld
         bJqINfu1eLSpV3AwpPvTqGvSmB32dUcEqACtcojL4YOWq8YzQEbGBbLlWt4KTKNwMG
         Tx1KMsecelSlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1oyIyW3NmM-016sti; Mon, 28
 Nov 2022 22:49:30 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] nuvoton,wpcm450-fiu binding example fixes
Date:   Mon, 28 Nov 2022 22:49:26 +0100
Message-Id: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hjvlACbizoHf3myeGqWxikJT7tGRQF2OIb7M6rNnhtAv/VyctUi
 YwXCbpI4aHFBeZlOY8tCPtq3ka7sshh/l+ZaqdM00woYskeJl8yAGjNUOznGrDiPu5oM9zv
 HHWgqKrHlHn7fzrm0cmBD2TS6vb3PrC3928zA9cKOujKetWqzkZ2CmFtlWHB4VTOsbbwK7x
 7kNruwJMXmSBn9B1DBqJA==
UI-OutboundReport: notjunk:1;M01:P0:UYcNhDvDYjc=;Zc0nqRk/l5vx1T3vmnRIYwZIYfW
 YtPmYmU2oSlqn+ffQogolisOCMagJb3rZZ3EG/BDrWC8yzVl8+AzAasIXXyBzU8X6yTGReh9i
 Pm53+r21du2nxjvISfAzzGbJEsEpKrF3QEA12f7gbyHf/Oh4FT4hNro/hXNZ385q95Inxttsz
 bige4juB3LXWQzcfjRwHZWaoIfrOqtjz6loo3UboqelnoUywnDi9oHxtX90WwHLORf0rFN4I1
 /kvC3uJbRxvKFCWkPlSn+64J9TnMnApXIiM0hXnH0cbUa8eQb2AKeTIW3mjAqnFQsayo5FMsH
 zgY3+yZxyb5yqJl8yVvwmcwATPbMU3YC5XJOo9HILtHQ3hhXPdnKfRl44RqEYcd6ZtW0GFx6z
 cImNzPF3hBdbvReXOYiaqgllzZr0xBm8O8p6EW/GOEOAPweLbiVHArlwrc++IZATDOgM+onO5
 zzQdXXts6yIP+eAAIptzhiQvHfXFN/1q2JD68lAuI9EVnou21wvtJOhXa0BEHdcDyk3o1lDHT
 1F2UimzVztBV/JHybS3dvwtwgRCqDeo17HOjygTXilVxhTB9MLwz1RJ8JjBBo3fQLF/HI+Bxl
 zzjeCpLXUmH1CYP/37bQz+IAf9YQnWOyPirAnB5YKinovyZVB2qCsXDx4fRxHSPib1Bx9gn5n
 +Cn2zIwRzPrPjqUX/V2ycwOLTxw9Ft46txwO+YZW1z9NwQhlD+O1Lj+FZNmPaVahnmkT8HTx3
 j4EL5VqvhNjH8t6+day/LUWsc4mczEYVJmzNciyxoIYe8fx2voNWgGhg0ZAtaqTt1pH8eW1Sa
 tMFNEw2WY4AQwsKjS6qKf+jiW2oGnPPubJnSR82ywKVPw2P/42wQZ3Nl6SSb6voTsRHrWkRiK
 sZ+lVKI/QBx52t7WDCWmNCAWmKxN6PRz+PrPyVVVaMOoG/e1IowIuiaLAlJfLr95FAI5fJEPr
 /J8G0TRKY0yeZbTYowWxiS8YBY8=
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

Thanks to Conor Dooley, who notified me.

Jonathan Neusch=C3=A4fer (2):
  spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus
    include)
  spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing
    reg property)

 .../devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

=2D-
2.35.1

