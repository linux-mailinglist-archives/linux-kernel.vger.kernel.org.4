Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C064645B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLGW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:57:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C1201AD;
        Wed,  7 Dec 2022 14:57:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4472615pjb.1;
        Wed, 07 Dec 2022 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjGta1oDX6IdWT6WPqCF/5mm9nV5vOqTsTIu1TCC9qc=;
        b=ewYgGJIQD1H+ia7Gf468w1wac7/IQYHWkha8NBb4nQfYN8Mb7WIj28A3JSoMO8ORxZ
         aC7JAxYlFevCpvdDzDF7AbGcob3l+JOd4zrWQel7TyG32KFciALM+YJ11bMqjAFa2JHy
         AITMK2Ya8LMUEm/LFUMGWcRmtPanZcESBe3W64MWHlkbZo9O4BGmHgzqa/pMkIrIgvUf
         EdGUkZbXMVYk1uQvx7fqC9ACzOVSHcqFnkEQXmPkOYMGm+bqccTgqM6JEsdxJvDTgN/2
         4YyEPwwBYN1WS3elm3MSOXls5KaRzD2jBfNpUklvriv9X9Y/8VIaP4ufGc7LfCkLG6mC
         5RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjGta1oDX6IdWT6WPqCF/5mm9nV5vOqTsTIu1TCC9qc=;
        b=1AKhg7+AWoJVV4wSizdFrbssNYgN5jFAk5aNNZnz4ZEjwX/jprkipgeImOtkiir9wy
         gG1iE4h6uvh2wSHbbB8327VnDxVpLoe5fd+YPUBU+e8N92W1b7XBUODshxXodaW6bC5y
         orvyInnglyF/7exL54dMPhE2BKQVQfLHaqhvMp9nPtQs2E+qQPi4hhlkaP4w6Y3WuTHD
         ewCbG1PROwj9ILXvl96utzmD0fTzYsmCzG3W8mkqyZym3roBYl++f2gpBHWQaUwX9+xm
         OF0J6JjQWM51TQvFIY+8O2T0hd25mVClkgotvQMLVUwC6SMZ4sBxec/ZhLzsoGGbdk54
         HMwA==
X-Gm-Message-State: ANoB5pldz6mF51SrndFc5fQ44ZPCrBFLeud8AHZiMsCTQ2MeE89icAur
        Y+mKnMw1dDfiJDeXOP+z0vA=
X-Google-Smtp-Source: AA0mqf43/RZXu2nCjF/73sn5835DiPfFelfjnNG2VzLc4ZdmFshJTp+t6A52J7Qszx2ff7Lp+qNvLQ==
X-Received: by 2002:a05:6a21:3d0c:b0:ac:ba82:f6ab with SMTP id bi12-20020a056a213d0c00b000acba82f6abmr719376pzc.33.1670453875063;
        Wed, 07 Dec 2022 14:57:55 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id gw22-20020a17090b0a5600b0021885b05660sm1662580pjb.24.2022.12.07.14.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 14:57:54 -0800 (PST)
Message-ID: <e3d15de9-521c-5017-112a-6cc7fcd54437@gmail.com>
Date:   Thu, 8 Dec 2022 07:57:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] docs: Move rustdoc output, cross-reference it
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, ojeda@kernel.org, corbet@lwn.net,
        jani.nikula@linux.intel.com, rdunlap@infradead.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221207173053.1463800-2-carlos.bilbao@amd.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221207173053.1463800-2-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2022 11:30:52 -0600, Carlos Bilbao wrote:
> Generate rustdoc documentation with the rest of subsystem's documentation
> in Documentation/output. Add a cross reference to the generated rustdoc in
> Documentation/rust/index.rst if Sphinx target rustdoc is set.

The note on rustdoc won't help much in non-html outputs.
Please apply patch below on top.

You can keep my Rb tag.

When rustdoc arrives at https://www.kernel.org/doc/, a note
for non-html outputs directing people there might be helpful,
I guess.

        Thanks, Akira

> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/rust/index.rst |  8 ++++++++
>  rust/Makefile                | 15 +++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index 4ae8c66b94fa..4fc97c1eb1d1 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,6 +6,14 @@ Rust
>  Documentation related to Rust within the kernel. To start using Rust
>  in the kernel, please read the quick-start.rst guide.
>  
> +.. only:: rustdoc
> +
> +	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
> +
> +.. only:: not rustdoc
> +
> +	This documentation does not include rustdoc generated information.
> +
>  .. toctree::
>      :maxdepth: 1
>  

--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,11 +6,11 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
-.. only:: rustdoc
+.. only:: rustdoc and html
 
 	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
 
-.. only:: not rustdoc
+.. only:: not rustdoc and html
 
 	This documentation does not include rustdoc generated information.
 
-- 

