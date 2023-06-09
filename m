Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2372925B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjFIIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjFIIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:12:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1AB9;
        Fri,  9 Jun 2023 01:12:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso14250885e9.2;
        Fri, 09 Jun 2023 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686298333; x=1688890333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/K5tYpr0uyjRNSZAPyx3ZIoIIDJLXA5XyIkkuNX3V10=;
        b=U5smjNqwRLICYAf9BnfzzvQesG0TofUWx5lEm4axQW7kDdK+jGuIDIwUD+KBzbIwQo
         /FBIc1lk+eYZgHqtGv9FVW7FqxQg1EHGMDGpLJVUm6vsqOmfUP1cMZZAZxKaSOMjBEa8
         0xLDw3m2+L/PSX07fVXMkdznWZ0O7o+Fl7OC3n8BHa676nF3ASIGHpP7uQs8B83pGv9i
         iMAwimHfjgDoqO5x6Oi7SA++BpikpCguxB7yk4weYLWzuMirZTwcmWsFRQwGsxggesV+
         03lxkRASFO48RNQ7FsMhn81nd5lGqQ0lS8YXHIWOn/Xm/Z6v03aFC0HoLLv6it8eUCYt
         lu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298333; x=1688890333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K5tYpr0uyjRNSZAPyx3ZIoIIDJLXA5XyIkkuNX3V10=;
        b=XTjEiW3RoJMBsLVp+WA/RgUSC6CTjKGUll48ccxa234pYvhmWV16+3yLQwz/PtFz2N
         Zraoi7ZSBnE+n5Xir/fy4dXmBqWjoFlBoHzso2pR0T/nRLjs0B8605hBlqBQL5t+j4q1
         tYvUqekd9Kx05sLNQwELA9hP4VNnXqI9TKamMMsFcLY0MFX8gwjCseZ23K3TaXyKjTui
         Ev4w6Dq18g0MtZZB7rzkfEdco52yo+ZckJxlgm+MEHfwQjYvpQ/stjR7uPvgoQUxHn8R
         YmtGS0YI/NV6IGd4licV7tQHsobEYFkZ5Rjin5j18b35jYWYgOAsbcRdTVWICYkFOOnq
         VgYQ==
X-Gm-Message-State: AC+VfDwx0HeTHo4RL8wSKOQNnVa1IYrFjfeTn+/0Z4nZ6kFvovfJEzBs
        ouxdn4f18b3LIjhRqeeJNK8=
X-Google-Smtp-Source: ACHHUZ5pMVfMD2N6fxcWKg1ENmmI5IvXZhleR9/leoP5eQbaNK2wmzw/zgbW+vJt+ArN/b3USKzlCw==
X-Received: by 2002:a7b:cb0e:0:b0:3f4:2ae5:b35d with SMTP id u14-20020a7bcb0e000000b003f42ae5b35dmr518114wmj.40.1686298332758;
        Fri, 09 Jun 2023 01:12:12 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c205200b003f74eb308fasm1806222wmg.48.2023.06.09.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:12:12 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:12:10 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/88] 4.19.285-rc1 review
Message-ID: <ZILe2u4BsXGwXXAc@debian>
References: <20230607200854.030202132@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.285 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no  failure
arm: 115 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3799


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
