Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135CD62D4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKQIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKQIUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:20:54 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F036DCE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:20:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 8C54220134;
        Thu, 17 Nov 2022 09:20:51 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F_4vo_GaCFsi; Thu, 17 Nov 2022 09:20:51 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id CE49D20119;
        Thu, 17 Nov 2022 09:20:50 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1ova8g-002zbq-0j;
        Thu, 17 Nov 2022 09:20:50 +0100
Date:   Thu, 17 Nov 2022 09:20:50 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Yureka Lilian <yuka@yuka.dev>
Cc:     gregkh@linuxfoundation.org, chris@the-brannons.com,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        w.d.hubbs@gmail.com
Subject: Re: [PATCH v2] speakup: remove usage of non-standard u_char
Message-ID: <20221117082050.54uhm54udqatdlru@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Yureka Lilian <yuka@yuka.dev>, gregkh@linuxfoundation.org,
        chris@the-brannons.com, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, w.d.hubbs@gmail.com
References: <20221117001244.212047-1-yuka@yuka.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117001244.212047-1-yuka@yuka.dev>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yureka Lilian, le jeu. 17 nov. 2022 01:12:44 +0100, a ecrit:
> This code is included in the build tools makemapdata and genmap, and it
> expects that libc exposes a definition of u_char. But u_char is not
> defined in either C or POSIX standards, and some systems don't have it.
> Namely this breaks the build on hosts using musl libc, because musl only
> exposes u_char if _GNU_SOURCE is defined.
> 
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> Cc: stable@vger.kernel.org

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

thanks!

> ---
> Content is unchanged compared to v1, but hopefully the patch is not
> corrupted this time and I added a cc: stable
> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4bf2ee8ac246..4ce9a12f7664 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
>  
>  static inline struct st_key *hash_name(char *name)
>  {
> -	u_char *pn = (u_char *)name;
> +	unsigned char *pn = (unsigned char *)name;
>  	int hash = 0;
>  
>  	while (*pn) {
> -- 
> 2.38.1
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
