Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2463B6C3DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCUWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCUWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:42:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B058C09
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:42:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f14so7675311iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1679438531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jDzsttz/Z1eHYKj405pV9Blev59eyzoaBzMYfjRtNs=;
        b=FbuEPLzjGcUCi2cFfW7+KLrqrWm95kIC11bt4fzbF/b61kskPlMJluOllYVw1m0h6A
         wjtYOFhDA9Fwh/wB2xK96Ao7cb0XoGBINiTpnnfE8nTFlhkeZaF0oJ37B6Dm1zkZQ/6I
         2Bw+XaNr4Si9JrMDXDNLAqQh3VFCWoWLBsdEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jDzsttz/Z1eHYKj405pV9Blev59eyzoaBzMYfjRtNs=;
        b=ZyAju8gIxpjireGgW24UTXKoVdAEwUYNzrqVh2RWd5OQwVXnMjxfkeotjCz3oJkhUK
         9JBdo68V/gRbcPf83+5JTdDPdp2KxTzIm6U4oi6cNoctlMefp1DB0QAPpYnIDwFXh5ye
         jFGgZkJa+tTEcvTcmCArFGGdhyZjPXxcCKuwUwq2mKknDxUJkjFTX1QL/8Sm1lDO6L0j
         QDbYjcmTS2X/E1to2hu2ZfqcUkw/cUcqkzTdeXghCxbx4+WvXN+DfultHMgIHpCJJqpf
         HIperMQvU3C4/ZcX6f5LFphzIpSQS41oamPW8iAYRVf1Jr8KWrF1uvqoIzw76IuyIiqt
         u1aA==
X-Gm-Message-State: AO0yUKXXbVi9MLBRzDwB8bnZIFF4ES06aW1W0w4IJp6t6M64yoTiQWpb
        pNCZF4BDx9gd0rOluMJ9p0nckA==
X-Google-Smtp-Source: AK7set9UDQnyyrcCtYn7eXxYQZekjyMc7aOmhQHbXeN5LP4f214+4CiDgvD4W08V+UsjisQ1AgvMWw==
X-Received: by 2002:a5d:8406:0:b0:74c:8801:af4b with SMTP id i6-20020a5d8406000000b0074c8801af4bmr177109ion.1.1679438531124;
        Tue, 21 Mar 2023 15:42:11 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id p13-20020a6b630d000000b0074c8a021d4csm3905352iog.44.2023.03.21.15.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 15:42:10 -0700 (PDT)
Message-ID: <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
Date:   Tue, 21 Mar 2023 17:42:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
 <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org>
 <alpine.DEB.2.22.394.2303212140480.2919@hadrien>
 <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
 <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 4:29 PM, Julia Lawall wrote:
> There do seem to be more than 100 definitions like:
> 
> #define to_dove_clk(hw) container_of(hw, struct dove_clk, hw)
> 
> where we have to hope that at all of the usage sites the argument is
> called hw.  Probably anything else would cause a compiler error, but still
> it looks strange.
> 
> julia

Yeah, that's poorly done and unfortunate.  The argument to
the parameter should be named something different.  I didn't
understand what you meant before but yes, this isn't good.
These should be fixed first.

					-Alex

