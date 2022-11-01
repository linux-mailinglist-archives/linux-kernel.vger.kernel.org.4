Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8F6151D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKAS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAS67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:58:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054571C933;
        Tue,  1 Nov 2022 11:58:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u6so14409602plq.12;
        Tue, 01 Nov 2022 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqgGYNiRUBQpbFO9gD8v/2mrLdOYGMPFEirI6ZSs87g=;
        b=HJJXTszBeabJCT3UH77BoqQsPO9yKZ1VJmkW5UxQGQDIbzFAPq0Z7mYtaJkpcPNCpr
         Q/syUcoenNxN5RbLOpFWzxxc7wXIzIH3uWXLu9ZOKt1O7BpFM81DI7hIPqFFPoAMoCU7
         2/USqJ8AxBuD46j6PWs6Fbogm4c9xAl78D73E1nwjjULZY4VbLGsw4a1YQrdaNjeaxHP
         uEVswBUUrmaek9nE4Dywa+YkXKrfZRxA9DEWX3CWG1vqPKprnHC2Rza5A0YYirAxAilt
         Y26W5KU/ufXb5iN6qYG142w0asxCEcyQc7U6iCtUXebA78S75tYAYQtcie+47oe2mXRL
         /jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqgGYNiRUBQpbFO9gD8v/2mrLdOYGMPFEirI6ZSs87g=;
        b=p3M7TsUBvL6J3XZC0/qYVoTpO6cyym6u4N80Dc77k5BX2Kcv6s3FQ124WNUt5GuZyE
         jFX3kjBrBZ49/+Wq7j6s8e2HRWcoe6h04bo5tdizYJNmhuym/ELOlwPM4xaSussqS7SM
         Y/Hb/tZYpwMhaxCk5s88oHarguSToOK2XwRCFA4JGYq08pUT2nNuv2re+0mH9Er8V8F0
         SPX7Gbo6DEceLEronivTmVHXamie3jai8Ie4n+CxbShL9T9N8L0JaiGyEBMnwhOxMfHE
         Do+BxRQjN+yCluvGYBGPF0Js2840eAAYuESeyUX/Mc8G4s93TywroWpV2/sl1EBVCeku
         eQUA==
X-Gm-Message-State: ACrzQf1EPy/iyelbTTaQt3BEIG0aiglIomqfsJF0huXSwscN9ZAJxWJm
        OYqtkDaAq1vsazkhdBHp5fUeqDLhHx0=
X-Google-Smtp-Source: AMsMyM7y3K02KULzlK5H2zB9uy/LMzaZg2eJA2R7koJzmxuDSpipihzu2kXlq9rdG8mH5nzyFemLDQ==
X-Received: by 2002:a17:90a:f2cb:b0:213:9afa:d13a with SMTP id gt11-20020a17090af2cb00b002139afad13amr21267818pjb.180.1667329138323;
        Tue, 01 Nov 2022 11:58:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id c137-20020a624e8f000000b0056cee8af3a5sm6810127pfb.29.2022.11.01.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:58:57 -0700 (PDT)
Date:   Tue, 1 Nov 2022 11:58:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
        wsa+renesas@sang-engineering.com, oliver.graute@kococonnector.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <Y2FsbufV00jbyF0B@google.com>
References: <20221101081458.8119-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101081458.8119-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Tue, Nov 01, 2022 at 04:14:58AM -0400, Bo Liu wrote:
> Fix the following coccicheck warning:
>   drivers/input/touchscreen/edt-ft5x06.c:756:0-23: WARNING:
>     debugfs_mode_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE

This is not a great justification for a change. Could you please update
the patch description to document why DEFINE_DEBUGFS_ATTRIBUTE is
preferred over DEFINE_SIMPLE_ATTRIBUTE?

> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 9ac1378610bc..a184425b6985 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -753,7 +753,7 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
>  	return retval;
>  };
>  
> -DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
> +DEFINE_DEBUGFS_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
>  			edt_ft5x06_debugfs_mode_set, "%llu\n");
>  
>  static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
> -- 
> 2.27.0
> 

Thanks.

-- 
Dmitry
