Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367775F79AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJGOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:23:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F23120EF6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:22:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 203so5907437ybc.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=;
        b=ngKGLeZw9CyDozp6mhH3E6+a9FtNqfDGo49G1ogq76s7RYMMmOKfZHUijQIMis6UTn
         Fi3JKdHhCGn2719hZRUeg8GTpk1q4t8cKpUHBoOmPIIOMoiQhdWewEfgvfVZxboNQArK
         5Gn18JCzuwjUaXwAC0aQORqQ9O1LmLB+46iD80w7oOLX+UwRfaLpi2zpgOLoIjrTEn1H
         /nUu076Aqvd+mBg9cqbDCyWCWmesJ2QuveR42CE0kShWT3nPFiIJkLVANTYKQx0X4Tx0
         WnJUReob4IeU36iwEzUSB1JEfJh5fcjXDNdzgd7MlIZ/mHqUSlIqIpC64jE/5TgutdtW
         9g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=;
        b=vg+k/Hsi696sZv7hzygWbq1PjSacFynL6/p74BSzjRDGxrpQWnRq+WKq6ZR3sLDExj
         m/uHZ4lprvrdy4SparecexwJXDypnNs51GqjstuV/udDnxUW+caRfyGbe9oD+vcs9HnT
         ufZ+aKpt1xrm+k7kCBTqQkbaI9h0G8dFUa26aT9SopWxTaWu2o9VBjD+gR65jPWvlvk/
         EWyo2Oxiga2oLtTtHNY+skMXxvpnRG08KoY/ZaeE0PbwI1KpPKKckkKN+7g8jsKDNwrI
         Kfzq0AxkRnQGhthh+w4qMfEle9hXDuVV+N6aSOy+Na6s1VXWPHYhdtNZXHvpUTeQoCXC
         ZGJA==
X-Gm-Message-State: ACrzQf1dElNbqrek39L9ZKmrfj1A9l+zqkGS7zpL/Ppz18T5yYGVKpIx
        S0+2LQ/mq773lXuySn4/TgTIn50s6wkYiuFdB8Q=
X-Google-Smtp-Source: AMsMyM4VT4oaq5VaehMYvvRhdY7chdQWG7EOpRVLKHvBbSzxLX+C9sSYsB2IR9PE8G5wPuWKYmgOLra8W20gxTVBAFs=
X-Received: by 2002:a25:a0cd:0:b0:6bc:9569:b63e with SMTP id
 i13-20020a25a0cd000000b006bc9569b63emr5069657ybm.376.1665152577389; Fri, 07
 Oct 2022 07:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221004171351.3678194-1-daeho43@gmail.com> <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
 <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com> <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
In-Reply-To: <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 7 Oct 2022 07:22:46 -0700
Message-ID: <CACOAw_weAbKWs6qi5x9t2=L41tVUV+CKjG-BGn1gOOtgjdWYug@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for atomic writes
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
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

>
> Fine to me.
>
> But another question is, now it allows GC to migrate blocks belong
> to atomic files, so, during migration, it may update extent cache,
> once largest extent was updated, it will mark inode dirty, but after
> this patch, it may lose the extent change? thoughts?
>

Oh, I missed that case. Maybe we could prevent updating the i_size of
atomic files in f2fs_update_inode() while allowing inode dirtying.
