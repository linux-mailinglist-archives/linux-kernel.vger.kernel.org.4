Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B173784C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFUAh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFUAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:37:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB2E65;
        Tue, 20 Jun 2023 17:37:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25e89791877so2481240a91.2;
        Tue, 20 Jun 2023 17:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307842; x=1689899842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CmmRrQCnGR13BTKNM1nX2I1ICaZM3+kWbJi3ubrV2E=;
        b=fq1Lo8s/yjPfpxS6WCgo7KmzI5TTNPtZC+t6vv/iXuM1AVPLCxCPXDxfCNNIFbHyAC
         FW2T4M7op68MNYWWMt85KZD0yhoifaHP2P/zBo0OXcePz0d4Iygjx7L2I25IGO2lR13C
         tFTfEgg0YLwUrEC2tMpvOdqnS8GB3yvj5Fd1jWxZ5onPlhLfAWO0gpRrrUxSW1CX9VxS
         PuN6yKSxHRxFvHsyNqjWneB7Bu4Oj6uVQ36XhzTFqxoJO3SaosBOsCvs5uIHqZOiXver
         XgVAaumCNqwxVdG7RGIVkmu4ja3TTp38KEqOs4NoQz0qmaVjK7Qf9oL4VkCFQUmg0KhZ
         nCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307842; x=1689899842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CmmRrQCnGR13BTKNM1nX2I1ICaZM3+kWbJi3ubrV2E=;
        b=QvPNse1lDVIO79yTRAecYGHoGFquX8NMyzJJCucGyXGu6BFW/z38CBuK+e2BaYLGIY
         rxwgsHouAX8XfgoSUTPewpyN0W3/zKboZeZ5CfAzpq9QuykbZWfO/Xk1/3YhvgAVpYut
         cQzYU02TqIH2jNBxb0jRtobFD7suYZ9QBlq3pyOEWDyhcY9+5XKUKyChEVQarWVNTlwQ
         7TIroCkJHL/Sq42mqPlVX2YmpwYfcm3PxUDMvzQ4Ep8l1k2/ll26p9VNiDy/91zPUrP8
         GZCHbUOO/9J7kLzja52kE8u5fP+YsxIvitLuIkXVvFHnE0zKZ9iFCQocQ72xZMoP7XwZ
         pfvQ==
X-Gm-Message-State: AC+VfDzmAA0auZUTnFZh9VtgWRBOuqAyL2vdW2GETYljJXpoQn6j3PTT
        cmRAJL1cbdqcyRrsFQU0FhE=
X-Google-Smtp-Source: ACHHUZ7XaFY65pBshpId6vsjCS3eiohcyTgZdIMOMDLtOJbm8gcWv2CZtbNhLJ83ncBTqXzLebmtgA==
X-Received: by 2002:a17:90b:918:b0:260:d06e:38b7 with SMTP id bo24-20020a17090b091800b00260d06e38b7mr2232428pjb.33.1687307842370;
        Tue, 20 Jun 2023 17:37:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a031a00b002502161b063sm8311379pje.54.2023.06.20.17.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:37:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:37:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.14 00/32] 4.14.319-rc1 review
Message-ID: <80273ace-d87e-400c-a926-c7b9bf2c030c@roeck-us.net>
References: <20230619102127.461443957@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:28:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 166 pass: 166 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
