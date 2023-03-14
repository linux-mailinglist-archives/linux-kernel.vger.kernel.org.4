Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40E6B8EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCNJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjCNJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:45:37 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D097FC7;
        Tue, 14 Mar 2023 02:45:36 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbTCw5Jj4zyQw;
        Tue, 14 Mar 2023 11:45:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678787133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HT7Vpa6sre4Xn0yAGB8ZJ0sWu2RsYbVe/dXZv3hQru4=;
        b=fBhcWBVA83sV/oqm2ON1ceXtB9m7frwTPQP6dwHBGQhJgjy+nRGPiPGMTwUKVVnhni33jr
        ED9hhOc88ihFDh6DF0dd+vnof0vhzSjOaWMW+HqIgYrn6L3SVrL/Vc3N16UW94hLzfKQQY
        llanqKrFO3QNG5GeD4fvjMz+1/Y6HF8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678787133; a=rsa-sha256; cv=none;
        b=fyl3TDibROs6ncV0aaOuVFwrsdyng7iSI/jH10MheWeXeD7c9rWMP3P37E0MRQ60TXdKRi
        DbsHEAKtgX5+IxWim0/Vz+lTvh/bmf5elkBe/r7eXHHHqwPLiLOudRxcpFuIBBwbRxQsM+
        0G/pUciOn/WNiOgNxx0hNSOe1KzmqwU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678787133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HT7Vpa6sre4Xn0yAGB8ZJ0sWu2RsYbVe/dXZv3hQru4=;
        b=qi3NfpNATkuksD69e2ijn0SzZL1LpcyMQTS2znVAy/REeorlnPUgALEUl9/VuuHCh41Zc/
        OnjufKDTot2RucvH8o9lUYqtqW3cScYaBPjEgC+BC0Ou/u2R06gBSpcfrxIZRQVN4IjwU7
        sfT6Uh4d7V6wPKAyhjED5O/uL0XAV3s=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3E846634C91;
        Tue, 14 Mar 2023 11:44:31 +0200 (EET)
Date:   Tue, 14 Mar 2023 11:44:30 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: admin-guide: Update rkisp1.rst
Message-ID: <ZBBB/pM0WliJUu2i@valkosipuli.retiisi.eu>
References: <20230310024056.59220-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310024056.59220-1-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Fri, Mar 10, 2023 at 10:40:56AM +0800, Jack Zhu wrote:
> Update Rockchip ISP1 driver file path
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  Documentation/admin-guide/media/rkisp1.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/media/rkisp1.rst b/Documentation/admin-guide/media/rkisp1.rst
> index ccf418713623..3eec078c9eff 100644
> --- a/Documentation/admin-guide/media/rkisp1.rst
> +++ b/Documentation/admin-guide/media/rkisp1.rst
> @@ -10,7 +10,7 @@ Introduction
>  ============
>  
>  This file documents the driver for the Rockchip ISP1 that is part of RK3288
> -and RK3399 SoCs. The driver is located under drivers/staging/media/rkisp1
> +and RK3399 SoCs. The driver is located under drivers/media/platform/rockchip/rkisp1

Applied now but going forward, please keep the lines at 80 chars or less.

Thanks.

>  and uses the Media-Controller API.
>  
>  Revisions

-- 
Kind regards,

Sakari Ailus
