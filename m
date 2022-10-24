Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB860B9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiJXURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiJXUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00C150F88;
        Mon, 24 Oct 2022 11:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FA1612E7;
        Mon, 24 Oct 2022 13:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F4C433C1;
        Mon, 24 Oct 2022 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666617295;
        bh=3nE0pujKjkKrAG3Zlhw1YeJuPRfB3mFezLZb6lzLCGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMm2+6OBEsQawTDmuHx79XkDRpx8g9QS54i0VAgQtCk02UkomS95/vMkOooCKFRX3
         xxQEe24yv/tDtsQYrTGmzauMv0Jh6zHqana1EL/TBHlmO6GXulViaDuIlAEYGkafKP
         kqE4fIBr817hQoEx/xF9wYtGawey5ywjjoX7MjRMntvcbUYm0BK0RPqRrLUuuXw2Nk
         nhWxKTcWwM9VEt4aM7KgAIT39FftcsQukjfpyyfLMkVVk5XzPzt3H5NCVm2IIV71GR
         WEwDHsAVQ/xfBG0zYbWT3h7jEZyT/78B/fc3OPRLq/euFmv9sbHup10WXUReRUbepL
         1J6fTEisi4WTg==
Received: by pali.im (Postfix)
        id 060EE82F; Mon, 24 Oct 2022 15:14:51 +0200 (CEST)
Date:   Mon, 24 Oct 2022 15:14:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH 00/22] Fallback to native backlight
Message-ID: <20221024131451.lvkesdg3kvyvbi7n@pali>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
 <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 October 2022 21:58:57 Akihiko Odaki wrote:
> Regarding the second limitation, I don't even understand the difference
> between vendor and native. My guess is that a vendor backlight device uses
> vendor-specific ACPI interface, and a native one directly uses hardware
> registers. If my guess is correct, the difference between vendor and native
> does not imply that both of them are likely to exist at the same time. As
> the conclusion, there is no more motivation to try to de-duplicate the
> vendor/native combination than to try to de-duplicate combination of devices
> with a single type.

Hello! I just want to point one thing. On some Dell laptops there are
3 different ways (= 3 different APIs) how to control display backlight.
There is ACPI driver (uses ACPI), GPU/DRM driver (i915.ko; uses directly
HW) and platform vendor driver (dell-laptop.ko; uses vendor BIOS or
firmware API). Just every driver has different pre-calculated scaling
values. So sometimes user wants to choose different driver just because
it allows to set backlight level with "better" granularity. Registering
all 3 device drivers is bad as user does not want to see 3 display
panels and forcing registration of specific one without runtime option
is also bad (some of those drivers do not have to be suitable or has
worse granularity as other).
