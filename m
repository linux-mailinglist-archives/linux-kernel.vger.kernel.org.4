Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B11729267
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjFIIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjFIIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:15:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684902697;
        Fri,  9 Jun 2023 01:15:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7f6341b99so10636125e9.2;
        Fri, 09 Jun 2023 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686298511; x=1688890511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/umIzeMz8geuBnQ70Zs8Lyt2KL70GKQujvQXIJTU5I=;
        b=KbhSHFa3fD+CZYTpEwafl5HoL6JuUzJZuMZpzscp3yLZVVozMf5fQ0nRfrR1PJ4b5K
         Tbo6jc8my7YAH3S1zBQU2riLYK3wN78KMqQO+1/dGzFFcusd3Brk3TMm5NExTmpRzK1j
         S/gDxOo1hkzvvzLwKh52hF84jmTaOQLaroUn3s1gIampmjQwQ1/quqd/Q99XEwrcjZwK
         BVEP0l9e85LDkR0/p1u+fB72sOWWjEl3pBuHACQqQThNpnddoYpqdjoEn79eWHyvpuC4
         UgC8eXdm7lH76nr9jKbLKFP3iFJTdm1VIRtVAQDl1HZkEs9i0UHsO0mxwEoFLwyRDtAx
         +5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298511; x=1688890511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/umIzeMz8geuBnQ70Zs8Lyt2KL70GKQujvQXIJTU5I=;
        b=J09/wI4wOjCvj5YR5JSzrPRP/KwP035j0JEzdp4LBQb4pNihSk3o+yavYrDQlazvfI
         Ktr5LWkliY/B6MWxiweFfObDG9gw6fdldennfxBeclzxrSHNLbaZTZcM/m+YsxgqG5C9
         /0Kb+GHkIwPkLfMfnkRMIt5Yt9WS/jGdRqaELcgFCSaZGwndCnhN2K90chuHUAYsJYes
         gimfDw/TU9QsIEb6PFh36vvuq8ndWwGD1ieSYFvmZ9deJErk5CH6QgAo2FK6zFt3N9Ys
         87B11gdsviWTPalZRD/4gCmo1mdeYO7AKBr4n3+YMnDLiJcxaxwaYzwRMqzViLyyQDC3
         Q3Fw==
X-Gm-Message-State: AC+VfDzAvvjjiZV41EFBH1yPiiuDZ5mrT2Ks7Q5X5/LCCZ3hyQTLcAqG
        iqTBFJK1CnEi2IxHw4h5hQ0=
X-Google-Smtp-Source: ACHHUZ6BmpVI5x5ggkMD0w0VWUNdDghA2OcdaPfkM0WhYLsbQuTeAyMgVWyqXMREJl7lSLDzS44VVg==
X-Received: by 2002:a05:600c:2044:b0:3f7:e800:abc8 with SMTP id p4-20020a05600c204400b003f7e800abc8mr325327wmg.15.1686298510644;
        Fri, 09 Jun 2023 01:15:10 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id gy15-20020a05600c880f00b003f7f475c3bcsm2583686wmb.1.2023.06.09.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:15:10 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:15:08 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
Message-ID: <ZILfjLdOLfXkBbYS@debian>
References: <20230607200900.195572674@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jun 07, 2023 at 10:15:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 65 configs -> no failure
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/3802


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
