Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96613623D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiKJIWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKJIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:22:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE11F2D7;
        Thu, 10 Nov 2022 00:22:49 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q71so1094165pgq.8;
        Thu, 10 Nov 2022 00:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BG2nzthEmyoGwZ2xnXYghTQwVyPBN3+wYVO3ZQp4p8o=;
        b=qEGP/jzAGERpSJ2HAdKdjTD3CLELEnHqw0Od9noXgvj2iH2RfDvff1LdH+PFNUUP9y
         3XFAj9ZZSpw6XG7RpoHLC4lxpOwx5KbjG3yE8u+TY/rAiGJYIVyw1yvMZTTXk39AdlZs
         JCNY6jTmCiKJOzMRaOGvT0Kq6Q7TE24v7GyytyyIMia63isqtreovofwjwPTSx5Y35iA
         nRDv1glNFZ2eKOLFyGJgZ4UTewJ4VfPd7qmw3/zQ1NVqS/6/yB3DsQMFDFOwJm8WzPwO
         enC8/nsjCwW84dc/ObApWjlsdN1XAaN7IWePQCoAWwxYAY6YyUwlItSfYH3s6FTz1zLu
         mXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BG2nzthEmyoGwZ2xnXYghTQwVyPBN3+wYVO3ZQp4p8o=;
        b=gEAkKqn1k3gtOJ6TuKduPhUru4EFOGJ5zSf54zEhU3fQF/s3p/p4xrVj+czUcCYgOc
         5Ys7bRu6jRaLz36WzLcjY/IKL6Iqr2Nf2Cm3eUF06Zrd+cYhG1kHgErBpZesDAia4V2l
         pI1lVWWdcJNyU4ax/GnhqOP8whpZHNsMNGNdtEAEL3JSFKAiVXA7A+C74VXw/BSyeLJv
         7fplvMyX8kguvZNeewTQbPINbMCyXi9GARIs1Rm4oFh1PviY/+0uSBiEoqw21GAnidGT
         wqL1UKoqEAAYQXymue9vkqZRU7tVKyjfgxNMLfyQ+X0hCcgEJYZFZYQQs0nmJ/FYPdDK
         MUSA==
X-Gm-Message-State: ACrzQf2G8B+dIWXMaewYXwIKnrApmgmzD9LhDceYHR815vzzhThk3/uv
        JzFzshPPU1DgMoxyRHtGI+U=
X-Google-Smtp-Source: AMsMyM7PmkX37DHPRpa1E+mx91ZBJY53DfFvZFhJAYLfvahogpFu57m0IgO8z/L56jKPYQ53iJQ8Pw==
X-Received: by 2002:aa7:8c0e:0:b0:56b:dbab:5362 with SMTP id c14-20020aa78c0e000000b0056bdbab5362mr2087321pfd.47.1668068568645;
        Thu, 10 Nov 2022 00:22:48 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id nm13-20020a17090b19cd00b0020087d7e778sm2516887pjb.37.2022.11.10.00.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 00:22:48 -0800 (PST)
Message-ID: <dd4deb4d-ec9e-8cbe-2835-d8b9931e7f30@gmail.com>
Date:   Thu, 10 Nov 2022 15:22:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] f2fs: support fault injection for flush submission
 error
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org,
        chao@kernel.org, corbet@lwn.net
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
References: <20221110032522.64043-1-frank.li@vivo.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221110032522.64043-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 10:25, Yangtao Li wrote:
> Since we now support read, write, and discard in FAULT_INJECT,
> let's add support for flush.
> 
> This patch supports to inject fault into __submit_flush_wait() to
> simulate flush cmd io error.
> 

What about this description instead?

```
Since FAULT_INJECT have now support read, write, and discard operations,
add also flush support. An usecase is to inject fault into
__submit_flush_wait() to simulate flush cmd io error.
```

-- 
An old man doll... just what I always wanted! - Clara

