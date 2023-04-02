Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3D6D353F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDBCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 22:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDBCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 22:25:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD81CBA4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 19:25:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6261eca70f7so1443575b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680402312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNJn7rJ9mfi+8BFFswpknbpijn0YYNUZ+eri+Zl6WMI=;
        b=KeSs8TLuUJ9k46im3nNlZft8qdRNFcPvl/dsXf01zYGR4qNwLMZGaC8JjwmwKhdSWo
         h+bvguldTAPmOdwC3Ox5IAUJa1/FRehs3Wb3sszcFYjIRBkZ6RBXl+EAdpOHH3RhhrnR
         NYV1yBLMPyVV565lYNviJPnzYwBCS1NQgOS7JoqEL9+vm0ZVf7vxXuik3CM0j0SHPlRg
         XR464QAuAMYt8WMySF1bHOMdgTSVZ9X/n1z13nbyqjTZT8XEucF7+sA27OSst+JnlWIy
         IkO5kW/ZomqVw1PVfMuwLnXuvo6rkQJ+1z50Dp0oXGFd6fIC6tDFHJQulFqp9PEA150Y
         51gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680402312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNJn7rJ9mfi+8BFFswpknbpijn0YYNUZ+eri+Zl6WMI=;
        b=2fU53Q1bYPQw0c2L7GfK6f6uF+09skmrzXHlfgy58szqjYCtEpUcdZDVT0Wq2aWEA1
         yKJBREj07RMcfTCtKyjHkHvAWRAfMcgnsTEJoH5rkKCcbez17ala1v/y7BZQHDTqdTx+
         mIYU7cbUmC1e+zTUQLJ9WLmNMp1/16VlLopOecHzlzm6+wmOynWX6wLeT66sYQJKzuhU
         ITLaJJIJjFRWAMQisFxakjNYBGkkWdS29ORZVwY7hS5OdHNJgdlx+oJaa/H8Sqi0W2j3
         9L67/kIVNklqX7sPc8Ieomw2MruPdaKYo71GtDfItv0mLnEz/NeCpZNRVCZ/KzdCnUsA
         1EIQ==
X-Gm-Message-State: AAQBX9ct74WphpqeOQppJAtOPog4j59koVfhfdJqeubSLL4dfgMq+45t
        lBKYxBHWKmmtqwEEFBREefBGUw==
X-Google-Smtp-Source: AKy350ZnNIOuLbxw5ULmCgiQnJPVCvCEZyhLzu6XGUcIgGsjYDWtlYY54TXYdTiKrMyiMA/evkBk/g==
X-Received: by 2002:a17:903:41cb:b0:1a2:9940:1f75 with SMTP id u11-20020a17090341cb00b001a299401f75mr8712478ple.0.1680402311736;
        Sat, 01 Apr 2023 19:25:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b0019956488546sm3934150plb.277.2023.04.01.19.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 19:25:11 -0700 (PDT)
Message-ID: <87e110f9-a57d-520b-6fae-f75d16a71108@kernel.dk>
Date:   Sat, 1 Apr 2023 20:25:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pktcdvd: simplify the class_pktcdvd logic
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20230331164724.319703-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230331164724.319703-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 10:47 AM, Greg Kroah-Hartman wrote:
> There is no need to dynamically create and destroy the class_pktcdvd
> structure, just make it static and remove the memory allocation logic
> which simplifies and cleans up the logic a lot.
> 
> Cc: linux-block@vger.kernel.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, I would like to take this through my driver-core tree as it is
> needed for other struct class cleanup work I have done and am continuing
> to do there.

I'm going to defer to you on this kind of stuff, so if you think it's
fine, then go for it.

-- 
Jens Axboe


