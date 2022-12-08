Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE14646B81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLHJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLHJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:08:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BFA5FC0;
        Thu,  8 Dec 2022 01:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9AE5B80D67;
        Thu,  8 Dec 2022 09:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E1C433D7;
        Thu,  8 Dec 2022 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670490477;
        bh=DA/5HF7V2NSQkN54uky2gasVxMmd2cNnNAGMRQXALrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUSFMFEVBQn9ITl5BeybwRbPT7vgOeOeyiP4TUgB907EOmVknn+3axNxVOIP6odNR
         mFA3dKr7PYIbfPVNdUDxTB+X8v5VoerBUD7jC3nSmD69KD/cVtRqnX3icWXhxrmvEg
         pg0wqFZqMejbkYKKMGP9aGm3iMIWHAPiBWQ/DcSpFulHQqIQF0Z0H9QrumOfm2IAyC
         tBSXHfJlbDn0URePQmOlQnMjO6Lf1UiubiV7mrt+pc0Kk1IlSBfIw2QjrKWq1P5unf
         fcC/+Wj98ip88HYq2xArfn4RyG7rCnVhPL9oKQ/PmTRptWR1do1H7/06ugDh8fxYj7
         +1iiLU26E5McA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] USB: sisusbvga: rename sisusb.c to sisusbvga.c
Date:   Thu,  8 Dec 2022 10:07:47 +0100
Message-Id: <20221208090749.28056-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208090749.28056-1-jirislaby@kernel.org>
References: <20221208090749.28056-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's the only source for the sisusbvga module, there is no need for a
2-steps build.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/usb/misc/sisusbvga/Makefile                  | 2 --
 drivers/usb/misc/sisusbvga/{sisusb.c => sisusbvga.c} | 0
 2 files changed, 2 deletions(-)
 rename drivers/usb/misc/sisusbvga/{sisusb.c => sisusbvga.c} (100%)

diff --git a/drivers/usb/misc/sisusbvga/Makefile b/drivers/usb/misc/sisusbvga/Makefile
index 93265de80eb9..28aa1e6ef823 100644
--- a/drivers/usb/misc/sisusbvga/Makefile
+++ b/drivers/usb/misc/sisusbvga/Makefile
@@ -4,5 +4,3 @@
 #
 
 obj-$(CONFIG_USB_SISUSBVGA) += sisusbvga.o
-
-sisusbvga-y := sisusb.o
diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusbvga.c
similarity index 100%
rename from drivers/usb/misc/sisusbvga/sisusb.c
rename to drivers/usb/misc/sisusbvga/sisusbvga.c
-- 
2.38.1

