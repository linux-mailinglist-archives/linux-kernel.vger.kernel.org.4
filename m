Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6167674D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAUQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:01:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF2D3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:01:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ss4so20855139ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKVMc4XtRN4OAzpt+73YglKGdPsJWpOm2v8zLKBJfjs=;
        b=WJk+anVCx1Y/Sg1JSEPsA6EP5qY4OfjrZbKya/DMoyT9eatlLH9QGCsVLXsQcC0xPW
         M9iCRSFkCRdxaSzgCMWunIy6ALE2XtF8lP6ygNPwB1CdyC3qzSLNkC8cKN3OzSVsQGI5
         3YmLzSGy/S2DzrKYoMVhWUcwz7pYDb5vHIMJ5BrZa65jAtSLOecqR+2Rsa65Rrl/hbbH
         XUGcCvDFb5rkCtKB2XgvX557S8eiQIm80vthScgtkJpWsMxe56rlrA/Q1HQKcTWZpH6h
         jlDG1+1VYj185R3s2TJqxQIWNNOQdFitm/zT2jrK7VRWdOSJVHdwXEVTCvX15WWr7clr
         arsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKVMc4XtRN4OAzpt+73YglKGdPsJWpOm2v8zLKBJfjs=;
        b=gSPzsrFiKFC8XtRUyRPMg+5lJWoGcl8TFdt4ngeGUOdsREBXL6I0UQFd21NornvTZr
         k/Ft2KeLoz+1et7Xr3hV+vjSixUrih7Xqbo+LgRidgYeWX3T9KnN0MXmSHk2PuvCe2xU
         nVWLHnh/xZVzOrXIEZTIjyGjeVnce1Kk8h/Dv1WWf472HJRbuviN07G5vX8dJn3HhQTk
         RgHYAzE+YHaKM2NhrUqOMlZ6N5Y25FhS6JMgEsc8W/1P7ZTvF3/XL0NJejAxwhtWI6k9
         CGqB9FRsr1LJmphyWNT2wMi8ETKlMnm1YXC9zzqg9+XS5Ancrpg13o/XQZOxof/EjvTx
         0WZQ==
X-Gm-Message-State: AFqh2koupF+623wnz1tMpIWenlw1OfOb9b7uiteSyrTosZqFXcjc9hKj
        7v3ZTH4YOgSRpdAggIFdC5U/c8qsKZ81kNkDnAc//z/k
X-Google-Smtp-Source: AMrXdXuVIr9xRAkzYr1hQHrZmlm0grwR+l8tkvtvwunVRTMZ3YGsxVjIHqb5vS4pbm5leQ+RqxwrJC7p934GAvRsHWk=
X-Received: by 2002:a17:906:e107:b0:852:132b:2d7e with SMTP id
 gj7-20020a170906e10700b00852132b2d7emr1986545ejb.224.1674316912347; Sat, 21
 Jan 2023 08:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
In-Reply-To: <20230111134513.2495510-1-conor.dooley@microchip.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 21 Jan 2023 10:01:41 -0600
Message-ID: <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 7:45 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> In order to differentiate between the service succeeding & the system
> controller being inoperative or otherwise unable to function, I had to
> switch the controller to poll a busy bit in the system controller's
> registers to see if it has completed a service.
> This makes sense anyway, as the interrupt corresponds to "data ready"
> rather than "tx done", so I have changed the mailbox controller driver
> to do that & left the interrupt solely for signalling data ready.
> It just so happened that all of the services that I had worked with and
> tested up to this point were "infallible" & did not set a status, so the
> particular code paths were never tested.
>
> Jassi, the mailbox and soc patches depend on each other, as the change
> in what the interrupt is used for requires changing the client driver's
> behaviour too, as mbox_send_message() will now return when the system
> controller is no longer busy rather than when the data is ready.
> I'm happy to send the lot via the soc tree with your Ack and/or reivew,
> if that also works you?
>
Ok, let me review them and get back to you.

> Secondly, I have a question about what to do if a service does fail, but
> not due to a timeout - eg the above example where the "new" image for
> the FPGA is actually older than the one that currently exists.
> Ideally, if a service fails due to something other than the transaction
> timing out, I would go and read the status registers to see what the
> cause of failure was.
> I could not find a function in the mailbox framework that allows the
> client to request that sort of information from the client. Trying to
> do something with the auxiliary bus, or exporting some function to a
> device specific header seemed like a circumvention of the mailbox
> framework.
> Do you think it would be a good idea to implement something like
> mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> clients to request this type of information?
>
.last_tx_done() is supposed to make sure everything is ok.
If the expected status bit is "sometimes not set", that means that bit
is not the complete status. You have to check multiple registers to
detect if and what caused the failure.

Cheers.
