Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B6714EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjE2Re0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2ReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:34:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10278AB;
        Mon, 29 May 2023 10:34:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso1376267a91.2;
        Mon, 29 May 2023 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685381663; x=1687973663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjXhXfKhF2yk36YQMCuS8AIma0LdxrDbNwpb9Q4Wbp4=;
        b=P4cNhvUPQQrPZ27uoNkGo6AyGHJtpXLSkcnhvCAk4czGo5S5rev3y4kaUEBHOp6T85
         HGUJPFyWPt90DuSjjbv1Z3nQHvSQRfx65OHpfnBrpb+RUKF7i2U3PkRGH0f1G3FtFE4k
         MsE8xSxZka1KjHDav9yn0kYCl9x1PhxxIr83/44H/gdgfkn/wmbVbXuf3AZtLQ4JLHSH
         NOktvReRq3IsCtUAh5N+chWtKpsVIiXZYky00FZkS5j87mFDfK85NOCrO/RmUrjM8GwS
         +0xTXJGTNyuehR5XdSItokcBM2HvNQGMsuN+1aE1r6Jg5vd1DYwbKat+J/AnxVs89X3A
         N9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685381663; x=1687973663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjXhXfKhF2yk36YQMCuS8AIma0LdxrDbNwpb9Q4Wbp4=;
        b=gm4MuRlb7NKn/bUIc/+1yAIOjDHF2Bq2uro47ClBuIrvF0zK46zof52vH6uZfb2oVr
         cedOqWyER+d6biG5uTno6N9QzCtnmQg+XHsoQwAVJd52cVQSjh4rZgB7yb6jqTW8FCx6
         eTET1jLOc4q7dQ66KJJVWAIKOg2UuSCv7IA3VauWBAu7IVJYsGv5MX6maYjkrTqAA3vz
         VVrdKbktoD1YNzQJxAhjbfzqMsqdg8YeqEmLI0Pr7YhXTU64Oj562ocufy18GtVPoZyr
         qWZx8cq5Mj6L+c5LZG9pTlbaylOpFutbNlkSAXeF+6omvki9TZiCTbzrB1b4AuI+ohG6
         E6QQ==
X-Gm-Message-State: AC+VfDwi+UCu34i16iAKg/uj4wgfC3xPNWvZACjJZdzoHZNWwUdY4l5v
        xOnPethgccow4W2kRU8K2Y0=
X-Google-Smtp-Source: ACHHUZ6sPom/NcIrUcHdPzwJWrwk2F9VMAsUUJ1L2FYw2L/0c7UeGSjOZM9kKjWHoh+5L2cezAcRNw==
X-Received: by 2002:a17:902:6bc4:b0:1aa:cddd:57d8 with SMTP id m4-20020a1709026bc400b001aacddd57d8mr10626402plt.30.1685381663435;
        Mon, 29 May 2023 10:34:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001aaf2e7b06csm8451575pls.132.2023.05.29.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 10:34:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 10:34:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 000/133] 4.19.284-rc2 review
Message-ID: <371de68a-36a9-4b87-a847-f8fba1516a23@roeck-us.net>
References: <20230529153919.729418186@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529153919.729418186@linuxfoundation.org>
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

On Mon, May 29, 2023 at 04:40:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.284 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 May 2023 15:39:00 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
