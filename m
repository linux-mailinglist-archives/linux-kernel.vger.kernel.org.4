Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471E5FFABA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJOPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJOPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:06:53 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373D1658E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=77Lg64p8/R9tZGnndPHn4KfYVzEjBmwCzK3REgaXQZg=; b=WdSHCzhebt6a0zY62k6qLC7maU
        y32Bsd5HeiRDzxYhM4aO3D20oVR3eyk6uPZUUuvR4ktUUodELPeLuQCXC1jANhIdAha0TGvIhTDkm
        SiWTSroNGWy+f1AbcD537ZagDXn02umkC0F2OEHDE5kjFhmm3m+j0Ep17pjG2ha7xsIof2yHv5aA2
        hJEUeoxHfaT0vGQEpZDOlRMqyCQEKm5z600AfoRg6+a1YRPADp4/tk3Pz+vMMBgZ0nSVbPjMosIrY
        qHOLLS8bAYY1G73LAlmjToAX9lZ09pU4pS9vEeFwYn4Yj+PLccK4zZgBEFANtS53qZtq+sEDln8fE
        Tob5zQTg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:65061 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ojikU-0000is-0q; Sat, 15 Oct 2022 17:06:50 +0200
Message-ID: <c6a8cac1-c566-af3c-d274-35195964f980@tronnes.org>
Date:   Sat, 15 Oct 2022 17:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 01/22] drm/tests: Add Kunit Helpers
To:     Maxime Ripard <maxime@cerno.tech>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-1-d841cc64fe4b@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-1-d841cc64fe4b@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 13.10.2022 15.18, skrev Maxime Ripard:
> As the number of kunit tests in KMS grows further, we start to have
> multiple test suites that, for example, need to register a mock DRM
> driver to interact with the KMS function they are supposed to test.
> 
> Let's add a file meant to provide those kind of helpers to avoid
> duplication.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
