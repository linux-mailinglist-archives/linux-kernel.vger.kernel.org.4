Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223963EF62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiLALXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiLALXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:23:01 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD425E5F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:21:58 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id w37so1405726pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcV2E+DLshJUcTnYfXOz34aTP2E58VdR57j+4Rky+uQ=;
        b=TZRZkF65FQ5q55inrSNPxIuLR7N/l0tL+GXiIolKXwtk8Llkai+VTu918FsGjgCVib
         bkVrtPYfM0rAl/aE/L2eAMDICmu7vR1aujpdtHNEseO+2vEuB6AXCVgq5H1puWe3S+xT
         t4m90KKwkwe2p1SC683IoQhPxAz4SvGh3deag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcV2E+DLshJUcTnYfXOz34aTP2E58VdR57j+4Rky+uQ=;
        b=TLsYagT56bqFpFbWc3oDvOXM1gH3xb9thXeHkXynM3IR8huvo4EMJnGWfkxdiXWiJ5
         CxmGPs8tQybi7ELeI5gaYTkYxr3WfjMYt84AM0Wd/NPl9IUv5nHCn6TnJ3l387gQpMHd
         4LGGq4C7RTPErM8nX5N5DdDq0WCa8A88fvRcpvbFPrVVDt7TwDGgu3FkmAZMQWudmeVX
         o0NakVZey/7WBsGSPyRXwcbxlexG96ETVG+FB2VvHk4NPtTIXH/fsz/vEym+80lTUrcD
         XNkmZgtLEFUQmi5qoTQD+xfQOdiqkDiVzer5io2fV85MDPSwsbBUd7whDsgAmvdU7ImN
         HQiQ==
X-Gm-Message-State: ANoB5plSVog0bs06g+Fdj9ullMi0BSbqDE3pQIH9YJRXRHM1dfsmhYfC
        jiBfFuV1orsr28E6Ibah21vnDg==
X-Google-Smtp-Source: AA0mqf5CwbXqaZTfVyhq2dfjg5jWlL0RCXWBvgRz/usGHIpDiDHZjcRlR8eeEJoMxzZrI/v8Bif1sw==
X-Received: by 2002:a62:be01:0:b0:575:caf6:5cd8 with SMTP id l1-20020a62be01000000b00575caf65cd8mr8989382pff.22.1669893718200;
        Thu, 01 Dec 2022 03:21:58 -0800 (PST)
Received: from 7bbcfc1ba566 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b00188fc33e96dsm3375966plk.198.2022.12.01.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:21:57 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:21:49 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/162] 5.10.157-rc1 review
Message-ID: <20221201112149.GA1304551@7bbcfc1ba566>
References: <20221130180528.466039523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130180528.466039523@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 07:21:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.157 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.10.157-rc1 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
