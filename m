Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C18724694
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjFFOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjFFOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:43:00 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9AC30D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686062339; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=NRMwi30fHFoOYPTsJxxPO8mtNBPqggM7ZYFYKYiH5T+3S+bO32/iCjvSCJohkvSusJJdGWPC1Fyo2/HpIEcNFiL7wMNQotTltfN0qLMi6y+AkmBR2k4waDePDO9X6ovrSXQ/IAFzyZL9Y3dzrIhjB5cjezOGaYX4qX0dOUzT/yA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686062339; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=we4OKyiqxKpRZqTOEuovizJ9NsdFVjeQ9dA+yX7m0xQ=; 
        b=LPvOJ7fM11E7ZXnz1BUNR76kulY0nl9otY5bAQBTEYnQqivKa3Dbi2e1R6tdNFKdvb+Q3/zKkWwME/KdSBFVzCx0MmHBTnXWNIBkCwwTufeT1Jvlcu4GQOTnDcb4AIYUhQGew1hDYN7BGWhvGbShzmv33iv/Ugh3I8IASrx6yJg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686062339;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=we4OKyiqxKpRZqTOEuovizJ9NsdFVjeQ9dA+yX7m0xQ=;
        b=dUxBTwoXq4sKuQ3aRnhHNUfBwypUh6wjQ00adzIIHni5kMVZ70/OS3OI3wg1Za7F
        spU+vGtHHZjNRZ97GnFvE10tpGuKWuSkO33UycppjDjHO5J/8GRSDBS61MsPOGPIixj
        3k8UAOVhTPTjJEefFpkhjQPRGCvzfXC5XtUQrhI8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686062307468507.0230860934555; Tue, 6 Jun 2023 20:08:27 +0530 (IST)
Date:   Tue, 06 Jun 2023 20:08:27 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Cc:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Robert Foss" <rfoss@kernel.org>,
        "Jonas Karlman" <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Suraj Upadhyay" <usuraj35@gmail.com>
Message-ID: <1889125187d.5d36766d120183.6659725053490512400@siddh.me>
In-Reply-To: <20230606142322.GB5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <52c8eb0f241a9d67ce5b7e6fc64dc397e735ccd8.1686047727.git.code@siddh.me> <20230606142322.GB5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 3/8] drm: Remove usage of deprecated DRM_INFO
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 19:53:22 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> Any plan to remove it from drivers as well ? If not you should mention
> in the commit message (probably in the subject line itself) that you're
> only addressing the DRM core.
> 
> Same comment for further patches in this series.

Yeah, this patch set aims to replace just in drm core (as mentioned in
the cover).

I thought "drm" would suffice since I did not specify a specific driver
like i915. So the subject line should say "drm core: ..."?

Thanks,
Siddh

