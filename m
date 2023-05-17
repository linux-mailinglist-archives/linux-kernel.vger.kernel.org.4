Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27774705D67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjEQCqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEQCqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:46:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68EF1706;
        Tue, 16 May 2023 19:46:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2533d74895bso312734a91.0;
        Tue, 16 May 2023 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684291592; x=1686883592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpSSLMhBAcCPj+MZ8JaHu1NFXCtiooTzWkivGRkLM9Y=;
        b=QYHw/ydnrHXF+R6ZEvCkssIt5Esix5mHa0yItDk9w+NNOzBWVberEUFUDl9h/SqGGi
         4on9wM+9V9MXGfjCUOOFQTX7tNCIkBW/WZpaacaPX4/qSfwJNrKBTx3Es+CEVcM3tMpR
         1tkLHHBwApkA3O6g0X0v3Dt4UsA//HWCoi5C53N87FiwHeFKm7nx6ZJxrZeOZtBZb6Vh
         pE7PRV96HldhHNZNybPjNccXdqCJvidUBedyg56yGUIBxqUTC8IrmPcELaHKPbD+gxY8
         yBvyfJxTnym4+jXwJJ9EDbRY5JwcdwCz7OT6AWZEs5otk4FBUb9DuB5yykHUn1Olqrbu
         3DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684291592; x=1686883592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpSSLMhBAcCPj+MZ8JaHu1NFXCtiooTzWkivGRkLM9Y=;
        b=f7NT2OGY+2CWGDbq2oj5AyTSUXCVPZEK+9pIwWtMYfvxh2fiurxp+HckHb903SrOWG
         Q+iqLagO/Geu6q+1qmKuw7GfxtoUDK0Rd3PnHG9TzNYT1YuKu0/MpziDklgp08QUIKQM
         t9NouJtV9i3CofDLuhhoPBZFUzofkj3GLWTSZbai5llThMhll0yb56wixByCHWTkD11v
         gZPHjmzodnh5kBaShgxONhmk4hLeJg62F2ksGxhHE16V+Am3XVqDI3XR8Vjp2fKWSwKn
         1E/t4vj2n4yZV4nmg0e1nxrDCE8c+Y0MS7DxOYMePNTPdtWX0yKs80IcFHk9dZLS3Cob
         oqdQ==
X-Gm-Message-State: AC+VfDwNasEjraZMauqsbFKgHGbqYLINfGPc5tz46akGcna3r2VQueNi
        pgl1Wp3rVAZSVxJ1S6XGLqfGw5EGotE=
X-Google-Smtp-Source: ACHHUZ6HIwLWUhUiU/Q0RJ3hHLFdUN6wnTe9rY7A0hH2DcZ+Jix0pFiqeZatFmsn238+oQX4vbw4bw==
X-Received: by 2002:a17:90b:4d85:b0:23d:a2a:3ae4 with SMTP id oj5-20020a17090b4d8500b0023d0a2a3ae4mr39699154pjb.44.1684291592274;
        Tue, 16 May 2023 19:46:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a950c00b0024e227828a9sm316347pjo.24.2023.05.16.19.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:46:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:46:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.14 000/116] 4.14.315-rc1 review
Message-ID: <20a22ed2-c8b3-4680-96f2-f286286f1539@roeck-us.net>
References: <20230515161658.228491273@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:24:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.315 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 168 pass: 168 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
