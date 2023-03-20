Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC84E6C24B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCTWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCTWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:20:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B791422E;
        Mon, 20 Mar 2023 15:18:51 -0700 (PDT)
Date:   Mon, 20 Mar 2023 22:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679350723;
        bh=o3rHxuelXGHhbZLT3puM4t2QwI8ieM4f9hCEpkd2x7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2reE3iqWE65Cu3wi6FN404ud8pPLFJPp68BPB827YQTPENqV2UwGt8/C2dyawaJ4
         U2w37eSUt0V2xwfZO6aEH4PWJ9uguAOGPUDQFsb42K2NXEDSgbUBuNROV3KCwZkSbO
         VbKWH+DUTYLXSut7xVJMvvn0rEKnUg8liAvwMwno=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: explicitly include linux/leds.h
Message-ID: <7fb9e268-189a-47d5-8737-310d9b6f0f35@t-8ch.de>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping,

this seems to have fallen through the cracks.

Thanks,
Thomas

On Wed, Feb 15, 2023 at 01:03:33AM +0000, Thomas Weißschuh wrote:
> Instead of relying on an accidental, transitive inclusion of linux/leds.h
> use it directly.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (4):
>       HID: steelseries: explicitly include linux/leds.h
>       HID: lg-g15: explicitly include linux/leds.h
>       HID: asus: explicitly include linux/leds.h
>       HID: apple: explicitly include linux/leds.h
> 
>  drivers/hid/hid-apple.c       | 1 +
>  drivers/hid/hid-asus.c        | 1 +
>  drivers/hid/hid-lg-g15.c      | 1 +
>  drivers/hid/hid-steelseries.c | 1 +
>  4 files changed, 4 insertions(+)
> ---
> base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
> change-id: 20230215-power_supply-leds-hid-f99a0a3fd2bf
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
