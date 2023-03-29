Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BE6CDC99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjC2OeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjC2Odr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:33:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98F9ED6;
        Wed, 29 Mar 2023 07:28:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bm1so4767183qkb.13;
        Wed, 29 Mar 2023 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680100076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JQ1XJjsuL6lqx3M3lM712uJGJOEQmz6djad/U4y/oU=;
        b=TP6L/5HG8ebiZoSa2P+wCP6OGe6YnQoguc3nyBjnrvkJpSOMvtjFKki624FZ9tf5D0
         AazONSqjyvAr27iyjCqDKqs4PGvpphbD6fww3s7XzZcwPFqi7QRoQB5Zjh21VyPPFhlE
         N4W7wmzn82J6dGC6PX2FeD+/4Yyeuci+Eo9IqNsWWRAJrYfauxfPa03SJKWnvqAhkE+B
         q18hnjjmg77ozqDSF3CSREmOvYFfe7/P5npWhOGIYs2V7MQ3PnvjJn0T9knXZtOQ83Ix
         lLnqUrKPI2ozCmsFF/+LFJ+wvODOzCH9cpaH+UtN5mMvrAi5AL6zZOco77E/cTyxqN3T
         KRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JQ1XJjsuL6lqx3M3lM712uJGJOEQmz6djad/U4y/oU=;
        b=K2CVrs84JeuURUjrAABvqg+x3jzcUqC37HZxzMiiKWspjD5sh4cu6z3jt6rk31sNpQ
         v/RjvMPTDhBThF37DlsUf35drDv7EhYubzYeUq+nSid/s/NZnkPrRRxu/9frQcRL7tC7
         5FFWenX2kmeMQoqePdlMj19JI0f3BQOslDZ4kn8JHU715jajj9mtMc6AEZFKz0YT+eQ1
         Qv7XvVxLpkRvpgCSwcI6ZR3MsShy6YXbcnWO/YJ5F0uYr1n1hmONdia9FtFZLdPULTU4
         FxysuZZ5p7fQgzW+kCO3geyZPjoa8Gwk6Ey+ImmWpK5+LYSPAkq4Ny9RTkrHiC+IfI25
         0Bqg==
X-Gm-Message-State: AO0yUKULPfUqWblfPOosUpyfYrYyixcb7nF5QR5VFHaqGA1BbsmU3/lQ
        Jjqmyd+KfpD7wnbWhD15vvZuUHFeDrG9iSWHv4s=
X-Google-Smtp-Source: AK7set+BHqeCs8Skkw2w2L5Xm0DUXvtQ318RZhOkITUti3EH+kL2u4jZ5oHcNttXsVQ1T0vXityEW+BFPv9CMj+sz4o=
X-Received: by 2002:ae9:efc6:0:b0:745:72f3:637f with SMTP id
 d189-20020ae9efc6000000b0074572f3637fmr4877583qkg.13.1680100076478; Wed, 29
 Mar 2023 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZCQeyWW3+d7+qT+b@CloudiRingWorld> <ZCQkPr6t8IOvF6bk@kroah.com>
In-Reply-To: <ZCQkPr6t8IOvF6bk@kroah.com>
From:   Kloudifold <cloudifold.3125@gmail.com>
Date:   Wed, 29 Mar 2023 22:27:45 +0800
Message-ID: <CAM44cXPVDMoGiMc9v+Z6wPANEW1vaj3=odVW8NtuDUtg+0qf1w@mail.gmail.com>
Subject: Re: [PATCH v6] staging: sm750: Rename sm750_hw_cursor_* functions to snake_case
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 19:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 29, 2023 at 07:27:04PM +0800, Kloudifold wrote:
> > sm750 driver has sm750_hw_cursor_* functions, which are named in
> > camelcase. Rename them to snake case to follow the function naming
> > convention.
> >
> > - sm750_hw_cursor_setSize  => sm750_hw_cursor_set_size
> > - sm750_hw_cursor_setPos   => sm750_hw_cursor_set_pos
> > - sm750_hw_cursor_setColor => sm750_hw_cursor_set_color
> > - sm750_hw_cursor_setData  => sm750_hw_cursor_set_data
> > - sm750_hw_cursor_setData2 => sm750_hw_cursor_set_data2
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>
> The test robot did not report that the names were incorrect :(
>
> > Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> > Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
>
>  Is that the name you use to sign documents?

Yes.

>
> thanks,
>
> greg k-h
