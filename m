Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08C6833B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjAaRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjAaRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BD589A5;
        Tue, 31 Jan 2023 09:19:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550A2615AE;
        Tue, 31 Jan 2023 17:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D8EC43444;
        Tue, 31 Jan 2023 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675185570;
        bh=4IqIsKwBqbWVPULwcClTlVG1Iry0wqy5rU9YNE2nIUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIHWNdb0Z2FqrlmWPc9Opv1g+sS/ff67HAUmSOgCZWwEBDX1zQBDsdsQ2KAtGFSi3
         +B95jSJO78whgicFGtqc/H6q0BJ72KeP24SCtEF5oXgOMij4wcwSZzLUK7Apnx7AYo
         c+4dGZ/7AJYRoDklPCYqBEnIC9eoNkh/qafJ2ty6kC5CdNJfSjXgCOg8ETN8N1bQiM
         LTAbOtg4XvCMHtDQeVYjfh6hJMud4lhOag167Z/upj8RZAebAnLKhbpD9x1v2HEdd1
         Bs1iWClAv1MjnrorGEYHm0RIWyh8PJ6q+qm7BEPb5yUOCLo/8hrmuKlamCrpIvLgFx
         kmZ/Fi3fN1GCw==
Date:   Tue, 31 Jan 2023 17:19:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Pavel Machek <pavel@ucw.cz>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH v2 0/5] HID: manually unregister leds on device removal
 to prevent UAFs
Message-ID: <Y9lNnOA87fCt0hFk@google.com>
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> To: Jiri Kosina <jikos@kernel.org>
> To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> To: Hanno Zulla <kontakt@hanno.de>
> To: Pavel Machek <pavel@ucw.cz>
> To: Lee Jones <lee@kernel.org>

Not entirely sure why I'm receiving these?

> To: Roderick Colenbrander <roderick.colenbrander@sony.com>
> To: Sven Eckelmann <sven@narfation.org>
> Cc: linux-leds@vger.kernel.org
> Cc: Cristiano Giuffrida <c.giuffrida@vu.nl>
> Cc: "Bos, H.J." <h.j.bos@vu.nl>
> Cc: Jakob Koschel <jkl820.git@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Roderick Colenbrander <roderick@gaikai.com>
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> 
> ---
> Changes in v2:
> - dualshock4: Clarify UAF
> - dualsense:  Clarify UAF
> - dualsense:  Unregister multicolor led controller
> - Link to v1: https://lore.kernel.org/r/20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it
> 
> ---
> Pietro Borrello (5):
>       HID: bigben_remove: manually unregister leds
>       HID: asus_remove: manually unregister led
>       HID: dualsense_remove: manually unregister leds
>       HID: dualshock4_remove: manually unregister leds
>       HID: sony_remove: manually unregister leds
> 
>  drivers/hid/hid-asus.c        |  1 +
>  drivers/hid/hid-bigbenff.c    |  5 +++++
>  drivers/hid/hid-playstation.c | 10 ++++++++++
>  drivers/hid/hid-sony.c        |  8 ++++++++
>  4 files changed, 24 insertions(+)
> ---
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> change-id: 20230125-hid-unregister-leds-4cbf67099e1d
> 
> Best regards,
> -- 
> Pietro Borrello <borrello@diag.uniroma1.it>

-- 
Lee Jones [李琼斯]
