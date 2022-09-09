Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455B5B3864
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIIM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIIM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:59:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA77812F229
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:59:09 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14E21DD;
        Fri,  9 Sep 2022 14:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662728348;
        bh=xFRSY8tVoameCWzacI7aRsh6R639BWApE28Feq41gbM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bd0xFClhil6KZxVzPRmJc1X51xuvyUPf6rAshbJsJkcV2RZzPeuady8UPOEGDIJO1
         fM54hVUOcn9h8uMNhPwvVKAJuwUb29XQ2/2M0ABOQn2axv0syoch5qRplIEhd3m+Hh
         aIe4+TwTFrclWk6HhMaIxYLY07al0Updjn05HsP8=
Message-ID: <9c8ff7af-7456-0fa4-ea9d-0182472a18b1@ideasonboard.com>
Date:   Fri, 9 Sep 2022 15:59:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/tidss: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, jyri.sarha@iki.fi,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220824130450.41703-1-yuanjilin@cdjrlc.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220824130450.41703-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 16:04, Jilin Yuan wrote:
>   Delete the redundant word 'to'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>   drivers/gpu/drm/tidss/tidss_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
> index 666e527a0acf..7de3a5ffe5bc 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -71,7 +71,7 @@ static int tidss_atomic_check(struct drm_device *ddev,
>   	 * changes. This is needed for updating the plane positions in
>   	 * tidss_crtc_position_planes() which is called from
>   	 * crtc_atomic_enable() and crtc_atomic_flush(). We have an
> -	 * extra flag to to mark x,y-position changes and together
> +	 * extra flag to mark x,y-position changes and together
>   	 * with zpos_changed the condition recognizes all the above
>   	 * cases.
>   	 */

Thanks, applying to drm-misc.

  Tomi
