Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEA566D9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjAQJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjAQJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:16:55 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F29303EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:11:11 -0800 (PST)
Date:   Tue, 17 Jan 2023 09:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1673946668; x=1674205868;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=w2iWydoXk8RHqXgW83JFpaIGSpe5l3Y2yeyuaKzWF/vPNEOIqRVxNR6QuwRmyJP/p
         5WOJV2yhDroi1EHes70rVxbpLabma5Yt0KikWA3ri9aGoiC8msgu8eHsJiYLFH+NMQ
         GOsUgsQOWkIyL8ayzjlp/r5IIxBit91tIYCrZpr16Eb46mKbEB7bdn4Gi0t6w9VNhR
         c0qwGXzGOn7/S4WYu6VRWFU1ORJYAIIkQEta5G03/c9rD3dqAZ3JzlbAOIH171rOkp
         nOr0ycLCLjkAPWx+tRvuxMQVNMhIl935j17chy6xVtP+mqAx8Ivx3b0aX5d2dP1Vd3
         AvEzBbCnIczxA==
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] drm/connector: fix a kernel-doc bad line warning
Message-ID: <nXsYJJqxCoslSZBdoE_PLzJjM20VzHL3MT7a2dyQ35XrgS590xyt14v6IIGpK4NQ1nQSBF9UmPzvM33zPJhLc3qMndm_zLcLIBBi7zjuTwA=@emersion.fr>
In-Reply-To: <20230117070224.30751-1-rdunlap@infradead.org>
References: <20230117070224.30751-1-rdunlap@infradead.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
