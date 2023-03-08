Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB996B0057
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCHH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCHH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:58:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A192BCD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:58:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r18so14478223wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678262316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftAkY/HAGWtPCN42i8FnBrPED03jDD/hiuSkO/UJIE8=;
        b=EnB3/ts3oG7afKJNMAGj9b0Rj3KVKl/ymfjBm1l2KtLvnEiMUTFeRfmWDKTkguMqIm
         B4sKebVI0QwfaYwm4TV/kGzgbxLNlCaP65LZunLkt+ZgI+XZkwyItnCAlmpOaNoLFiD5
         icu/aaw60mX4QJHCbMbfp+16z8jD/myfbeQjuUylRwcXEHwTBDcSmxTuamTL83W1qNLu
         Xw0gc7aYX+tzBPl7QPM7Wv0yZH3ieMK+wke2V16w0tgKex0RpPRXx+cuEgFEN7Q4q1Pe
         X1K18nNHMaRGbqp8AsyCjy8utjvjv0Wv8jvGMsjoQdMKBsz4M719GiKxCvRy/4MLV8wG
         p11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftAkY/HAGWtPCN42i8FnBrPED03jDD/hiuSkO/UJIE8=;
        b=CCIam1f6nEWyGNTU7zg/RX/sC26ZS6NCDOoYicfm2n2arwWB3+7qqHCwSRR/E74HNX
         1gFrQBWf8V7ZROvaiMZ2NRWuz/+opNIh+g+MaCAQFoKDJl19YlomkaBI2fb0SQ6sFQMo
         /mQi+Rcl4qy4MK4Fe5kzk+7XfqjOddWFTd7GMj9Dn9uKbbIMcJgZ0AZaHjsyR0QQYJ5j
         LktLVHHf3ebidAR6F/0pIP2k3kc7Ol3VjXPlhXzWzHJ6kTY9Dzfdz6jGf2/frPUrhU/F
         c+YtLtbwC+oOSMT40P2ej8pX4K5qo26wnVCkPJtnOyzJI/8JEtGvSyN6picyl7pshVPA
         38Ww==
X-Gm-Message-State: AO0yUKUXuhJPwZc8snKvPbxlqmd9+D0lDcmbDggtiNQ9OaKFtH0R0jEC
        C/azDuMWPpvVFm3NufBiwOVXON8c5BE=
X-Google-Smtp-Source: AK7set8SW3QHYbwXotcXcSpGeoafSW3v8MoqXi0Lx268197z+LenVKqaA21glL+GqJf4mKDEYA+75g==
X-Received: by 2002:adf:dec8:0:b0:2c7:454:cee3 with SMTP id i8-20020adfdec8000000b002c70454cee3mr10386981wrn.7.1678262316282;
        Tue, 07 Mar 2023 23:58:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4e07000000b002c5694aef92sm14530016wrt.21.2023.03.07.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:58:35 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:58:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8192e: Remove unused Array
 Rtl8192PciERadioC_Array
Message-ID: <5c6eae1d-1593-40c1-96b6-8dcdf0b0799c@kili.mountain>
References: <cover.1678222487.git.philipp.g.hortmann@gmail.com>
 <ed1e0df7ed677c335340f42c1108e7b5c0f18462.1678222487.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1e0df7ed677c335340f42c1108e7b5c0f18462.1678222487.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:01:06PM +0100, Philipp Hortmann wrote:
> The array Rtl8192PciERadioC_Array is only used in function
> rtl92e_config_rf_path which is only called in function rtl92e_config_rf.
> In function rtl92e_config_rf a termination condition for the loop is set
> to priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH = 2. The loop is only
> executed with numbers 0 and 1 for eRFPath. So the function
> rtl92e_config_rf_path is only called with eRFPath for 0 and 1 and never
> with 2 that would make the "case RF90_PATH_C:" be called. Remove
> resulting dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1->V2: Changed argumentation in the description and subject

Thanks.  This explanation is very good.  I was expecting that the issue
was in a completely different place so this explanation really helps a
lot.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

