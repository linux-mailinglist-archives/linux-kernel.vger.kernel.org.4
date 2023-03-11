Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E956B5BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCKMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCKMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:39:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907E2B29D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:39:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p4so1222983wre.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678538373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5ymF9kHOMLefiz12Rv98z0NE1tYU6jJ7RUypvP5at8=;
        b=hzC9H8UxblqYsyDYYldUy71UHauWYeyuts9a8n4EThQhv5UC9NU8Qtz1oiLRy+sDRZ
         4g0KEk59TObxpk+ZRf1jhAzazA/X7abc6oRFbwdrzGOGqsBNpJdutw8wk1KWe0hSV8DT
         Em6unX0jZwpsjdmZ8dxCbxs6iP+jORwrXGGjD7UfJwO5mHcqYLTyda8Ti/lpntuXFKxj
         j4iUNJD5B8pcE6li8tnjuoHBJ5SFaF1UK7GTVhNQiVqczODwq/lYP+PbdTjRzLoi1Dpb
         W/4zNed8Z0io9MZXrtwgb3gk+3u3eGEw+Zgl43xamtofMx79BeqHxKQ2krIwalSLdrFN
         74dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ymF9kHOMLefiz12Rv98z0NE1tYU6jJ7RUypvP5at8=;
        b=YM852Txu0ZNN6cK4rICJwm0iPfwdq4wH3/OmjFTGqClrN1ERb6WVrg81DC49yUyAck
         siQb68MYw0UU/HPFFb6eaFZA1iryzsUD56R8gn5Nj38p9Ceg3usd5zrvE4D2o29W6Khe
         kHIBpFWHKRQ05qRgVxZOAXU6fNAied/23f9Aa1fsIdVRe2a4zwiFnAIBNJ/HByoAacM6
         NC9merxlDjW5p2QWA4s8Pi2ZGJwYR/wR/EwRA0wqnl1JXGGwLBzThTh1QKc4oaNaSAkn
         FvohAVZ5z9i+Z3eb3kFIhVka7gRzkKfp6JGwkqVxGA1V8EOMXjmtA8h+pxRrsZ7bvKdu
         1ltQ==
X-Gm-Message-State: AO0yUKWW57pl/pgZBD4yh4b/NLJsCFF3r22NoYQYSDft+yzfaZA6+RLH
        1M2E7U9Zm7+mYOHX57w7nis=
X-Google-Smtp-Source: AK7set95Bp+Ah6AoER0cNsasdr8Hl3ZBhIu0SL0nSrVtjCEuu7Dd8p4QxUaM3MdHn2HgezDdd9QawA==
X-Received: by 2002:a5d:4a51:0:b0:2c7:778:5da6 with SMTP id v17-20020a5d4a51000000b002c707785da6mr18782112wrs.42.1678538372768;
        Sat, 11 Mar 2023 04:39:32 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d6a86000000b002c3f03d8851sm2448270wru.16.2023.03.11.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:39:32 -0800 (PST)
Date:   Sat, 11 Mar 2023 15:39:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
Message-ID: <b9d62635-b968-4dfd-aa10-e34e38a114a5@kili.mountain>
References: <20230311122346.GA21752@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311122346.GA21752@ubuntu>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 04:23:46AM -0800, Sumitra Sharma wrote:
> Change bit_rate type from u16 to u32 inside struct pi433_tx_cfg to
> support bit rates up to 300kbps as per the spec.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---

That's not right.  Read this for more information:

https://lore.kernel.org/all/?q=pi433_tx_cfg%20bit_rate

regards,
dan carpenter

