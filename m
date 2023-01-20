Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F26675C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjATRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjATRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:51:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970499AA94;
        Fri, 20 Jan 2023 09:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B57A8B829C6;
        Fri, 20 Jan 2023 17:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2F5C433EF;
        Fri, 20 Jan 2023 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674237059;
        bh=EcRsfuo4MLQFoLffhlRTLRURobAOtGtBzMlm0KeV8TY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TiYO+gSX+PZl5Uw0rCYZVcYqP9jEzfVc4e6L0DsrgxFDRGgk65Lv1XAVifucBd7KD
         Szeq9JcfVFaquifPpMMjwYPepNy2k3KHvIPUr26z0+QO8vno2M+Hr6VQv51Fw+Cz77
         qJNrL/H3jX18TGGwux7EFa4DOoZJaYweHTFlzztY7793Pj90Xtk2o+Mtn97u/PhGOY
         dxPAql31f6fDBWM0KodCN7z/SlD6/Mlsl/IUDPtXpuSuuWuNMyZjT3qRtocHYhUhfa
         Febu3AeZ+fPUvwOxZLOrO7iC30k4IEjA6CcX3/+zvOcvdHmPgWVo1F9L3gSgxeWXIM
         2+rDxZb61QXzg==
Date:   Fri, 20 Jan 2023 18:51:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Qi Feng <fengqi706@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
In-Reply-To: <20230109123216.4974-1-fengqi706@gmail.com>
Message-ID: <nycvar.YFH.7.76.2301201849090.1734@cbobk.fhfr.pm>
References: <20230109123216.4974-1-fengqi706@gmail.com>
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

On Mon, 9 Jan 2023, Qi Feng wrote:

> From: fengqi <fengqi@xiaomi.com>
> 
> Our HID device need KEY_CAMERA_FOCUS event to control camera, but this 
> event is non-existent in current HID driver. So we add this event in 
> hid-input.c
> 
> Signed-off-by: fengqi <fengqi@xiaomi.com>
> ---
>  drivers/hid/hid-input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9b59e436df0a..22cca3406b5c 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1105,6 +1105,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
>  		case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
>  		case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
> +		case 0x0ee: map_key_clear(KEY_CAMERA_FOCUS);	break;
>  		case 0x0f5: map_key_clear(KEY_SLOW);		break;
>  
>  		case 0x181: map_key_clear(KEY_BUTTONCONFIG);	break;

[ CCing Benjamin ]

Hi,

so according to HUT 1.3.0, 0xeb-0xef are Reserved for now, so I'd be a 
little bit hesitatnt to but this into the generic mapping, as later HUT 
revision might define this in a different way.

Which devices are known to be producing this?

-- 
Jiri Kosina
SUSE Labs

