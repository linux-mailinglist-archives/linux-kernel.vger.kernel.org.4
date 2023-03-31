Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377956D2124
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjCaNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjCaNGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:06:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BF1A440;
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so23258089pjl.4;
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680268004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14bpLXKhsGbcNPJuXxXGVYE6w75UYQ85KK15RjcJ7NM=;
        b=J+rhCmXUXYpIA9Z4hqSg12/qcx1JRwMtRVYOyRG1oZdWSz28BP+6taWx8MpvgyPCkf
         z/4Z1gf3ifZu7a+4JHaMc4GEF4BFvsIPuMIIEjj7U/NR98vHHqiGmtXWHjfeSfoPCU5I
         XIrr9MIr/8N20eLT8RwMJWWWLhiqofH7bkjLfIEthvekHDWWhDw7n66g3vOaxfXRkSSV
         wlPfMDe8Qqp9RxBouFY0LbY2ZpW40dfnn3/eAb6CV+6MUCjbw8MmCUw6Plpk27E0kH9Q
         u5jK2hElNCL/LH6xv2ZSmQ1M54Fp4Paq3bqNEn7EtFfObQDHipQTMyqs2vTX0L1U/+Ys
         7EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680268004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14bpLXKhsGbcNPJuXxXGVYE6w75UYQ85KK15RjcJ7NM=;
        b=YAz4I3Y53pvLoNdAebubcMRzzMfA6pfDBtjrVgx01qj9uh4m42o0jTm+bTARmpFZxX
         xTv4i0R+H8eARFyTB9Joe+/9ohCo+XI5PHU3ol/hx9DHOxqG6/XxFG4YsIcXK4jkbw4V
         Z6387QZnIClxr3V9VD8+5mD1Ii95cuTvo43tpEBA3ESdxFnkZh2+BEKAH5v0esjOYa+y
         JjjeFHr+fkZ10PtrD2rjqegvEL2cmI7YYkvpmeARIdM2qOl8BlTnqpB6bsaTok2OOFM7
         mcB+E4PX4IaK7sjwgU4xy74pRGeftyEeBVnnxs4JoWhJFqVqp/Gxg9HAser7jcPHypwA
         79Wg==
X-Gm-Message-State: AAQBX9cvdaK9aEJz+qtkhrJmguLovZBp31nws71UB5b2lK3dUBzvi/BD
        XODwIloOrLx2naFt9kl7/pI=
X-Google-Smtp-Source: AKy350btzesFQdGHg0HNraW7MNdqEP2cgp0ZyzibFgofLQwudP9lvC9SJrYkNOkcOtLGChmUI7NE8w==
X-Received: by 2002:a17:90a:e7cf:b0:23e:f855:79ed with SMTP id kb15-20020a17090ae7cf00b0023ef85579edmr29725179pjb.28.1680268004333;
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-236.three.co.id. [223.255.225.236])
        by smtp.gmail.com with ESMTPSA id gz21-20020a17090b0ed500b0023f355a0bb5sm1465269pjb.14.2023.03.31.06.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
Message-ID: <730b79b3-5adb-c8a2-8eb5-8790860fc1a3@gmail.com>
Date:   Fri, 31 Mar 2023 20:06:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 19:28, Petr Tesarik wrote:
> +
> +DMA_ATTR_MAY_SLEEP
> +------------------
> +
> +This tells the DMA-mapping subsystem that it is allowed to sleep. For example,
> +if mapping needs a bounce buffer, software IO TLB may use CMA for the
> +allocation if this flag is given.
> +
> +This attribute is not used for dma_alloc_* functions. Instead, the provided
                                  dma_alloc_\* (escape wildcard in order to
                                                not confuse Sphinx for emphasis).
> +GFP flags are used to determine whether the allocation may sleep.

Otherwise the doc LGTM.

-- 
An old man doll... just what I always wanted! - Clara

