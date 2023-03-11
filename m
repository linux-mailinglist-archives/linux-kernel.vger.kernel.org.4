Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF36B5C31
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCKNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCKNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:18:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB56D31C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:17:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso7938688wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678540677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCjTLaYDZiJ8XkbV6O0se/hxyGHop4SwanTGb6lzi1M=;
        b=YmT2PAymAK8fck2e49AWQL8Wirpyr/LDvSAW+cy7qA/ZIua4l8pAI28j5UlJtMgcxo
         6D1XfJkH8C+xNMsNwhDDF6xn47VVgrY1/oK5BS8ffPQz1ffhozJtel6DPvsFapbs26lK
         2L8SlgDinviMN98LBPJ2bbX9fKv1kor75FSTUduXMPjQzbPa4+TdmUar3OueQ5v01KuK
         iTooxA6IQuIt4fZil6pm2JlihyT2ReFzu7VFTHAWvqm37LeAI/doOMLNvdXCZNlgqFWt
         Rr01UVTl1Ot6Hrf5qouz1GlZZrg8epQBvjruZqkFsXHu/szc2na0kEk1hyXWy0cJUxT7
         8YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678540677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCjTLaYDZiJ8XkbV6O0se/hxyGHop4SwanTGb6lzi1M=;
        b=kM1IfWq8FJAvvM6r6nCxYEmBP5jJlmD9rEWW2ow7Fp8seOQA1zaZQFXKxvZObSN86c
         c3uRKZuxWoY44Ec1rNyS+Mvr9WmPp8K698cAMIn7YcM4vmEIUlf5Dr7iy/lgRx4d54W+
         F2YlVX/gRF3NrW2hYM7m/rQL2gmc+4ME1jrN9QUEvH7j8iiTDVxHYjD3bkqj1Fou9gj+
         7+JGrCI/kVWl/ym/gwcQ/OvWC61f9vXcq8Ky/JD7UsDpdnCfUrv0Bnt89HF9N8Fp1BE+
         xt0GnWTz8hqxrSW83IpNY5Sx3kUvjBcHibJeAaqasJxrm13S7SYtd+Avhn0cpm9jz1hJ
         tAtQ==
X-Gm-Message-State: AO0yUKX6+kHuR3ac+5SMSZL9Au2F2wQ1rSMmIxkExCQV8bjJPMTDw5zt
        rENibTDiBj0X4QX4oEgXWDZi68Vz9hxnj8ke
X-Google-Smtp-Source: AK7set8IojbqWlEavLq+aYCjMF0+8zMNyH3vKf7eumPixvIsxTRAxp0wR77iDdFTjsCWM5c5KyCiFw==
X-Received: by 2002:a05:600c:3ba6:b0:3eb:29fe:7bad with SMTP id n38-20020a05600c3ba600b003eb29fe7badmr6186078wms.1.1678540677585;
        Sat, 11 Mar 2023 05:17:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q10-20020adfdfca000000b002cea392f000sm1708666wrn.69.2023.03.11.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:17:57 -0800 (PST)
Date:   Sat, 11 Mar 2023 16:17:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
Message-ID: <de7df101-6cbf-4e69-afcb-b80204bc1d5f@kili.mountain>
References: <b9d62635-b968-4dfd-aa10-e34e38a114a5@kili.mountain>
 <20230311130023.GB14247@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311130023.GB14247@ubuntu>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 05:00:23AM -0800, Sumitra Sharma wrote:
> Hi Dan,
> 
> The description in TODO is difficult to understand. I would appreciae if
> you could help me understand it more in a step-by-step simplified means.
> 
> "This configuration needs to be moved to sysfs instead of being done through
> +     IOCTL. Goind forward, we need to port userspace tools to use sysfs instead
> +     of IOCTL and then we would delete IOCTL." 
> 

This driver comes with a user space program to control it.  Your patch
breaks that program.  Someone could find the program and change it to
use a u32 instead of a u16 but the old version would still be broken so
users would be confused.

Generally, in the kernel we try to avoid doing configuration through
ioctls these days but instead prefer to use sysfs.

Now the driver uses a pi433_tx_cfg struct which is the same for both
user space and kernel space.  What we do is create a different one which
is private to the kernel.  Then in pi433_ioctl() we copy the user space
struct and convert it to a kernel space struct (new format with a u32).
Change the kernel to use the new struct every where except the
pi433_ioctl.

Then add some new sysfs files so that the user can control the bitrate
without changing any of the rest of the struct.  Update the user space
tool to use sysfs instead of the ioctl.  Then after everyone upgrades to
the new version delete the ioctl.

regards,
dan carpenter
