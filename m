Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC617709480
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjESKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjESKJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:09:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041510DC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so29474195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684490977; x=1687082977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJlEOvjOYMzVHa6nkNTyqakYgS1PMcSlu4GwECBSsAg=;
        b=IVx5j+UggibN8TcmUU1ozNMKzNQaoHNCQhDJFR/dFNQVgevyOIMwL5Taw6dhV4lKJu
         OnRQ6UdEgtosHxufuS/2w+qouJ3OJqS6TxVBJ9CftfqbSiNEb4sINRpB4eqehULeIs1A
         +eQLCSMzy9NldqcWwXjNlnGQXhSW2fV+d2sTXFQsLWhqqHlcRDxcFh3rgoLStL/o6SKF
         ubRB3qoxxPPy/VmF459/b8krXol1OXV8JTrf6wh03tHUbsAhdScCb4R4wLk4l2CgnrrU
         l+6URWDZ046rxebSPuFqFis9oWUv+rdE84HVm3fK2ZFPD9mC5MsQ13LD0d8rmel6Sj+o
         7A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490977; x=1687082977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJlEOvjOYMzVHa6nkNTyqakYgS1PMcSlu4GwECBSsAg=;
        b=ZbshDx5VdhARQEJ6sZa08m3egkbpJOczHRr7L9t7wsvT94DcSlwhdvhjPqokhVQzjw
         D2nbZwQyPqI6tmNcIAx5Y29D4BaSw7D5Y0Nm5RcRd7p3TB5Dsy+TWw2nC70bGBvseLAr
         q1AjqQyTo7+WO0d/oOXmTmsnzYQG1dVc0P0+6+40/7O4Hp8kP7NRlBQaJzduHsrri7M8
         REW0k3TuYGebY3dj4bVTC7E89VosXhlZkd0dXEdvwj+stXBffR8VhTMFfRJ61GylBJGl
         Tevfn8GWagLqVo+qRSvp/QbGgkopMExmQ6ZFOIor3D5V4aTmoByQ7/dOiLGm7tWXE+/m
         dFlw==
X-Gm-Message-State: AC+VfDwAZjlk1wJ/mAjG/b/MF9hf82tS8csowtoau259TmV0Mge0g1pd
        H/UDFUVEP9r70UkD9TiixFS5iw==
X-Google-Smtp-Source: ACHHUZ5WGSwQQ7EEO1V31pVH0j2pTxUgl+1Bv1Lk9gY0K2gUi29/J53PK5LFtcZKjUtEBt74c42wwQ==
X-Received: by 2002:a1c:7908:0:b0:3f4:2254:bd86 with SMTP id l8-20020a1c7908000000b003f42254bd86mr999177wme.8.1684490977014;
        Fri, 19 May 2023 03:09:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n8-20020a1c7208000000b003f50876905dsm1920690wmc.6.2023.05.19.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:09:35 -0700 (PDT)
Date:   Fri, 19 May 2023 13:09:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] [PATCH v2] Staging: rts5208: rtsx: Moved else statement
 to same line with else if
Message-ID: <f82a3d65-8c01-4537-9ec6-bd6fca5d84c9@kili.mountain>
References: <20230519100119.25482-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519100119.25482-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:31:19PM +0530, Deepanshu Kartikey wrote:
> Moved else statement to same line with else if,
> this warning was given by checkpatch.pl
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ...
> Changes in V2:
>     - Moved else to the same line with else if
>     - Moved comment on else statement to inside of it
> ---
>  drivers/staging/rts5208/rtsx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Please read my blog about how to resend a patch.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

