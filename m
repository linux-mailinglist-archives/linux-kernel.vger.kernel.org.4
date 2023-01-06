Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A765F858
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjAFAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjAFAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:52:06 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A392DC4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:52:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id C21AD20176;
        Fri,  6 Jan 2023 01:52:02 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CXxScuYzd18E; Fri,  6 Jan 2023 01:52:02 +0100 (CET)
Received: from begin (adijon-658-1-86-31.w86-204.abo.wanadoo.fr [86.204.233.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 157DA20172;
        Fri,  6 Jan 2023 01:52:02 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pDaxl-000k0r-25;
        Fri, 06 Jan 2023 01:52:01 +0100
Date:   Fri, 6 Jan 2023 01:52:01 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] speakup: Fix warning comparing pointer to 0
Message-ID: <20230106005201.h3ikdaisqgjupavc@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Yang Li <yang.lee@linux.alibaba.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230106004114.72589-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106004114.72589-1-yang.lee@linux.alibaba.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li, le ven. 06 janv. 2023 08:41:14 +0800, a ecrit:
> ./drivers/accessibility/speakup/utils.h:39:15-16: WARNING comparing pointer to 0
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3636
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4ce9a12f7664..db00c962f8e2 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
>  	else
>  		snprintf(filename, sizeof(filename), "%s", name);
>  	infile = fopen(filename, "r");
> -	if (infile == 0) {
> +	if (!infile) {
>  		fprintf(stderr, "can't open %s\n", filename);
>  		exit(1);
>  	}
> -- 
> 2.20.1.7.g153144c
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
