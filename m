Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910696BFA0D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCRMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:31:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B239CD9;
        Sat, 18 Mar 2023 05:31:26 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o14so3480700ioa.3;
        Sat, 18 Mar 2023 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679142685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuuhWqM52yUbART6GQd7rB0mc4mEDKGLzARz87TDztY=;
        b=Hyi2z5Uo0uZRcM00fORNt4Him0EUFNQE8eOU6bWJnmrD8QQjGPdy932c2qqOm7dKNF
         ijgeYLcYlzlIucaCE3Y7iJ1Kbcv3Avx+QLi2Hmd6Dde+zFZ3yh8UX0KGRhy9AHyoepzW
         6VMXIGYVETj5IbbRjMLdsgtkYlMN/aj2gcK5OYI+SF2Vqhc2N7kH6xKx9xhxDkixwhb1
         wGddnN+xmi188dH4asEua4PbgyV4XBysJSIrVsXIYMXRUfgIfeLaDmZP+vSUsuvfsgt0
         H2NK1KkBd2SfAR3Bj6G9obeOeuFc8AWfJq5w/KFFIuJOvDgNcKn6TipfjJ59aPtvkmr8
         CUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679142685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuuhWqM52yUbART6GQd7rB0mc4mEDKGLzARz87TDztY=;
        b=sHcRvJDJHgRmy7Sc0BjeGupuUcHUt/wgrJaMt2g3zWFe+M+b+CyfvPEC7w6Fuvkyt0
         lwgtAqk1cYgX82yya7WgwqtRLR5BUj+sxUK4BYztN4smSqOelw4QTFOztlO+583dhIwB
         QPr6RpNH/+PJbiH/yJ4A6M1VGFOJhmCkL1pUZ1KatPIyZnZtYgEgA/Z2u6ScIByIwyG7
         oJB4KRHzu3jjXIKMq4HBOpz7QYTTdI74EaGlG98Y76YebYJmwQKKWeHxFZ8DZu+Kesoq
         rJ38I8I1M5A8vatgKRcgQYQ72zUOuw28qRWgIPFT0bkWltwJtulmhCUDbEnXHh2n2k4U
         FX9w==
X-Gm-Message-State: AO0yUKWoRSEao21v5Nuirm7y+nXlUATC1RBF/XJQc3lBAykn2WVP47tZ
        ASqJUOOTHNBxzTo7QbWif1g=
X-Google-Smtp-Source: AK7set/atEcgQLXFE6mT4gP/KnPpU0c7sEgKvH9r2cNq0fyx3DLvVNeZ3hnOSt6fOoWzOo7Ju4CGiA==
X-Received: by 2002:a5e:8c01:0:b0:753:4e0:1cf5 with SMTP id n1-20020a5e8c01000000b0075304e01cf5mr1314548ioj.5.1679142685553;
        Sat, 18 Mar 2023 05:31:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020a023f4b000000b003c449a192cdsm1483590jaf.73.2023.03.18.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 05:31:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 18 Mar 2023 05:31:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tianyi Jing <jingfelix@hust.edu.cn>
Cc:     Jean Delvare <jdelvare@suse.com>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: hwmon: fix ioremap and memremap leak
Message-ID: <332fc348-40c3-4471-9571-fc3fc0fe927e@roeck-us.net>
References: <20230318112711.1803167-1-jingfelix@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318112711.1803167-1-jingfelix@hust.edu.cn>
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

On Sat, Mar 18, 2023 at 07:27:11PM +0800, Tianyi Jing wrote:
> Smatch reports:
> 
> drivers/hwmon/xgene-hwmon.c:757 xgene_hwmon_probe() warn:
> 'ctx->pcc_comm_addr' from ioremap() not released on line: 757.
> 
> This is because in drivers/hwmon/xgene-hwmon.c:701 xgene_hwmon_probe(),
> ioremap and memremap is not released, which may cause a leak.
> 
> To fix this, iounmap and memunmap is added to line: 754. And the
> declaration of 'version' is moved to xgene-hwmon.c:620 to help simplify
> getting 'version' below.
> 
> Signed-off-by: Tianyi Jing <jingfelix@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Please just use devm_ioremap() and devm_memremap().

Thanks,
Guenter
