Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E386E72E291
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbjFMMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjFMMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:13:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D648CE;
        Tue, 13 Jun 2023 05:13:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec9bso3522035e9.0;
        Tue, 13 Jun 2023 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658424; x=1689250424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGUiRPk+gVEHbD7ZvJ2F/Ye5LU63063fiqe0GTm1AZI=;
        b=EVaGpthskgsEhBQzet0q4sysCdrLW6JpLIwOR/ykspc8Qlo4oS14H+POulooWLSXEg
         Qazr4Lezoe+6bTtFeDi80tDrP6IVpQczSxfvcPNnAeHGnFfIPAnbrjkc/knqIbiB2T9L
         /6f8LSY4aIJ0ftMicOsxo8HUKkvBnDo0Swd/OAW6YBsFxzCtx9QYaIZM7qCiMDqz8bFP
         5UNBRiZ9Gv+YZTzVhfC9cXtld7r8kbSYEDEbgn7A5d7QuFMQdWKsvKMe0MIOv9V6RPh2
         krWlY5N2Zi4LJWqp9oB0/HobpHdUHIfRvWPwUzOx6mDTU9v9XWOdYqrALaBQrO3Gv2vK
         CTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658424; x=1689250424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGUiRPk+gVEHbD7ZvJ2F/Ye5LU63063fiqe0GTm1AZI=;
        b=CIQ6Koflb5FLtYsaFT8zkFBUpX9RgGxnvjkIjiq2DodPMx9zRRYd+Jjq64vifTySD2
         poMOOgHtg2YT5d9WHowbXdZ/dDHdVngYBazaqUNS1DRi0ZpRx9uMHv31EJVv3aov5Yuq
         TfyfUL42xRnh8u5VlKa+eZErG3Y52q36awyiyODVOUqzVAZm6zCiHCp4LU0VyjD49yUy
         z3njxXY6RqlY/DlRuY1LBw0tcKTFs1Nd5jyOWfuCheueHOyVJjAdDhYhmBoWjTQfS4cr
         Ss+0QYKid+2q/j/Nssoi2BCY3/PFj7n4FlWR0SopR/Z+pzPzAPimIutgtpYpqbGaVYIb
         nIfQ==
X-Gm-Message-State: AC+VfDyjDIfak8JEM4QK8Q3cbBh5vl0LN4j5jH2SAhO6KQAHclGsXT/O
        m/O+fCcHMiPFdFm6Euw6IIU=
X-Google-Smtp-Source: ACHHUZ7tuBZ2AMJ+KiLoQMQy1dESv+R03sMRcwSb0QvHb/EWax8eQTCRA6ajmludPK6QmTXavw+8LA==
X-Received: by 2002:adf:ef52:0:b0:306:2e04:5925 with SMTP id c18-20020adfef52000000b003062e045925mr7962050wrp.17.1686658424415;
        Tue, 13 Jun 2023 05:13:44 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id v18-20020adfebd2000000b0030789698eebsm15220338wrn.89.2023.06.13.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:13:44 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:13:41 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
Message-ID: <ZIhddcdk001hcJgU@debian>
References: <20230612101658.437327280@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no failure
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3913
[2]. https://openqa.qa.codethink.co.uk/tests/3914


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
