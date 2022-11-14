Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EF62874C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiKNRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiKNRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:39:50 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CE209BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t8qh4oUGT/30GoOcmL2v+OUkSFJCDzN2hc5A8Ni9aGI=; b=Fy6WVKVTT/BBOCITGJzqSozrOF
        PB3IrU+voTRHoPhWZH9k8MrFMMJ+oIAtE9Y1vCbPXhvq6AQnirI7LqNXAMq1Og6u8V7w4eA/5qbEI
        EY7DFxE9q1pppCf8BMiMiHE5vEPBSe5ZHKgGCDXTQACPUkG7CgTrJJqREHsOBsgF0cygFwUu7kqrJ
        lvlNTmQwXh1kkAySEguXUsFDelzOwLVblCSq0zAHmAcsBpgDxXWyn+5iVTFpyfeyQMAnSoap/Pkf4
        PZdDUT+cnpvqwNc1e73pKFjouJ9hjl35rPilHjaokvKePufHHxbp2yUWkSQ/AuMHeDalYmYFcvtCS
        q2UJ7/BA==;
Received: from [2a01:799:95e:1700:c981:e728:c113:ea41] (port=57803)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oudQw-0001hO-0M; Mon, 14 Nov 2022 18:39:46 +0100
Message-ID: <6c9aec32-f260-9df1-7fb7-1240bfff7f6f@tronnes.org>
Date:   Mon, 14 Nov 2022 18:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 01/25] docs/fb: Document current named modes
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        nouveau@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v9-0-24b168e5bcd5@cerno.tech>
 <20220728-rpi-analog-tv-properties-v9-1-24b168e5bcd5@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v9-1-24b168e5bcd5@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 14.11.2022 14.00, skrev Maxime Ripard:
> KMS supports a number of named modes already, but it's never been
> documented anywhere, let's fix that.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
