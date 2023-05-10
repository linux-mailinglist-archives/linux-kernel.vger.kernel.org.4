Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F36FD9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjEJIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEJIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:47:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C4E69;
        Wed, 10 May 2023 01:47:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so45519445e9.1;
        Wed, 10 May 2023 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708447; x=1686300447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhnW+JP05p5xI3BHymPhzEKMUYpUnBRttHR9ooutHcA=;
        b=sQji7RQpC1tFjw8pY/rXACVFK44Wpz6QpwTSd5NEk2ENdzXVBrzKDiTYt0kVPnwrWb
         bcViRDJcJ4qH7fS1W2LVoojw6+ro/2ragXR43AQV+KAjy+jXoLBtF+9df1TFP9+upcTa
         QDHtFTLJZu/dv4bA4epHAJC7xUyqdvqyiBs+cY+fuYOJ6TDDQ9hJAjROUExK1XUpo5J2
         pe9883TDGNNdRcuJRgGdcSD0SlDUcb8LI/UIOz4dYIFbmog9eqHAh5cWaB1wXdbZ3kue
         MuCBmwNeJ0kn3ArqCQtq325239DDnfnKjjahkL1Z+Un2jtobd9oPPClUOZd1bxxRc/3s
         xNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708447; x=1686300447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhnW+JP05p5xI3BHymPhzEKMUYpUnBRttHR9ooutHcA=;
        b=P8Qoxl9derE3BdcpLUjMwVP2B89S7OHd1LDp4SHdrcdDFjRvjTJJbldY6IsSUBmiPP
         fAuDeB6P/7u7FgwGkXXf9YKbbclcKNj0s4YkTE6EjXSfRFNv/Wohw9j9Iw+stO5BsgZC
         O/iR2yL1fT9OKA7TBqjt+QpifJYelJeXcGbL85WI5H76/y2QyzGEQwki69qvEXRmcnAS
         c3ngp3zJBR3Rp9GtZfXtA2Z75upv6LqJTsrtAfSPTRFQG9kvPIzg3yN35Q5afh3+LJ2m
         GjgmZgykzbSbMF/JJqtUuhUCi6a5ynWBguSwhCijluQFOF+zBoZ4NeBk/60RvTDGPlEM
         rbmw==
X-Gm-Message-State: AC+VfDx1vvQQO8b2HJ01Oe1UOghdnhPlkyOcNoNQdKNOWnjwLzdZ/QNj
        qbNpVdhB9OsdsOU0o8Ldv0Bn0MwNWXU=
X-Google-Smtp-Source: ACHHUZ4FEGxEnQqg2x4qqKQD9yQXQATLp3B/BWp+Z3oK5uLblyLkRX248AOauwQqT+WxGDEplj8xyQ==
X-Received: by 2002:a7b:c8c6:0:b0:3f4:2220:28d5 with SMTP id f6-20020a7bc8c6000000b003f4222028d5mr7786003wml.29.1683708447218;
        Wed, 10 May 2023 01:47:27 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f17eded97bsm22087861wmd.19.2023.05.10.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:47:26 -0700 (PDT)
Date:   Wed, 10 May 2023 09:47:25 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <ZFtaHYsRjdVrVMhc@debian>
References: <20230509030653.039732630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:26:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230501):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3490
[2]. https://openqa.qa.codethink.co.uk/tests/3491

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
