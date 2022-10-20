Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7146605E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJTLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJTLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:14:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09979119BC7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:14:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mg6so13248753qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5LQ5ibOgwU/Lu94muSYgBgt6tHWsp6OsYy77B2Gzs8=;
        b=X2AFDhzaoX+UhDyu6eIi0W9a5feHsZYEGcCAaBfZ/QL//eyzLfXhfsOIadWecYW7N0
         2/0lSn4HMoNv54c3p7rSy3t5zTfDH9jVzBaqWonTY5sYc/KMmTKcZL9D2GIgoq9IliaU
         AY0WdO77c+QoYi39pG42nLEmYYk++NEPGOZv5EWM8i/7lpjbNOha753HZEIgd1UATsJi
         hMOkG3cWUEDA3kzqowuCKmxNwj2pTW/AbwZw5xdoiaQGVEYW+EVVw937BqWbx00uXdle
         X2ob6nDUPTXqgKubPafyNbEwWz3+AOfN3frAnqmU07FKELPLOxpGhmwxhnXos/hlBvMK
         UIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5LQ5ibOgwU/Lu94muSYgBgt6tHWsp6OsYy77B2Gzs8=;
        b=7L0VveTg6jy8h5WV6nqUx3I0w7O3QVE63zRp6xBmZ6Sm6W40JwWb00Cci6wLUcmdwn
         ZTOwRXnqnN6lvHmA8WXZmxcozRBfFUeQj2R/jIuQTJN80XjW+tHKZjraLjJSupmlMXzU
         rb6SJRPNUMcn6MuHYb0tNTL9OF4xIPsLnJoCUwzx/j7wj62Jxx0XbYzkruL3uCviUBa/
         XimyV6fDGnMqhtA2OuiikmIxGILWzHG+PqVFjl7eIIjB7u5X2wkvye4fiOeNf2bLDFHR
         WLrFU5NneC9C2o9rbhcMBG34SDPZBnQa4tbvK1YtSNZhhaj2W81jqQ2bw/nOARBQ256B
         PelA==
X-Gm-Message-State: ACrzQf2PufA6BsDK2WzbLMISI3sNoIbmCx7kL7ANMIRuChSd6rS3vmTw
        LJBbC+nGQZQpPPZFQdV36VUxrTAPSg7lqlsCdJk=
X-Google-Smtp-Source: AMsMyM4IPeUUKPsJx1cZtJSYdRgd1jqIgCk6jpBz39CyoPaqFSSRY+howYatQ/Xg7ext5BTkoXfmLv+/eev+mx6CpKQ=
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id
 fn12-20020ad45d6c000000b004afb5e063f1mr10454955qvb.35.1666264457151; Thu, 20
 Oct 2022 04:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <Y1EskCZF7qkiPW2O@kroah.com>
In-Reply-To: <Y1EskCZF7qkiPW2O@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 12:14:05 +0100
Message-ID: <CAHJEyKXLFyYkz2sVxSu_GDgT878=qcHOmvT=38gBGqJvaz3tTQ@mail.gmail.com>
Subject: Re: Request for assistance
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 20, 2022 at 11:00:59AM +0000, Ubuntu wrote:
> > Hello,
> > I have a diffictly deciding where exactly to split a long line of code. for example, this line of code is too long
> >
> > uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
> >
> > if i spit it this way:
> > uCTSTime =
> >         bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
> >
> > It does not help as the second line is still too long. I considered doing it this way instead:
> > uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
> >                                 pDevice->byTopCCKBasicRate);
> > But i did this on one of my patches and i was told it is not advisable to split a line between
> > parenthesis '(' and ')'
>
> Who told you that?
>
> You are close, the code should look like:
>         uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
>                                      pDevice->byTopCCKBasicRate);
>
> Like millions of other lines in the kernel source tree.  When in doubt,
> look at existing implementations.
>
> hope this helps,
>
> greg k-h
Thank you for the clarification
