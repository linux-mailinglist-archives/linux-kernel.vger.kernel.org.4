Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6B7262C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjFGO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFGO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:28:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BD61AE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:28:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b00ffb4186so42451475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686148104; x=1688740104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYxLrENoa6fLzoq9JCLGKKY3HqSTatxxb13DcYAiDNU=;
        b=sNs96nbrvSU7ztAkj2PgjW4O8Nhl07ZErpP+5V2m4yuVFNX+u5I9xBAAlBfsFI98Df
         hkdCqf7vZy6iVYC+P5NisaDEiEX2/knCYc0qYU+GewBuz/VsBD/HXgq2g6pPQ6MqBVCa
         BScDKXSglppLY87ZW+C1HHe3Qd++mheAGdMmaBHVkRSYR0pyrkuyJuKfmzJ+mEmJ8OH7
         h3BJmZC8qsOPHVw/4Q7xT6X1n/kR81v7ThL3hc8VaSjReqwm1p/+kJds1Zh/V9rua1Bz
         NPhLJPCE05PK9Fx8jmrWfNraeMm+hOpf0ot5Sa/IuXABwarqxWODY/YwRBR/DLhHx/BJ
         +lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148104; x=1688740104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYxLrENoa6fLzoq9JCLGKKY3HqSTatxxb13DcYAiDNU=;
        b=mGyDBYuVIefc9gu2BC7V5hur1MuOl0J0p0H4ktqNeFdXKyceIZvxUm3k983xaKIFds
         r/Ue93wOINS9GnUoc8wx3PUZXAfTZJG5YF3Zxb9AjF1fXHpbGSWgk5fDz51sdPfNHC3I
         iz+2n+PO4jD9417LTLkc+Ii1Nttp7xjmhynk6nFdtD+xiVQwX0PyH1kK6+8/hm+eFWw9
         n1Oh2ngwxp2eI7YsKgLBVy7Ti9NNU+ShhRzWZmzVgMp7amb4+9b/uH2bUva+S1qywZRW
         uRxumrNtc04BUksnT3+93roYLp7Ty8Qvkz06JxLQyuWeXOcZMZn2cZI5aDoD8Griq3tC
         Xucw==
X-Gm-Message-State: AC+VfDzoxnHCiKWQqt3o9uiZK7o+YiJ1XqQ/+fMgfRwr3g1//m/JNjgz
        sfgTdLQdZ2mH6IgEcpP5fKDYJCj5VDhO12+GV87I1Q==
X-Google-Smtp-Source: ACHHUZ5y4pMevhd0x2TrN/nddMvUrM4tc1Xl58HsNIvNlQeORsX5Iark0cvZM4OCCotdBTKpA/jszA==
X-Received: by 2002:a17:903:1207:b0:1aa:feca:b616 with SMTP id l7-20020a170903120700b001aafecab616mr4706557plh.65.1686148103713;
        Wed, 07 Jun 2023 07:28:23 -0700 (PDT)
Received: from [100.64.100.6] ([199.101.192.34])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001ae5d21f760sm10494093plf.146.2023.06.07.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:28:23 -0700 (PDT)
Message-ID: <4f5316cf-f6e8-2016-d29a-f0cc6cc75c8b@linaro.org>
Date:   Wed, 7 Jun 2023 22:28:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] Documentation: uacce: Add doc title
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>
Cc:     Linux Accelerators <linux-accelerators@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
References: <20230606132911.37137-2-bagasdotme@gmail.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
In-Reply-To: <20230606132911.37137-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/6 21:29, Bagas Sanjaya 写道:
> There isn't page title on Uacce documentation, which causes all of its
> sections to be listed in table of contents for miscellaneous devices as
> separate titles (since there is only section headings).
>
> Add the proper title.
>
> Fixes: aa017ab97a223d ("uacce: Add documents for uacce")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>


Thanks Bagas

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>


./scripts/checkpatch.pl reports a warning.

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> 
("<title line>")' - ie: 'Fixes: aa017ab97a22 ("uacce: Add documents for 
uacce")'
#12:
Fixes: aa017ab97a223d ("uacce: Add documents for uacce")

Thanks


> ---
>   Documentation/misc-devices/uacce.rst | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
> index 1db412e9b1a380..8c536b84167cbf 100644
> --- a/Documentation/misc-devices/uacce.rst
> +++ b/Documentation/misc-devices/uacce.rst
> @@ -1,5 +1,9 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> +========================================================
> +Unified/User-space-access-intended Accelerator Framework
> +========================================================
> +
>   Introduction of Uacce
>   ---------------------
>   
>
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
