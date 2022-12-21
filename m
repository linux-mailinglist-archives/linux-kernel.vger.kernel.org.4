Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7697652FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLUKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:53:28 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7F1FCE6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:53:25 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1671620003; x=1671879203;
        bh=38K/ZcU/rpkZ40zlfd7cH6/N8jRFFqZ+s5+dWSD7f/0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VHUQSi1j9kqEXv5+fsZK5WHUssbse4nWsMCEA8ZJfJJWSZqanCgXanb7xVHT1ugDU
         1ETuiSQ4F+OKrn8ne5ILCOUCNkkADuq5vbmdFb4XqjdU13zvT0czz/NyvZCJpLXIzI
         BhjyN1/UfMHmSqTEf2ep3YvoJfddnGtcCMwNhDGDvLj3RzdBtq3i8qICZHlCmHdtH9
         BXJ1jTwB+rRg4jhTa9DrMMBmfnAfg387k12MVYzkHPO5+5eJJhwkIm609/T8n9/Lac
         MpThZbAs8dVsIc5Luh4xhB65utL29/rsGgtvmcEkUqFNkDhgw759NgshlzI7kBX4xn
         VZqLAOjNlxFdg==
To:     Siddh Raman Pant <code@siddh.me>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 10/10] drm/drm_lease: Remove usage of deprecated DRM_DEBUG_LEASE
Message-ID: <hcCVdh5zwsAppV-NZm4hkeNpG5TRbMLAq_8vzt33GZpXE5VS0HSLH1_SRz_7FwI3rJugI1JevfKExAY3Y1tFUWi_T0GpdykLqN8cBp7-c9g=@emersion.fr>
In-Reply-To: <3097218a132d9184e82b2f9b9861161b1dd99db5.1671566741.git.code@siddh.me>
References: <cover.1671566741.git.code@siddh.me> <3097218a132d9184e82b2f9b9861161b1dd99db5.1671566741.git.code@siddh.me>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch is:

Reviewed-by: Simon Ser <contact@emersion.fr>
