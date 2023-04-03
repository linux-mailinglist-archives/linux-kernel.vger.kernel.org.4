Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F36D3B62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDCBTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDCBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:19:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CBC659
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:18:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so111146450edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 18:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680484729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCe8S/ZbFd32iadHpAz74xiVMxjzJpl0e1TXToqxByE=;
        b=dLHXvYgHmYqyccRY2uuFhwOgBFDIo3F86iRmdDZTyn3rMWnUpbyXL2IekVDNFxr2oy
         u6TuP7SrkKFnHxfVHdJZ7ALGLUsx29yYq5vrB6Y6kSkBz/YEk5gicWb9Gm7yZm7oWao6
         2C/tyOTc8OStItqLrr4KgiRt4/sxgNsjUTWrYwnPvLOAmcVHHqp4p8fdIsIHuApgsmNE
         MRoC9BcsDspMkS+B5N5+rLj8VATdwg1do9oqvOmC5AZmx7z1hMaAJ53ERkxk1HqAv1p0
         j9kaXJIY1Jp/mHR3rM3vR3BVCtDU1t9VrDxT/4jwVHjNC501+b8Gs+4sPOSKoCnYg0bk
         pUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680484729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCe8S/ZbFd32iadHpAz74xiVMxjzJpl0e1TXToqxByE=;
        b=IMAeLA6CA+mox1/E7Npy4qnlfdtrj1rC+HS7B2cYXlLyCnoDJR9KLb+mfzrb+eyxs8
         Fa3j1oEW387jyc6ElB8KDYcM9KvURFilq9Cq0XT7glQ9i+OjjFuEaR40i/4k3E94qweb
         Z1gfz6LjwlS5wv3X/TOlRHJe/G2sioApAvPjYEvdAGu7CkXhL3f5qhin+70v50APH8xg
         /hR8jsfK8Om4D6BUQ1cxKI5tsnCgDdSVxaDdJJvSW5iJgsYE0sazNetHaHiMKk6jJh2r
         iTKjW9AsfLxnUd8TOTuu/PEeG0wSEOfbbY1GXVcxHHzM1OQcrl5II1A0WFeqKtY7TO8w
         dX/Q==
X-Gm-Message-State: AAQBX9cVO54xBg2Ii0+q1gWhc3DYOEaCKAEsrZDDXqs9sHyRYSWa/r/J
        ++Fe74HIspORdDVJh9Ati8mS2fmFEVrbjA==
X-Google-Smtp-Source: AKy350YWt3CDxWTeY0hg8BwCbo95PeMJlu9paedE93oDJkKi6SgsUSRjo0xEjz8VrWMiCMbDvVsWgg==
X-Received: by 2002:a17:906:7193:b0:931:7adf:547e with SMTP id h19-20020a170906719300b009317adf547emr35949132ejk.70.1680484728696;
        Sun, 02 Apr 2023 18:18:48 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id dx1-20020a170906a84100b0093048a8bd31sm3792039ejb.68.2023.04.02.18.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 18:18:48 -0700 (PDT)
Date:   Mon, 3 Apr 2023 06:18:45 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] improve arche_platform_wd_irq() function
Message-ID: <ZCopdYy7wMGEVx5P@khadija-virtual-machine>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <642a1f88bd232_394c38294a5@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642a1f88bd232_394c38294a5@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 05:36:24PM -0700, Ira Weiny wrote:
> Khadija Kamran wrote:
> > Improve arche_platform_wd_irq() function to minimize indentation and fix
> > checkpatch issues.
> 
> Minor point but the cover should have
> 
> 'staging: greybus: ...'
> 
> ... for the subject.
>

Hey Ira,

Sorry, my bad! I missed it by mistake.

Regards,
Khadija

> The function name is nice but it is a pain to look in the code to know
> what part of the kernel this series is for.
> 
> Ira
> 
> > 
> > Khadija Kamran (2):
> >   staging: greybus: add a single exit path to arche_platform_wd_irq()
> >   staging: greybus: refactor arche_platform_wd_irq()
> > 
> >  drivers/staging/greybus/arche-platform.c | 84 ++++++++++++------------
> >  1 file changed, 43 insertions(+), 41 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
