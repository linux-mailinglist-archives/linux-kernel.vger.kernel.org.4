Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B958624152
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKJLYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJLYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:24:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69664046B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:24:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r203-20020a1c44d4000000b003cfa97c05cdso1437456wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mo/HZpj8w38ANVpEVSro9TPOmrz4MXgGYRbhOeboqg=;
        b=Btd6nmuMr4PsvGpdVwfteWzw4NkDlkaneWAUfCD8UO4/JuLHh9wcR+JtHPs+sPRpOy
         KxyTIeppbNF955qujMWbr365v6mdM546i8zMJp3Z1bL51oAY3vyEvfY9QOMWpz8KGKb1
         DYP/mdtmwLipFJeX2f+M4AeSNFiJQLlENqDuTLIDYo5v5lk8nNSoc9+YD+vUTII9noCq
         0H9TOx7I28qDKwNjvlt+iWQMmFkKYq/4EkuBsOmeX7a+EbJ2ETLJFQLuisfEHx1SRB2V
         73oZFS8m6J845TxgIJmkKdyBrikZvSicpAh5dE3A0Sj03nHCwF9SoD4HoqoEtySd0TBf
         BeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mo/HZpj8w38ANVpEVSro9TPOmrz4MXgGYRbhOeboqg=;
        b=553QwjWYTxJan+RtDBMrcbJY+YRvOSYg4+AYrAXexv33JPe474u2ah+x5ADCuWY00/
         GhZjA5ziZoj1/AXdIaSePgSqj+VlIv7z3Et5OmU9cWX9214ZPWD0UrpSxMiyRbTMSI8x
         FKLHphSnyXc5l+yw8/5pK3RhQh9u74arTLqFKCx8t8SPzpj81bv6Ow89sH2OQKmt9Sqq
         sF3bSaGh8WsvsALuoGA21yKQEdkCIPq7Mz5Qbcr6qr+u/zg1Es1xp+v13HFQVYeAjqHp
         nLm16r17Ys+QmD+AQm0Yl27ORFW+i4r0Rpye/g3XXfXMa9dJ8EkjAKjAVxNPwSuJ3409
         TJgQ==
X-Gm-Message-State: ANoB5pl1IiJoiuum9y8JB0NDNtRLbVI7eUo6gU5SPtB5zs4ZPYmx/ZtI
        RwMXGaz/m7XhLJCsg0VuAQw=
X-Google-Smtp-Source: AA0mqf7a4QVTKL4NLbGglhdl2KfKEyVq2aRSN6y8tzERBF/mhOqgcSzHi05o3QOaAIUS6GyjPH/GQg==
X-Received: by 2002:a05:600c:3049:b0:3cf:a985:767d with SMTP id n9-20020a05600c304900b003cfa985767dmr14659772wmh.32.1668079447504;
        Thu, 10 Nov 2022 03:24:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b003b497138093sm5312260wmq.47.2022.11.10.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:24:07 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:24:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] staging: rtl8192e: rename tables in r8192e_hwimg.c
Message-ID: <Y2zfU+Cw0/odYATm@kadam>
References: <cover.1668075486.git.jacob.bai.au@gmail.com>
 <01eb4d9cb22be5f76aa39eedd406577cdfd9f486.1668075486.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01eb4d9cb22be5f76aa39eedd406577cdfd9f486.1668075486.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look at how these defines are used.  Take RTL8192E_PHY_REG_ARRAY_LEN
as an example.

On Thu, Nov 10, 2022 at 09:35:10PM +1100, Jacob Bai wrote:
> +u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN] = {0x0,};
> +#define RTL8192E_PHY_REG_ARRAY_LEN 1
> +extern u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN];
> +#define PHY_REGArrayLength			RTL8192E_PHY_REG_ARRAY_LEN

It's only used to create the PHY_REGArrayLength define.  Layers upon
layers of indirection.  Get rid of the RTL8192E_PHY_REG_ARRAY_LEN
completely just do:

#define PHY_REGArrayLength 1

Except get rid of that as well and use ARRAY_SIZE().

What I'm saying is don't send a v6 of this patch.  Just step back and
try to figure out how to get rid of all this code instead of renaming
the variable.s

regars,
dan carpenter

