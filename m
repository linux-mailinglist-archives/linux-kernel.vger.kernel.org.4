Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05956937C0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBLOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:31:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3126FD533
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 06:31:55 -0800 (PST)
Received: from [192.168.2.90] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AAEE6602121;
        Sun, 12 Feb 2023 14:31:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676212313;
        bh=fEBEPh0WiDzaTRIigC1PzyCaHLk+y7JbnWUC2sST6Vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KO+PXvn/Yzo8wluxM+vZde1lSoKsc4/+bCvZtOwLYGSdBj7ze9zLiOWwbfw9HnZk7
         TAZ45UfOi/37FjMMvS3E0lG/fVRcazIQpmhxHZe5hhoc8GRNJMzbGs8Crmtm5E1DTR
         rNMN2hlNwqeZygwuQUyPk6gB0CYuwUeqb8R3ugKXxeJ7hZidRVxdDy7kx7qwoqJun5
         3hDapQwWMaUo7iDqzC7vAtAhdAmR8pXYRmf4bGnfmECTX80T9ol76w6bmiRjjBrgi7
         BMZnjoNTCktGdFnuuAnQiWGIVthjH4q1L1XBLUEbX3v9jRFfyd4d6TXS72veEp2JbW
         DLDvHzC+RspKQ==
Message-ID: <5d5a8183-aebc-6660-9cbc-03950f9b14b8@collabora.com>
Date:   Sun, 12 Feb 2023 17:31:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/edid: Add Vive Pro 2 to non-desktop list
Content-Language: en-US
To:     Yaroslav Bolyukin <iam@lach.pw>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220118170037.14584-1-iam@lach.pw>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220118170037.14584-1-iam@lach.pw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/22 20:00, Yaroslav Bolyukin wrote:

Add a brief commit message, describing a user-visible effect of this
patch. Tell that this change prevents exposing headset as a regular
display to the system, while it will work with SteamVR.

> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 12893e7be..fdb8f0a6f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -200,9 +200,10 @@ static const struct edid_quirk {
>  	EDID_QUIRK('V', 'L', 'V', 0x91be, EDID_QUIRK_NON_DESKTOP),
>  	EDID_QUIRK('V', 'L', 'V', 0x91bf, EDID_QUIRK_NON_DESKTOP),
>  
> -	/* HTC Vive and Vive Pro VR Headsets */
> +	/* HTC Vive, Vive Pro and Vive Pro 2 VR Headsets */

Nit: I'd keep the original comment, or change it to a generic "HTC VR
Headsets" to prevent further comment changes

>  	EDID_QUIRK('H', 'V', 'R', 0xaa01, EDID_QUIRK_NON_DESKTOP),
>  	EDID_QUIRK('H', 'V', 'R', 0xaa02, EDID_QUIRK_NON_DESKTOP),
> +	EDID_QUIRK('H', 'V', 'R', 0xaa04, EDID_QUIRK_NON_DESKTOP),
>  
>  	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
>  	EDID_QUIRK('O', 'V', 'R', 0x0001, EDID_QUIRK_NON_DESKTOP),
> 
> base-commit: 99613159ad749543621da8238acf1a122880144e

Please send the v2 patch with the added EDID for Cosmos VR and the
addressed comments. Thanks!

-- 
Best regards,
Dmitry

