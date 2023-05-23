Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C281570E7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjEWVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbjEWVuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:50:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667BFE49;
        Tue, 23 May 2023 14:49:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so11158b3a.3;
        Tue, 23 May 2023 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684878566; x=1687470566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QuyMrYX/v4kGUEcU1dQFkTC9RvlOlPJYB46X1ZcevA=;
        b=eGPMcDGfpdxUEcD/xs1YeWyP5mBSlFduLUdhSjS/pFmi0jeQzbZeS1yDcu48NcsXa4
         G9C7sywrKkY0Stz2RD48b0EMMGwaygdI36zu3+YiMtGKCpintLcVfoKCAHj4381LWYiA
         J3CB4PrLIn25kEa0vpKIjdK0LydkNiMyD7VE7ByE0w/FswJbDtvK12VYSJtDh2/zESrf
         8wdJ6A4HNw46bzo73ApnGlf17bKugA3hPRhj3oWL/wCnx+3WAiQKpK+6MvwN3DGf31ut
         pTimNrpwIA7UwsdsyO2zWEvmXVHLGr+uCGyh+jQF4NEUf4/jdt22awDORwJXlQuU7eA/
         DhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878566; x=1687470566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QuyMrYX/v4kGUEcU1dQFkTC9RvlOlPJYB46X1ZcevA=;
        b=aFrse5ViZteerZ3cjglEbVmou72Cr0676Ki3ewvFsAiqTdrjhsXcv5+M8RyqzhUoCg
         JrVCjxC1XV0OilOrq0q7EL/7F8qm6XYr8adJtbHoRIKy0u47CmJtdsP4yIZOtfOtqCeg
         Ivcr1T6MKScuPlthgh5u9fJdb6PzRKmGMi59WRZ21+PlxXnDM8N2RMpPeNsd5zZcVS4O
         EuCjSx/LBfqQTYKOFccJk72eEoy45DvlXMEDckCB/376bC7KMhoYhv/aAROIGLmYNSr5
         dXJGICE6Npil4v5WTDAebzROCVbLo5Gx0GGV0CLXNstMPyd5rPSEw1oDdJMquDtUum0R
         UFrg==
X-Gm-Message-State: AC+VfDyroYILdNstYcPnbnu4STbVValjfMoyt8aRIMnK6m5PmGA5sMpv
        PxmWSpo/vyT1IUH53q1ag7o=
X-Google-Smtp-Source: ACHHUZ7Ozssw445PC8iwedslvsvPghexHc5rQ108rKJnFmm1K7/BFPo4pUyK7cG3HCT621zIgREOug==
X-Received: by 2002:a05:6a20:7f8c:b0:104:4c7d:25f8 with SMTP id d12-20020a056a207f8c00b001044c7d25f8mr17379983pzj.3.1684878565956;
        Tue, 23 May 2023 14:49:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a3f8f00b0024b79a69361sm26352pjc.32.2023.05.23.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:49:25 -0700 (PDT)
Date:   Tue, 23 May 2023 14:49:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v2] Input: xpad: Delete a Razer DeathAdder mouse VID/PID
 entry from the gamepad list
Message-ID: <ZG004m62A06vXm74@google.com>
References: <5c12dbdb-5774-fc68-5c58-ca596383663e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c12dbdb-5774-fc68-5c58-ca596383663e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:28:09AM +0100, Ismael Ferreras Morezuelas wrote:
> While doing my research to improve the xpad device names I noticed
> that the 1532:0037 VID/PID seems to be used by the DeathAdder 2013,
> so that Razer Sabertooth instance looked wrong and very suspect to
> me. I didn't see any mention in the official drivers, either.
> 
> After doing more research, it turns out that the xpad list
> is used by many other projects (like Steam) as-is [1], this
> issue was reported [2] and Valve/Sam Lantinga fixed it [3]:
> 
> [1]: https://github.com/libsdl-org/SDL/blob/dcc5eef0e2395854b254ea2873a4899edab347c6/src/joystick/controller_type.h#L251
> [2]: https://steamcommunity.com/app/353380/discussions/0/1743392486228754770/
> [3]: https://hg.libsdl.org/SDL/rev/29809f6f0271
> 
> (With multiple Internet users reporting similar issues, not linked here)
> 
> After not being able to find the correct VID/PID combination anywhere
> on the Internet and not receiving any reply from Razer support I did
> some additional detective work, it seems like it presents itself as
> "Razer Sabertooth Gaming Controller (XBOX360)", code 1689:FE00.
> 
> Leaving us with this:
>  * Razer Sabertooth (1689:fe00)
>  * Razer Sabertooth Elite (24c6:5d04)
>  * Razer DeathAdder 2013 (1532:0037) [note: not a gamepad]
> 
> So, to sum things up; remove this conflicting/duplicate entry:
> 
> { 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
> 
> As the real/correct one is already present there, even if
> the Internet as a whole insists on presenting it as the
> Razer Sabertooth Elite, which (by all accounts) is not:
> 
> { 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
> 
> Actual change in SDL2 referencing this kernel issue:
> https://github.com/libsdl-org/SDL/commit/e5e54169754ca5d3e86339d968b20126d9da0a15
> 
> For more information of the device, take a look here:
> https://github.com/xboxdrv/xboxdrv/pull/59
> 
> You can see a lsusb dump here: https://github.com/xboxdrv/xboxdrv/files/76581/Qa6dBcrv.txt
> 
> Cc: stable@vger.kernel.org
> Cc: Cameron Gutman <aicommander@gmail.com>
> Fixes: f554f619b70 ("Input: xpad - sync device IDs with xboxdrv")
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Reviewed-by: Cameron Gutman <aicommander@gmail.com>

Applied, thank you.

-- 
Dmitry
