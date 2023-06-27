Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79B7405A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjF0Vdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjF0Vdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:33:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA8210D;
        Tue, 27 Jun 2023 14:33:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8033987baso2236925ad.0;
        Tue, 27 Jun 2023 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901607; x=1690493607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/guY2SniCeu+4ZiuvXjL57Te+BL73R75/hCInNX1NJc=;
        b=eIosBzQmR4GxM4fiKFnuW4rJqG3uok0QNSkZeT/YSHs1ab6lydEw3dxqzidrh7/PI0
         G3ghiVAnUNDAXMbOMAZ2RZyxVilTDqhzuqT9ZJ8yaIRPJAOnlqR79qV3lT5quCMrpbJI
         wsrtOEKR5ewkSZqfEVkBsNJZXi05iPN1of4m9aRPVJ56L7v8KFuk5HDf9uTqfyoPBJM2
         eY+YWj3M/l7hleLwmTZj7Zgalpx/Mr/FBAzW0rDtUhCcW+rOkJfedrzfW8P8tpEGlPxs
         49sEPFIuBTIs0Uz5JUlGBEN2wM3l568U2w7eOTNRkro4AWneqYimtF48GfUhGdjMKYO6
         JhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901607; x=1690493607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/guY2SniCeu+4ZiuvXjL57Te+BL73R75/hCInNX1NJc=;
        b=SoKtc4U4vbOPRim8aZgaJda6HKtbzSefq7IH+EXiSLsYgMIqW+bw4vAtYWRpNS3dao
         h2K1hnWff8IDOhYANVXC9djvuJmYZ+I9gdWkORHzODn9huPYDonRAcfPTxsIZp08xmnJ
         iaCXqdsDBD0Ew5qSU1y2GNlBnalI2zMWVu4H+/cflqV/gyFVadZ1CzsHtyfornAA0t1f
         tMlY5FUURKmwgXELpVmsU+i+tifZlSVPRrk+MLq+WYQNvEpumaSnCVZ7Gz5MZ1wLq8FW
         s047pVJn0ZUukLN49VJgfLKd7bftLg2WtnnfTTU9BBdxmNuW5vLWx79Mz4bXDny4D55S
         8HSA==
X-Gm-Message-State: AC+VfDxShyN98yR/KLhOqYsUdhk+2OOIMwQnPLQu6tkZnK21/gUBEZi3
        F6vFhm4sO9PInvQb+dKOcss=
X-Google-Smtp-Source: ACHHUZ5ftZl0RpzB4U3iVzKGkTUEJHhm6RYggP0w1/TJYqDzyy2EItZxHXJAIENndE/9769pVqAyww==
X-Received: by 2002:a17:90a:8d86:b0:262:fe4b:b45 with SMTP id d6-20020a17090a8d8600b00262fe4b0b45mr7832931pjo.19.1687901607450;
        Tue, 27 Jun 2023 14:33:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a018600b0025bd4db25f0sm7009741pjc.53.2023.06.27.14.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:33:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:33:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
Message-ID: <4f5e74aa-2fe8-4118-9f59-6760103292e8@roeck-us.net>
References: <20230626180800.476539630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
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

On Mon, Jun 26, 2023 at 08:09:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
