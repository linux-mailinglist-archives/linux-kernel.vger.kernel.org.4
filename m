Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA946B4D71
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCJQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCJQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:44:40 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46779509A1;
        Fri, 10 Mar 2023 08:42:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 32-20020a9d0323000000b0069426a71d79so3234222otv.10;
        Fri, 10 Mar 2023 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3keoP5JJxcABarNYW93qZLS/wAAzdGHiMT52nWZiSY=;
        b=CO0OjCTqNBrO+ktT5tZYvLuyTpSoHGHuT2uKB4gtoCiLGZy8U/0SUudmpqZO22di7b
         jFq0ezkpqqrT/DZNrnNgNw7cUrefY6UcF0knHLp+vmYre670MN+Rsst5affcK/1K+XFe
         G76j34DznhQoF59SuzEALU5r5Qq5hSWeikD6SoDql0WSVa5myPe1WqlpjZO4p7LzPbVo
         HbHtoCEZL/DW4J9zrwLB0ZGUFZaQTyDjzgTFwzy2RRciHZqeECUofeDfZwrhg7oLhj+8
         b4FcrMAa5Ri1f1ZBWZYezWzYZVG/I/eofO1iFmWHCWfyXq1uC4SXx2HDxNm96Bz41gUt
         TchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3keoP5JJxcABarNYW93qZLS/wAAzdGHiMT52nWZiSY=;
        b=wJR6lYJQSG7jNIC8NGdzPh+i5MWIeDKDdzAZ9Zt7oX4BoKEymD2VgBr/pbU/GxRf0Z
         9HJ9gbGtnt6Sytx1upKhIkn2pJJ1B9gACG1kgL2pWZ22NRZ+RWwF5K4Hb5uT1G9v7qkr
         2RGMpQ49sPDCYiQC9GmuMd87pE/IKUaCaoWhWaGqwHm+sYCwr02muKxQ83GxEw5ADTrF
         7VUZMV7gR8ovZ1KGYYtlE+HGGFXc3w1RgevC1UChH3vaeLWpOdjDid0EyEz21yuzpaui
         RS9yrzLuSof5SIc/zS19iM0/ZnAiquwPyDLulcl0hEskfaBdwjXRgwCfCzsWLYbyGCnT
         jLCQ==
X-Gm-Message-State: AO0yUKWLAtVf0YOyop44DvbZbNLPIXxrr4SJeFJHraRAT9ES8VclKHlK
        AzIYLLSbCRZN28XAgpTn4zcXayWVyLQ=
X-Google-Smtp-Source: AK7set9NuxSiYOEw/98h840vzqmBGy96qEQ6JSjqk2PIyFEbHH51M8b2Tpm8bQu/YjiEzWz2C6f9RA==
X-Received: by 2002:a05:6830:716:b0:694:419f:4b2f with SMTP id y22-20020a056830071600b00694419f4b2fmr12256186ots.23.1678466532324;
        Fri, 10 Mar 2023 08:42:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d725a000000b00684c5211c58sm216283otk.60.2023.03.10.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:42:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:42:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     void0red <void0red@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com
Subject: Re: [PATCH v3] hwmon: nzxt-smart2: handle failure of devm_add_action
 in nzxt_smart2_hid_probe
Message-ID: <6f835ca7-66dc-4df2-814e-ba6d94478f29@roeck-us.net>
References: <f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net>
 <20230227091534.907101-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227091534.907101-1-void0red@gmail.com>
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

On Mon, Feb 27, 2023 at 05:15:34PM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> 1. replace the devm_add_action with devm_add_action_or_reset to ensure
> the mutex lock can be destroyed when it fails.
> 2. use local wrapper function mutex_fini instead of mutex_destroy to
> avoid undefined behaviours.
> 3. add a check of devm_add_action_or_reset and return early when it fails.
> 
> Link: https://lore.kernel.org/all/f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net
> Signed-off-by: Kang Chen <void0red@gmail.com>

Applied.

Thanks,
Guenter

> ---
> v3 -> v2: use local function and devm_add_action_or_rest
> v2 -> v1: split the patch
> 
>  drivers/hwmon/nzxt-smart2.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 2b93ba896..340002581 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -721,6 +721,11 @@ static int __maybe_unused nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
>  	return init_device(drvdata, drvdata->update_interval);
>  }
>  
> +static void mutex_fini(void *lock)
> +{
> +	mutex_destroy(lock);
> +}
> +
>  static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>  				 const struct hid_device_id *id)
>  {
> @@ -737,8 +742,9 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>  	init_waitqueue_head(&drvdata->wq);
>  
>  	mutex_init(&drvdata->mutex);
> -	devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
> -			&drvdata->mutex);
> +	ret = devm_add_action_or_reset(&hdev->dev, mutex_fini, &drvdata->mutex);
> +	if (ret)
> +		return ret;
>  
>  	ret = hid_parse(hdev);
>  	if (ret)
