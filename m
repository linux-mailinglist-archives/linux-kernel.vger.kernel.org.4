Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2B628BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiKNWRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiKNWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:16:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69F1A202;
        Mon, 14 Nov 2022 14:16:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so31827797ejc.4;
        Mon, 14 Nov 2022 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjLI2FcjyN69i2elF7u5dbs6bViyjvCGIV41wLE1z4I=;
        b=gSoPitTFxFGGK4rA5UkjrBSbLyBmOXhPgxb3+eI0dOrbHgjTpZL3GrOQycEkxT9Esf
         6O0SFRSpkFIZZsQ9WX81PEvRKmfPGjeOeiZ88e8RZV1+i4FXFRyLAY8kF6pX9XK9Uh98
         6+QnNNizoQRzKTpxK8ix/yFNqIvrKf+e8x7AVntyMumtjUtBAV6RY30Oppcet4tdnqn+
         M7j9bCF59ODuUPzc6x2t4J0FsTEbna4XgpIVk6sBPfN+UGRBnl9tUJ0jag3xFAICO0Qu
         iAJ7JHDeRmS+JQgTFAIXKRSZLPkRhWc3e3FjWbKJ0r5YaJJ2zk8bhQqqpU6B+eL7lwR5
         sWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjLI2FcjyN69i2elF7u5dbs6bViyjvCGIV41wLE1z4I=;
        b=LjkadQO2L5TCVCiUTSjqtDoIY8ytoHWFJ9TQx9bqGFeMR/vhUtwp3AxEJRifL2OAY6
         pg1AzaEmULtCZGwHpt/pr66SfjLr+ZLyScI2EIUton8weAWb8QfPo+dRLVSIlQ6Wyc9R
         +PGwoFCpHiblogfJ9LUUCzW0bMe/Nzs7aKIPTmXMOCMFCUOvlzxzD8skzFYolG4JgWdE
         wQbd3jPegoBWVLaLyTfmXO47ZdZ6Vi+7m0Cqjg+qxs43IU/p6+eZhovjI/ar62eSuDOd
         lFrSQ5/hwI7H0vU97Bt/JaYtKqT6mhVFpp62VKJjlqtWsk0Hzxbn+2OFAshTlqHQM2eb
         vsRQ==
X-Gm-Message-State: ANoB5pmOS17VCZUU0XYmSD/Nf7NnV4PY0932D+a/xL0uO8TUqAAu0Ior
        edq45XIuKhT796OJ2TCO/GLzrcaIeiY=
X-Google-Smtp-Source: AA0mqf6JdiQzvjH4eK5ZK+Uuu+5I4TJjjOBWIO5F66uTTmWevEDKDnOoQbyQ1WdKJTg1uO4GHrhQuw==
X-Received: by 2002:a17:906:6d8:b0:7ad:e82b:b66b with SMTP id v24-20020a17090606d800b007ade82bb66bmr11801221ejb.453.1668464200220;
        Mon, 14 Nov 2022 14:16:40 -0800 (PST)
Received: from localhost ([46.211.249.127])
        by smtp.gmail.com with ESMTPSA id gv28-20020a1709072bdc00b007af75e6b6fesm269646ejc.147.2022.11.14.14.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:16:39 -0800 (PST)
Date:   Tue, 15 Nov 2022 00:16:24 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mundanedefoliation@gmail.com
Subject: Re: [PATCH] hwmon: (nct6775) add ASUS CROSSHAIR VIII/TUF/ProArt
 B550M
Message-ID: <20221115001322.31d4f44d@gmail.com>
In-Reply-To: <20221114214456.3891-1-pauk.denis@gmail.com>
References: <20221114214456.3891-1-pauk.denis@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch is tested with "TUF GAMING B550M-PLUS WIFI II".

I have checked other boards by comparing methods implementations in UEFI
firmware's from ASUS support site.

On Mon, 14 Nov 2022 23:44:56 +0200
Denis Pauk <pauk.denis@gmail.com> wrote:

> Boards such as
> * ProArt B550-CREATOR
> * ProArt Z490-CREATOR 10G
> * ROG CROSSHAIR VIII EXTREME
> * ROG CROSSHAIR VIII HERO (WI-FI)
> * TUF GAMING B550M-E
> * TUF GAMING B550M-E (WI-FI)
> * TUF GAMING B550M-PLUS WIFI II
> have got a nct6775 chip, but by default there's no use of it
> because of resource conflict with WMI method.
> 
> This commit adds such boards to the WMI monitoring list.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Reported-by: yutesdb <mundanedefoliation@gmail.com>
> Tested-by: yutesdb <mundanedefoliation@gmail.com>
> ---
>  drivers/hwmon/nct6775-platform.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-platform.c
> b/drivers/hwmon/nct6775-platform.c index 41c97cfacfb8..50fe9533cf43 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1043,7 +1043,9 @@ static struct platform_device *pdev[2];
>  
>  static const char * const asus_wmi_boards[] = {
>  	"PRO H410T",
> +	"ProArt B550-CREATOR",
>  	"ProArt X570-CREATOR WIFI",
> +	"ProArt Z490-CREATOR 10G",
>  	"Pro B550M-C",
>  	"Pro WS X570-ACE",
>  	"PRIME B360-PLUS",
> @@ -1055,8 +1057,10 @@ static const char * const asus_wmi_boards[] = {
>  	"PRIME X570-P",
>  	"PRIME X570-PRO",
>  	"ROG CROSSHAIR VIII DARK HERO",
> +	"ROG CROSSHAIR VIII EXTREME",
>  	"ROG CROSSHAIR VIII FORMULA",
>  	"ROG CROSSHAIR VIII HERO",
> +	"ROG CROSSHAIR VIII HERO (WI-FI)",
>  	"ROG CROSSHAIR VIII IMPACT",
>  	"ROG STRIX B550-A GAMING",
>  	"ROG STRIX B550-E GAMING",
> @@ -1080,8 +1084,11 @@ static const char * const asus_wmi_boards[] = {
>  	"ROG STRIX Z490-G GAMING (WI-FI)",
>  	"ROG STRIX Z490-H GAMING",
>  	"ROG STRIX Z490-I GAMING",
> +	"TUF GAMING B550M-E",
> +	"TUF GAMING B550M-E (WI-FI)",
>  	"TUF GAMING B550M-PLUS",
>  	"TUF GAMING B550M-PLUS (WI-FI)",
> +	"TUF GAMING B550M-PLUS WIFI II",
>  	"TUF GAMING B550-PLUS",
>  	"TUF GAMING B550-PLUS WIFI II",
>  	"TUF GAMING B550-PRO",

