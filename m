Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD960DDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiJZJJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiJZJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:08:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59709E6A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:08:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id be13so27295586lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxvYJthqzz9Ch/FqWQ8XhBVmiJuFjTiWQBM9GNthY1Q=;
        b=dLq1lvr7ijuQYVhxr6ksYWfPSV5MW7jkOz7HomVM7JcsvhE7pEA3RhV6nb/khhtVRf
         xuSIzjunoHk9DH7ihAoreksPSOu4eRXykeH5HfgbkW552dDnfWToCOKg0ltwZyo+PMvt
         3AEHCAH3JOJoE114X7S+cXXfy4jvpZPEWOIC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxvYJthqzz9Ch/FqWQ8XhBVmiJuFjTiWQBM9GNthY1Q=;
        b=N3v6fw6ztCvlemxoZ2aqE3a97BlD9kmEfMKkWalL6/VNJxwCYZ22T0ZbTgtfo2UzLp
         Je5UNk6xEjn9oYLZfPyP8W362vUGky8lmzwXj5BXc1ETuXbpQdS5+2VLYFEYz5vE75N/
         bgVq4UTr4Q35RPz6gKPkL8KvNDhebb+XWiOVqdDG2nRYVy8LIU2RQIgz8aE6aRnLnHEl
         KF1eHwPJhjSyhwwS0yxtJf7N1UubJ33b00/jqwbsP+3+po4dMonal3QrLjnZ2QM5HW5h
         r/bfQVerXh7OnP8jCN/7M9Dy6fNyA4mxcc5XYSNpkc2K6y+nBIVRNl97V6KAdH2e+smV
         0ugg==
X-Gm-Message-State: ACrzQf03bVl+TDTQHQ1tRcbc7WORlZuLz+s/CYn9kpdy9ZRUm5NEer2k
        NzPpOLQ4gVB+VDviKFoRMnBDjw==
X-Google-Smtp-Source: AMsMyM6xUY+dz5Tae0JqZ/Gt/+e/3j4bX9GN6Q/duxsMwusZHTZGtpBDWt+XZUOl2BllGHQisMALcQ==
X-Received: by 2002:ac2:4c03:0:b0:4a2:2273:89c6 with SMTP id t3-20020ac24c03000000b004a2227389c6mr14264301lfq.245.1666775322987;
        Wed, 26 Oct 2022 02:08:42 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v24-20020ac258f8000000b00499f9aaa9desm767405lfo.179.2022.10.26.02.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 02:08:42 -0700 (PDT)
Message-ID: <a5233381-4081-afce-07b5-72d653eeeefb@rasmusvillemoes.dk>
Date:   Wed, 26 Oct 2022 11:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221026053922.GA19206@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 07.39, Willy Tarreau wrote:
> 
> No more false positives nor false negatives anymore. I'm sending you
> the patch separately.

While you're at it, may I suggest also adding a few test cases where the
buffers differ by 128, e.g. 0x0 v 0x80 and 0x40 v 0xc0.
