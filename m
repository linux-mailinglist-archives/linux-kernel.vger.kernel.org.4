Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990526C4E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCVOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCVOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:54:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A471E5CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:53:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so13199741wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlAbqyMQyxvunTln8KVLdMQBh24n7pyXjoPD37FQIJ8=;
        b=wz3ob0KdC9zZBP6ei6sp+d/mpFckZr0/hViQ//b8sN62MIIJ7+8lx1+LDKLGJBB1T1
         C2kQjK97cHrBCrdcPRSYS3uP8tjDz1sN9UgyfBoMvi1KN0EpfpkQ61npHseheyeDlxYf
         Ffxe3YwmU4S4KOZxk4R7cSATKWD2fniFxZE2RydgrfVEPg5mSlQfd7LGat11Lm4aVYjn
         fz0uOn1eW+MRsQkwEzRfy2rEJoHvbCeKz/eNFt/OGZdOj3/ZQpO5RNxgGPWkP/1xQPjK
         4m5enW1LjZ38V6iYbexEJ+NGu5M0DCq8SHlxtWAJslIMpy1KUiqEAgzDhuSJoraUE04J
         6iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlAbqyMQyxvunTln8KVLdMQBh24n7pyXjoPD37FQIJ8=;
        b=WQrMSZsVAgoS+OjwXKmBkEU3s1n4FYK6IKWUZjLt2x72Tjq8H+ppsqE/6tcIsN5Ges
         gA17zf4Mn+V94Q5yjjz/jivUKRH8/9rxDIQs/pFI0zFiAk6xjHqLV/6S+smgweP0vDJz
         Du6iqKtQOjEtkNYSYOdBS2m/kFrwdX5nkfv6nlnWELvKBKOQJj0GUD46zet4AEenIEVV
         eZ9+pqRaLQAdOPeb6qbNZ4DaVkITcHAIJ5NtL1vI4ekyXuKqwck8+V9XrAyDHmb5joAw
         9eoSJJv4N1uPAbBvbzf/IgG5smYWLokBZQCP2ZzWgdedSPsM7qsitaC8gteBhxxA1gA9
         0gbw==
X-Gm-Message-State: AO0yUKWZ+DafAtPCUxR4ke7s2xD/UTQNscquK15/L7+xeqXwFBZGqb49
        se+iBbw/o9gMxBHmGwElKIYx6A==
X-Google-Smtp-Source: AK7set/DMAStdErTYYhNuy3JUmz+4R9vEeWDoXAl/2dC87kqGFZgRKL8gCrpdOx7N5Y0j+9f/uZRKQ==
X-Received: by 2002:a1c:7216:0:b0:3ee:5754:f139 with SMTP id n22-20020a1c7216000000b003ee5754f139mr2393005wmc.13.1679496784074;
        Wed, 22 Mar 2023 07:53:04 -0700 (PDT)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id he12-20020a05600c540c00b003ee7169d57dsm890106wmb.40.2023.03.22.07.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:53:03 -0700 (PDT)
Message-ID: <82fd9d68-7dcf-efcc-ba5d-99563770c728@linaro.org>
Date:   Wed, 22 Mar 2023 15:53:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] MIPS: octeon: Use of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230319163148.225443-1-robh@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230319163148.225443-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/3/23 17:31, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c | 35 ++++++++++++----------------
>   1 file changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

