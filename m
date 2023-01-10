Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8A66444A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjAJPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjAJPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:16:09 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308418E39
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:16:06 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1673363763; x=1673622963;
        bh=OIpsXNSXiQX2+u5NhaG+g2vGcpI5c0rvpdJemusUDtg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ljxfUFRKpDotckB0rBfR077L5lVUoKjHcBlAQk0BuvRjjp8En7LEV2ex2rTHbh+MA
         4uzUuWGnuZGIZQEIjr8EXGJ5iirE3Wj1Mmz4qHYBx83NUByyICNkFGA6yOYp18wMSS
         KoMmdI0ujOdNC5/0Ec/ka8CCBYx8P8ed0PSJmoynsx4V2t9tuNH8uI8ZV/HWBIBDnu
         RyESygxlfU+gJeFNRxPT7mF+2J80ZBOODcDQqqnZyu84q63sKtJV16Zyb85mKaXDON
         7F9OtmmUEesiDvC4rNLQrurVewnNpBhL75o6C/ByjEGJrxk7630h8eJ3/NDmSfqkK4
         IWf4ULIxdGuzQ==
To:     Siddh Raman Pant <code@siddh.me>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/10] drm: Remove usage of deprecated DRM_* macros
Message-ID: <C6RlXueyDNu9t4z9O_S7mx1gZbmzjCcHqbarn7w6QZcNVuBLUAKwyzGZQXk2dIQSxcauzlHqtkFwPveNglu8ZDtU875E7X4pS9zQsYyfMPA=@emersion.fr>
In-Reply-To: <cover.1673269059.git.code@siddh.me>
References: <cover.1673269059.git.code@siddh.me>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I pushed the last 3 patches to drm-misc-next.
