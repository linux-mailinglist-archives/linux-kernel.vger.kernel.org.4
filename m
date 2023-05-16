Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669F27048E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjEPJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjEPJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:17:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10A49EC;
        Tue, 16 May 2023 02:17:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-309382efe13so188315f8f.2;
        Tue, 16 May 2023 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228596; x=1686820596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1IhhzxB4ld++kwVUQBLJ+A21ev47I69qBykT3coDis=;
        b=ZTi+SscxdHIR9WWsfrSoFeB1FUYfl3ewKRBEkna2ORTjo1QQ48jl1VEKRKxpJMZBLj
         SWr5C1TGBSO9wAQrbY0cFBvfKv2Jfq4G0IusY2mqBpjF7QV0gdVyENretJJkkhaADARk
         uSfUd5L3P4zgpljQloc4E8zHlsqzMNe/Uz8Je6uynYBKOt1XkZhoQ+vGoeIMBLPwqKp4
         lng2/3fMxTaUHB/p0kDvYecyS/q6u1ArYIN+SuyBkSdHxSwBHeEd1pXl8Pj8mmOYt4pO
         EY95ykDu//fSZJCPaxw2MBsqQledsBBcwIKvjz7YE6tK73VhZ1bvKORkFpp0fIz4a19n
         X+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228596; x=1686820596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1IhhzxB4ld++kwVUQBLJ+A21ev47I69qBykT3coDis=;
        b=QJFEevABUgp46IYtkjvTDJDvhccrlTr+4Gu7pWadaWcrsrl3nxaE2EpLior/lRhK2f
         WQRhlguozQ0+v6dF5nnIy8EU+rddChJcg/pPyRIpRgq7RySpG0ilL6/KfmhHT+GRsvpd
         KXCg5cePVF9BFZRzcBR7FGRZ7tpjbj5ehSHBsmcszrjr1oPjt/oZajS+fVcFA2sJk5AQ
         /bO1lbKwG94rtsLWHT9xvK3JZkPOCehv2/VQilvkWO9L4JjnjP9Hviml5ex38/Q2GQSc
         k4Qml/8d0apPHNB9U3kdacU19qrt0nbE/3U6yN9ZhSaBIjPqDAFz/UrUlXqPxvc8JjGp
         oJpw==
X-Gm-Message-State: AC+VfDwF7d0dgZ65MhpaksQb/ch3fo4O0ES6AtA0MRiJqyvN9s0udQZc
        VxVXC0mKX8cTTHRLT5ef1OrZahJ8p1w=
X-Google-Smtp-Source: ACHHUZ6Yb5LY8toZrq9QUlM2s0RaPoyjZyKienkGcjLEyg3wqsRjagP5t/yUcLY1KeMxHTqeJcuR0g==
X-Received: by 2002:adf:fd0e:0:b0:307:663d:fb1e with SMTP id e14-20020adffd0e000000b00307663dfb1emr24719501wrr.36.1684228596510;
        Tue, 16 May 2023 02:16:36 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id d9-20020adfe889000000b00307972e46fasm1856086wrm.107.2023.05.16.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:16:36 -0700 (PDT)
Date:   Tue, 16 May 2023 10:16:34 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
Message-ID: <ZGNJ8kTietfewsgu@debian>
References: <20230515161702.887638251@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:27:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3532
[2]. https://openqa.qa.codethink.co.uk/tests/3533

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
