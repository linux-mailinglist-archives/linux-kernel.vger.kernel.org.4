Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35762604A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiKKRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiKKRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:18:27 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835425C7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:18:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v8so3320093qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdtI6UbB5wmG++XC226FrHVJyXk+ZL72ipR2W0nf3TA=;
        b=Giscrycg/IhkWuPEtuG9heCQyVPrnRe+weAN1ez6KwWRkl4XDUs+ep9h0/JkNqGYJD
         aTBC8HCMuu53IG5VpoomBrrsz+saMw18YeEVvXfZHETUix4nKrKbRI7F1Tx7et8Nwkpu
         itsjOQHCEM8ikeMYpO9K5k7cPrdtXpYENkLspbPcL4WUrmvrhBHz0yNSsC3CdDkjSdHZ
         4F0DeubmEO7TPkKrtti8ZOTsZ9+BNyNHieLLXjfg0rAOqqUYVNt+JqEciYGqZaPzTj+x
         8UYqMlm2SqkmWzcXJijw0u91Sux0jwpbKRshuWc3C3GFANSxozXYoXwRDVxDqbw3LjOX
         xQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdtI6UbB5wmG++XC226FrHVJyXk+ZL72ipR2W0nf3TA=;
        b=tEYE5PG2uYTi8KfR0erFaUg4e/ABMjaV/TKu9IvT4WG1V1/WfsFzAdfqmI2HfIyRjz
         Lq+9AwlKCuaT9VPHuYacDKDGuNYXAaTBYr7iz8D4Nl1D28T4msX5bAYKhwDWO1M99CAQ
         DCvonr7tZDxEttYmywexJbGeY3fhfcGPkI8yUj/KIsLdkW9Qy7NVyfJxgRMuErz3p7Xg
         SqIHVjJUwSjo9usrjS4k6qChAvlxJV/hDlHQKDb7nrnWHFnEuBNpxteT0un5BfOgi1hn
         AfFTUd4LKHedJiJ3GXkleouUDjBINCcdTiNiQmlkZhE6en5DtvnWRM/eRSrAn5A9pnmG
         YZPg==
X-Gm-Message-State: ANoB5pmfVOnDtTpsZPhCCxlemyjIvTBD+eY6WIqaaPeB47JKUKjvQXnc
        L9kSC+hqH5VCkrFE7zSiPSeCOg==
X-Google-Smtp-Source: AA0mqf5ar8tpYdoEycvL5cWQPm9q7S/RXlRccqGuTlGG243PooULMPf6DBq/Jha+IaL9qpnzFOB7Mg==
X-Received: by 2002:a05:620a:2233:b0:6fa:566f:eb1e with SMTP id n19-20020a05620a223300b006fa566feb1emr1883068qkh.616.1668187103756;
        Fri, 11 Nov 2022 09:18:23 -0800 (PST)
Received: from localhost (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006ce580c2663sm1685659qka.35.2022.11.11.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:18:23 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:18:22 +0000
From:   Sean Paul <sean@poorly.run>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/2] drm/bridge: anx7625: register content protect
 property
Message-ID: <Y26D3pENgEIMu3hc@art_vandelay>
References: <20221102111148.1810314-1-hsinyi@chromium.org>
 <20221102111148.1810314-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102111148.1810314-2-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:11:47PM +0800, Hsin-Yi Wang wrote:
> Set support_hdcp so the connector can register content protect proterty
> when it's initializing.
> 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index b0ff1ecb80a50..0636ac59c7399 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2680,6 +2680,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>  	platform->bridge.type = platform->pdata.panel_bridge ?
>  				    DRM_MODE_CONNECTOR_eDP :
>  				    DRM_MODE_CONNECTOR_DisplayPort;
> +	platform->bridge.support_hdcp = true;
>  
>  	drm_bridge_add(&platform->bridge);
>  
> -- 
> 2.38.0.135.g90850a2211-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
