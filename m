Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF31E5F453D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJDOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJDOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:15:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F98BCA3;
        Tue,  4 Oct 2022 07:14:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so18726644pjs.4;
        Tue, 04 Oct 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Q0eGf4H3HQEZvc34OQHmLUIB2H2lco3lblwGNYzvq6E=;
        b=cpe93c77jhYjWIY1o4kQCmI0FJgY+d1vHh75r7bHQymNYwNInghBgNB5Lb5FCqU9K3
         s6DyPxAi5MOo6rp3ZPSlBAbzkaKec92iN0lFBzA7rGoPApTh1rp53fYnOe0N29Kowkl6
         Mdy+yUpIoXhrS/kzWSVALKhEn2lMhoRV0eJ0IfXO9fkHog1iY+LADlRhQ0R/gMYpHEy3
         rxh5hquYWxwV51Ci7wPeTZ+JhSmsVJS2bhHKqOO0QwOTxDg8umY7iv+ngAK3kgSYrluj
         vxARpCi83zVasFgu+EcJxY+EQUT+5gw3eWn8fWNE+xEuRYdwq/5xZXeWkWrR/wh7jkik
         hvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q0eGf4H3HQEZvc34OQHmLUIB2H2lco3lblwGNYzvq6E=;
        b=el2cMCiwI2bTVAeWrfYUbg7J2xCzbYZUXGmC0zuZmjng0A4SgDnrg2Z1zx3Zdz8Sm6
         +vbxu7VtkbyuXE1H+PIPtIx93102dEZa6qWbFRD8Srmr30jXI2TknF0MpC3PJJK4hp08
         7F9Vr8fERYEpCs2Q/hm0+M5FXwyyHh9HHA/fD/3zJ7QHQ8n4NVBE7zO3Pqo4ApkVWDKE
         f/HOwu+j4+aEMNiRyWk5xJfoXMQVLekVjEyTL0ZHP0nf7CIuHb34fVP2olvB5ROPf2ur
         x1gX4Lw1hqhFBOsFQFnN6COaLJdZq8xuAHB/O5V6NPKUhKIL77CTM8FfNaFawtj0yUx4
         KtCg==
X-Gm-Message-State: ACrzQf0CKSaHFDsUo3PnGTmWDy6ap9ZceuKIkxWfff9G1iy5NIS4/L+f
        93SH8tOtzMs0E1fQqFJnhQs=
X-Google-Smtp-Source: AMsMyM4TGsq6C14TubP0NXUQesEI+mBAPXYiXNIg88omuMKjBDyFpdTZuK2fcfL+rWXpa20azPCiiQ==
X-Received: by 2002:a17:902:aa89:b0:178:a537:f386 with SMTP id d9-20020a170902aa8900b00178a537f386mr27371481plr.124.1664892897898;
        Tue, 04 Oct 2022 07:14:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d190-20020a6236c7000000b0053ae018a91esm9576747pfa.173.2022.10.04.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:14:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 Oct 2022 07:14:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 4/5] thermal/core: Move the thermal zone lock out of the
 governors
Message-ID: <20221004141454.GA1746997@roeck-us.net>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
 <20220805153834.2510142-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805153834.2510142-4-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:38:33PM +0200, Daniel Lezcano wrote:
> All the governors throttling ops are taking/releasing the lock at the
> beginning and the end of the function.
> 
> We can move the mutex to the throttling call site instead.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/gov_bang_bang.c       |  4 +---
>  drivers/thermal/gov_fair_share.c      |  4 +---
>  drivers/thermal/gov_power_allocator.c | 16 ++++++----------
>  drivers/thermal/gov_step_wise.c       |  4 +---
>  drivers/thermal/thermal_core.c        |  2 ++

This doesn't drop the lock from drivers/thermal/gov_user_space.c.
Is that on purpose ?

Thanks,
Guenter
