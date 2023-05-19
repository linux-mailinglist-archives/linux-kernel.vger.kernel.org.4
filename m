Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908D67098EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjESOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjESOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:02:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1319F;
        Fri, 19 May 2023 07:02:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso5351604a12.0;
        Fri, 19 May 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684504949; x=1687096949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gU4fcWRkdVVZk4e/xekN0dbe8Liasg2vpN9d6LWDIj8=;
        b=kJm180i1UBge3gCR83fkSzsqYvJz6RKG1c3LFKtZrdUPhIJ1/Wq441ACbP/jR900yG
         ny+2UGVO5J8HvdoGenH0Q+3/Y/teP4bg/rn09UgRa8cK5BdGjBFSQfto8RffY5uKzAoy
         crpwxTnLz2Lbp+SNBI6Ssl1EapvepZIDdFrZ7aXAjRRQJ3w8Vg0WfjbRRSoQ+WwB6WaV
         nv5ERlypqOCiDHS/I6D+ky/2zYmBNhS75bXVSLtme0lWgZ7pv5bpMqnQpR1RKPu6J3Vw
         qIHWTddAL4rrBseYrhl80a02T4erlhoMUNj3gcNUml+nUCfbjcNSO/BzjbrDzwGDzgC1
         LooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504949; x=1687096949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gU4fcWRkdVVZk4e/xekN0dbe8Liasg2vpN9d6LWDIj8=;
        b=hAYDqOJwbphTe0MyNORs6hn4eL6AzXkAbnbA79+k8Pl/tvkr+ZwDwzL9DW0JR4C7Nh
         Zn3B/tbQC9sGJ15i/RRg6HDzdMDxtZxNF1VibbYXIG/xFsPBteF9eevZcRgP8MsbSE6K
         TIMhpI9MtZ9Ugz9k15rJF58t130xORn85XPSv/cJAk2Eud+FElENX66Xt3+yZbzr9KIx
         ONOrHgpj9QahI29wBu4j68zGyktFizm3Hqf3nmALMNRDCOFSABFZjLAOlG3GJYUjClzd
         mHtZImqxCxvdinhcdZxok9ruIl1QUUWJOjMJaHrK/QHas0YDvAATI54YAJnZNBLN8+r4
         pzMw==
X-Gm-Message-State: AC+VfDzjqFRvI2Ggs65xlmGfizTPRQEycO+cR7Pk+kCMR7RT9PFEdo9r
        lF33Gtmp4DeI3iL+gSr9yjc=
X-Google-Smtp-Source: ACHHUZ5+6O6UimiC9BuTzXStBnJe+Pv1drzr+y3ZimksVFDewJX9nt59+m8oKxUJFw2oCmxRAA/UDg==
X-Received: by 2002:a17:906:fe04:b0:94f:6627:22b5 with SMTP id wy4-20020a170906fe0400b0094f662722b5mr1547950ejb.47.1684504948627;
        Fri, 19 May 2023 07:02:28 -0700 (PDT)
Received: from [192.168.0.28] ([87.116.164.240])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7d493000000b0050dab547fc6sm1681516edr.74.2023.05.19.07.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 07:02:28 -0700 (PDT)
Message-ID: <587c9c16-db0f-3b92-915e-23ceccf1d8b8@gmail.com>
Date:   Fri, 19 May 2023 16:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        main@ehvag.de, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer
 Leakshield
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230516164213.7938-1-savicaleksa83@gmail.com>
 <50a17124-7bb8-4868-987a-08d4988747fb@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <50a17124-7bb8-4868-987a-08d4988747fb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 14:56:24 GMT+02:00, Guenter Roeck wrote:
> 
> This would have to be a separate change.
> 
> Guenter

Will move into separate patch, thanks.

Aleksa
