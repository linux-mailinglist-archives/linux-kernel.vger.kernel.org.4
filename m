Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9E66B26E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjAOQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjAOQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:07:19 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A531353E;
        Sun, 15 Jan 2023 08:04:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n8so21498141oih.0;
        Sun, 15 Jan 2023 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D04CJM4/P5lSZvVChP8Z+y9dpKnG05jyZJaJFC5t9xA=;
        b=mc6+AdIZ186PlrkdUmvrvrg0xNGeupZV4SOjF8IQqQ0Gv2JLd98flOoZ6AS/tb3lSR
         jNPc/5geD5SuFyZPcnbqN2/5Yhk/Zqb9KuXGGP1evyxw3yg4U+ei9v68uRkcRB6Dmg6J
         Qm9JZhvs+wcLk0WiF7Ybhhkwbw0RpJ20HVdIicmHapJ3Uf07NgP5k7woi+GxZoUYNzfx
         zZedeQvxVDENg6u7Nx+TlIA9zPLiln7U+zEP3V2zp+uNPNAeSZj4/rcv4lrwQDm2HaeI
         0R75YchHGaeVgss6ZQ+nu68koVtnSm5YyLduZcQII9KEKrIZuNBz4HB8BEAyb+YsFa8G
         xgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D04CJM4/P5lSZvVChP8Z+y9dpKnG05jyZJaJFC5t9xA=;
        b=CUuYNlcfdXox96bgBVvV3c6rM6lCW77w4zOarZguVsKPAW0HY93tVuuWjMY1TuKmfp
         WpyNjuR38i6wdV2K0O59qqetR91xziD0Ke+lE+hRjx6Yeg6Ug8omTblWSvUR97bwx96t
         vKe8m77o8ffLD5HToJw6f5Qso3dsdbph/3K3lwTIWUsGfN1izobrQU6HJDLymWwvKxN3
         ljIA45sDP+x5uAs29Hpnjyqh2gwEgsumTt9pG+oiOzvlRIKp4ia0ssbjGqZ7AGUUQ/jg
         oc0UJngmwwoxGM7aPOm8UOlJYGu4Hn/Ytt44LSsEI3US0IiQNqSPnKQfl52IFX9HiK7v
         Ynsg==
X-Gm-Message-State: AFqh2ko9rJjxaFgcwXoZxRTvClILT8gVYNuvIfZwiTSD/WTAxOgSnLMQ
        LLrVK38xx+2EO0AkQ7dRY2Q=
X-Google-Smtp-Source: AMrXdXu426fH72t/ib0srJ7xpjgY2wpiBJytVGmrAh+Ta9c1+YMUmaTEDcms6IUp3AiAQfEFmUNh5A==
X-Received: by 2002:a05:6808:2222:b0:363:a27:a336 with SMTP id bd34-20020a056808222200b003630a27a336mr47814966oib.42.1673798673322;
        Sun, 15 Jan 2023 08:04:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9-20020a0568080f8900b0035e461d9b1bsm11669057oiw.50.2023.01.15.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:04:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:04:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (hih6130) fix kernel-doc warnings
Message-ID: <20230115160431.GA1245975@roeck-us.net>
References: <20230113064549.21289-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064549.21289-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:45:49PM -0800, Randy Dunlap wrote:
> Use the correct function name in kernel-doc comments to prevent these
> warnings:
> 
> drivers/hwmon/hih6130.c:164: warning: expecting prototype for hih6130_show_temperature(). Prototype was for hih6130_temperature_show() instead
> drivers/hwmon/hih6130.c:185: warning: expecting prototype for hih6130_show_humidity(). Prototype was for hih6130_humidity_show() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org

Applied to hwmon-next.

Thanks,
Guenter
