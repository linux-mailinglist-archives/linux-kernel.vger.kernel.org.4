Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAD654482
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiLVPoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiLVPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:43:52 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3BF30578
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:43:42 -0800 (PST)
Date:   Thu, 22 Dec 2022 15:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1671723819; x=1671983019;
        bh=o4JeQC4lgkRxJjuokfNcEDFkwXkl10oVBWPrONTTxh4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OoNghi9wVe65hydZTHIjymohs4EMmhq55Bts23s4Uu8lj+7Fy1JZ1OEWUuONaKYJX
         h3M8aoAMSSuD/QFj/a5E7dF+bT3F/kk1kjz5qi3OotxyN4FZKkdUY5WEE0uiFF1KnV
         /9De7mKtx50IVmPgMD8lOQG1vp8umZ4/NeRIqRDHylkMYd0qBd1id9AUOgnhaA3vM+
         TlRBSYpSjUUJzZAy3H7yz4i/q0G1dIBaSXxUUcxrLSpGIn44EsMXjIOhTh6GqbBU3y
         xojRmRuLE4dbKNsrlEYoV2w8iJ8HzwTcgr+Dg6DlPmtXCMeNbbjce3As+koosq7vtC
         EwL5k3SNKARWA==
To:     Siddh Raman Pant <code@siddh.me>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] drm: Remove usage of deprecated DRM_DEBUG_PRIME
Message-ID: <WQPlQmSRlNYiwN86XBcaxDTo0r2rDi28CRLzZszXS2IRVoKrqt44xkUXYW21GifuV_p67kKf1q0NYwsC1qYWn-LwOKwFNq4aEMX3tHlpHQ8=@emersion.fr>
In-Reply-To: <e7b5b54ebfac4ba53cd95174b81d3f3169a4d630.1671723195.git.code@siddh.me>
References: <cover.1671723195.git.code@siddh.me> <e7b5b54ebfac4ba53cd95174b81d3f3169a4d630.1671723195.git.code@siddh.me>
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
