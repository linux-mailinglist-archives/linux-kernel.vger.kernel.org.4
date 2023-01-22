Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3606772AA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAVVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAVVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:30:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE815C85
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:30:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so12799444pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6suFEBiFDBF7/CgF8yysN0WnMM/zeevTLOn21QRMh5g=;
        b=U3fFjDYd3i5BTixCoy3mHhFVdE84HIxh2ZvHx24pGbEEM4cQEd3uO8HDLNjxuHaUKA
         kFBY64M+HsxGxEew3fiXjZ92Fme1kq9EaHBH63GBfJRRWjBpDETftQ+Xa56pY/tRtlI3
         Cr15urd2k/9JUky0lwhnSOOqorjOoYY0fdusoupEh1+qiduFDnKBDKN6Wcl+tmMr/wWc
         RwIe34sn5mTLh2Nuo1och99U9TPzvYX4A3BR2bU8KUM1nsicKkbrKdiTWAQb+jeE+qSN
         aJLJuS+oNG4IkshelVm+jAg25wDLNg4V9J0T46HYHK3ztgnVahVhr4bDrtDU3UzXbKXJ
         v/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6suFEBiFDBF7/CgF8yysN0WnMM/zeevTLOn21QRMh5g=;
        b=d2omnhQo1l2qsQ+DVhNdJqlFNu+HrvkL5Yq8QU3N4MjKQWcC4nNilymjKV+ZAAJMRO
         ZprvMe14NsWkfOcl5cgOCoqns/Rhjc9dMs1YORftB5Bwwwt51LxwZ1PcgNzK9KtJ+vgP
         0w9zX8ht5GBNM9BmhJQB9m+SPjtr9OuBSZy141CEoNV7orFLKq699lp4WZP9r6Zb/XZY
         +i2CdepHJz0PQzt0QZ+uNue6TyhyatgQEsJ2koo9RSN9wJFoMkPMWzWDajhA4KNimBda
         ftN6jzOyRCiiYelAtwdYpqjV51VywLf0D8iTI2kvJQGbQq0VyhHwmAv+HSoUzcAqIDJJ
         lEQA==
X-Gm-Message-State: AFqh2kr0Mhki478JNv+W6+Ds16dgibbufEhGaa7vQOrTs434ACrVRPlx
        V1FO8Ffsv5rlGP7Z4BAo4anntgLEB1PNp0gi
X-Google-Smtp-Source: AMrXdXtFAqDQScp/WucJuxYs0KLE3WhgT6lq/XT8dORGasu7uK9h74fpyhMz4sPX3sseoSA0/DxpHw==
X-Received: by 2002:a05:6a21:c00f:b0:b9:5fc3:6441 with SMTP id bm15-20020a056a21c00f00b000b95fc36441mr3070423pzc.0.1674423016663;
        Sun, 22 Jan 2023 13:30:16 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090aca8900b0022bb3ee9b68sm4290655pjt.13.2023.01.22.13.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 13:30:16 -0800 (PST)
Message-ID: <61a0120a-4cff-90c0-6f87-4957aaee7a0b@kernel.dk>
Date:   Sun, 22 Jan 2023 14:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123080830.7d50fccd@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230123080830.7d50fccd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 2:08 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   24337ddf1ff4 ("io_uring: Enable KASAN for request cache")
> 
> is missing a Signed-off-by from its committer.

Fixed up, thanks.

-- 
Jens Axboe


