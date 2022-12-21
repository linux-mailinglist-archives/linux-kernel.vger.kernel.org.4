Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C096530A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLUMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLUMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:16:51 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7323143
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:16:50 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v70so13148658oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7gUlc1sHcGQgKs5k8gVhHit/S+tlYXh/+hMIkbtr3w=;
        b=OxAO/i4IhQEGtjoA2p+uVjYvtJMMCXgrseUkDD1BxuSAzH1pMejYdtEZF56n7SWbTB
         +kNKGO+B0QVQ15FbwB55YDaF1sZmRa1YuyaC7RIgcYNGeGAN6ZA0JV3ze0+L1yEDJS88
         FrsemVpbMRkg/k0z93KhkYnkUR52q6yoSCgbeWlOKoQv8gIWQNfj4zZ3lXv4cWODLvhI
         cqdLz4n+uiNs4DWYxKL2MEj8K7cj0RyYN81iLotgVKxrA7IphX8hzOLlCshoESzzmXGL
         Tjboc5WXLwxW+4g49Kh/YTSD+VTkuM26VPq7JM30fHrrZbKRZxA3eRie56rCEsyvneD+
         5emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7gUlc1sHcGQgKs5k8gVhHit/S+tlYXh/+hMIkbtr3w=;
        b=lFvhxW9Z1YtH4Kr8sael1FAJypsiQHzoYNRM1ffDXWuNY9rKDP3eqFXV+neOMEGAxN
         KTB4FOe7bsbNEii3uIWHEcmhl3IEuWVN5+wabOwzb5nGyQoYrs7VTGA1xpLEPLHPhZOV
         wO9mVh0ywbXrWVTVDcofPr2fN72/wlj0G2omxGcaYMcaF2I6nQ6ZLZrNs3vsURuapAnL
         3NBHiODeebRXyzIEDrRexZZXxkAeB8i+r6xwVsJL32EKek5IZpQLiWL7uCG5FwU5sGo+
         +FKWQafit179eOO3KUSrRAz+TSn2Q5lI0KnLuY9r2f3/qoIwstsI/S5Fi8gWw77Z63po
         sVVw==
X-Gm-Message-State: AFqh2kov9aheS08tdEF+uGfjdeDUF9we9fBL01JuVrihIep/XFce7Xsp
        8Wx7KfIgUM0cP1vAhIdb2BA=
X-Google-Smtp-Source: AMrXdXu9b5VImz2WDrwJTxTlZikQ2QoNfQAsFGFICYDcFs+A0fgHtYnVoeTaZ34nferXeu+DJNNn6A==
X-Received: by 2002:a05:6808:154:b0:360:fc0e:f61c with SMTP id h20-20020a056808015400b00360fc0ef61cmr630996oie.1.1671625009936;
        Wed, 21 Dec 2022 04:16:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020a05680804d300b0035ba52d0efasm4679802oie.52.2022.12.21.04.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:16:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 04:16:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Walle <michael@walle.cc>
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based
 on SFDP
Message-ID: <20221221121647.GA1353152@roeck-us.net>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
 <20221221003009.GA280250@roeck-us.net>
 <9cf53ca3bfb39c85da968f9b46dbe6d7@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf53ca3bfb39c85da968f9b46dbe6d7@walle.cc>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Dec 21, 2022 at 09:22:04AM +0100, Michael Walle wrote:
> Hi,
> 
> Am 2022-12-21 01:30, schrieb Guenter Roeck:
> > With this patch in place, qemu emulations with is25wp256 fail to
> > instantiate the flash. Specifically, this affects the qemu sifive_u
> > emulation. The resulting error message is:
> > 
> > spi-nor spi0.0: BFPT parsing failed. Please consider using
> > SPI_NOR_SKIP_SFDP when declaring the flash
> > spi-nor: probe of spi0.0 failed with error -22
> 
> qemu is to blame here. It doesn't fully emulate the flash. Esp. not
> the SFDP tables. See also [1]. Adding the .sfdp_read hook with the
> corresponding binary [2] should fix your issue.
> 
> [1]
> https://lore.kernel.org/qemu-devel/7827c791b7f91f4eb216b33473dd6103@walle.cc/
> [2] https://lore.kernel.org/linux-mtd/CAHyZL-ch=mr0x_19e6P9G+Z4sW2iJXW9nTnXUNAhn+pTptN2ww@mail.gmail.com/
> 

Great, that helped. I'll prepare and send a qemu patch.

Thanks,
Guenter
