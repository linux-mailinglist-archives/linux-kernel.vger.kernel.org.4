Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A57067CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjEQMQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEQMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:16:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5FB1;
        Wed, 17 May 2023 05:16:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64395e741fcso620509b3a.2;
        Wed, 17 May 2023 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684325764; x=1686917764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYx+hQznULbDgHBHhMcBPNNhmUVrymb8gRKQiR95H6E=;
        b=JuvtaHTgZiIUrrs7dw8OnIyUokf4+jrd8bQ7V8AeRtV1bpbvrK99kZ7w7TJI6IqmSS
         qaLvKRg0V2TmFmI6CKjRCJx6KUldEL3N9vK4dN4mzFzVX8pGMxiuKc6PlCj8DG1BGR6r
         QS+slcXDD11htiBu5+PVTekzsgYU1uDuAwFlyQJlMjTxxo2PK9GdyLuggwIYEmu/szEs
         JwmyQ/CnejxMOqepcW0XffvB53LpZV26THX/sOiaf006MHjn5LoyttIuGolEk2gZUmRu
         gJrwlQoFPSL1c5wq0XXe3oi/tplrMGzHWfjQZcRXUxFpqmvwpJoWVF/Tb0u4ZJdPn4P+
         pSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325764; x=1686917764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYx+hQznULbDgHBHhMcBPNNhmUVrymb8gRKQiR95H6E=;
        b=Z7K606fU2EXKFz7EqeMKuZg+LC23C7ZiPgW0CXyarVKxkVW9tPirRuaMqJqqUlrJLM
         4Tk2aRri4aLqw6s96DnmkG6EO7OCmdaTS/PGHfx/hQX6k+rQjsO6r0L9r6/vu3JBXrsz
         KA0IO88Sb6Hy5CMt4rMRmaqk1pnjI8wl2G0kWRXtPB+oEbXAyUE4deneRDoB7fwq+Gah
         +UQ5w23+aYo4j6VfA/egvc/iyv+BiS7g9pSdd5T+EQgkp3nXAwIxsKX0m4lwbUoV4rxK
         EcAr6RBZWY19PuzeNgF4Aw+zN/u+nAkkGLzDCcBzbaUsofAThvogOFb+Y7OiOHZcH0F7
         9GwA==
X-Gm-Message-State: AC+VfDznAwd/d5tFGDlKc7HmhP+PH4JYB67ufm3xmkv4FkTsl8Jrw9Nq
        wEd8Pn8fqY6SAIiQ33eqdgE=
X-Google-Smtp-Source: ACHHUZ5cTnPdAL69Wl3XvxyB46UWDsrusliz/s7CVAloiveaIwzltNt6B2XU/GfdURJimDjaI3DZvw==
X-Received: by 2002:a05:6a00:1acd:b0:645:fc7b:63d6 with SMTP id f13-20020a056a001acd00b00645fc7b63d6mr691016pfv.6.1684325764484;
        Wed, 17 May 2023 05:16:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b0063d375ca0cbsm15043941pfe.151.2023.05.17.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:16:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 May 2023 05:16:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Watchdog Drivers <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrey Panin <pazke@donpac.ru>
Subject: Re: [PATCH 2/2] watchdog: ibmasr: Replace GPL license notice with
 SPDX identifier
Message-ID: <15b47d41-af2c-4eba-9cc2-5f72e6a9f976@roeck-us.net>
References: <20230517072140.1086660-1-bagasdotme@gmail.com>
 <20230517072140.1086660-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517072140.1086660-3-bagasdotme@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:21:40PM +0700, Bagas Sanjaya wrote:
> Replace unversioned GPL license notice with appropriate SPDX license
> identifier, which is GPL 1.0+.
> 
> Cc: Andrey Panin <pazke@donpac.ru>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
