Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7073785F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFUAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFUAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:40:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44C1986;
        Tue, 20 Jun 2023 17:40:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76246351f0cso437557285a.1;
        Tue, 20 Jun 2023 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687308000; x=1689900000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2BhE8PPmWBt1qLEATbwKDuUtBvcIPSH1ZbZlOGSXrA=;
        b=nj93ZwSmxASCm5bErY6UapbpcfnDZkEDMG2v2b2ZbezNajXkBok0g9rGYgLzJRfTHI
         pdk6Y8+WWVPJ1JQvTWpFvp3HKmZHuNBvt1tn27CU5ir4jpt8ZfHxSCLg74OJJr7lA3f8
         tq/bBOak5AG5rkYuTWMjGDXhwxXi43sa+YdjKAx0IZK+P97uKOg6bANKOkKTpWbw453U
         MbtXhZ4Qe/GRxKC7X/EHX3EdUE6JW72SaxdEsQZgydjodfp+SASXb/QtPI1v36o03eSZ
         o2zCkRWGN6yMWvt2j9pNBPhxYLwmyRcXW7XeV6cVxiWZ3XdDY0AQZjZow7Gy4slkYmpN
         VDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687308000; x=1689900000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2BhE8PPmWBt1qLEATbwKDuUtBvcIPSH1ZbZlOGSXrA=;
        b=ddOe6PCSUw5Qbz1voySyvjk4iZRcRNevq9nOyF5tLJ4NCCnrpLkTk6/OIyZ+DpmDv1
         XPokEL4imuK+Wc2xwRsO+AXGx/oJwEcnDvGr3b1bHhio4d+fF0vVel64BrYC7Rg7TGJr
         taPUDU7RN4kDTzUcryQeVscMfG5sDBdLTsQXT3bGjK8ft3S8aMqO0jANn4mwAhKYGIxq
         ClMqrBKUpdJO8qacKJD3fsd9OvWplPLLmqno4ZId7ida2eawrpyv9TXsw371S+wy3n5U
         fO3WCOZcWLMcg3Om+OFD88UZiVQ7wO5LLO/mJukhiovme0Ksmx4GOp1lBoCfQYp0h7Ny
         O0gw==
X-Gm-Message-State: AC+VfDzopjsqHg78qv3Ozxd5vhFRumWjp0wqxthjdDFoQotw/jk4oaV0
        9l2JUIIiSI7+AarrGmb+8x4=
X-Google-Smtp-Source: ACHHUZ62Ms6XpCnSRYkvy+/fUWnBukvOjiNhmWus5VAz/jNFYExtVAp/tOl3rmRJOL2CX1aMBmNS0w==
X-Received: by 2002:a05:620a:460e:b0:763:a11f:b861 with SMTP id br14-20020a05620a460e00b00763a11fb861mr6661364qkb.33.1687308000085;
        Tue, 20 Jun 2023 17:40:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b0064fdf576421sm1866119pfo.142.2023.06.20.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:39:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:39:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
Message-ID: <1fe57d2a-3bbe-485f-bf90-3ef1e4460761@roeck-us.net>
References: <20230619102157.579823843@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:26:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
