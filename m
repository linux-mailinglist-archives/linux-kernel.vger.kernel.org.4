Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32BF6E5753
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDRCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDRCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:11:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C31A1;
        Mon, 17 Apr 2023 19:11:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i8so18736350plt.10;
        Mon, 17 Apr 2023 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681783880; x=1684375880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30LF+74h47bireainrLuyJUJ7mJ1XOOzx7GiLgJnkq4=;
        b=lgkprahT40tqQeRc4PO26Jp/f18/2SbJOZQf0Rhiw3RdsSerCuGwlFNmBEBazdCknI
         1/ZNAi+HB/7xO5nWI4pc3DkshTdI/AWrr5IFFTmGLAoiTlwCJS/RioNsYY/PTixuKDtb
         1W89nrBXfwjrc2PoiqlidrkS6EzALcqxlRqP5sauwaDKhiD+o+mvXRPTRe9ytQXotRkE
         mELBOZ7L1kwOk2bFVG+bbPvJ+22RPs4aFg/tfkm/wSnXXDR9+BFzMLW7NyxSRs+MJgdh
         J2ccFcCy9DCBXD9d8IHEMVPVFbHXuQhQQj91KesPm2lHjhnrqhdHWjv75MlTWVl5n7qW
         CGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783880; x=1684375880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30LF+74h47bireainrLuyJUJ7mJ1XOOzx7GiLgJnkq4=;
        b=hhlQEZuPs7d1lCIHdZiHDuvRIerP4bKpovfMxvnX9LQw/YcjRJh03OsaeIZw7BKT1s
         kw7ivC5T8SXT7ozWwQhcuMORhfnADkF1pPJH5sbuUHzD0eQbRpcxBrYFWNBlyz73LSac
         zzMEkd83V7r0/5TRWLcnKiZY9GO8CmjGSF3Y70xfqXmcZtMa3oNfHf4ms7QdArxVuJOh
         ZpsYQDQGFXjpCGKflL11sVWgBZaMK7JtDY603xAp6D8dMo7zqXkB0bkCcyMhJsBVEXbP
         EtgyCCiBNq2vB1j/2B/3zHjDeo/9s4CJ5TxJ4ndDZeHbf2Z3IC+PaVkkyxp9LVObdRUX
         rAdg==
X-Gm-Message-State: AAQBX9fQFywKOZPcl3k+YXsPWpwtK2oP11CesPI5Fukk/XNH3ZwhRfye
        Om3qScnVGwW5Kt+DpSOqQh32Z5UxzEcpFQ==
X-Google-Smtp-Source: AKy350aOOiDkLzk1dzYsDdo+Y5rFtFQYG6MGFGKTxrR5ASI4L+Vshmq/XhawN6xegxioU96rxz6k6A==
X-Received: by 2002:a05:6a21:7891:b0:ed:ca22:a1e7 with SMTP id bf17-20020a056a21789100b000edca22a1e7mr18463189pzc.16.1681783880149;
        Mon, 17 Apr 2023 19:11:20 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id r5-20020a635145000000b005186e562db0sm7581267pgl.82.2023.04.17.19.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:11:19 -0700 (PDT)
Message-ID: <4517330a-00a3-220f-2fc5-a9ef4aba5ea8@gmail.com>
Date:   Tue, 18 Apr 2023 09:10:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] docs: f2fs: specify extent cache for read explicitly
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417044100.56409-1-frank.li@vivo.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230417044100.56409-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 11:41, Yangtao Li wrote:
> Let's descrbie it's read extent cache.

"Clarify the fact that extent_cache and noextent_cache toggle read
extent cache on or off."

> -extent_cache		 Enable an extent cache based on rb-tree, it can cache
> -			 as many as extent which map between contiguous logical
> +extent_cache		 Enable a read extent cache based on rb-tree, it can cache
"... . It can cache ..."

>  noinline_data		 Disable the inline data feature, inline data feature is
>  			 enabled by default.

"Disable inline data feature, for which the feature is enabled by
default." (submit as separate patch).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

