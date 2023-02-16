Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D3698F01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBPItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBPItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:49:18 -0500
Received: from smtp-out-04.comm2000.it (smtp-out-04.comm2000.it [212.97.32.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D953A09D;
        Thu, 16 Feb 2023 00:49:15 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-04.comm2000.it (Postfix) with ESMTPSA id 8A003BC4540;
        Thu, 16 Feb 2023 09:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1676537352;
        bh=PQPNu0ICzycgofYS3iFsEuSYoBFLhXMOuIcmqqj/OMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=uhwoyh+YGaX6DC67jyFpp58iJ1cRHzwBZVupnXs1lsRbqdKYyyvl+/kN8Al8CiTc3
         j8XXLHLiDo1X7RsxHoI3lFqA7F8vtgFzxBqiL5egbWmSiwGUeHKFB/AUhdzzp/Awf1
         1D1VPn4Z8ANGSTuJvL6lNlX2WkU9Iwo05B7mMbVKBi4PVKfPTkJFR5x5oJIy3wYM2F
         uaXEymqSdR9IgKp5Uo14AEy9kAuosB125Lhaz/D7UsyX0crcjKT68Re7ykmQv8cmKV
         Zep6Z2z6qEutim3uGCnWkM/cKOKmNsirorzncsvn2IuqOFZDLnOvAvYNK0cOSYLUtW
         0mdlhK4MK7P3w==
Date:   Thu, 16 Feb 2023 09:49:07 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v3 5/5] arm64: dts: imx8mp-verdin: add 88W8997 serdev to
 uart4
Message-ID: <Y+3uA7ygMRMd8hbK@francesco-nb.int.toradex.com>
References: <20230213120926.8166-1-francesco@dolcini.it>
 <20230213120926.8166-6-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213120926.8166-6-francesco@dolcini.it>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

On Mon, Feb 13, 2023 at 01:09:26PM +0100, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Use the serdev feature to load the driver for the 88W8997 bluetooth
> driver.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Patches 1-4 are now in linux-next, just pick this when it is
appropriate for you (I know you already sent a pull request to Arnd a
couple of weeks ago).

Thanks,
Francesco

