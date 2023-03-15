Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414E66BBFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjCOWSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjCOWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:18:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60366211F;
        Wed, 15 Mar 2023 15:17:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y15so16633862lfa.7;
        Wed, 15 Mar 2023 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678918677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohh0sNko5t8OAsphcRpCNrGFt9h2wrYQQBp+YtBOx6U=;
        b=ZziAGsDMwqsRuMQZvA11+qbBfioHGZMUCMGfFrWn9YcgZAJPvqZwZ6w9idxuJ1Y1RZ
         1MhT5b6r8MMgeTVzce+FpNcVFjB+YwJ7yfWptNkk24e6ZMhiiqH3jx3xDHX8/6eOeHPm
         WmIraLRFkw7RixwZpiMvRyPW3OfYh/RmIPjOouOIGlWDOjMz9ngojtQdSal0ZKtamiCs
         kvOHjzUcbQqS0psZjHp+gstc57RdE3PNJzTBEt2rgHzV9H2lEnbUXvmfRVnLmPR21tt9
         7CyLUKgxSp9bJXaEi/wVi3EZh8H7YotOb7an/UFtjBbrKDT+gOfAnMzDL9+lpV3+V/Bt
         ZY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohh0sNko5t8OAsphcRpCNrGFt9h2wrYQQBp+YtBOx6U=;
        b=8CHKjoalAvOIGkkABxEGtffHt+6nU5hwrRCTiCW2PYB9CNIqVlt6gJLXJ6qbIzmFQv
         I8GTK6nV6TF7uBgPXhLRpBvio/Va8QFmmKmUpgPD+D2LXAO5+MhHrg9UkWPHKjBz5vKX
         +xEMzWlvtDZbJuXKD+0tJNh2XSYr9i/UkNeT8oMcdqvpQxdW1gpJGOEByyB9R4U2Tez2
         x09ZFSAGhN6LSV/9MfmIjFoAgK9cKC5dEiK9KMrc8rqFsMFLc9bVmiHazc/ZtC1jbo5O
         zB/jpML+dduIQBBGLmHqSwGPQT5McrBLjzDrKcSbAvU+9T6xa3yf6AhlnUrrELXouVEG
         tiWQ==
X-Gm-Message-State: AO0yUKWpnrRAIFHImxs8qvrdpSAM3G06Dd22tfX9f8fuI0v+VCgzwS69
        1JMUTwvI4surGpM8Z0HoQE8=
X-Google-Smtp-Source: AK7set8egnxWqeQOwdnQervf5UH/p6hmFz0ct3UOIP5lYa5zmJS3YvP8Yr1kRxodIC21cfY6bRo6xA==
X-Received: by 2002:a05:6512:3910:b0:4dd:af74:acef with SMTP id a16-20020a056512391000b004ddaf74acefmr2157265lfu.35.1678918677485;
        Wed, 15 Mar 2023 15:17:57 -0700 (PDT)
Received: from localhost ([46.211.236.75])
        by smtp.gmail.com with ESMTPSA id m3-20020ac24243000000b004d291dcee7fsm978044lfl.55.2023.03.15.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:17:57 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:17:49 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Message-ID: <20230316001749.44e51d08@gmail.com>
In-Reply-To: <20230316000453.553bf6a8@gmail.com>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
        <20230315210135.2155-2-pauk.denis@gmail.com>
        <20230315233054.5ac21db0@gmail.com>
        <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
        <20230316000453.553bf6a8@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 00:04:53 +0200
Denis Pauk <pauk.denis@gmail.com> wrote:

> On Wed, 15 Mar 2023 14:58:24 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 3/15/23 14:30, Denis Pauk wrote:  
> > > On Wed, 15 Mar 2023 23:01:35 +0200
> > > Denis Pauk <pauk.denis@gmail.com> wrote:
> > > 
> > > Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
> > > 
> > > Pro A520M-C II/CSM is also tested by Holger Kiehl
> > > https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/
> > > 
> > > Could it be applied as single patch or need to rebase over "Pro A520M-C
> > > II" patch?
> > >     
> > Sorry, I don't understand what you are trying to say. I just applied all
> > patches in sequence as received, with no conflicts. Should I undo that ?
> > 
> > Guenter
> >   
> 
> No, Thank you!
> 
> I just like to mention that Holger Kiehl sent separate patch with
> "Pro A520M-C II" support and it could create conflicts. I have found it only
> when I have sent my patches.
> 

I have rechecked repo and "Pro A520M-C II" is added twice after apply both of
patches (my and from Holger Kiehl), could you please remove one of mention of
it?
