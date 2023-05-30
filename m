Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9B716209
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjE3Ndd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjE3Nd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:33:29 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E1F0;
        Tue, 30 May 2023 06:33:27 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DF431C0013;
        Tue, 30 May 2023 13:33:25 +0000 (UTC)
Message-ID: <d4d6eb1da42de6536e708331100fc33e9cfae140.camel@hadess.net>
Subject: Re: [PATCH] input: Add new keyboard backlight control keys to match
 modern notebooks
From:   Bastien Nocera <hadess@hadess.net>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 May 2023 15:33:25 +0200
In-Reply-To: <20230530110550.18289-1-wse@tuxedocomputers.com>
References: <20230530110550.18289-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 13:05 +0200, Werner Sembach wrote:
> The old three KEY_KBDILLUM* keycodes don't reflect the current
> situation
> modern notebooks anymore. Especially the ones with RGB keyboards.
> 
> e.g.
> - Clevo NL50NU has a toggle, an up, a down and a color-cycle key
> - TongFang PH4ARX1 doesn't have a toggle key, but one that cycles
> through
>   off, half-brightness, and full-brightness.
> 
> Also, on some devices these keys are already implemented in firmware.
> It
> would still be nice if there is a way to let userspace know when one
> of
> these keys is pressed to display the OSD, but don't advice it to
> actually
> do anything. This is the intended purpose of the KEY_KBDILLUMCHANGE
> define.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Can you please point to the user-space patches (or issues filed) that
would integrate the support for those keycodes, and make the key
presses do something?

Has anyone tested that those keycodes are fit for purpose when mixed
with other brightness changes that don't happen through key presses?

> ---
>  include/uapi/linux/input-event-codes.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h
> b/include/uapi/linux/input-event-codes.h
> index 022a520e31fc2..05287bf9a77f7 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -803,6 +803,10 @@
>  #define BTN_TRIGGER_HAPPY39            0x2e6
>  #define BTN_TRIGGER_HAPPY40            0x2e7
>  
> +#define KEY_KBDILLUMCYCLE              0x2e8
> +#define KEY_KBDILLUMCOLORCYCLE         0x2e9
> +#define KEY_KBDILLUMCHANGE             0x2ea
> +
>  /* We avoid low common keys in module aliases so they don't get
> huge. */
>  #define KEY_MIN_INTERESTING    KEY_MUTE
>  #define KEY_MAX                        0x2ff

