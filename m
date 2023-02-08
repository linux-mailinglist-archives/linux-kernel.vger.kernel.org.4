Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F768E959
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBHHwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:52:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92941F4AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:52:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g13so13580101ple.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zhDJApKtBQcvwymZ5SCtHomIXxqcYYVtYxL3jD0nv8A=;
        b=eqGrOQjEwqnci7sSQ7FMs3Ok0ATLFezDT3iEUXY6o7kh6Z2Ah3wdtWQk9ljBd2sXfX
         7ay1T3MqcGgE8eiymGU4SGIrPRS2Elb5ALGjaZXq8n3K70j3/4yVN6LLZNfTK0c339Yh
         RbNoAlQVxOKVyUcIsXM34bjv7F4KJa2E7uzGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhDJApKtBQcvwymZ5SCtHomIXxqcYYVtYxL3jD0nv8A=;
        b=aOFpX9RWUruVv414Yy/F2C6O7b6J8S86KAui4YKgQ2lKR5sv+kfQ4q25bTNx0zJYAH
         6w5v9cimrgtVcMr3hEIg1PWhTmnHfsQKGKqeFmgm7c0xRJHLTkztmzBWlTKOdUmorDqL
         eh2Nbhg1DgcS8EoHYCmFXgHiDxZUiIKd8ygENmkPNX1luta+DBv3/fworbZ4xsJoOMX1
         PBbbpiHjLmdEowuVah0lz3jVFWp4WhvqN8L28PNDhDrMow8w9gUmJwytKLLD7ECjyZyD
         6Yqkj6Td1Ln18kd2JbiWbP6F2LGWsGMY8PGZFpyg6qN7H+HgmdhtNrlpp1GIuWcPph9+
         q58g==
X-Gm-Message-State: AO0yUKV/09bdMA2zgwHhWrr+Z9TSdu9M34Ts9UCYc0zFGYg0NogoCGJa
        E0sJ2jb6XbVUqAwq0myTjCa7dONJH5S0ii0ijOX8XQ==
X-Google-Smtp-Source: AK7set85cPdzxaY0rLNikp+E53fZOD5mAQhhWbvkPlDWSAtyKYtHs7ThVA1FO3XcwaBZAO9Qs/JSARXhC6J9eEVZWXE=
X-Received: by 2002:a17:90a:7483:b0:231:eb7:ece4 with SMTP id
 p3-20020a17090a748300b002310eb7ece4mr448656pjk.26.1675842765263; Tue, 07 Feb
 2023 23:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20230207091443.143995-1-colin.i.king@gmail.com> <Y+NQLOJ9IlbQJttd@google.com>
In-Reply-To: <Y+NQLOJ9IlbQJttd@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 7 Feb 2023 23:52:33 -0800
Message-ID: <CACeCKacOiJHMGTaT3J-B1_rYbU=yJQ2Xr7nFjX_1aMcya1xT_Q@mail.gmail.com>
Subject: Re: [PATCH][next] platform/chrome: Fix spelling mistake "Attenetion"
 -> "attention"
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 11:33 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Hi Prashant,
>
> On Tue, Feb 07, 2023 at 09:14:43AM +0000, Colin Ian King wrote:
> > There is a spelling mistake in a dev_warn message, make it lower case
> > and fix the spelling.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> It's about time to cut for the coming merge window.

I thought there would be an rc8...

> I guess you would
> like this simple patch to be included as a fixup for f54c013e7eef
> ("platform/chrome: cros_typec_vdm: Add Attention support").  Please apply
> the patch if it makes sense.

Sure. I'll make the modification you suggest and apply this tomorrow.
Thanks for signal boosting it.

>
> One minor suggestion for the commit title:
> "platform/chrome: cros_ec_typec: Fix spelling mistake" looks more clear
> to me.
>
> With that:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
