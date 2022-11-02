Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1608B61576C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKBCPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBCPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:15:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621EF95B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:15:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so627454pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ti4EogjuUVSAXjX8LKJ5hd8zLc80cVbv91Rg8a9RWk=;
        b=SXTEaTLbwee5S4XolBwI4kB+WP1KdH3mnJ3ahA/qoXfTtCtDsFiyAseNonjQExpXV3
         XLuYqXcX4CjgjbZDCXvLak5xAt966BJwAZ8cMbPpYmkubLfavf2PIdJ9qIHrAiWg7taj
         Ieeei7HD6EHVn8+ECUxxrcaq9oiuXK38JTtRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ti4EogjuUVSAXjX8LKJ5hd8zLc80cVbv91Rg8a9RWk=;
        b=IKZwYoXHxBWr14Nf7heU34HhKw1+0Rei9S4u9oxj6eVx6+A770T05uSTfCkL8wrABx
         euRyn34I/OehkFSdcOd2UQTBdn1KdJnEcER9oVoNNHqy7isa7y/yXPADBIXQKbaP5uiJ
         0B+c9dSlvYDASYnqMVzra+XhyyZfmlmR6ky8IIIkIDpsxMbux1xdWkn6QUtwS6799m2G
         h7/6uJlBERltxqjaYvy0wW4gpLzFvMrAW2Hgzs0JkOoVEpFycEXmSSSKtF25mveiBVgU
         CW0qdVgjWTGXQMWHUXKQSAALUipuJk9s0GGXTwDM1o5ISfNkQ9kbPDpEYRJ5ixE6lDEh
         NZkA==
X-Gm-Message-State: ACrzQf1Qc72HXnO/MicU6Kmm8IaBtwaVZ5OsLtC8BR+yVIdXrMBhurLE
        K045aBA3qPWrJOpMxMU6FjQG89rN8IBLHg==
X-Google-Smtp-Source: AMsMyM5b+oJlZwQ+kjV5skbKpGaSNTevCyYJYHxZ7APrAMcrG2wKPhqa9r8hcgYlWWqPfX7Y4lYMXQ==
X-Received: by 2002:a17:90b:1490:b0:212:68bf:fcc5 with SMTP id js16-20020a17090b149000b0021268bffcc5mr5661510pjb.52.1667355344859;
        Tue, 01 Nov 2022 19:15:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f63-20020a17090a28c500b00212daa68b7csm197048pjd.44.2022.11.01.19.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:15:44 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:15:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202211011915.02EDB6377@keescook>
References: <20221022182828.give.717-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022182828.give.717-kees@kernel.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 11:29:47AM -0700, Kees Cook wrote:
> This is so very long over-due. We just need to do this and put an end
> to this legacy operation.

thread ping. Should I carry this in my hardening tree instead?

-- 
Kees Cook
