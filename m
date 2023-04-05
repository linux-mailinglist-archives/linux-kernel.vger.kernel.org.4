Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C06D7D01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbjDEMzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjDEMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:55:42 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9530FE;
        Wed,  5 Apr 2023 05:55:33 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzcv-3yyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4505:1fdc::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Ps4Ny5fhqz49Q2n;
        Wed,  5 Apr 2023 15:55:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680699331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNlTPAbjdtS26ypADnDdofnih8dcbhDcszLgzK/cR+0=;
        b=bI7FZgFMqo//ViNpPq7jYGOxhp9IesTmsJVAX0Eo5c7D6ga+bpA92xBtBLRiDa9OwVSrtB
        +nTDzTQyID4tjKmyR4TpS6doUA0xu8HagJGnoUI1ngkqbOnCQ0kQXPcLBEg6IUJ4SDciCC
        IP/xkhXdI3xIZg/BGvX14LVBrLDyalGAFndCb2cPuA0SuyamIe/odMhJ4qRDrxga8XD2NF
        1BcP1VNcgLJ/q3W7gBpKWa8Qb2FVAI5Ty3xw5CacKhOpctyoyqJWA6xbewDwXwRm6dj1WX
        gtzqg4asxpRsgZbuV22pRytuzAGrzszawafHtnK6HEEyYK88RKkafZi7jRkL4Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680699331; a=rsa-sha256;
        cv=none;
        b=MrEsYbXqv8x/IMkRuiqwAMNR6s6kHHfREWcaSzHUlSnPlVxxCEFP4SvbobAFIE1KJFwxA7
        EJb0safaC+6u0omwm4fTd2nLoG8cQXPPIgbQUa2ZBgiPUXx4VbqB1BDQrFYGUWOmLB+vwc
        /JGJ9XupAVcHPBvz6jWZrwsE1BYJCmdPavY2J5RbuzuDsRr/W4PY6vJjtCwgsQfCvkaay2
        dhCf9FW/OFifHqghRQ0W4nCY2ldntAk0iM7UOiYRWeYeMvVFG731jAF5W5g3yoRG0k1g0r
        r5tKjqnVCCOMAZQlqdsWfRHlt0rHnW1uNw+QHUKc8ug4lmgGjyP71Dcf+sYzpg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680699331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNlTPAbjdtS26ypADnDdofnih8dcbhDcszLgzK/cR+0=;
        b=O3PXthfiZO+Fw2/XArNmAJKVG3Dgdv2a5dBezMRzTrzIdijwbbllX/PEhcBeeoWKBaL7Ql
        JKzBCk2hJxmd6TJexn04kUM5Tx3zWbMXYwKPqNC5Ei0+6cKRYVaXJa4d8JZhpUaMU0in0Z
        iVjXPu7h+Yw2BTDulmUTZmjZ/0vVDlyiJ61AAFZkg2cxV3fxNYeEUuVzk38jq+ZzGgUS+3
        pUbeU6L0Fonff3Hny5UndBPqIqAyXbyTmpDv1HUbAXLXy6S9teYzedAM3aNsAgQiE4i0KF
        jp47D47tioQ6Yp4vhsfE+qcuInNEXyvv5NbS2OPLVWBRH14qoYGvtiAbO44PrA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 4B2A7634C91;
        Wed,  5 Apr 2023 15:52:53 +0300 (EEST)
Date:   Wed, 5 Apr 2023 15:52:52 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
Message-ID: <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405092904.1129395-2-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> pm_runtime_get_if_in_use() does not only return nonzero values when
> the device is in use, it can return a negative errno too.
> 
> And especially during resuming from system suspend, when runtime pm
> is not yet up again, this can very well happen. And in such a case
> the subsequent pm_runtime_put() call would result in a refcount underflow!

I think this issue should have a more generic solution, it's very difficult
to address this in drivers only with the current APIs.

pm_runtime_get_if_in_use() will also return an error if runtime PM is
disabled, so this patch will break the driver for that configuration.

> 
> Fix it by correctly using pm_runtime_get_if_in_use().
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/media/i2c/hi846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index 5b5ea5425e984..0b0eda2e223cd 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -1544,7 +1544,7 @@ static int hi846_set_ctrl(struct v4l2_ctrl *ctrl)
>  					 exposure_max);
>  	}
>  
> -	if (!pm_runtime_get_if_in_use(&client->dev))
> +	if (pm_runtime_get_if_in_use(&client->dev) <= 0)
>  		return 0;
>  
>  	switch (ctrl->id) {

-- 
Kind regards,

Sakari Ailus
