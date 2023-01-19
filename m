Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1623674582
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjASWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjASWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:09:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1BDA13E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:47:11 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j9so2729364qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09kTGcckMAMH+LEzhPYzGrk9M65a9aALWHozMS+Q/aY=;
        b=qKpmZ5ryJalc87ZonxwejohBKZCo0rsxES39789UuyDOmMGwlqFsejI//GJWwGF6bU
         Dzx6uf4ggaHImuV5cMYJEUBhMcEqGptxCFts/sptvkYvJ16KoJatmQzLfJVyuw7PihVG
         /O5TdPme2Nc7QiYQpgEkayg7JdD+T3OuIXifrpwkQTLmDoY13WboXQvBGG9eOUUC7Z98
         IpP13LjWYcWP8dYSnIR/Kz+0/8M6v0H4m7agpTHwpTYNJvxY5+Dgtp0Z/vO3dEe1bVop
         layZaOSlvu3uNEtAwzJ/eK/RWCzy7Pw3HRACpENVKail+TD7iTn/CcqcJGxs3zW5ZLdd
         QYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09kTGcckMAMH+LEzhPYzGrk9M65a9aALWHozMS+Q/aY=;
        b=CAJQwxdsz89aiwzS7x60HuSSOnYqa/ZSaf5eqetAN5RnOdXVskuaPlQT0GeEpHodTN
         Dj8moznF2b5lMrnbGWZ382rmnaMkIvi2ww0eVPYpVo0hN7It2ziK13ucqTGSPHuAixXH
         IJlpWIP+r6keXIjaonmbTHYrgw0fsRQ4bNGJlxlV9FQHwBwIo9OD7y1gCEzVftVYsHe8
         WRJcEQbej3FDSJKKTY5GvwRsjSpznO+n2h7qblFgyYDL4DYMt2IQkueUQIH+ACPSr0rC
         1MVQMH3ahlzslstGICSwH/emKLAp7l5KK/0TVvip3qTByLyi8o7enxeF1Coy3V71/7iG
         i4Pg==
X-Gm-Message-State: AFqh2koNToDm8/ZiIfRNIG4xwN4/l2IZ9mHqKnarAPRfOMtmHTb/1VvJ
        aZQ50KsbrwcYuMgBdDAOO9w=
X-Google-Smtp-Source: AMrXdXvGmKEppd3QWANAh0nFETvqHSZHzwuruKqp4iKcXzlzT7Fzfd4M/oyXBL/2uBBFOnmvkFX3oA==
X-Received: by 2002:ac8:67d7:0:b0:3b2:e9c2:37f3 with SMTP id r23-20020ac867d7000000b003b2e9c237f3mr18431126qtp.16.1674164829804;
        Thu, 19 Jan 2023 13:47:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bn39-20020a05620a2ae700b00706bc44fda8sm3373373qkb.79.2023.01.19.13.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 13:47:09 -0800 (PST)
Message-ID: <e0a09ca8-2ad8-c519-c47e-4707bfb4fe93@gmail.com>
Date:   Thu, 19 Jan 2023 13:47:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
References: <20230118121426.492864-1-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230118121426.492864-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 1/18/23 04:14, Cristian Marussi wrote:
> Hi all,
> 
> This series aims to introduce a new SCMI unified userspace interface meant
> to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> from the perspective of the OSPM agent (non-secure world only ...)
> 
> It is proposed as a testing/development facility, it is NOT meant to be a
> feature to use in production, but only enabled in Kconfig for test
> deployments.
> 
> Currently an SCMI Compliance Suite like the one at [1] can only work by
> injecting SCMI messages at the SCMI transport layer using the mailbox test
> driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> the related replies from the SCMI backend Server.

Took a while but finally:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Any idea when the raw_mode_support or the acs_raw_mode_support will hit 
your master branch in the scmi-tests repository?
-- 
Florian

