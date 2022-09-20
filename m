Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4C5BDEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiITHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiITHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:55:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233811C32
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:55:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e16so2872859wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=AK7WxZbNSpstZXHolRJnrYd/asJAdENTOvZne+528Sc=;
        b=MrbwwxQENOrsWdh3anhqti35FxrranPGzZYH0Of59nH9kzcRNSH4ztrEytR5lgyMvU
         Njk8ENLAEN9tkJcUBkg3QXa/BEzLKrjcBn91BlgAy0DYohqzI88yWqvOV42ll7ZA+Alj
         kfjRl3s/TtWwCXeOgJaccK2NBya71a3I7FudmofZq1YOF48NMuZ6/l9/vadOB1nuAbxA
         BJE6/x2Z5tMIVtHqLbYtM+PBXDnI7x4/do2+W+EpQD/ynyByVIMEHq5JuzKcFM6BU4BI
         798I5x6JoQKuulPEWOk+PwQ/mnZ4ZJiE/GhtSarvu9hclxKUkRsExoXpXOHgztsA3oJR
         QjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=AK7WxZbNSpstZXHolRJnrYd/asJAdENTOvZne+528Sc=;
        b=byAxcM+lgaNZDKDx7gOdk82bA0DQfWTn4WdTwvYvFxkgO5IKkykSeoW1/jVe1uGTs7
         HG4G7aGOfP2ag7j6BplkQZch8L7KOO6h1Ob9Ae5wS8qbr2/VP2E+PEsIg33kX8j1waE6
         0RGjk6pmBkBqzRNj44zgZeEOVKaYMC7oElAsLWqf9aquagFZHSZlouDA07kLcoZ737jk
         xmHIdUkA7G8ALDans9Aq63m+jGw4GP5KKAZ4XKeeA8njD3cxgxijvLl4Qp1Zs0CRTeXE
         thlfwj1alrN9vpVSIJrEjgQYrlLhFFS6UhWT38TuyW7OLomsWHvqZAIQaDaLTioJhhdw
         BCDw==
X-Gm-Message-State: ACrzQf3QWZweWYEzcVMoFaWAYZLWrshUD5N3S8xC9q7yysg8PUW77bJB
        39gW5JO/L0JRXsHQdvRdzD0Deg==
X-Google-Smtp-Source: AMsMyM4iaLz4qxA4Z1YihK5dxBVhKpKsFQWBGAwwPro6NRa8O1+V/JvV5TQscgz6i0VLxFudoD5vSQ==
X-Received: by 2002:a05:6000:110e:b0:228:c336:b1db with SMTP id z14-20020a056000110e00b00228c336b1dbmr13707459wrw.194.1663660499603;
        Tue, 20 Sep 2022 00:54:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ad91:24d8:d1d3:3b41? ([2a01:e0a:b41:c160:ad91:24d8:d1d3:3b41])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003a62400724bsm1563923wms.0.2022.09.20.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 00:54:59 -0700 (PDT)
Message-ID: <a78f7a93-9eb8-fb80-561b-f4cdc42c016e@6wind.com>
Date:   Tue, 20 Sep 2022 09:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] ipv4: add documentation of sysctls of error_cost and
 error_burst
Content-Language: en-US
To:     cgel.zte@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
References: <20220911085737.14230-1-xu.xin16@zte.com.cn>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220911085737.14230-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11/09/2022 à 10:57, cgel.zte@gmail.com a écrit :
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The descriptions of error_cost and error_burst sysctls are missing.
> So add the descriptions of them in the documentation ip-sysctl.rst.
> 
> Signed-off-by: xu xin (CGEL ZTE) <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang (CGEL ZTE) <zhang.yunkai@zte.com.cn>
Thanks for reposting this patch. You need to cc netdev, else it will be lost.


Regards,
Nicolas
