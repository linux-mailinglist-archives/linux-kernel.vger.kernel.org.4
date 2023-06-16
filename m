Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4F7331A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjFPMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbjFPMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:53:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566A35A4;
        Fri, 16 Jun 2023 05:53:21 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 673C46606F7F;
        Fri, 16 Jun 2023 13:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686919999;
        bh=GD0IQ3bhv9H+r+p7Yfv5LbZuqKXlGbz71alNC7YkYMc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=isDh7gwjFWlLuMygCaXLjfhXMuk28dQ13Khrla1nAYTWsNPuMBt08xbpnc1OBYaeF
         7gYKqCu4C8W7pMY5U3tKimX4bnp6slSokcjUXNS4cOktrmTuJQUOEoAdfGFAXwDwAl
         fYQVj7qY++aIii7qr3EAQ6Hj95U4oZ2q21VSExxSxTW4iFMZHdrXmKWnDuy5gmHTVm
         0s8UvD33C9+v+DHB7dgYJ685iVXaLS0y1YAjcoi/F9SLPq8YjbfiCzwxfuCcWMH2R7
         PcjyuwMC9oJ2CuetUlPr2N6VumasNqj+OcEan6AG5tRR5qVgv3/qUbWgrEzZaBYg10
         NdAOrNx+pAQwA==
Message-ID: <fb6121fc-101f-0779-b752-ac8202eb761e@collabora.com>
Date:   Fri, 16 Jun 2023 17:53:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accessibility: speakup: remove linux/version.h
Content-Language: en-US
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
References: <20230303125152.2030241-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230303125152.2030241-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft reminder.

On 3/3/23 5:51 PM, Muhammad Usama Anjum wrote:
> make versioncheck reports the following:
> ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
> ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
> 
> So remove linux/version.h from both of these files.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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

-- 
BR,
Muhammad Usama Anjum
