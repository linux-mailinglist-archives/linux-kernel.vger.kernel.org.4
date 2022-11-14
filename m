Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1316282FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiKNOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiKNOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:41:47 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74592C66C;
        Mon, 14 Nov 2022 06:41:44 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id d9so13966645wrm.13;
        Mon, 14 Nov 2022 06:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvyXMscut8YtEUKW0LG7nYy3yoEfhlS82oiHCR3CSTA=;
        b=OMtXP03o2RsRE+P9rIuBiz4HGT4vnoxFx7QQPpBLPEnj4h4ln56Sk5BvLmwyZQ1l8J
         rl7MWva+9BHGbw6VZu858Mv0O3QT3JsrS0ORfwhDUSB+o2cs1nm4d6EeOegDE3h8tLUU
         hHHA4HuqtwrIYW9dBxh6l20kIAigUbcTKvQFOEe8mNCrjJJAIbf93Q7YBBcn1RMuyILt
         9tb1Rp3Slk/W/c9FDtJsSZlNkAmUMr8EQZUKBczQ/jnrK7tu2adU/87uEJfza+mgv0jA
         6m3ojO+UIQVo8E1WaSFyWWPGiVEdbsMzskxC2cAQZfKoEPC/d9w/BaFyzzkRB2SqNW47
         xtjA==
X-Gm-Message-State: ANoB5pmnSDlNepyOSByOUrJSA1yDrn6clMX3SjBWWZC6Vrax49rdQF6h
        i4CuJ/fnlJ/czryWhrmpSWU=
X-Google-Smtp-Source: AA0mqf7A1q532W+LuavPbVaU6245v6ZBJf1IycKelwo/r+3ik49TGY4koSyx5vprQlZib8ZH7EERyw==
X-Received: by 2002:adf:fc02:0:b0:236:ea0d:e49b with SMTP id i2-20020adffc02000000b00236ea0de49bmr7933863wrr.472.1668436903315;
        Mon, 14 Nov 2022 06:41:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm13149048wmb.39.2022.11.14.06.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:41:42 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:41:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 04/28] rust: samples: add `rust_print` example
Message-ID: <Y3JTpdt47xuY/8cz@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-5-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:16PM +0100, Miguel Ojeda wrote:
> Add example to exercise the printing macros (`pr_*!`) introduced
> in the previous patches.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
