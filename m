Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B464104E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiLBWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiLBWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:02:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E52F88A1;
        Fri,  2 Dec 2022 14:02:01 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y15so7118107qtv.5;
        Fri, 02 Dec 2022 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijnpZ07hK4ahXelPeyrccDJp/vFZrgPBzvgzRVSPwcQ=;
        b=YcUBMxflyK9rsYXMpcZMWjZti1O7PMbXZ8xFQZyxkNNwkTcGoZh8LKARWMdXn32XFr
         A87vCVV7s8Gj75k/77gr0gy5uhjOWV3Cl7Xp5VrkjymO7FbPa9+l+263wbHMjvODowBt
         cwc0aY8IVFB69AWe7WIIbXuOVU5HITCPWK9o9elFR+wNXf3bS4OmxGGxBFBxoyVpjDXR
         0it/J3eXMGiGjvRJSPhmBf7AOmkXCxGHlxNsBc8tmaXOwhXRgQfZuvaChsiwOCMVi7wk
         JLrvezqCcbayicLo+TAyDuo2ai7ue4WX2AjzyH75O+ZWGdqKdBIYv+1xBm/cAv/4wiRb
         GOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijnpZ07hK4ahXelPeyrccDJp/vFZrgPBzvgzRVSPwcQ=;
        b=ghzlwriKz+OMqcmC6y3AVYiLItgcbzvijDq8bwZ6/fPIjK4xS3S9nphbykMfI0vKBO
         4Wea7YMdDegUk6XKYmgW8bXdxPbwCFRtB5lkTi2lEnU4XtSQqFMn3zuyigfFk4jZYhA3
         RqUQdptFz9MlJWJ+0GcLN07+UcIH/pUkCD1eMW1S6yJqkZB6SqtLs3VmJ0lTzmssQyUS
         oIP5UCPZjWZBeD+3T8aKJaBchXn5EZdVwG8UBcO5I1bS0yZ2PD60lLxhWIf9MaI8P070
         5vXzFZGxiRcwy49F4ABM6NKEYbdqt9D7InOFQV/zyuCUZWnUnbvMW6Zdm3uuVNSzRbj3
         rOEw==
X-Gm-Message-State: ANoB5pl3Ujp9pJi0slXaxQCGgFI2vPmEPKECw+1JdrJ9tgU0N/dx7V0G
        Cl0CTqs9ajZ/qX+M9b5Xaqc=
X-Google-Smtp-Source: AA0mqf791z95i5H75aVgSKh3ytyxoUf5EHk6btym+i3slF6UmZIrfdzjZSLDGyvOdJVWBYS0hEqAlg==
X-Received: by 2002:ae9:f103:0:b0:6fc:9709:4b69 with SMTP id k3-20020ae9f103000000b006fc97094b69mr15582829qkg.148.1670018520357;
        Fri, 02 Dec 2022 14:02:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k17-20020ac84791000000b003a50c9993e1sm4923477qtq.16.2022.12.02.14.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 14:01:59 -0800 (PST)
Message-ID: <e1eb7d12-5fd0-4d7b-6009-d8cbbc6eb3ad@gmail.com>
Date:   Fri, 2 Dec 2022 14:01:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for SDHCI Broadcom BRCMSTB
 driver
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <20221202212119.43214-1-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221202212119.43214-1-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 13:21, Kamal Dasu wrote:
> Taking over as upstream maintainer for Broadcom SDHCI
> driver from Al Cooper.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Kamal!
-- 
Florian

