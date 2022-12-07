Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD645770
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLGKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLGKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:19:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE471C900;
        Wed,  7 Dec 2022 02:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3D63B81B9C;
        Wed,  7 Dec 2022 10:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EF4C433C1;
        Wed,  7 Dec 2022 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670408356;
        bh=jLZ+U5kmw6I+ayqdCVyX/ZyMEbDQAKT2IIZwNUyLMDg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Pv/NdwJ3BMB6i37CUVduOfmNbLnNjKKHdj567ZLh2mbHE7x/NJGoHpf8b5Dit2WGO
         YqTUhzz29EZEP+PWNH+2GNgUx2XZBkvhl3AoxMyK9HBLnQ6LdfTse0qTx0h9TPSmFy
         G+9wlpbnqKiBxj0mtcIkWpV9tXZyUmVVx/hB/Mqww/VflncQNscVVHh4TKBK9XznHX
         8dAblt275LDb+KHmdiqJARWAsApCtOeJJ/GXOswP26xiZ0HYUnw5WUu1aSXe3eepbX
         Z0opIiSMRue2zzxTPw3GPa1OPdYDRXokJf8no7YLssmgjlWP3gCWvBAtYL/zPHaNea
         Iv1gNf4zBgs+g==
Date:   Wed, 7 Dec 2022 11:19:15 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
In-Reply-To: <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher> <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net> <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
 <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022, Benjamin Tissoires wrote:

> Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I am 
> worried that you won't be the only one complaining we just killed their 
> mouse. So I think the even wiser solution would be to delay (and so 
> revert in 6.1 or 6.2) the 2 patches that enable hid++ on all logitech 
> mice (8544c812e43ab7bdf40458411b83987b8cba924d and 
> 532223c8ac57605a10e46dc0ab23dcf01c9acb43).

If we were not at -rc8 timeframe, I'd be in favor to coming up with proper 
fix still for 6.1. But as things currently are, let's just revert those 
and reschedule them with proper fix for 6.2+.

Thanks,

-- 
Jiri Kosina
SUSE Labs

