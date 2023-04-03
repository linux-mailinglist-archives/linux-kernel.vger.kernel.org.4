Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9526D4BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjDCPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjDCPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:23:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5738170F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:23:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j24so29801822wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680535387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTzkLYbvfd2IjRZTFEqIenxLEq+ZjYmO48DPd7DLZEY=;
        b=G/Pda6VDK6CxGQSeSiPCjP+S24TJAX3Dk5+qGro8GNMocnUHuA1ITVKwywe21C5HZ7
         BESY7KJmZeWGxvOiIkcexgYYe30hSBzTlwgAN8o1/RAw0tLS5N7FLOirAFLszZcqLGl1
         CwuiLVeC+RO+KLy33iEYBdVr+oDSxoxm0vh+f219Xp1IcVHRFeC3XocRX5h/gDSYIjtI
         b2EF8E1pP7XBplWfwKAwhI+4YALVOxcVL4siHkV/ujRLQwvYLbawMIDMnrXM0MRDjWJh
         rrvkgHAWGLTfKWyV/ZR9fPL9645FfkiJlty1QZ3DTHj9KOj7DWAUvHXE6sJ5LwLxFT8Z
         BPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTzkLYbvfd2IjRZTFEqIenxLEq+ZjYmO48DPd7DLZEY=;
        b=Hv7C7PUGpx1d/IBomY8W1JVSUro3lqRMoWr70QmhppNm0VSkaUHbW62ugy5mZfJVoB
         meON27HsmZz9NDUj65OwK39oxI7O8x4sqRihxZ+2DyErK97ogLP5A6JaRJzqH6V5QKN6
         eLa3vdkNvrgSD1vo+ncY1AOWfqs9za8EDF+Lli0fJztV5VF5CWk1OU7CRMZqcyJJXGEn
         GlDSdC45F0ji64URX3VkGUUmLnLx1icmP4xywKbMK2K8GyIvKPWjJ1qHiSv1mXOafJ/L
         Q0M1IDOBbUyJdKSBzaNNq/9QQTgWe4GLbRrNc8QS8Cpdz6z48J//QlUou69TX2TZWs4H
         vJIw==
X-Gm-Message-State: AAQBX9czNTn6XNch3SMR8inw/Z89WBSeXdrUaxy02t2FnPXADi4mdF1N
        BlFRPvMED+vEQpjZvXryIy9amRY5Z/iC3+kD
X-Google-Smtp-Source: AKy350bqYjtBj10U3WWxA1pDD+RJFNIqqC8vJ90OuKimssYnRw8/Viy514sQo53q4o6IlyeMdTEtfQ==
X-Received: by 2002:adf:fccc:0:b0:2cf:e868:f789 with SMTP id f12-20020adffccc000000b002cfe868f789mr26500082wrs.48.1680535387234;
        Mon, 03 Apr 2023 08:23:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d6386000000b002e558f1c45fsm9870405wru.69.2023.04.03.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:23:06 -0700 (PDT)
Date:   Mon, 3 Apr 2023 18:23:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <02031cc0-c035-4171-89d2-6e53a5c3d6d8@kili.mountain>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
 <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
 <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
 <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 07:29:36AM +0300, Dan Carpenter wrote:
> > > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > > background?  Can this check be removed?

It turned out the answer was yes, it can be removed.

> Also if stuff is changing in the background and there is no way the
> locking is correct.

The locking is correct.  Take a look at it.

We are holding the &arche_pdata->wake_lock in arche_platform_wd_irq()
and every place that calls arche_platform_set_wake_detect_state() takes
that lock first.  So it can't change in the background.

Delete the check like so.

regards,
dan carpenter

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..4cca45ee70b3 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -172,18 +172,11 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 				arche_platform_set_wake_detect_state(arche_pdata,
 								     WD_STATE_IDLE);
 			} else {
-				/*
-				 * Check we are not in middle of irq thread
-				 * already
-				 */
-				if (arche_pdata->wake_detect_state !=
-						WD_STATE_COLDBOOT_START) {
-					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
-					return IRQ_WAKE_THREAD;
-				}
+				arche_platform_set_wake_detect_state(arche_pdata,
+								     WD_STATE_COLDBOOT_TRIG);
+				spin_unlock_irqrestore(&arche_pdata->wake_lock,
+						       flags);
+				return IRQ_WAKE_THREAD;
 			}
 		}
 	} else {
