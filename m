Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE575FF432
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJNTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJNTob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:44:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72851D79B2;
        Fri, 14 Oct 2022 12:44:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so3895238qvq.7;
        Fri, 14 Oct 2022 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRUJ/QuzoFh7CZWCmP/Tvwc6hY7OTq8JN3QKuFbW8/8=;
        b=iPwNeLHyqaFNTPw3QAfJflixPHFnxLKYWk27ZjSlOrkAf1sNonJPypAnjw+0nVjuP0
         RTNYnwrrm8+SOU9H4gtwLe8/dFs0D+UOilYO5IlMqLfxNV+QUNY76S0GcIzMCWB03Ka1
         gKUqtw/YFWBsYEr5kRK71GtG7k48lhNfycbF93pH5WjMYgywC555KUrCqwKswTztolOc
         RVtjxYlccZcxs0vNyTI+6Z7LQiagsWoOm98ClzwSwE4KQAWqxBNWUh+FiYFI5CbVqy3B
         dPnyWMQWgbzQklANOqoZMU+Qo3+tQqkNlIpLZ1AZvIvZC1LS0LkvEccVrtetuM8afc3T
         afFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRUJ/QuzoFh7CZWCmP/Tvwc6hY7OTq8JN3QKuFbW8/8=;
        b=by3Cwvl51mY9KIw/Y3WIT3g+6Sxuhx7dzIsXnJf7ygYO0s94F6Bkl3zHcXzkmK7Dh2
         ZJs8Xe3V9kM16A2tsUQQAvLOyk8K3B10U7606I5QIsCM1mIy39eznvlMXj6b/JIcZH6U
         wT5TNTAtwzlob3VmQz70uHVAwSmg5Wz9hbAMAanXsmglVbnvZ3r2ncGvACSBCz/pBa9p
         b3NkmX9nIb7hwjKjpmzDGMNWOQC3eU2EKuSNDvV/G9gOUyudBR4T321GzWnMB/vV6rUb
         ZM9e9pCaGlOjVSDv6/aQojq1dVtZOpyBK3W8NfUBQs1Nq10hw43pzrOzWLGbeG9snbUl
         loYw==
X-Gm-Message-State: ACrzQf1SuUTBM6k8ahWlajx/Wqtw8cSfKhpohqvR8RntUuwC+ONENgBE
        ImdOPX39EfPCloq+rU0S0ZY=
X-Google-Smtp-Source: AMsMyM4Z3G8ESlxxaBGvcPzIV8pBrcD99S8yd+JZsybkrXWtMqOFr/g1WwkRVGlDPTmYl9kd5q08Gw==
X-Received: by 2002:a05:6214:622:b0:4b1:d189:1631 with SMTP id a2-20020a056214062200b004b1d1891631mr5391197qvx.62.1665776669830;
        Fri, 14 Oct 2022 12:44:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t138-20020a37aa90000000b006ecb9dfdd15sm3053872qke.92.2022.10.14.12.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 12:44:29 -0700 (PDT)
Message-ID: <c3535ca9-1676-750a-9041-8bcc4c636e86@gmail.com>
Date:   Fri, 14 Oct 2022 12:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/7] firmware: raspberrypi: Move the clock IDs to the
 firmware header
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Emma Anholt <emma@anholt.net>, Stephen Boyd <sboyd@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech>
 <20220815-rpi-fix-4k-60-v3-2-fc56729d11fe@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220815-rpi-fix-4k-60-v3-2-fc56729d11fe@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 02:13, Maxime Ripard wrote:
> We'll need the clock IDs in more drivers than just the clock driver from
> now on, so let's move them in the firmware header.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
