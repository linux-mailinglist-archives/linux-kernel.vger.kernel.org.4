Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904BA624093
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKJLBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKJLBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:01:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D672C1D64C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:01:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3114310wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l84LEgQqFAdGVkHqr934QyhT+PG4ypnQNWiowlrSNlg=;
        b=JFjJEvY7H7kKRYvWCxpdFTXRXz+lJzpevJwMtmWpc97TBlQM1tL5nMKQ+BlsUdcgf3
         bMwEHT1X9ZD6dlsFm3EjNxdsrLLGFUNyzQiflVtndRmnddjL2OaUCMNanf3a0gt1JmqP
         FNfpu6k6A1C0IrPNNyD8MNTyinXiUi+MUeSOJ1aLxU+YHkGraW68U88FefRLq7x6t6FH
         h6ZFeUmfzxSjCWzwCfQdgzQZdmEMqz+e6mE47Xx24egAhqy0Ol5fFchAQtzmoLqhLWZ+
         wOKnBxMDvId6iP5RP2O8joZkkwBybrvR9uMaSeo6bhhPFTpF4DVASFVChkXZauy3qAgl
         Rnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l84LEgQqFAdGVkHqr934QyhT+PG4ypnQNWiowlrSNlg=;
        b=Wft8o3HMeDIU4p3MiGQtG9ucGMEUWKU4idJ/HnXdZCqZQcjRwVYCVdV60m3Hzl8x1m
         F5ZUXrduO3WUFZVSq3c5UOFFKRA0bSFRtudNGTAZZN0sErGfOoNAG5JM6dBxYtiuJKMO
         PFDZ7BZ7whlQa4f+uu4s72piHKDoqAdBXHKt5uR6AHaSn0Eyz0sb/4w02zN9pQ4PeuBx
         gsh6ZlXRLhssokIVNYnS8deDH3koYjUW8rRZGFrT7qjXswFHeVkL3sDgvcnxYY5yqKsa
         pogf9jQFUomF5l210X3BZZwzfJxd0KGx9jiv+XkV/iXOKvaoHUO2oP9eITB2fLThEG9m
         mU/A==
X-Gm-Message-State: ACrzQf0A3YOuIx93LiiPBJax4kF/n4Qvnh6avJfjfr1s+1Xbq1ZtyMpD
        UOFEFVcDs5UGJ5FPudGmZUQHkvkX90E=
X-Google-Smtp-Source: AMsMyM7iYwRfhVvSq+Ma2Ov3nq1pe02Ua0Ec0gnqrqH4XeOa+9o23QctpGw9egJLkTuoTZeFL6U7tA==
X-Received: by 2002:a05:600c:c1:b0:3cf:63e3:bd73 with SMTP id u1-20020a05600c00c100b003cf63e3bd73mr42747185wmm.206.1668078065325;
        Thu, 10 Nov 2022 03:01:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003c70191f267sm5153978wmn.39.2022.11.10.03.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:01:04 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:01:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] staging: rtl8192e: replace macro defines with
 variables
Message-ID: <Y2zZ7SXu+Wk6H68D@kadam>
References: <cover.1668075486.git.jacob.bai.au@gmail.com>
 <354847ce7b2f9ea4dc549bf13656192c1db7c231.1668075486.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354847ce7b2f9ea4dc549bf13656192c1db7c231.1668075486.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:35:11PM +1100, Jacob Bai wrote:
> remove marco defines of array length, use variables instead and
> initialize them from ARRAY_SIZE().
> 
> Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8192E_hwimg.c  | 31 ++++++++++------
>  .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 36 +++++++++----------
>  .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -----------
>  3 files changed, 38 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
> index 8920283f340e..ec9e2de4c942 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
> @@ -6,9 +6,10 @@
>   */
>  #include "r8192E_hwimg.h"
>  
> -u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN] = {0x0,};
> +u32 RTL8192E_PHY_REG_ARRAY[] = {0x0,};
> +u32 RTL8192E_PHY_REG_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_ARRAY);

ARRAY is bad name for an array.  It's like saying "int variable_i;"
It just makes the name longer but doesn't add any information.

Get rid of the RTL8192E_PHY_REG_ARRAY_LEN define. Use ARRAY_SIZE()
directly in the code.  This is no need for a layer of indirection and
obfuscation.

regards,
dan carpenter

