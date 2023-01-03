Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669DF65C8D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjACVVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbjACVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:20:42 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFE25D4;
        Tue,  3 Jan 2023 13:20:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r205so28122732oib.9;
        Tue, 03 Jan 2023 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQ5DgIZp2LNRHGnV5119ejH3FHQfg8orunYV5dxZUwg=;
        b=lGzMjBMmEm+VKtnN4eRtRV1jhtiPuLrLrkDecLzNk7oS6FzucgOZI/DD0ppdZOGLTe
         tDxId8GFaITzzvyX4u1KU+Uo6Dah7biR07G3B0CxQdFGqKNru4F3Bxbwq86FU1kUI5aU
         /x2lBB6zh/KYujcHkEgj0zSaH+7NFQEvJxctB1B/YcMMVaDtS5NqrX4pxZs6FbnvF3Oe
         /CEgc7km1kKdeJQzX4LoXwr9G1cUBrV7bRyUQMsKpnJsjUV9n1XAcCnNqeGvCneMD3Lw
         vOK1l2n2ZJcYComSaXd90+ajnJA0TDtdOejxqkCNYJVwQ4sXRSFAQRF/mcb/6Oe4EHYR
         u4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ5DgIZp2LNRHGnV5119ejH3FHQfg8orunYV5dxZUwg=;
        b=CniFNizooaivdTqun/uoH03jf1FLfHeTwY4hXwrNEV1iCGFzC0Ist6nLDjKUSUZzdL
         va6PSaC1wUaa9bx7bwueQEWv9mvzMe2s6+IUJoCljQplbF39Wtww2B/i6zqIq5NhUWRa
         DQiUU83TaCl8phqRKiHrb1D76cHl571QWh8JTfCAxlZ0YdSc1e8N95yB0ISGrnkbx7Rz
         8KKLGz2zceC/SjwS5klfMvSQh2te4HRdwLD3xXiadtSI3zqOzfcRfpCF9JtNU/7j26Wy
         KZpSiwv1ChS9tlatAf+iE7VX6VaUWYIcwLX41W6kAUJlyNDy4Q90b1LGiGqU/qp6yI57
         DJ/Q==
X-Gm-Message-State: AFqh2kpRFjVNI2fEo1CbHra8meJP3RQxut8v/hBRtZ0ErB/FF1WlFZ4a
        9i+DWtGYkoJLZqeeSU1K0RU=
X-Google-Smtp-Source: AMrXdXsST4t4vw+A5mz7awfpHJ7k2T5wXuMDorH4jWe/WG83p4ztpH3pY6MzKh6VbcdQeqfqdu1arg==
X-Received: by 2002:a05:6808:114c:b0:363:995:eb69 with SMTP id u12-20020a056808114c00b003630995eb69mr26987203oiu.0.1672780839553;
        Tue, 03 Jan 2023 13:20:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c20-20020a544e94000000b00360f68d509csm13418823oiy.49.2023.01.03.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:20:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:20:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Denis Pauk <pauk.denis@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) Fix incorrect parenthesization in
 nct6775_write_fan_div()
Message-ID: <20230103212037.GA213138@roeck-us.net>
References: <20230102212857.5670-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102212857.5670-1-zev@bewilderbeest.net>
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

On Mon, Jan 02, 2023 at 01:28:57PM -0800, Zev Weiss wrote:
> Commit 4ef2774511dc ("hwmon: (nct6775) Convert register access to
> regmap API") fumbled the shifting & masking of the fan_div values such
> that odd-numbered fan divisors would always be set to zero.  Fix it so
> that we actually OR in the bits we meant to.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 4ef2774511dc ("hwmon: (nct6775) Convert register access to regmap API")
> Cc: stable@kernel.org # v5.19+

Applied.

Thanks,
Guenter

> ---
> 
> This bug got noticed during review [0] and the fix was incorporated
> into v3 of the patch series [1], but then I somehow managed to
> accidentally revert the fix in v4 [2] that actually got applied.
> 
> I'm fairly confident this is correct, but I don't have any nct6775
> hardware to test on (this code path is only used on that specific
> chip, not others in the family).  If any one who does can try it out
> and report back that would of course be welcome.
> 
> [0] https://lore.kernel.org/linux-hwmon/YiiMfJV3bjUmoUcV@hatter.bewilderbeest.net/
> [1] https://lore.kernel.org/linux-hwmon/20220426071848.11619-3-zev@bewilderbeest.net/
> [2] https://lore.kernel.org/linux-hwmon/20220427010154.29749-3-zev@bewilderbeest.net/
> 
>  drivers/hwmon/nct6775-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index da9ec6983e13..c54233f0369b 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -1150,7 +1150,7 @@ static int nct6775_write_fan_div(struct nct6775_data *data, int nr)
>  	if (err)
>  		return err;
>  	reg &= 0x70 >> oddshift;
> -	reg |= data->fan_div[nr] & (0x7 << oddshift);
> +	reg |= (data->fan_div[nr] & 0x7) << oddshift;
>  	return nct6775_write_value(data, fandiv_reg, reg);
>  }
>  
