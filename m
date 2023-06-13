Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9B72E7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbjFMQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFMQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:02:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53A1727
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:01:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25bbcf3c0acso1872693a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686672119; x=1689264119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wapCm2hOazX/LWg9cChCceZuhZiGkHyzjGVVgP4LkzI=;
        b=emAi+wytugNGE4PLtRWr5PwUHIdv4M3VLuZtaZ4PslBqwXEYy23tGyqBPOSwfVS0c0
         0QQhG2zblFHLVeccET9SjMAhAsbvAJaiYENNMStrjOi9R+ambH8brILrSHXs+QIxLPVz
         r5tSTYvt2ImyWy23H81HvoUMIIMxJMJomGPcCG5iL/PvSuZ5mP7eO7sT4lKMi7C9eXD2
         7VCcATXVJ4oLzCGEQVOQvfEgEO/NRSeFgKxARP+z2pIaWjqKWuSfvIrB9GQN6S0SsUHr
         VBfdBMkBBXtrtdvQtZocELwTs65iW6MzEUYQSzfvm1v4rhHosxVaHvpADSIWmhrTI+ne
         FigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686672119; x=1689264119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wapCm2hOazX/LWg9cChCceZuhZiGkHyzjGVVgP4LkzI=;
        b=UsBCXVkjv09pRwPjMygiqm6yjCdlG2tUBZUAAGCX+IsTZqw1hUb/FysVjmn4+nCLSU
         216yXntGRoULtE6xCdm1jP6ywOWwpqT7MlYBFZbe7VFhatlJPYedK/C54VJ2P9V98a1H
         REzhCoUB5sRJjeQ4JOuXsA6A5IrQTA4CVMX8FXhGGetvybjvOkPlDgtz44mSVj0JSud0
         itieQjLJ9ZTonpH1w/gFW3G5OLaJuVsu7euHoXTpaUgYZymsmWpwjmnPBiLW5808nRzs
         r/n583sP6R+1yABpVVPcs9GQA8TMJtCWhScG9kQk3N7StNWEUutc+g5pqg23nEpEdkun
         ysRQ==
X-Gm-Message-State: AC+VfDw4MoQxpvZhv183N/gWmXyk6b+tGvNQcmmmOxawKCN+FcK9uSd0
        bNphy180rHsUHIirj9I4TWg=
X-Google-Smtp-Source: ACHHUZ73Xo1+cZsPEIo3XJxoktYekEXvd+rhISKMUdnp07CNvu/MsjsEXQvD6qaq84i4F4dt5/rz9A==
X-Received: by 2002:a17:90a:4293:b0:259:30e7:7349 with SMTP id p19-20020a17090a429300b0025930e77349mr10423696pjg.8.1686672118891;
        Tue, 13 Jun 2023 09:01:58 -0700 (PDT)
Received: from redkillpc ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b002560ab7a15fsm9407509pjv.36.2023.06.13.09.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:01:58 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:31:51 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 3/3] axis-fifo: cleanup space issues with fops struct
Message-ID: <ZIiS72stdaX71qGG@redkillpc>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <20230527115101.47569-3-prathubaronia2011@gmail.com>
 <20230527223111.jidik3ffcsxdkenb@pengutronix.de>
 <2023052808-predefine-thrive-d84a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052808-predefine-thrive-d84a@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 09:57:52AM +0100, Greg Kroah-Hartman wrote:
> I agree, there is no "requirement" that these fields are aligned at all,
> so I would stick to the real fixes that are needed for this code to be
> able to be moved out of staging instead.
Sure greg, leaving out the cleanup fixes for later.

Prathu
