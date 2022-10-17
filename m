Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF074601A60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJQUga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiJQUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:35:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC757FF83
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:34:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b4so20303158wrs.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpFRQZsOmdW9c3SZsmEc4FDFMxHFXWrDNqO8HToIKbM=;
        b=nnGtmLBJbg/Dz4Ev5W1kS5QWcbUVTCJXoo1L6aJO//jgQNOYYIEhlPRmkn68+Se74o
         QjjSpGBvOiYh4d9TRuOLTECVgySqc0PNKMJb9JvyfHV+43s8WdjiPM1qy3Ou4AW5fZWC
         /+fmop0FJnVq3MRuWhSb2stmWt126ME5XZDY4uF+GhB6QWbJBHOemSvk+jzipirrIpGT
         WafokMDYc8TUgjahhptVTgRfeYAS2U4Gp820AqthEvlZcHa6C4ULQC4uOSWiYVwKMGDA
         nMBYic6JpeLh8/Q1RqoRjzAn9UoLn6XnTzqUMQnTzQEALOenu8xGSH0Pek+CstMGdl7P
         aBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpFRQZsOmdW9c3SZsmEc4FDFMxHFXWrDNqO8HToIKbM=;
        b=jTQzolWDcIT9g9XrSfxdM3XNW7pK6NgWv4vHtJHzh9SHhItYOAgwpqRspB43ZwDj3h
         4q3+amDBL5lKCeXPzmR1ap2dzURcpS65hHLfrZrbjC14SJ+OBb8tGFUQxXratKk+I6+E
         BVot8I9LTs9LW0bUSapdvxBy8J4t9a5QfRzsS5p+Zcce7JWkYP+PE9x3A+PpHK/JtOjT
         INSdaOtN+nsyJ4Wms5HrWetw4o/HDaztxNdQ5LtocPoTvZo0gu0HSyqcKK/F+GWri46J
         Ln4dk1kP8e/PUr2E/s4RoSYtlN/4RFMLu/Vzk1reKEJlaSvu3C8OEuVo9JjJN2hZdaEL
         gMWw==
X-Gm-Message-State: ACrzQf3r3EjbvEQqPoLlnQ0qiZSckWicO3RMcAaSOkG7A5wszcz1tQWA
        gh5X+fuJZx5RN0UMQdyYczbAIg==
X-Google-Smtp-Source: AMsMyM5ekRBaAlfTq0XCOYKDJstuADP7J5QGlNJnWuMqJYHe0SqM2mGL4/dvjME/dpR8t+4Mewhhjw==
X-Received: by 2002:a05:6000:704:b0:22e:c347:291c with SMTP id bs4-20020a056000070400b0022ec347291cmr6923792wrb.585.1666038756434;
        Mon, 17 Oct 2022 13:32:36 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d670d000000b0022cd0c8c696sm9383231wru.103.2022.10.17.13.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 13:32:36 -0700 (PDT)
Message-ID: <13211d56-db6e-33da-2624-20aec8a0b3c2@linaro.org>
Date:   Mon, 17 Oct 2022 22:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 awilliam
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, alex.williamson@redhat.com,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20221013214636.30721-1-palmer@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221013214636.30721-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/22 23:46, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
