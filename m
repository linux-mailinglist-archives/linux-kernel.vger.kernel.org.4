Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED2682A37
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAaKP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAaKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:15:57 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27874A211
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675160108; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=AnMq+5elFPUhIPHg/lZuIkx2KbX18eyi/w4q9RVOhNH7TpnU/ONgLQVxp90U89axUjmmh8X+VWhKe2raktiSmF3yTmcbk2HRsUN8NM1CyRvLKwhOHDg9/X5bIQYbMELCGU3GH8LO7uOnOg3hWFzM6vmy+C6PIYth3nfPIp2ARKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1675160108; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n92mC6ZuA5G2Jp0m1IQ48fttaRXQ9O8TIQKnESJL3cQ=; 
        b=a2REufaeh+DpT2R0cjEq5Cp+C6ZHOjaQWSIxWz5r8/9Nf+tGDaJdqZ4A3sfRmM2nfk1jtOcR09WZEOmGGKMp7Gmg9/ZLlAFApiPgyoUPqi2mXbve4Wj5QQARwpGWBvqnO9m9ZJpYeNRzxtfm82evExPJvH6HIpCCMtQU6cDdTms=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675160108;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=n92mC6ZuA5G2Jp0m1IQ48fttaRXQ9O8TIQKnESJL3cQ=;
        b=Xz1m4dolZOV3RcJSMWFiHahqu6Rhr9/YiCh2bOyj5na18HaxytQvZTasgm8QQdxJ
        Er3r6X0MyQXshw3Ghi557cyboDC/Jh2fdDSS+RVeVB7lFW60sT+fYXbSmtDn8WBfxn8
        SO46bqDhpaeQ5gaoD0Jq6e7+SxbsUSrA43s0CDPQ=
Received: from [192.168.1.9] (117.97.173.26 [117.97.173.26]) by mx.zoho.in
        with SMTPS id 1675160107680903.5041974356834; Tue, 31 Jan 2023 15:45:07 +0530 (IST)
Message-ID: <1393b9df-f234-04c7-0471-1012b54aadbb@siddh.me>
Date:   Tue, 31 Jan 2023 15:45:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <cover.1673269059.git.code@siddh.me>
Subject: Re: [PATCH v6 00/10] drm: Remove usage of deprecated DRM_* macros
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <cover.1673269059.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 18:30:25 +0530, Siddh Raman Pant wrote:
> This patchset aims to remove usages of deprecated DRM_* macros from the
> files residing in drivers/gpu/drm root.
> 
> In process, I found out that NULL as first argument of drm_dbg_* wasn't
> working, but it was listed as the alternative in deprecation comment,
> so I fixed that before removing usages of DRM_DEBUG_* macros. Courtesy
> discussion on v1, I added support for NULL in drm_()* macros too.
> 
> This patchset should be applied in order as changes might be dependent.
> 
> Please review and let me know if any errors are there, and hopefully
> this gets accepted.
> 
> ---
> v5 -> v6:
> - Move drm_device to default case in _Generic as it is the default behaviour.
> - Fix incorrect const drm_device handling in _Generic.
> - Minor positioning / comment changes.
> 
> [...]
> 
> Siddh Raman Pant (10):
>   drm/print: Fix and add support for NULL as first argument in drm_*
>     macros
>   drm: Remove usage of deprecated DRM_INFO
>   drm: Remove usage of deprecated DRM_NOTE
>   drm: Remove usage of deprecated DRM_ERROR
>   drm: Remove usage of deprecated DRM_DEBUG
>   drm: Remove usage of deprecated DRM_DEBUG_DRIVER
>   drm: Remove usage of deprecated DRM_DEBUG_KMS
>   drm: Remove usage of deprecated DRM_DEBUG_PRIME
>   drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
>   drm/drm_lease: Remove usage of deprecated DRM_DEBUG_LEASE
> 
>  [...]

Hello,

Please review these patches, which I sent more than 2 weeks ago. Note
that the last three patches have been already merged. Lore link is:
https://lore.kernel.org/dri-devel/cover.1673269059.git.code@siddh.me/

Thanks,
Siddh
