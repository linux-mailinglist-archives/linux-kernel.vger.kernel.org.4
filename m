Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F06717D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjARJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjARJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:20:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143D59993
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso847095wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22BxzJ1I2g5CT4PBXC4jtXMSZii+bF3n9yE6J2j4Nb0=;
        b=fzgF8kdyThujN0e3XDBEFEVimxZI9UOjfDV0//Qk1I3gS6KDSAMYQX6VSO6y36WIK0
         42kcpq0vvvcTXiml3K/76AbVpoNxTSyXIvUVZiTysWF51Ft8Mmfo9OsJwxCPvKfWENuV
         z6DrWHId/BUBzgYSH5FHYQs/XEP5U5Thh+I7o+1Fdk1ACrWszVecl/WLe6Z1jOAuYFvh
         oRrALOxAk7XtbHwfEQhZUrr/eZjhoBVU6hHgy0g/ziKm0lNdNfx8liP3Hcr6VN380Dyh
         wyfKNCxK0lM7JuVzer5Fpotyoc6OqqnHT9KcJjcY6Hs/IhL8RS/bkw5R/K6aP6YykmRe
         Guqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22BxzJ1I2g5CT4PBXC4jtXMSZii+bF3n9yE6J2j4Nb0=;
        b=RcepdWGoYquiudwadPaJVj6FJgGLlVFzt2NVURJ4A1a9agtvAhT5yonL+fBLB9YTLu
         eR3jZ0pDL6wMYbKLxfM56eTBIF9Psob/tKe1533nyTfRPkflh6NAyYKor+fUVkDSXpcy
         sxLZxO230QUafecnOuCnwn08GEwHuYFEEueBs8lDKk9a2Km02jl/etaa6rZunPKTlwch
         naq5l2J5htVgIzdzpDZNN+8wQSB56y9zFBsuDHLKoEhopjIua9X1+31nTzfdCvXiG+iC
         TNSnfBNnDU1VGT4mUp3SfUyCpY5Icp4bKeNK7GyVmy+nZpnC0klX41WpM5ryCSvFfU0u
         Y75A==
X-Gm-Message-State: AFqh2krTTv8dVVN83S4047znkOCqMLwh1eNqbWCKxGgI0haF8MsHA012
        Eb5zO6Dtmz1TApiO9beO7KE=
X-Google-Smtp-Source: AMrXdXu8sggmhiVQbHcxiXko3AczajbXLKn7sftHuTG2wPYKrznfm6qkMVy2KgS5TC7GgPHQXwWbgw==
X-Received: by 2002:a05:600c:510d:b0:3da:f6ae:faa9 with SMTP id o13-20020a05600c510d00b003daf6aefaa9mr11167805wms.29.1674031101319;
        Wed, 18 Jan 2023 00:38:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c314600b003d99469ece1sm1297950wmo.24.2023.01.18.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:20 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:38:17 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: gpio: Replace macro
 irq_data_to_gpio_chip with function
Message-ID: <Y8ev+UNO0bQDoZTs@kadam>
References: <20230117152857.22141-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117152857.22141-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:28:57AM -0500, Brent Pappas wrote:
> Replace the macro irq_data_to_gpio_chip with a static inline function to comply
> with Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>

Thanks!

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

