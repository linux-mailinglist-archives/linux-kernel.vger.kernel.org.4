Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD376048EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiJSOQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiJSOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:16:18 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7E148F49
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:58:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z30so10690001qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QPTGMIHyDmPTfMviXDce3DxQEy+e1CPFIayJHevH+Y=;
        b=xtlSrNubgfnEs0mfmfcEnepUHEDCxeY4mUNsyK21KqcWplN54t8eIi9Z9X1dTnTEmy
         eN2+4BKzObsku2PIyjl4cjtfx3TC/bsJXTJGUbXxY4Pkxtez0BIJsRBhLAWyqCD7OJM4
         AY09IoWkbF0FuDWRIG959J6KXeoOGPErg3UHBtxAhZY0OnnKmQbk1jDElRoiDd8BpKJB
         P5XWuVX4xZysTY+z71UmngiUC8Y4ZSEjhEggmfms/H7iUMG8YHr7if4XwjmtrCuKR0zh
         qreclZE9FWy0uH5u1JFm/zBcUySsGv4pnzpPjAXB5kAoZJXn6nO4XDbimuQeXVPwmvUy
         cZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QPTGMIHyDmPTfMviXDce3DxQEy+e1CPFIayJHevH+Y=;
        b=JgzlxuvpzwOIjXrAuOGX0Xbk8Uso6pW01eSHsF2UvQSz1/9wat8QAOHJlYEXd7HGqE
         hi4pSgGNrNbeM7XZvBEZPINYHasFsoIF840ES6eSi7H8arVd+b+Tf+YfLXZhe1sbKOB/
         6oZMaPYLCMdSh7RihryFwEVXUTyufOsgro49qHWJMkN556I1UHxgwOzqqz9K5VfEgEzP
         MYmjdFTWPXbolIdYOswwcAVIqiti1w/tkrRsWmeO3t7rjejSAlnVEw7yiuhyfmGT6PY6
         IMA47F6qF7KbRHrW8OFuAnK2ynswKe3i2hlhXITutg3yZo7rVGt/3MOTdgebu8IMUUdd
         GEeA==
X-Gm-Message-State: ACrzQf320S8UuXCU22jBhLsaKCFxxBLaIOHg/Ju9Znt5XIkTg632y4SI
        QWgLlwOKmU8a0M0u2/4qgjNo0Q==
X-Google-Smtp-Source: AMsMyM4foCoQhOqDlVRT/lBD84pRFRwhMCa/Ysoxq9IZgvMlsfOVDBxaURL+zLRIFXs8YdzuRRKxJg==
X-Received: by 2002:a05:620a:2723:b0:6df:b61f:99f6 with SMTP id b35-20020a05620a272300b006dfb61f99f6mr5599994qkp.3.1666187848427;
        Wed, 19 Oct 2022 06:57:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id l13-20020ac84a8d000000b00342f8d4d0basm4086757qtq.43.2022.10.19.06.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:57:27 -0700 (PDT)
Message-ID: <644c4a8a-8e30-5f00-7b9f-55c2d59e0d69@linaro.org>
Date:   Wed, 19 Oct 2022 09:57:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display
 controller
Content-Language: en-US
To:     =?UTF-8?Q?K=c3=b6ry_Maincent?= <kory.maincent@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-4-kory.maincent@bootlin.com>
 <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
 <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 09:48, Köry Maincent wrote:
> Hello Krzysztof,
> 
> On Wed, 19 Oct 2022 09:38:45 -0400
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 19/10/2022 09:32, Köry Maincent wrote:
>>> From: Kory Maincent <kory.maincent@bootlin.com>
>>>
>>> Enable the PL110 DRM driver, used by the spear600.
>>>
>>> CONFIG_I2C is dropped from the defconfig as it is selected by CONFIG_DRM.  
>>
>> I2C as a user-selectable option should stay. Don't remove such
>> (user-selectable) top-level options just because something else selected it.
> 
> As the CONFIG_DRM selects it, the "make savedefconfig" removes it by default.
> Why keeping something that is already automatically enabled by CONFIG_DRM?

Same question every few months :)

Because otherwise we can drop select in DRM and do not update the
defconfigs.

https://patchwork.kernel.org/project/linux-samsung-soc/patch/20191125125515.30795-1-m.szyprowski@samsung.com/#23021125

https://lore.kernel.org/all/20201130202501.GA32878@kozik-lap/

https://lore.kernel.org/all/c5150e83-0e50-3be6-b6bd-bf30fe5e94d1@linaro.org/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2315d3aea5976acd919d3d3fcf82f752562c25b

Best regards,
Krzysztof

