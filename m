Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05385BCCB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiISNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiISNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:14:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8619DE8B;
        Mon, 19 Sep 2022 06:14:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so27875656plz.7;
        Mon, 19 Sep 2022 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=sIdX+KvJzSz8VQO2i8+nyP74m6V2LlUV6kWGw0Al+eo=;
        b=JHQ0nnC79SidXusB5KgASHgTs0CPClKpYMR0m+2M3VxKN5Xv1YkoRDqe8LERjDFPx/
         XYUT5anRgJRpsS4bcDLPeEQmpIC8DtsKZZHjN5tRq+tJMXA3XdCj7u3qcOrX/rQwfdLU
         W+plCryOdLwAgDlD7ktpQoCAkbtWiyLpEUDQ6WxLFSDvL4cdDEPb7vmC/J/2eQxtjF99
         bM+Br68Lac5NuSpesaToLh5e3QuDKabvBmuLA4dup3ZgLB7tlJITI5vAtTBy3lG6CFv0
         W6czAwRlUYakMJeAbBNKWGmDV/JkEfyNhrwYd15ocEhtcmysDJFIbd5EYzX5TdemBf0j
         lnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sIdX+KvJzSz8VQO2i8+nyP74m6V2LlUV6kWGw0Al+eo=;
        b=hPXNjeoG8Fdca/wzz4C1DBsfUgu1MWCESTjLsVPTJ2RlYBQ1hd8gcCg3x3yzP6Cmfv
         +qSLd8IyFpppKnZhV86Zve6xQ8ymVhy649qoo62NZBaVSpjkUBlaMkAFoaKnX2am4hs5
         a/r2DlgBOasMZuDiPdQvgPDk1a3t+62XiUprPPL2l9iwekyN3AAtEGbEKIQy/nyZck64
         7xmFhsgITntKyvEczaz6j6iZm/79rHAwEc8P0idAb71o6PtDc6zx5xziT74zkEm5AIwc
         VT+H07EheaaKP0gd8Fngxfn5BqcAA5oAkZgmMAQ98djsm6QnL4R6L66zUvaYT2mQP3G7
         9ovA==
X-Gm-Message-State: ACrzQf0zKt5PHH00DuybZ/se1+qZWgKQLfj0ad95hD/Xg+LHrqYYLRLq
        usLqsgmlHAQnd6ju/5Nqa5U=
X-Google-Smtp-Source: AMsMyM5+CZ26gFhgHzgxwgFP5yjvQAsUI9ehnhJLDcb+Gssm42XcEIPVwinU6iM+MSqMZImRVlcJvw==
X-Received: by 2002:a17:90b:1b4c:b0:202:c1a3:25ce with SMTP id nv12-20020a17090b1b4c00b00202c1a325cemr31516220pjb.232.1663593295278;
        Mon, 19 Sep 2022 06:14:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d70900b0016d1b70872asm11895663ply.134.2022.09.19.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:14:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:14:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix Quadro fan speed offsets
Message-ID: <20220919131453.GA3546413@roeck-us.net>
References: <20220914114327.6941-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914114327.6941-1-savicaleksa83@gmail.com>
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

On Wed, Sep 14, 2022 at 01:43:27PM +0200, Aleksa Savic wrote:
> The offsets for setting speeds of fans connected to Quadro are off by one.
> Set them to their correct values.
> 
> The offsets as shown point to registers for setting the fan control mode,
> which will be explored in future patches, but slipped in here. When
> setting fan speeds, the resulting values were overlapping, which made the
> fans still run in my initial testing.
> 
> Fixes: cdbe34da01e3 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 3ea25edfc7a5..c51a2678f0eb 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -120,7 +120,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
>  static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
>  
>  /* Fan speed registers in Quadro control report (from 0-100%) */
> -static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 };
> +static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 };
>  
>  /* Register offsets for the High Flow Next */
>  #define HIGHFLOWNEXT_NUM_SENSORS	2
