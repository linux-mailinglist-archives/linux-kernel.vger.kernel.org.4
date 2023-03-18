Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA56BFC16
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCRSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 14:00:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9D1F918;
        Sat, 18 Mar 2023 11:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 110E0B8010F;
        Sat, 18 Mar 2023 18:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FB9C433EF;
        Sat, 18 Mar 2023 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679162450;
        bh=iQv2UWT4vp+zaZRW7O18XPD/QQoMvERRM+QNrfGepGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAYcje2tV8zG2FX9OfYDEBiijUSQbXspknLvLpc1EVQ7Cd2I1a8QS5PP6jYT48tLu
         qgpfHEoAMMpF/sNVwusHmFhY4xgcS+v1nOQqyZWnYc0+CFZFSDccnwNKUZbssrACZE
         pJlYK+B7K/wQc+5o8OINig2YeBUv/SyEIYskuqfKm3MP5SZSlm7xUKOCu9lPUF1fLf
         e/Se8Zu9pN0uG1uRvR1BZZW3MnzQU5kfqykPLmvyYLM2YVQpGx3ERQ0mSNxYI8GXE1
         fRxGz38+Oz5naX5qvQ7eKeRp3vWL6Kb1WTzblLKPpOwEe6ipdtCJ5wRKZcuN8K9wL/
         CSHsWnlSX972g==
Date:   Sat, 18 Mar 2023 19:00:47 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Matthias Benkmann <matthias.benkmann@gmail.com>
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        Nate Yocom <nate@yocom.org>, hadess@hadess.net,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH v3] Fix incorrectly applied patch for MAP_PROFILE_BUTTON
Message-ID: <20230318180047.3pzcep5roaon3nph@intel.intel>
References: <CAK4gqCCk7ipRbZ=LM8Nsj+nE2S6v6QN39ziYSr3d2NmVMHULYg@mail.gmail.com>
 <20230318162106.0aef4ba5@ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318162106.0aef4ba5@ninja>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 04:21:06PM +0100, Matthias Benkmann wrote:
> When the linked patch was applied,

Please refer to the patch as "commit fff1011a26d6 ("Input: xpad -
add X-Box Adaptive Profile button")" and not as "linked patch".

> one hunk ended up in the wrong function. This patch moves it to where
> it probably belongs.

probably? We need to be sure here :)

Besides, please, use the imperative form, not "this patch moves"
but "move what where", please be more specific.

Andi

> Link: https://lore.kernel.org/all/20220908173930.28940-6-nate@yocom.org/
> Fixes: fff1011a26d6 (Input: xpad - add X-Box Adaptive Profile button)
> Signed-off-by: Matthias Benkmann <matthias.benkmann@gmail.com>
> 
> ---
>  drivers/input/joystick/xpad.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index f642ec8e92dd..29131f1a2f06 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -781,9 +781,6 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
>  	input_report_key(dev, BTN_C, data[8]);
>  	input_report_key(dev, BTN_Z, data[9]);
>  
> -	/* Profile button has a value of 0-3, so it is reported as an axis */
> -	if (xpad->mapping & MAP_PROFILE_BUTTON)
> -		input_report_abs(dev, ABS_PROFILE, data[34]);
>  
>  	input_sync(dev);
>  }
> @@ -1061,6 +1058,10 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
>  					(__u16) le16_to_cpup((__le16 *)(data + 8)));
>  		}
>  
> +		/* Profile button has a value of 0-3, so it is reported as an axis */
> +		if (xpad->mapping & MAP_PROFILE_BUTTON)
> +			input_report_abs(dev, ABS_PROFILE, data[34]);
> +
>  		/* paddle handling */
>  		/* based on SDL's SDL_hidapi_xboxone.c */
>  		if (xpad->mapping & MAP_PADDLES) {
> -- 
> 2.25.1
> 
