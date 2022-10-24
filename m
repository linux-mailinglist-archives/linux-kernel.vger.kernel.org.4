Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26213609B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJXHLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJXHLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:11:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC75282D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:11:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so6405103wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TUGbLVodhqYZAO48Jh7YixM3z7THsbgGkk7yTQHPn4=;
        b=IfQWciidN5eGqk3U0o3jp7tUVhcbsfzZ7IEBVEKSN+4P8q9fSCrWRg0pZK1eqUCbmz
         3Z3Jo/y4qFjnXclJwRNMbbta+GiuPT6fENmiBwBkuWvaq4bVhgYxxMCWtbL7rk16u4eu
         1LgHX8soadTaXvyOVgnY7pPdDGTdh2jGx3LGwgX7BB9W+7VqTPW2ZkFIGuCAUDmOrRRJ
         v9ydr2ePVYCCMxFV1p/Njw1qjqXAiIae7ra/wp5ER2gC/8z99pKloSv2q9WmbR5PTVaL
         /8YIN9fIY+xLFuOAELGyBFMmUYvkkwBF56GD43WX6UDbul8cWV7qOmVcRBzRvYIHMAzq
         g8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TUGbLVodhqYZAO48Jh7YixM3z7THsbgGkk7yTQHPn4=;
        b=Z1rRt1lERBWsjDy/XFZxDoSeJwp1Y+G7RORWchOh1TdH3b22uOCPUcVbMfq6bVILv1
         uuGEl0rP/M14Abx2Et9MhUhOERWVOCoeaxGWyTK8jnbahSpEE+wgFej4kDCKlNhKKGaa
         kDf2sQ8GVvM5BhqSN5x0hFckJdnvMotzTrMK2tKqkKnvV6ujmurQ/ckF/45BgJx5IRL+
         hHfmPRe3FScviZM5aHHXUTStiK3j5o6nPEelzDsxPVc3y63wHfSrHASg5pp3b72A4bbl
         EXdy6fmzJJil3bnGzN4yqh+8aMPXr+kDZaKG8sme1YAKFikbHqFlJ/mC07m73lmLFgSb
         XStw==
X-Gm-Message-State: ACrzQf3Xz5xB+gc1TIEd/J2Ek1mfW0Izsx2U6q+kvEH5YqrCzDqdqGW8
        3oIeoPmqtMm0JPzeH23q1vDufuvzaYE=
X-Google-Smtp-Source: AMsMyM5e8ZI08C7XosDYT8Psr/OgtF7RYIvOiUEsFl0SoxdZbmWoRUn7p2jcaPpbIhmDUhmzk6roVg==
X-Received: by 2002:adf:ef82:0:b0:234:ef87:dc8d with SMTP id d2-20020adfef82000000b00234ef87dc8dmr15699706wro.297.1666595473633;
        Mon, 24 Oct 2022 00:11:13 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b002364c77bc96sm9665475wrz.33.2022.10.24.00.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 00:11:13 -0700 (PDT)
Message-ID: <4f3eef2e-ac9a-d307-2e0b-be7b897f1df2@gmail.com>
Date:   Mon, 24 Oct 2022 10:10:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] char: xillybus: Fix use-after-free in xillyusb_open()
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
References: <20221022175404.GA375335@ubuntu>
 <9674abb2-b40c-3862-5272-58b643dc91e1@gmail.com>
 <20221023142614.GA385798@ubuntu>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20221023142614.GA385798@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 17:26, Hyunwoo Kim wrote:
> It's probably better for you to work on it.

OK. I'll be back with a patch soon.

Regards,
    Eli
