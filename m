Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184A69373F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBLMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBLMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:18:36 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF012F13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 04:18:01 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PF6174MN6z9sTV;
        Sun, 12 Feb 2023 13:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676204251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FczVmXhgWDsSvXajJY85Vq5BsU6XlO1BFQUzsdrxudM=;
        b=WucPbm5G8B8Qkm+q/L0sCsiMGv9lWAriCEH5diEETvW6CEv6A1+ueludFcH03aAQEFIDu3
        R7rH6N84zqgSwBRn2srsxFu4bxkRM18jp9KJSWMoTYogTY5xMlPy17dOdB7RfLbQx1PwSh
        b/DXKG9utMaotfX6xV/UowuZoK8QMezjAVZcCA7ehCL/+V5/9hQd1JdbVErb0TdWczrA+p
        HOJByxDGX8rpnuFtHmuZofP9JtPa/6aVVHrjiYgrSu/aQmg3Mhv7/zeAD8WT2jz9t3JWxu
        KAPlQQmWgS94tK2cwuuGqQ+zy/EfOyy4pzMaqjB5uc/QSg2WKAYeRLVINrbIcw==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <guido.gunther@puri.sm>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] drm/panel: st7703: Fix initialization failures on
 Xingbangda XBD599
Date:   Sun, 12 Feb 2023 13:09:33 +0100
References: <20230211171748.36692-1-frank@oltmanns.dev>
 <Y+jLzCUyno4A+SiD@qwark.sigxcpu.org>
In-reply-to: <Y+jLzCUyno4A+SiD@qwark.sigxcpu.org>
Message-ID: <877cwn13jv.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=--
