Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5B6FE338
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjEJRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjEJRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:25:45 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974755AD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:25:44 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4QGhkb2WxKz3qxt;
        Wed, 10 May 2023 13:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1683739543; bh=3vzeVieXm2xf9+VzU0gVvFLlV+/iwQu/sK9Jt9RTw+4=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=EFng2gh94Y/9VT3NuRSMb7JJtBFESmkbWDHvkTjaRKkO77PfNTvMFtWX9OtexDduv
         lcMqaXgV4xe3CIoVIsyLzp1PjK5nbu1yoxlTqi4k/KD00vevyGdsS+mgqmT7EIxyhe
         Ck+x7JXvutMi2ZrO4dvEPbKg9yH8MVr05JEoZ5iQ=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 10 May 2023 13:25:43 -0400
Message-ID: <1f2a1e8ee99fc9f0a89ad47d112728c9.squirrel@mail.panix.com>
In-Reply-To: <2f4370b6-8426-400a-8be1-36a48dadccad@suse.de>
References: <20230420155705.21463-1-pa@panix.com>
    <2f4370b6-8426-400a-8be1-36a48dadccad@suse.de>
Date:   Wed, 10 May 2023 13:25:43 -0400
Subject: Re: [PATCH v3] firmware/sysfb: Fix VESA format selection
From:   "Pierre Asselin" <pa@panix.com>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>
Cc:     "Pierre Asselin" <pa@panix.com>, dri-devel@lists.freedesktop.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Ard Biesheuvel" <ardb@kernel.org>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmerman <tzimmermann@suse.de> writes:
>
> I found this casting mess even more unreadable. I went back to v2, fixed
> the style issues and committed the patch as v4 (still under your name).
>
> https://cgit.freedesktop.org/drm/drm-tip/commit?id=1b617bc93178912fa36f87a957c15d1f1708c299

Will this patch make it into Linux 6.4 ?

--PA

