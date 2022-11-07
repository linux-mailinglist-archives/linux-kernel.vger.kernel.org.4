Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EE61F435
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiKGNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKGNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:22:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260FA1C41E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:22:57 -0800 (PST)
Received: from maud (unknown [184.175.40.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5DA7660283A;
        Mon,  7 Nov 2022 13:22:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667827375;
        bh=ZnFOZyXL8uJEDuix8RxOgFRb6se3qayxtK1aRcf42S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QboKrarDISQxl9/snAAVdfm/ScDLKgrDQlRmxy10aNYWW+ElLweUCVKFFQc8UY+ki
         6r4GEgBYcaGiPYH3dn1GNnEMwuXG5RktG5Qyde+oRm315jvdEcqTe2h6agyfGzlV3x
         F6LRU8Ou+9cwQcPHUvbqanNWVD+QVvK/SAXe2iMXkrwQjLu7syKzOgWsln/L2Q/vpO
         JP7KeGA/TzD5dradJexgYYAuAEE8QbKAYtgruhrf7E8hsMynqo93TCBMylj7skKlQ5
         Ea2fPwpfaU1pMtnyJaa4FNul71WfPbf4wXxgjZPg0DnZ9KL8zp+yjRNshzWCSwPGj4
         9AYyAoM0ma8Jg==
Date:   Mon, 7 Nov 2022 08:22:48 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Remove type name from internal struct again
Message-ID: <Y2kGqIAE7WPYUTKx@maud>
References: <20221103114036.1581854-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103114036.1581854-1-steven.price@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@collabora.com>

On Thu, Nov 03, 2022 at 11:40:36AM +0000, Steven Price wrote:
> Commit 72655fb942c1 ("drm/panfrost: replace endian-specific types with
> native ones") accidentally reverted part of the parent commit
> 7228d9d79248 ("drm/panfrost: Remove type name from internal structs")
> leading to the situation that the Panfrost UAPI header still doesn't
> compile correctly in C++.
> 
> Revert the accidental revert and pass me a brown paper bag.
> 
> Reported-by: Alyssa Rosenzweig <alyssa@collabora.com>
> Fixes: 72655fb942c1 ("drm/panfrost: replace endian-specific types with native ones")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/uapi/drm/panfrost_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 6f93c915cc88..9f231d40a146 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -254,7 +254,7 @@ struct panfrost_dump_object_header {
>  			__u64 nbos;
>  		} reghdr;
>  
> -		struct pan_bomap_hdr {
> +		struct {
>  			__u32 valid;
>  			__u64 iova;
>  			__u32 data[2];
> -- 
> 2.34.1
> 
