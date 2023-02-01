Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1516686F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBATrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBATrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:47:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A67D6CF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:47:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q19so8905563edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tthTFJYUUhy2iSLAXFe4WJFnmH1a4NUAK3uBBkBZ1+Q=;
        b=usBEPstacT7Yk5Rq3V0KVu6gtI7AkE7nkXeyVLrwO2W0J6hDivESJB3+O55HaEXYx3
         ioZ0wl1r+kgaIpoGE1zCXwWRDBG7sIk9IPRCj97OCs9EV+52eKWjMrk6BHzRJX9qUMP9
         mPyejeXtxc3vrWEwWlyL8nQMIWQFweVHr5awAqWg8JgSvbqsLWskg9BwdiogsLVPWvx/
         A+WzjtXpuOeoi3QbuKrX9uUgB0RhZDx8CvEDTZCfTzuFkIZEIYpUR9olvXizYHB20CoK
         lr9kyZBU+2oiDauiHNsK5Vyz3jz5hKUYfegRi9oCs40QY75fMuuIZJBg727caGvlDOdN
         fdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tthTFJYUUhy2iSLAXFe4WJFnmH1a4NUAK3uBBkBZ1+Q=;
        b=JkHgcVlJGx4J61hy0kzUZ6mPAUpTrwf2RnpQeE4+m6TNvkzles7hhxEvzwfRAZj0Pq
         EmMQnjyde+aCImkVEQzXt1Xv4ViepqSg9Uzrl/j/lpc8ddv/ri1yoVyj6w8BmAI0jA4X
         FuSCvdJvCfIQ6H1IhzF6IRbRY28nkZYAvuD/Oram9MYk0UhGMDDw3dCvzjVO3p8wEhPZ
         ReZoCbEhyJANGWNyap1bVGZ+NFNaJU7bJhpqR/yyhUSjcLidX6eFW9EY4jdEBBJz2BUq
         FRn88hu3CDv9kPFCrnFILWRXtrXSZaNGI7VojGGkcBj0xBo0bV2KK2lwlRIQrIr0y+hw
         hT1A==
X-Gm-Message-State: AO0yUKWxE9aM0hDhXGq0WYJYsQXvhsxLqZug106C6ImRgWd/W09xRdSa
        xndZWRQmWbDTy/2M3WtPTsSRZg==
X-Google-Smtp-Source: AK7set+Fc1gEX1k5nC/2ryukBTh5CkW6m9XkfztkdVqCmjJPcBXhRLHsACQClLJTlr3PYyXqYB9lcg==
X-Received: by 2002:a50:aa92:0:b0:492:bf3d:1a15 with SMTP id q18-20020a50aa92000000b00492bf3d1a15mr3769817edc.1.1675280843700;
        Wed, 01 Feb 2023 11:47:23 -0800 (PST)
Received: from ?IPV6:2003:f6:af11:1a00:4837:80b9:2673:1df7? (p200300f6af111a00483780b926731df7.dip0.t-ipconnect.de. [2003:f6:af11:1a00:4837:80b9:2673:1df7])
        by smtp.gmail.com with ESMTPSA id e9-20020a50fb89000000b0048ecd372fc9sm10335233edq.2.2023.02.01.11.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 11:47:23 -0800 (PST)
Message-ID: <77df9cb1-e978-7fb0-9b8b-e0264a2f605c@grsecurity.net>
Date:   Wed, 1 Feb 2023 20:47:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/3] KVM: MMU: performance tweaks for heavy CR0.WP
 users
Content-Language: en-US, de-DE
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230118145030.40845-1-minipli@grsecurity.net>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230118145030.40845-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just send a v3 which should appear any time soon here:

https://lore.kernel.org/kvm/20230201194604.11135-1-minipli@grsecurity.net/

Thanks,
Mathias
