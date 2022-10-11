Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40175FAF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJKJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJKJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:36:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE280F7F;
        Tue, 11 Oct 2022 02:36:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l1so12657959pld.13;
        Tue, 11 Oct 2022 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjEDzCZ7FMePv51+qKNV+Auv7I6iSTsYL37Gle+Fwyc=;
        b=NXfKM567zgYtZA7LDsbzhbC+Pvmgn4PnLcx1kwCHYGgJBm0o4SYOJnxOaBQWprRrLF
         S/NEBBXdxZYzk/7cSjBhU2UNpokd+ZjYdmMbbwsWFBIaLn0dH6W1d28ibXODolxh9dfR
         EsbDWrS71dp2RdeIN2DotRAbrE41OuT4Y1r+XMboP0Y2pfbIqnwrFl+Au86IIgSoCzOV
         4XX0qkJKBrrXaGRL8quhHeszk1W1LWJwkCuTRrMhipphUmr8jmPPES89s8/RmCwkQQnc
         zgK0cwCYYtiSjRiluB7yzvW9FrHyZCY8tm5Gg3S2F6+4exdzPQB+cu0E8YBRsQ7QkjJy
         tpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjEDzCZ7FMePv51+qKNV+Auv7I6iSTsYL37Gle+Fwyc=;
        b=CkqtUZUrLrEObHv7kZZP/LtSwL8RNqPvPUKKmJ3gdPNmjeB1n/1JPWnOmDoUNByqvi
         S0FwbREki0XEovyHIlK+ha5k6KZTwEk7i/gE669j94nyiuhcKJhPxDa8BgaeLqNmcTQm
         MkInILiefAU/L1llMZ1bmmq3o97ehpIeZudRJcdcuFtvAM5eor5BeOrNM0hKZaGaFxJ9
         YhDEyrPlO0G2FJiv/hFGDZNuDTkyAIpGCFurCBzPSqwcNH5CtXbm3QgK3kwOWeOZXs76
         BZJbLQXGrsxen1Pq7aLFkkagZ5W4a1dMpSH43rdzsp9Rp7EMBvrfyy52TFS+yuYAkoEL
         DbAg==
X-Gm-Message-State: ACrzQf0V8/GH5qqGwSKAlNsWBE+mUdfwA1KrF4LrXO6Mo5PIjoZbVNoC
        Ihy3Xd3DyhLCYz4t1Bds0Nk=
X-Google-Smtp-Source: AMsMyM7WhVZF+nawGLSBaVkAAb7yHhMnsbIsfdU06GHec1RRjpnYOayT9epY9SV/ItigASfR9LongQ==
X-Received: by 2002:a17:90b:1b4f:b0:20d:363d:7943 with SMTP id nv15-20020a17090b1b4f00b0020d363d7943mr12728402pjb.106.1665480979825;
        Tue, 11 Oct 2022 02:36:19 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id n15-20020a65488f000000b0042bf6034b3fsm7537757pgs.55.2022.10.11.02.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 02:36:19 -0700 (PDT)
Message-ID: <e60a114b-b99a-8a11-ac39-c9ddc3ed926e@gmail.com>
Date:   Tue, 11 Oct 2022 16:36:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 01/13] docs: gunyah: Introduce Gunyah Hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-2-quic_eberman@quicinc.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221011000840.289033-2-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 07:08, Elliot Berman wrote:
> +The diagram below shows how message queue works. A typical configuration involves
> +2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
> +queue 2 allows VM_B to send messages to VM_A.
> +
> +1. VM_A sends a message of up to 1024 bytes in length. It raises a hypercall
> +   with the message to inform the hypervisor to add the message to
> +   message queue 1's queue.
> +
> +2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
> +   b. Explicility with gh_msgq_push command from VM_A.
> +   c. Message queue has reached a threshold depth.
> +
> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
> +

Seems like you forget to apply my suggestion fixes at [1].

[1]: https://lore.kernel.org/all/YzUUaIx+azyzFDNX@debian.me/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

