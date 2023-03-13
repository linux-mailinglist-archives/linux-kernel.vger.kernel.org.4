Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103186B7A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCMOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCMONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:13:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874BCC1D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:13:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p26so8098519wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678716783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXaW8X+ac0AfXs+wrChmgieQwlcGySHkeR7jml2OA0M=;
        b=f0BFPyRjQxXQtbi4EGq+BuwolnN9PQOD2FCLFshZTCltqYO+wJ+DINIgKDAhH+ob8i
         gu472eu6RjbYAIyRQUKf4RUlxXguonfJtU9ZwEn6nzJg935V4cAf8yQbBgCvTWraAwCc
         WIj8enYbQGG4fEeoJFs0NW4XMgvUMPAPIDz5+KjdspyFvLlXdJg+Wb51vK0CWyZFtiVj
         GBRvkA2WLhI4qxAO20hELh+UBP0GHV+MVp5iu7yv49X9U1IBsj5SRkQhyx4b6Rv8+AgO
         38taThJcBDx4L8xOTSxrLJTKTLSSlM6TgbdMGT8aTi7FpGoNYBVgm6hUAG646wCU77nj
         AMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXaW8X+ac0AfXs+wrChmgieQwlcGySHkeR7jml2OA0M=;
        b=MEcld7IjJOJXGgFngYZSFNXNQYxwZJDuyJDmDGMuKIT+MzkZns+7Ya83BtwXKIQuBA
         jNrkXNXvXz7TMDgU74SrxjckCH94B8psPqgEO+ULB7opTpVUl9IJE/WP8tjods8Bvx1/
         60aJY0WPHhgEN136K4V5M63zehgS/2pLDcHq6OeJRjZnOXSMWLwH67Yfw3/QsJiAl80N
         tE+Lfs297uykf35BXwpkarKyT1XE2Zt4JXfRjdofXM8cMAHJrBfjnBAkrxWLw3k6xD/T
         7JPDMGISBu4N11PgNFQrVwbaol6653z0dkrpKsWfCLwYzOE4r5IV5zYXmYWJ5btO9tyF
         YTtg==
X-Gm-Message-State: AO0yUKUb20SMQFqffj8lNy/fY5LIzvJH2ueQakgSmvgES5rk9GikGYJG
        tKz5weyeB4F51rxqjZew3+rr7WjhZxfvOw==
X-Google-Smtp-Source: AK7set+rp1NYJgQoTgFazlVqG+Xn5xixjgbICPOdFskd+rd+k0vmsC/M4z4PDnyPp1WLYAYfwMzNyg==
X-Received: by 2002:a05:600c:1c8d:b0:3df:d8c5:ec18 with SMTP id k13-20020a05600c1c8d00b003dfd8c5ec18mr11093367wms.13.1678716783032;
        Mon, 13 Mar 2023 07:13:03 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b003e8dc7a03basm9643310wmo.41.2023.03.13.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:13:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy@lists.linux.dev,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and write_timeout
 once in probe function
Date:   Mon, 13 Mar 2023 15:13:01 +0100
Message-ID: <9938109.ZD9C4EEAuf@suse>
In-Reply-To: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 12 marzo 2023 18:33:19 CET Khadija Kamran wrote:
> Module parameter, read_timeout, can only be set at loading time. As it
> can only be modified once, initialize read_timeout once in the probe
> function.
> As a result, only use read_timeout as the last argument in
> wait_event_interruptible_timeout() call.
> 
> Same goes for write_timeout.
> 

Nice idea... But it's not yours :-)

Therefore, you should give credit to Greg with the following tag:

Suggested-by: Greg Kroah-Hartman <...> 

Place the above-mentioned tag a line before the "Signed-off-by:" (which is 
always the last line, whatever other tags you might need to add).

> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---

If this patch was a v4 you should have put a log right here, after the three 
dashes, explaining what changed from one release to another, release after 
release. Please read some other well formatted and accepted patches for real 
world examples of how to write version logs.

However, this patch is _not_ a v4 (so no version log is needed after the three 
dashes). This is your _first_ patch that addresses Greg's suggested 
refactoring. Therefore, just put [PATCH] in the subject line.

That inappropriate "v4" seems to explain the second error showed by the patch-
bot. Thus, read carefully its message and ask for further explanations if 
something is still unclear.

Thanks,

Fabio

P.S.: The code looks good but I could not apply it in mainline tree. I don't 
know whether this patch is somehow broken or the driver's files differ between 
the most recent staging tree and mainline.

However, does it work for you on the most recent staging tree? Did you run 
checkpatch on your own patch? (I'm also asking this question because of the 
first error showed by the patch-bot). Can you git-reset to a previous state 
and reapply your own patches to your local work branch?

>  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)



