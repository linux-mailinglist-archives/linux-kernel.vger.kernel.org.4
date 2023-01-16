Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B566CDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjAPRpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAPRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:44:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72347568A4;
        Mon, 16 Jan 2023 09:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976966108B;
        Mon, 16 Jan 2023 17:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC4EC433EF;
        Mon, 16 Jan 2023 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673889828;
        bh=JYdgMzjX3SdtHUhlc4JqQNlQEpIgJ4tHf+fTdHFdHb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YppIn6k9jGPDSp77P5hlkqwbe3XdHs8C+pzPcjc4LzgHZq9iYLlDNh1+m96T8qzyq
         4dXD/4siUPnnCXhFsmjoqRbjuRnA0vksn98yQGWysEfS/zuyHJ/j2nvsDgtA4p0Uk+
         aXmAr6+VAkYhRBKGMwFoZbffaKhAsR5hGlzQAZyE5n+4+POhnM08Gk6apNO7D7aVRP
         +KmuEPwNNQLujE24eT2vagiEMBqWA3tu3d8zmCpkl4z61/0b17ZwoNy12h6Jv7+mCZ
         FvSJeU1AcyNui7w2DJ6gyAL0dntf7XuTrPuHFcwKy1Gj2Zebuqkeze/APTUoM178wo
         qTsgQLVE/AABQ==
From:   SeongJae Park <sj@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-crypto@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-input@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] Docs: Add some missing SPDX license identifiers of subsystem docs
Date:   Mon, 16 Jan 2023 17:23:45 +0000
Message-Id: <20230116172345.12835-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADnq5_OUnkzoZcCdW0X-=gJsXSRgY=GLrbmfNj0geDCzL5a7eQ@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sun, 15 Jan 2023 10:35:57 -0500 Alex Deucher <alexdeucher@gmail.com> wrote:

> On Sat, Jan 14, 2023 at 2:48 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Some subsystem documents are missing SPDX license identifiers.  Add
> > those.
> 
> It would be good to split this up per subsystem.

Thank you for the comment, will do so in next spin.


Thanks,
SJ

[...]
