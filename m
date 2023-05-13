Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362A701770
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjEMNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjEMNdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:33:38 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95F0AC1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:33:36 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:35296.2125776308
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 7478E1002D0;
        Sat, 13 May 2023 21:33:34 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-2qvwx with ESMTP id 00bb8058f4194826b1ffe8909a1cc8df for 15330273260@189.cn;
        Sat, 13 May 2023 21:33:35 CST
X-Transaction-ID: 00bb8058f4194826b1ffe8909a1cc8df
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <ed8e4fa5-cbda-f1b0-621e-c3bef41405eb@189.cn>
Date:   Sat, 13 May 2023 21:33:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: drm/drm_plane.h: fix grammar of the comment
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230409131547.494128-1-15330273260@189.cn>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230409131547.494128-1-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks a lot


On 2023/4/9 21:15, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   include/drm/drm_plane.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 51291983ea44..79d62856defb 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -56,7 +56,7 @@ struct drm_plane_state {
>   	/**
>   	 * @crtc:
>   	 *
> -	 * Currently bound CRTC, NULL if disabled. Do not this write directly,
> +	 * Currently bound CRTC, NULL if disabled. Do not write this directly,
>   	 * use drm_atomic_set_crtc_for_plane()
>   	 */
>   	struct drm_crtc *crtc;
