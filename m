Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053EE724A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbjFFRah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbjFFRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:31 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D11706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686072586; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ZBSRFyICfOJrAcbRS5ORpYDf/ZvmdQpGrrec0bsZ2FJdcsyJXUE8xRytUpTsCX5SsMRW+E3s0SVhULHG30B0s4EWPxzmn1ieFbHo0b19RlltKA4xT6q/XIqrRMZGar+UV8NnSE9ph3gLGuNWHdoilXjYVz0bOuEN0WhL7BppfEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686072586; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Q/lg2cuY9NfgatGsJ+3rhXij7qz4ZMKGJ048y4n18ho=; 
        b=ebPE5QpqZN3hB41JtLPa/Zw6XzxhKqADJq52bkLv3+INKbkNUVlTmheCpt8wGDid9s9EWOjYdamQ3dhd+FBH0p4VLoQX+sbUI8epXFkOGhGsRH0MVG6OfqV2TrIiHGoQ5cS5MJ4i+ddcxdLWWn+DMgi9IQ9Fcr21Y0re3S6COL8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686072586;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Q/lg2cuY9NfgatGsJ+3rhXij7qz4ZMKGJ048y4n18ho=;
        b=cSGdymNuimMWKCBoUWJU2pAg1Wutx0Tu3ZnqguRGfluPTAsaElSoix60vvHg3LJq
        DRW9y6u1r+VXHnktx7PhnELnoa7+V5PZwr7fvgrW122GbCEYqgDzi/UdlJT8q6o8PT2
        A0sppKyz9AU5laiSKfPzx5KlEkgY6pvMHvb6RKfs=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686072554600520.406666699926; Tue, 6 Jun 2023 22:59:14 +0530 (IST)
Date:   Tue, 06 Jun 2023 22:59:14 +0530
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
Message-ID: <18891c17458.393a54b1127185.1502341592143085000@siddh.me>
In-Reply-To: <20230606150545.GJ5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me> <20230606150545.GJ5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 0/8] drm: Remove usage of deprecated DRM_* macros
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

On Tue, 06 Jun 2023 20:35:45 +0530, Laurent Pinchart wrote:
> This is a nice series, thank you for working on that.
> 
> Now that the deprecated macros are used in drivers only, would it make
> sense to move them to a drm_print_deprecated.h header, to make sure no
> new driver uses them ?

Sure, but then should that header be included wherever drm_print.h is
included with a find and replace, to avoid breakage?

Not every file can be seen at a case-by-case basis or by coccinelle
as far as I understand its usage. Consider the following:

DRM_INFO is used on line 210 of amd/amdgpu/amdgpu_acpi.c, but the
file does not even include drm_print.h directly. It includes the
amdgpu.h header, which includes the amdgpu_ring.h header, which
finally has the "#include <drm/drm_print.h>" line.

If a simple find and replace has to be done, then that can be added
at the end of the series.

Thanks,
Siddh
