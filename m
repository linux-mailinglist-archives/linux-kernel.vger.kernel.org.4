Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B136A2685
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBYBaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYBaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:30:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1E1422D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:30:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s26so4154452edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xdbzOcRjq9G4sFMOEFb17xXds/OZkETpcA/h0xDZLmk=;
        b=LxBa1NGaikzmswQ5eYuauhrZUuwPh5x0lP8u3tH5LrRO8T/VN+kzrY+GA30FD/T3+a
         Gga+BuOdgcJVAi88hi9sO3liQpQ7mBGBVUNMIEMRLRRvpNdE+sTC1UOcWs+zxhTWu3rB
         /D2B8Ktp0+EOQg+ZsNGG++5U5pPL2PFDLrg9yRp/vyJFPTd0sCObLPf4E3V/JjEEU+KG
         6hl1r+QL+JgwtOSUugdZW8SwPWpQFGmqJfiFqjYiSszNMJna72u7b+FAW5saGbgqnh+v
         l6mGtCN2WvlThpet/OvcNnRKsGj6Obxt8rYs63ys1M7MVhKoToRpCenDphjSe6Z5SG4j
         f4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdbzOcRjq9G4sFMOEFb17xXds/OZkETpcA/h0xDZLmk=;
        b=penZCjVb8sObwnXq39rGkzHCyPK/R6la7k8WSoqa0W+R0SvQIqRBwQm0kGa9gu5q6j
         9sLeerOhCWC6rVD+vix2mX9HIzNDI4bRM63r33OUQZKGbHl3tOGXl0o58H5DmmdyG29O
         afjZQzVUlrjjWBXdq4+jR3tgrsDersTwdLFRYjUmfOy2H3NlnIAqFII7KTkHKuN51zrn
         YJ41JIC9f84jbDPZQ7F+Fyn8mZp2dtTt3jFCuSJQWzBi2wGdJI+VtrtZVi1tbw0gK0gf
         P1rKvz/HkCM+rC2uBMOJww3hEbWJgqPZY1osvrm9+B2Qj1V6BSngVkifw8dTy0gAkT3C
         h7wA==
X-Gm-Message-State: AO0yUKW53eL09CQXWi+hOQw7lUMW4NnATZCJruUKOuqMLDQFaJx0pqAk
        aZNaetn4DfSVt06z7kxTxrpz8dqqzL0OQ/c6szI=
X-Google-Smtp-Source: AK7set9OsYC3y/M46F2H22mmzbxWl97FfuzNqRJmusuxRxQ/gRg/b5RBuUU5DL4bEDuP75/gZZxk6jpTBFkFs9ohYJo=
X-Received: by 2002:a17:906:4ecb:b0:895:58be:964 with SMTP id
 i11-20020a1709064ecb00b0089558be0964mr12741554ejv.2.1677288610784; Fri, 24
 Feb 2023 17:30:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txhVJ3t_3-wMdWH7F+=_BbW19NYxAnm2cceP2uHR47_5w@mail.gmail.com>
In-Reply-To: <CAPM=9txhVJ3t_3-wMdWH7F+=_BbW19NYxAnm2cceP2uHR47_5w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 25 Feb 2023 11:29:58 +1000
Message-ID: <CAPM=9tzPxixXnRuk0Jfs2ESw-eY43H_e5_FtGbxAhRmvaByYwA@mail.gmail.com>
Subject: Re: drm next for 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, 23 Feb 2023 at 10:10, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This is the main drm feature pull request for 6.3. There are a bunch
> of changes all over in the usual places. I got two conflicts when I
> did a test pull, and I think you should be fine handling both of them,
> one in amdgpu and one in i915, if you need help let me know. There
> were some media/i2c common trees pulled but everything should be acked
> fine from those.

Any issues with this? I get nervous around 48hrs :-)

Dave.
