Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1B5FA945
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJKAY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKAY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:24:56 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDF175AE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:24:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id A8B0420166;
        Tue, 11 Oct 2022 02:24:51 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PG3SXhi9Mn50; Tue, 11 Oct 2022 02:24:50 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id AF3E920165;
        Tue, 11 Oct 2022 02:24:50 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oi34k-007ZK6-37;
        Tue, 11 Oct 2022 02:24:50 +0200
Date:   Tue, 11 Oct 2022 02:24:50 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Yureka <yuka@yuka.dev>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: remove usage of non-standard u_char
Message-ID: <20221011002450.d25x3gvgu5snsozm@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Yureka <yuka@yuka.dev>, w.d.hubbs@gmail.com, chris@the-brannons.com,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b7e4894-deec-39ba-bb7c-3c6d6427fa1d@yuka.dev>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yureka, le mar. 11 oct. 2022 02:17:43 +0200, a ecrit:
> From: Yureka Lilian <yuka@yuka.dev>
> 
> This code is included in the build tools makemapdata and genmap, and it
> expects that libc exposes a definition of u_char. But u_char is not
> defined in either C or POSIX standards, and some systems don't have it.
> Namely this breaks the build on hosts using musl libc, because musl only
> exposes u_char if _GNU_SOURCE is defined.
> 
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4bf2ee8ac..4ce9a12f7 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
>  
>  static inline struct st_key *hash_name(char *name)
>  {
> -   u_char *pn = (u_char *)name;
> +   unsigned char *pn = (unsigned char *)name;
>     int hash = 0;
>  
>     while (*pn) {
> -- 
> 2.37.3
