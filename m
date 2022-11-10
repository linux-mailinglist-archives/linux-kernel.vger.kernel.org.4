Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002B62473B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKJQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiKJQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:41:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625243865
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:41:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v17so3919144edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXjmgmTZbivYNCVWB/JUFc7h/+Q7RCIq92KdMMjOLfI=;
        b=tadhODvAQBstTXxKr5UPmLw+VB7fNxM2svKr46LIB2KDzmBT5FyakWQoUP4PpuJ0HG
         WnUU8TuxJnzHwD2FEUyixga1iE47JHIwFlLMic3SOl1rqHyxt9xhhS7IKfBDaoNxoHY/
         Guo3wEjVfuhpr+bNUS9wwCkoQsGoI6w0vAO82n1E/VEgZqjRBxOZ8Jf0QWOhg44gyt4r
         aG4H/8Be20qkWgEJ3q1IyuP1neyhXBnDpu+wIRpPwP5xaWzmaFz8/D0o54DGA/ML3fj2
         BFSTiBstcr1FdQoI17Aj/Vps/AyBqS9+Wcp8nST4woTodIesMS0P1ECvmiEBbxM9Gd/y
         vIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXjmgmTZbivYNCVWB/JUFc7h/+Q7RCIq92KdMMjOLfI=;
        b=gXfCbcGgrnH9nV4QJOkHwk2fGo2ycIZxyxXyLiqiMD90XfiNj9GeellWgODOeLtgHr
         /LZqsq2HVEmBrz+UOPiB7Qg+h4GVD52DVm9FDd17Jz7ISwMu7WoXAX4IgGXKzqGBbcNd
         tuvYL8pMXvCO0KJXoWNbVUyIkjaN4FkUL5O7Tbp2k+cMZK7TLAnMTkDFgDaXZQP9Uu0H
         V+pSSuj4JU6jM0QV3dgFlQcVUQCH2PW+6WP1izUTEdcCO0xk8OzzKRLEFxxV3lKT3bim
         EhH968qCIzarCmC6C6aglocTOoVyWDAWvYqK9NJs+0shDzSWgKKRsqDcFLTGcmXm++AE
         V7qg==
X-Gm-Message-State: ACrzQf0iHww2tvFKr1bKXqbjod9rIW5RtYdgIjIyUtzwNyi0u+q21eIi
        5jKxUtDq6A76fEROAEAQfkGMhN7nV7gGDc0QOtQy2umrK/4ndQ==
X-Google-Smtp-Source: AMsMyM5xmiXxEeOzmNuy/Kq98htw3UnaNPQB44q/IPt7Hgv62yRSWf//kYvb/fxfl2oNtNsLD6xYTxGlImkj0jpfphQ=
X-Received: by 2002:a05:6402:c07:b0:461:87ab:78aa with SMTP id
 co7-20020a0564020c0700b0046187ab78aamr64197695edb.258.1668098505181; Thu, 10
 Nov 2022 08:41:45 -0800 (PST)
MIME-Version: 1.0
References: <202211100830.1F097DC@keescook>
In-Reply-To: <202211100830.1F097DC@keescook>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 10 Nov 2022 16:41:28 +0000
Message-ID: <CAPY8ntCkjG0BafMy+iLna2BDvr0n10E8hzUqL01WpUgFCjwV4g@mail.gmail.com>
Subject: Re: Coverity: imx290_ctrl_init(): Error handling issues
To:     coverity-bot <keescook@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 at 16:31, coverity-bot <keescook@chromium.org> wrote:
>
> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221110 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Thu Oct 27 14:38:02 2022 +0300
>     4c9c93cf8657 ("media: i2c: imx290: Create controls for fwnode properties")
>
> Coverity reported the following:
>
> *** CID 1527251:  Error handling issues  (CHECKED_RETURN)
> drivers/media/i2c/imx290.c:1056 in imx290_ctrl_init()
> 1050            imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> 1051                                               V4L2_CID_VBLANK, blank, blank, 1,
> 1052                                               blank);
> 1053            if (imx290->vblank)
> 1054                    imx290->vblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> 1055
> vvv     CID 1527251:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "v4l2_ctrl_new_fwnode_properties" without checking return value (as is done elsewhere 9 out of 10 times).
> 1056            v4l2_ctrl_new_fwnode_properties(&imx290->ctrls, &imx290_ctrl_ops,
> 1057                                            &props);
> 1058
> 1059            imx290->sd.ctrl_handler = &imx290->ctrls;
> 1060
> 1061            if (imx290->ctrls.error) {
>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

I looked at this one when the patches were sent to the list.

On failure, v4l2_ctrl_new_fwnode_properties will have set the error
flag in struct v4l2_ctrl_handler. This is also what it returns.

In most of the existing drivers the error flag has already been
checked before calling v4l2_ctrl_new_fwnode_properties, therefore the
return value has to be checked explicitly. In this case it is checked
at line 1061 which is after v4l2_ctrl_new_fwnode_properties has been
called, and therefore there is no need to check the return value of
the call.

IMHO Neither is particularly right or wrong, just slightly different
approaches. In some regards this new code pattern is nicer as it
removes a number of error handling paths.

  Dave

> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527251 ("Error handling issues")
> Fixes: 4c9c93cf8657 ("media: i2c: imx290: Create controls for fwnode properties")
>
> Thanks for your attention!
>
> --
> Coverity-bot
