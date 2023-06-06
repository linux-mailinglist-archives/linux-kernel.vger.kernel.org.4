Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA272443E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjFFNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbjFFNWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:14 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939D83
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686057678; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=IsleUbvHQKYA75512M57S2nWuNFv9ftsopRs9T9/NiYPKF3N9+ktrfd3C+adSZQlKrSIkhRXiqWikxtqSMkcAwwAOGEs5uhiUpDaxBjIhgF5y/b1ySUWb67iSVLb2iiSUZ5WpNJieOJJWwflIiwseo1KyMebw2aFNISUzPYzBFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686057678; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZeTAQnMstl6o6gzMB6r+R3fC0od+ep3sPbCDDY+xTuw=; 
        b=DYSPBvExNKK4Nmjk6tlXYnTepDs/K2/jsSUWyapusTjN8rmhUJ/T1GXRSwWLN4xB5ztp6uuDPy3kSSHy7njGVGICQZI1em0SXA+qW7oZs2psGlncRjNbOiTqXH4+BY7hQy1NUqf/drmZnZcINYsqj2bqAx+cR1kZIBHIj0kDeNU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686057678;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ZeTAQnMstl6o6gzMB6r+R3fC0od+ep3sPbCDDY+xTuw=;
        b=vFrHNq3GboGmNcLzTkJE0HXoO2mAu9L5wiB6X8eml1h1VF8vLzI9KeSDk6IFkI/K
        E2TlZ/Jhix8yX4cALfb6fAtqeoSRi9UjF2uWoIwojIMWyyThYE0W8K/1P1EOOamG9HG
        9M9L57aTPelTmEwTFgklS+fQ1kkjowjmXrFGqNOs=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686057665971364.0299014993585; Tue, 6 Jun 2023 18:51:05 +0530 (IST)
Date:   Tue, 06 Jun 2023 18:51:05 +0530
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
Message-ID: <18890de45a9.592cf481119039.6913148846210954357@siddh.me>
In-Reply-To: <20230606125537.GC25774@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <bff523677c65a4a6b1c06152b154cf5651f51d68.1686047727.git.code@siddh.me> <20230606125537.GC25774@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 1/8] Revert "drm: mipi-dsi: Convert logging to drm_*
 functions."
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

On Tue, 06 Jun 2023 18:25:37 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> Any chance we could prevent this from happening by turning the macros
> into inline functions ?

The next patch in the series almost does that, with a function introduced
as Jani mentioned. The macros will call that function, so if the argument
is not drm_device there will be error.

Thanks,
Siddh
