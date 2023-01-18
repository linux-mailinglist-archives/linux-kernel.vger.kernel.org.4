Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8996715C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjARH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:59:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B966EFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:34:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so813256wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyUX3mVkFb704ZR5bE8VGDfpv5ttttIo1yF7fkX19nM=;
        b=Le1BuNwehcAGMI3BMQPsEveagBCM8BlXnWvG1gc3sOmdPSZssAaUmk3KL4sRdULyhM
         U6LRTgdWEZKKVNxGWQZqzKM7KIhOJUe3V5J+ZwxNn+IXgHxn3Wh9o0hAazJufqetp9dh
         p/uOj0YyfeAAkOlhK/SXmZ4mLI/DiE64DAReayx3JAN3Fwwz4VPGYr6Zwz3ZSIAMdzzH
         cDQuqcib51LpCJ6TjvKzPPoevxCoVMMMBPbPqs621pPGTJmI2bz8ZOGQUSL16rKDr9YS
         hjzNA9OM2X8aZl9NsPvIhdDIxrm4ZDR/xyP0SHARTY14mGNYpgZTso1RQz6bxVV3nuUH
         wSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyUX3mVkFb704ZR5bE8VGDfpv5ttttIo1yF7fkX19nM=;
        b=SRXRmL3lnZvcVyRJIcIoJEhv5r23dAVZdaKH/qZvrp+pslZsKOXEiQrzBXqpS8Rw6h
         cvEaosvwNnEN6ORQSzkkj4g+2vUEUEd0Wg2k+y4nwunHyP5QB+jj8QvDexWWzrIgy2vg
         hiP68IIPTqVa2RK5nsopTGhBMtDiZq4x5o6mjGzxx5PglLHY+EmVG/R0gKYDtiu4Y/q0
         JVDfEfOtYbdNgcAFzrvMVK9UMyxm62rSDWKfpyOwSU1t1asnkbmEf2L9MnLWcrfQfIPC
         lw3OJdHsVf5AT763pu0RKNA6wH05KzchcDc2vLERQhsew9lyKt+OoqJslt9CKjT4Ebox
         TwdQ==
X-Gm-Message-State: AFqh2koj2zbYQsZIP/nlQkZ0NdEboeByLPcEw/rejiLleMho9kENdoeu
        bixAW7WINEfqBtZrnfWM9zyQ8g==
X-Google-Smtp-Source: AMrXdXsJMs5+tNGqm2kcA7wkU1Etj7BlvI1kKIDbMtJUd4uBS9RxjGpJ9jG+k1GSvObVp0/RAung6w==
X-Received: by 2002:a05:600c:3c94:b0:3da:f2b:d7a0 with SMTP id bg20-20020a05600c3c9400b003da0f2bd7a0mr5493286wmb.31.1674027283155;
        Tue, 17 Jan 2023 23:34:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b003dafb0c8dfbsm1385849wmh.14.2023.01.17.23.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 23:34:42 -0800 (PST)
Message-ID: <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
Date:   Wed, 18 Jan 2023 08:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
To:     Mohan Kumar <mkumard@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, dmitry.baryshkov@linaro.org, shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
References: <20230117181658.17010-1-mkumard@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117181658.17010-1-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 19:16, Mohan Kumar wrote:
> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
> ARM64 based platforms as Intel PCI driver was used for registering the
> sound card.

It's not a part of SoC, not a common device used during debugging or
development, so I don't think it is reasonable to enable it. We do not
enable driver just because someone uses them. Otherwise please clarify
which board has this device embedded (not pluggable by user, but embedded).

Best regards,
Krzysztof

