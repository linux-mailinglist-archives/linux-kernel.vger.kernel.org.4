Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20270627AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiKNKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiKNKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:36:53 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF951D675
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:36:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t1so7155514wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYEO6wqTqv+FmuwBR3/AJzBYR4CPg3qT2Kq0wYLhKiU=;
        b=tZ14j0SiCf8JV93gqVeXeoWfM+JsdMsHV2hntvr+QN2dDMd/uYDN8Wpx/KxozF38wD
         cZ2zf7uJI0snn1TDL51ODIZInsW6uz2FS+6paUlffxk+thi8mXznjk602tO/vhADiDN0
         MRx1Tg678u2DOEmJd8BUEVdBBjSBqvW9Fp0+4SGqjK++QQNLm1nclhETcIit0kUvdPYg
         hu0w61TUI8olMpc0jnrFPaJqeu3CEtn7Z6XvcNME/5/wU/lpw50e+Cih+NRPIZajk/6W
         48iqJDud2eFeYCqWa63NbiTYQ7WVA9G/bVrcg+ZKgas4AHTg4bzu52zPTX1UlxV6hYq9
         h+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYEO6wqTqv+FmuwBR3/AJzBYR4CPg3qT2Kq0wYLhKiU=;
        b=h7LjyJrzGsRVGE0wJhK5C+iJXIFNTwoSyF7K7QsBccyc3R4kz4bDu1koebMJ/amy2o
         uQqe6oZl7MJ+drmUub4rDFAKBrpefkziKvw5PjbAnZYMM6poAu7md+H+sFp8cVudLFau
         bNcQRH9lfodcXldFOtTMZQT4vK/SIJSquWzklQo6f4qNUeOmvMag+X3HFyPs6jFzx16G
         LePO4it+pJoNtgbDmkKx0IL9or93cGe3fKe2Q284PeeWsCPOGsjOQarEvBGEbmfmCZ+7
         cT7HDtXbChHotegbwbRnCTkBktDwqTtORSQ8E854bIQHq7vRTT6KVDq5/qmrPNkzsdNy
         lqQQ==
X-Gm-Message-State: ANoB5pniL8GDhv9ObgzpVie1njuYCBnuUYNeVWXXMd8yz+4tUgIhRi7l
        IyP6Ssprn6XZ85D+sFjf3fgI9A==
X-Google-Smtp-Source: AA0mqf4YJcvPTrnfwB9SxJQj7zSWXRYmGMKX0EaC/tn8RkPDskfV7YW9kGN3LU71V3Da614+gWPRhw==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a18d:39b1 with SMTP id f22-20020a05600c43d600b003cfa18d39b1mr7168244wmn.149.1668422211083;
        Mon, 14 Nov 2022 02:36:51 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g7-20020a056000118700b0022cd0c8c696sm9001984wrx.103.2022.11.14.02.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:36:50 -0800 (PST)
Message-ID: <015e90c1-b70e-c93e-d757-1c2a07c35f36@linaro.org>
Date:   Mon, 14 Nov 2022 10:36:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Signed-off-by missing for commit in the nvmem tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221113205734.40500074@canb.auug.org.au>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221113205734.40500074@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

On 13/11/2022 09:57, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    7a69ff9c9bde ("nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env")
> 
> is missing a Signed-off-by from its committer.
this is fixed now.

--srini
> 
