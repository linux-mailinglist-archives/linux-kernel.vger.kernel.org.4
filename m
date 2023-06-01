Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9F71A14C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjFAO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjFAO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:59:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7810CF;
        Thu,  1 Jun 2023 07:58:44 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a1fa977667so1077158fac.1;
        Thu, 01 Jun 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631518; x=1688223518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKA7bXeTxOFAGtKnHALKsnYjOqM8LI5Ovc7qv8nHXy4=;
        b=VbnEgHTh9xF4ebL07QtrT7IKBEyHLCw0QVrUCnHaD6hD1lvRPslcpTX91zn3hAvWzx
         ulibMwWZFHmSArR1Js46N5RKP2nJv9bdUpXM2WSng5LizAhofHiXTVQQfqca6v+jPXKe
         HvtDu/CfmB1slVve+kXxvvQ0BgNQJ3XFLLqvuZMoYiQKb3LIzutxDOewUsQMmH2E5ZVa
         nUHXWQZZVE+BdWPLsAQyGecmA2uHxI7IzhaUVupAxOYA0OiDDmvfeGiXAf73/Shha1Et
         jaG3ST69YQfcksirDQfDNwj+0zv225EuOKqX49xfmOB8NdSNiTprBZaCstS6qLkW7u3s
         Wowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631518; x=1688223518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKA7bXeTxOFAGtKnHALKsnYjOqM8LI5Ovc7qv8nHXy4=;
        b=To7cGyUqyYD69uxMBNDAekU8d+UxwlLmpaiZwJF5rPujpm9kfkdkoDy197IqfaeS3+
         l9MUl4jZH3rN9mvXX+BQTO3cTkku6pMy6NyOlHVnb588Fwt+uYQi1xkBcRYMTVwL8iFX
         x1BuXRSisQb43GMyPPZNs49fiL5UAxd44JuScZwLh4725RQzeiidnh2K0rn1PSV/yuGl
         Pjj79XS3bz8j35V1iO//ul6Bb6SCgLcQ6zsVlqnXA+5qBSjYQJoT0fNle1BeGY/Pm9qu
         OZwHb6wbYuxKNuOezQ4yQpLgH2X5eZnHt2CwPKf+nodL5PR3/GgWh+IPNx9vaH27o/r3
         wQIQ==
X-Gm-Message-State: AC+VfDxXsAw/3QOYiTQCQaeHsTYQfm9MeB/srGj7U3MQXWbyAWlDcEuf
        C/ZhQ8ezxetBv8AxTCt0imU=
X-Google-Smtp-Source: ACHHUZ6yE1Id0grKqywwZgmTdnr0O2dPuH6cit6vXBQMcYrvks7tA0S44ZEnYsykFDZRKmPXN90PAQ==
X-Received: by 2002:a05:6871:6bb0:b0:19f:af14:9e60 with SMTP id zh48-20020a0568716bb000b0019faf149e60mr5853140oab.8.1685631518122;
        Thu, 01 Jun 2023 07:58:38 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q7-20020a056870e60700b0019ea8771fb0sm1757100oag.13.2023.06.01.07.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:58:37 -0700 (PDT)
Message-ID: <5e5e1590-ad97-4590-1db8-8ce89840b9e3@gmail.com>
Date:   Thu, 1 Jun 2023 11:58:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 8/8] rust: workqueue: add examples
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-9-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230601134946.3887870-9-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 10:49, Alice Ryhl wrote:
> This adds two examples of how to use the workqueue. The first example
> shows how to use it when you only have one `work_struct` field, and the
> second example shows how to use it when you have multiple `work_struct`
> fields.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
