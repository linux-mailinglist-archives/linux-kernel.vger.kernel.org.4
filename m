Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E504C72E2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbjFMMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbjFMMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F4310FA;
        Tue, 13 Jun 2023 05:18:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so40406665e9.0;
        Tue, 13 Jun 2023 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658689; x=1689250689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lN7lpEDhUAFrWCql8GXgz0NB6FUC/uhCsLDpu9xEis=;
        b=sGOaxWfnltQqyhvjw10PWp15U+snxILw/aOJVFnVmoroUvlASQNXSj4ltoGNcw3nHl
         I79wSUahzanCYjybZkX9XYsl9zll4P0OF730gjq/1+7KNhDBRTWq5wKqyVRCP1CPuXeI
         F4yBWe0K6c3FJiS/dsqmAREiURH4+T/v9xusNuj4LtdUP89PasuYfoFog6iINw06fGgW
         prI30vAz2Cv0h0sc3WRZrv+7MQswjMVG/l7szoXxQna3C2x/FgXrDQTc+g+h0c62ljWl
         QntSFHHG/UMZG6+xDySaDHE4fngbH7dKYmU51wZkXjxP2GfFscRHMTCtCSmtaFY1BL8z
         PSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658689; x=1689250689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lN7lpEDhUAFrWCql8GXgz0NB6FUC/uhCsLDpu9xEis=;
        b=dygstSDbmsgMyD7UB8IssbjjFZxLkRvqGoWl2aZbJasMql8Essn0B8/cLOrBFJc2Zw
         yJHNKXwKGbSiQQ0zMGvN+UF8E5gHQB1Vs4q2sKW9H4VYtzsof7MgPpMZXSsDjoTs0Pjl
         LtnxP/p/qUfZ56iYspmjwb1PeTWXiZQl4zDEWHp8Qqfr4llJZ0i18KDp0HeAAhEAdoRh
         C6e6MH2zr0q49OjNLj3+WYVN0zEgL2gw53neQtvymH0vuToy9iputSd/YMzFrkWnUQmW
         wWYUjDdNw1G+DDDmMIjurwe8MVQRqzNla4m4N5RD+pSntF1Fj6ntPFqXGRdrzvPjhwgm
         kRsQ==
X-Gm-Message-State: AC+VfDyCy1OMiDe7fNQ+fRWGO/qU7olS804C/P3Xz3kPLs0QgK2PZc9t
        9H5PeZDVtCoxio0Z2aGlU3E=
X-Google-Smtp-Source: ACHHUZ7tXyNzLeloSSFIoDzLEWtS2QbakYDXkwCEZCpaQlzqXFpbZ/CYc1OAP/xp1Wm0dJHPHwQGEw==
X-Received: by 2002:a05:600c:2103:b0:3f0:b1c9:25d4 with SMTP id u3-20020a05600c210300b003f0b1c925d4mr7738419wml.21.1686658689044;
        Tue, 13 Jun 2023 05:18:09 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f7361ca753sm14217408wmf.24.2023.06.13.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:18:08 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:18:06 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/45] 5.4.247-rc1 review
Message-ID: <ZIhefkuiBubOqSe6@debian>
References: <20230612101654.644983109@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
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

[1]. https://openqa.qa.codethink.co.uk/tests/3933


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

--
Regards
Sudip
