Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA05F59E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJESbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJESbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:31:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91AB7D1E3;
        Wed,  5 Oct 2022 11:31:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so2563172pjo.4;
        Wed, 05 Oct 2022 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=lncrKYF3dhxHA2yeuvS54Ddh1xazf36FsZjmkMxlg6w=;
        b=bTTkW0QLjG4FZ6yAyAIASgkGRVrVz/uorbNdxH5GR7Se2mxXDRsHmPul2YVI5CXIzP
         Wy1cB0KQ0ZSOXZyCHcUq1Y6dwoTB1E0e5P4JtW6W5w95W8vrtPASR2xuNewhKQ2Gv+nA
         GvPFAK9cmK+0nXavBx3B5qVAU/FTQyypYKoih1od4CpelmKhcxF+OqpLU1Gt64gKJI+s
         OlwPwko3/XxBBSQTs4nEWammEGWmJ52sOKkWFM1x35mS4vgSgLSwtpwMzEjsD+fSdpGR
         Rb/lxMReYfeTHyPsG8AD7gy62pNZxAbErIi+bVzilUd7PR6Ytyzm1CYid+arYaULqdMB
         TfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lncrKYF3dhxHA2yeuvS54Ddh1xazf36FsZjmkMxlg6w=;
        b=OmqagrAjF7GW8fxhUaTeMCCh/1EM5Y4hT6uXbx4fdpOtn46+ey8Coe/EVt0P9/s/Fu
         wVXUYuGSLnX50rtNe7YAIepNkpOJ+g0hPtBzqA/ENt7J3aIVLAZrt6xcpwY8yzCqkTlF
         rDp5LevdDWjdg7qavNooiTTYEi+FPmlp2W1cyjwqavvCKzMFm+AET5jBdKO/sSnDLzVZ
         3ieePcms9yBohjRfYx3YGS0xQgqCcWnhCh2ZfaeXbzwMW4nQrrDSNhs4+wJN3pZrfnyR
         URIzjma8B8Wsd1h42SRr0WyLzXDWTWJBOtngkYsgxSV5SvKMD8QrhPVIAJAPGcC3KhBr
         3+eQ==
X-Gm-Message-State: ACrzQf1/fjVmjZ/2BNFXRFjMDJaYgx4RXZ1t9judHJF5Rb9s24fyv3sj
        IQhvY4PrkdYFKo94JyySE9c=
X-Google-Smtp-Source: AMsMyM6WkxKa3ApjrVvd47ddYhDKX3KPYfV6GCvohPT+LmKBuWgfvnAiG0io+O5JvRvTyVpQ+rWmCw==
X-Received: by 2002:a17:90a:9408:b0:20a:6d13:2b1d with SMTP id r8-20020a17090a940800b0020a6d132b1dmr6505892pjo.0.1664994678960;
        Wed, 05 Oct 2022 11:31:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001786b712bf7sm10700207pli.151.2022.10.05.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:31:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Oct 2022 11:31:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (fschmd) Make const arrays static const
Message-ID: <20221005183116.GA2734583@roeck-us.net>
References: <20221005152752.318493-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005152752.318493-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:27:52PM +0100, Colin Ian King wrote:
> Don't populate the read-only const arrays names and watchdog_minors
> on the stack but instead make them static const. Also makes the
> object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/fschmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index 0a77d6161928..e1f426e86f36 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -1083,9 +1083,9 @@ static int fschmd_detect(struct i2c_client *client,
>  static int fschmd_probe(struct i2c_client *client)
>  {
>  	struct fschmd_data *data;
> -	const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
> +	static const char * const names[7] = { "Poseidon", "Hermes", "Scylla",
>  				"Heracles", "Heimdall", "Hades", "Syleus" };
> -	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
> +	static const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
>  	int i, err;
>  	enum chips kind = i2c_match_id(fschmd_id, client)->driver_data;
>  
