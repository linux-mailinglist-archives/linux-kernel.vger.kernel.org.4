Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E76A9847
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCCNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCCNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:23:05 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F7E3A2;
        Fri,  3 Mar 2023 05:23:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 7BF9820149;
        Fri,  3 Mar 2023 14:23:01 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qQ-QzzLQ2TTo; Fri,  3 Mar 2023 14:23:01 +0100 (CET)
Received: from begin (unknown [77.241.232.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id E58C520146;
        Fri,  3 Mar 2023 14:22:59 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pY5ND-009i2p-1A;
        Fri, 03 Mar 2023 14:22:59 +0100
Date:   Fri, 3 Mar 2023 14:22:59 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accessibility: speakup: remove linux/version.h
Message-ID: <20230303132259.u25cnuh5u6d47koo@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20230303125152.2030241-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303125152.2030241-1-usama.anjum@collabora.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muhammad Usama Anjum, le ven. 03 mars 2023 17:51:51 +0500, a ecrit:
> make versioncheck reports the following:
> ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
> ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
> 
> So remove linux/version.h from both of these files.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  drivers/accessibility/speakup/genmap.c      | 1 -
>  drivers/accessibility/speakup/makemapdata.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
> index 0125000e00d9..0882bab10fb8 100644
> --- a/drivers/accessibility/speakup/genmap.c
> +++ b/drivers/accessibility/speakup/genmap.c
> @@ -10,7 +10,6 @@
>  #include <stdio.h>
>  #include <libgen.h>
>  #include <string.h>
> -#include <linux/version.h>
>  #include <ctype.h>
>  #include "utils.h"
>  
> diff --git a/drivers/accessibility/speakup/makemapdata.c b/drivers/accessibility/speakup/makemapdata.c
> index d7d41bb9b05f..55e4ef8a93dc 100644
> --- a/drivers/accessibility/speakup/makemapdata.c
> +++ b/drivers/accessibility/speakup/makemapdata.c
> @@ -10,7 +10,6 @@
>  #include <stdio.h>
>  #include <libgen.h>
>  #include <string.h>
> -#include <linux/version.h>
>  #include <ctype.h>
>  #include "utils.h"
>  
> -- 
> 2.39.2
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
