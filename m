Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D3653DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiLVJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiLVJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:46:58 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C7AA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:46:56 -0800 (PST)
Date:   Thu, 22 Dec 2022 09:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1671702414; x=1671961614;
        bh=o4JeQC4lgkRxJjuokfNcEDFkwXkl10oVBWPrONTTxh4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Fb7xGHaMJzijXz+01bGkDxjdncd+TJc7dozXVdqW0kEZ2lCBDn2pnI4Nxmcb8Kf1d
         NQHmDPjkyGKnTVHtQhPNWRO9oRUSj6sLt9rq3TqY9buS7MBj04WEJ/9EH1Tq3aY8ye
         NsSfWD5a2VGnC0U2DPVJcDZVA2++caAx/PR4fo3/6q99B6sMF5O3MCiZqLP7EB0KsA
         3XdziExN5258GefdLHgvToDJ8s+2+QZXokDURmm64OFGxOn5EYvAdewFp/GXaMj6a7
         7ORhb7QwF8xY2BHmYQJuF4kYL3FMZ9WWoNfbheymLZTq+ilgLLuFjJc6FLWGQWjwtN
         ZIHLJ0e95RjPg==
To:     Siddh Raman Pant <code@siddh.me>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 09/10] drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
Message-ID: <gVqAatNcTgp2XXpPwlFMezMo6sMlpbJKyR6Lhwhn3btzL0o8Y_pK-3Zh8iFTkrSl5PGgLUBX8EeAReikGeqNppc_BeHuDUvP2D4Mn2dD_ag=@emersion.fr>
In-Reply-To: <adf001582998535f212cf93e0fa35ed34358301a.1671566741.git.code@siddh.me>
References: <cover.1671566741.git.code@siddh.me> <adf001582998535f212cf93e0fa35ed34358301a.1671566741.git.code@siddh.me>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is:

Reviewed-by: Simon Ser <contact@emersion.fr>
