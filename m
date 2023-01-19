Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3447B673105
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjASFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjASFMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:12:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694AB22DFD;
        Wed, 18 Jan 2023 21:11:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q10so721728wrs.2;
        Wed, 18 Jan 2023 21:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tjbpu1SxuTEzHSu4hfhiQLazDPHI+RGvql9dhrL0NQ=;
        b=BZHdfb3xC+QUE9x42xdBIAVgRdnD+oADJ+j2t4Lg6k78gutt71TMP9p8T+msJiZLIW
         68FHTJK0KLA+8x8xskBC/94eRIK+woqo4c+qzMJ9LmNyJ4u3pMllBanunBPvsFnpuFeD
         oZuY10iqQwhG5MKy8hFDgr1RjYdNSskxz4NMVGMsHKZ9Ki5TQOmf5zfnMvDcyW+Hrxbt
         a0ddXCwV2bS+CxdnI6AooGaamiMFE/oji8rb7DFd8OIQYcJQTuRqMYenigUzUaWCeI7X
         /VmWlrYtGA+JyOGyj3ms51Ccgq0EmxO3R6QTOBot5p6pFTLf1E/K0yXLEuZDhKnyd/1W
         Ce8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tjbpu1SxuTEzHSu4hfhiQLazDPHI+RGvql9dhrL0NQ=;
        b=hR226kBvKZ8Z0Ko7KkDw4hm9V+v50jQ31Vs+scc37rxzL3nyMe2IP2pUxIHiey4qV4
         MTmex7GLWJiAKZbTWTnTCf9w067afbHP2GctcxJUj96Sym8YO0AmgOScWdA31s427dIS
         2bVenPRXS7BVctrJ5pnki+mgxBjZDjLWtA+nOs/LkQxH4Y/R033VRSp8umm6Zi6mpXTc
         qDPSsRBNFMKl++0KFaw2kiALLiQSCjDuAonrdQcMvap2drHxCM9FidnlQvgO3EeM84UG
         cpbRr5Lb3UiGANXb4fsTDyAyxqPq+uKvMGRRq2bwvScjNXjHAAEZxSdDnJlH6uP/uKK1
         B52Q==
X-Gm-Message-State: AFqh2krO/37hKRw6+b92dl0DCUK/3lYU4iF1/kXP3Jn3Q6S5xYkCvsJL
        zg6yvF5EIO/eX6jYFRF/xPM=
X-Google-Smtp-Source: AMrXdXtJite6JKf4pGTxLI2ygDKj1sCVv+/+7k0s80+bC+EzVSmIycwrf+SCCakYVITW5cqgnqALEQ==
X-Received: by 2002:adf:f085:0:b0:2bd:d4bd:581d with SMTP id n5-20020adff085000000b002bdd4bd581dmr4037847wro.53.1674105063778;
        Wed, 18 Jan 2023 21:11:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002b6bcc0b64dsm20494305wrz.4.2023.01.18.21.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:11:03 -0800 (PST)
Date:   Thu, 19 Jan 2023 08:11:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Message-ID: <Y8jQ5M1p5AN4LAMQ@kadam>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:54:56PM +0100, Stefan Wahren wrote:
> Hi Umang,
> 
> [add Phil]
> 
> Am 18.01.23 um 12:58 schrieb Umang Jain:
> > Drop custom logging from the vchiq interface.
> > Mostly of them are replaced with dev_dbg and friends
> > and/or pr_info and friends.
> > 
> > The debugfs log levels (in 4/4) are mapped to kernel
> > logs levels (coming from include/linux/kern_levels.h)
> > Would like some thoughts on it as I am not sure (hence
> > marking this is RFC)
> > 
> >  From drivers/staging/vc04_services/interface/TODO:
> > 
> > """
> > * Cleanup logging mechanism
> > 
> > The driver should probably be using the standard kernel logging mechanisms
> > such as dev_info, dev_dbg, and friends.
> 
> i don't have any experience with vchiq logging/debug. So i'm not sure if
> it's acceptable to lose the second log level dimension (like
> vchiq_arm_log_level) completely. Complex drivers like brcmfmac have a debug
> mask to avoid log spamming [1]. Maybe this is a compromise.
> 
> Btw some loglevel locations has already been messed up during refactoring
> :-(
> 
> [1] - drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
> 

Kernel logging is actually has a bunch of features.  You can turn them
on for just a module or function or enable a specific message.  See
Documentation/admin-guide/dynamic-debug-howto.rst
for more info.

This vchiq logging is a re-implementation of a subset of the features
that normal kernel logging infrastructure provides.  Moving to normal
logging will make it cleaner but also more flexible and powerful.  It's
better in every way.

The broadcom stuff is different and more complicated than what this
module is trying to do.  They are sorting out their logging according to
various components.  I understand the motivation, but they would
probably have been better just use standard logging like everyone else.

regards,
dan carpenter

