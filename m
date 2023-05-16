Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE2704E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjEPMxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjEPMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:53:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25705173D;
        Tue, 16 May 2023 05:53:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53033a0b473so7236508a12.0;
        Tue, 16 May 2023 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684241609; x=1686833609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlf53SXikb/z19JEmJl8BWwJrESesSp4gphf4RnkfAs=;
        b=mp7oye7ah3vsLF6Ld21S4KL0XTrHi/w61bY7zoUelJwygwXW2pmAzftec/18aD6ihL
         sZbcwxqEXmydZxSjCZpB1sCjA1iMqRJIta7PUKd+pP6tKQgbNezWhSaDcX9MKaDbomYu
         VBj6JegOu+Kxcia5FEqTtCdPj8CDaTf4TrJQC2uesfCo0GKzFzfKjRp6j+RIoMMWFP1X
         /1AAoqRpb3eEyPrlDbSwTvtaDFXNKOhPwECOyFec1IctZa4ydgZPrLZY3RVjaa93N8/i
         5YTlpqXdAWb8VsdAMsxzdIaayAJAsFMSdlHGQZQwpzy9gRBAS8/plxlfZZlP49SGuKZ2
         43Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241609; x=1686833609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlf53SXikb/z19JEmJl8BWwJrESesSp4gphf4RnkfAs=;
        b=gV5Ibbyq37/vHB0RYTybxvlLpmCuOGKFWCaO5fHFUpXwQlTPHpxh1T7oH7eHZ3g2qi
         6zpXJV06MwGIAnYiuCBLK9sYrGGSdBxGGRMzz9EqcKvX/hh9zu50a6T6BIRxOvVeEUeL
         FQdOvX0skWlKiiO7SCneG6LOZKYImDqQbww4nUjaUvjQ8Da33TCr3qyT9SQrneVLtNSG
         1kSAK4qMmQTg71alNAL9Mj/mHFvG8oKTs/OzJf9Tv8CBBNpswe8nDQu7zRS3ZqBk7nGj
         rQzqOfmaZv8edIDiDaF2Bx9w0pJmRknxAfitxwCq7gilrAeDGQebkcPJM3ZNj4dRxKhe
         /aAA==
X-Gm-Message-State: AC+VfDyU/vJvq+k+UccJQMLUn5gWMiXfeX+w1oM81yqXk9QBRPDynUFP
        tkVI8onH8iYodgLvH/ZIGHI=
X-Google-Smtp-Source: ACHHUZ61ld0bQ66K0nxyj0WctGp6rkEVUAgGPRlAjOXRjcV5Ep83yiie8a2UX6lc7DGLN2qxURdTdg==
X-Received: by 2002:a17:902:a584:b0:1aa:f173:2892 with SMTP id az4-20020a170902a58400b001aaf1732892mr1402835plb.57.1684241609391;
        Tue, 16 May 2023 05:53:29 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001ac4e316b51sm11103462plg.109.2023.05.16.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:53:29 -0700 (PDT)
Message-ID: <2ecd714e-f00e-3f6a-4ddd-4c67d3798358@gmail.com>
Date:   Tue, 16 May 2023 19:53:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230515161702.887638251@linuxfoundation.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 23:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

