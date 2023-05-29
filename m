Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C322B714DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2QHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjE2QG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:06:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8740F4;
        Mon, 29 May 2023 09:06:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so829589a91.2;
        Mon, 29 May 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376409; x=1687968409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u833MBzdB2wFYwPyayytWh2DQl30cp0T10eYrBaLK8Y=;
        b=iAzy4j6NJKd33RPpforkXAfvd/NJI0wwPOKhqyDwRZoAhRCmhYplt1WPSdNEKJqmtb
         pXPFYnYgZuNbo9W9Rm7siqnyxmS7+F8hYArMuFUEUoDbkkg0UFdiZTs8GQmYBPlZFnc2
         RKGMMNgmkjxD1EbpUYFIvABTvCB20qazuCh8RvnfgV7plpIynG2EYQICAiw+SeA10Slh
         aKIrsDOkDTEqnQkWNdsd0Cdj/bwR29mjhfx0gpkA1YLkjUU0JnrTBDQgI5duY2g+7uND
         mBByCuPQPujiOBKaT/tEVmsNIrH9516dsV+8Uoph57J96xOpvl1Bo0XkLoK/yQQUf4VL
         4Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376409; x=1687968409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u833MBzdB2wFYwPyayytWh2DQl30cp0T10eYrBaLK8Y=;
        b=MuG/RAM+8UcBmAfT21rMbVcvc8II7kSOdZ1bsoS3+OK0JNKgVuaBaqG3l7iIp7Yda6
         zBCY1cGhaMZ1pZ0/osp1YReSWh+ZbqFgS/ZeyRDjZj7HBty+vdlKYTI6xHCDDvIWSNGA
         lX4Gm5xgOtmCxV1M7YEnZxAoIJaG7Wa+qAa6aaPg46mprm6iq5/209rWafSBt6PwKqk3
         SI1vIWEnT+GyBtzQQpri4yquG97QnA1schIV9OUGNRw0HMFNlq3bHmYbOZOoMMrLErob
         8qdxLtRo3CILCTFu6uBrWVguLkeqGWMRcEmGNG1qPTQiF64ERnyoiMm84XpfoMYbgETA
         B5ug==
X-Gm-Message-State: AC+VfDzIvcUVHn9NRim+/C3yWG5XhQWnQp3UURc0I0wLZi9xJ8kwLMG3
        k0FcXZ7ite2dmRpyUO8VoJI=
X-Google-Smtp-Source: ACHHUZ4BeuetqwPYGlcAaL07UlMwKRwAkqQ52mBbSC6nsQSP7D85iA2YeSUIdf9g6MO4bBrt996MXw==
X-Received: by 2002:a17:90a:1b69:b0:252:bb8d:3dce with SMTP id q96-20020a17090a1b6900b00252bb8d3dcemr11267134pjq.39.1685376409031;
        Mon, 29 May 2023 09:06:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a3d4200b0024e227828a9sm9739944pjf.24.2023.05.29.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:06:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:06:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
Message-ID: <75c964cf-e293-412b-962a-ee5580d3a15f@roeck-us.net>
References: <20230528190828.358612414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:11:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
