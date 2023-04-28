Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653FE6F1ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjD1OqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjD1OqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:46:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4AF61A2;
        Fri, 28 Apr 2023 07:45:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b8b19901fso56942b3a.3;
        Fri, 28 Apr 2023 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682693135; x=1685285135;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8sjpzzaBY2e0/v6AlI9meMXx03JqnmlUQu3gzvDUEU=;
        b=Znb4btGpUzMvQI0f4y1uGKUelyEpulesT3wU3406dWvlQSWNinhiL6hRG7iNsgJvgf
         bLNUEjd6skj4Hg14PxZoRsZWUMjXay3SZ9Xj5x1Y7+gAjBbNF/VRVTfSZKZ1LdLrTFdd
         huHFhiBBFx3JmUHRdQNq2LCsFx8qhp/L6d5TELOZccBulQWHf4Vvvlwq2IsvJtvdAOau
         ygjV+kouChxhkfFh9F3FBogw6YpQ2OZNyK5dKbRTnU4swIAz930tQRtyygI8YtoOLcsq
         H2pBLejxOOL2UJhsfVejTX5IWNjZAit+t9dIk/lR8h75FtbnqyNhcEzVcAGXki7SmNiq
         ZdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693135; x=1685285135;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8sjpzzaBY2e0/v6AlI9meMXx03JqnmlUQu3gzvDUEU=;
        b=O88w4LY4GuOr1W5yyW9RUd8Od0s6DRQU3JXYB+HdbbSrGo6ljCTRzGIyDFK5VefGvE
         Sy2BUqtBDe1XpmPhSh9/jKVLR1Sgr21vZ5TVN6EoJAvyXmH0LkjQfYImzLlj1s6YEGEK
         h2m0z8Rgu6D1iaTIEx+by2qJRaj/V7mvePceG2+GBJnOOWYANYoYKZvOo3cdGEA7O/O3
         u1vaPKg5kcMjRoy9qiWukWVfkFKOxgeRok+OX93XXMsDlRrECSLc1b5AnDEMcDUnKmst
         Jt+kLmQAGh8k21xNswefgzD5sQKlZZwgaLgNVYcJqRSx78Q6ld128RaMi1sl3iTiRqMa
         Egdw==
X-Gm-Message-State: AC+VfDxEgoc/jaLePhwAroYQLLlAvibRULdfFiJeKLw3zF0usVXRUiaD
        Ow9rIfdN+BH0LknRMMs31oE=
X-Google-Smtp-Source: ACHHUZ6fdnpihgnlbzjwTd8FPQUwiyaNK9HjhIxBSXmL6+k5eZX2PkVP5hqSWxcosJxAxwIlpBRgXg==
X-Received: by 2002:a05:6a00:2d02:b0:63b:8a91:e641 with SMTP id fa2-20020a056a002d0200b0063b8a91e641mr7898671pfb.11.1682693134637;
        Fri, 28 Apr 2023 07:45:34 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b0063d63d48215sm15227734pfg.3.2023.04.28.07.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 07:45:33 -0700 (PDT)
Message-ID: <71c91ae5-2ed7-cfd5-7b7f-6cb5a0141816@gmail.com>
Date:   Fri, 28 Apr 2023 23:45:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     wangdeming@inspur.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shibata@linuxfoundation.org
References: <20230428091018.1558-1-wangdeming@inspur.com>
Subject: Re: [PATCH] Documentation/translations/ja_JP/SubmittingPatches: fix
 some typos
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230428091018.1558-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-CC: Kosuke]

Hi,

On Fri, 28 Apr 2023 05:10:18 -0400, Deming Wang wrote:
> Fix of  typos spotted reading documentation in Japanese.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/translations/ja_JP/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
[...]

Your patch is rejected by "git am".

In the header part of your email, I see these fields:

> X-Mailer: git-send-email 2.31.1
> MIME-Version: 1.0
> Content-Type: text/plain; charset="y"
> Content-Transfer-Encoding: 8bit

This looks broken.
Please make sure your email header has a proper Content-Type
as shown below:

    Content-Type: text/plain; charset=UTF-8

        Thanks, Akira



