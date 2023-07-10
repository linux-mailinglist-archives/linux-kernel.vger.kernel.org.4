Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED174D30F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGJKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjGJKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:13:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1E129
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:10:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69923a715so65321081fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688983846; x=1691575846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDVSv0BUzAivXetgdKrBuwOPkl8QhzMrPZZmrB9OuK8=;
        b=u1jqFtGpGVOXoXwiECjQzgOfsCEfyiGzOfxV9zjjKvtQvKFhlsJx6hhjcOLGhNEb+u
         8RehyyVjx2Kvz9iuCVa0RVKY7pF8oSv5Hr42OTdVpVN3TzLkuqIsW8Bpm2kYN6kHtQhO
         dxe0xvf8F6dkwRaZtrKU6KWrPtSTlkm7a4DyfxAvctFSmtDp2Niqtc+Y5VT3JAW1xA8J
         YaGJRCMIvl8NLq/nIYVaDkZLGx4O7t2R8kk3ntV+Sgw4O1QPWRCqLE9HyCNg0ItMn0Zo
         9+Xw1s4CPz6SUaRQe6eVmsvk331UbtLxoezHeAp1CwLMaTC7Hx5Q1gv1p/VLPFT6ltRA
         3IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983846; x=1691575846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDVSv0BUzAivXetgdKrBuwOPkl8QhzMrPZZmrB9OuK8=;
        b=B+zOy85UNDBDgfF3vl14OzxlDtxqaQf/GbtL9yhbeZAabAFuMzN8yk8oUTz/Wi9QxT
         zVnC+Kx1uROQ/tjU9GS0z1u+iGLqk58o7CU71WK0vWLmKA5nawF5uzydrXt6+aPf1Zr2
         N6VvGaXGbuP5xithD8SjaUNJBrjqx2+ilFXWlRhsXaDbAZ8mqhvFQ6F43xqs/aAMbjdt
         +R+zKlXLCjlhqbEhQmgarbyX/uNXWNo8aogtNj/+q1KyxR5/6JDvGfUGQ+Av7ufvI/IQ
         uu18M+99IGgCM0D+J6GadNb84IWOVLhkrn7NYpAXWEjSNCqDWZXFxDhBCPzFb9AdkgHE
         HGJw==
X-Gm-Message-State: ABy/qLYIa8HafR3352XTNn6+JY2TFrSvAxhJLmcLlaTKVRUxTFD2Aukm
        NEmOf8m8sl/+MhhdUOqhD+yesbBUambPa7dRpubhLw==
X-Google-Smtp-Source: APBJJlEjRSZppr0opX3KHv92MlPmypVTqCCtVBGYEKS06BgiK6REWX14A2oUTtxT8/9xR0HgST5J5Q==
X-Received: by 2002:a2e:3317:0:b0:2b6:bb21:8d74 with SMTP id d23-20020a2e3317000000b002b6bb218d74mr9883560ljc.1.1688983845509;
        Mon, 10 Jul 2023 03:10:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709063c4c00b00982a92a849asm5925530ejg.91.2023.07.10.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:10:44 -0700 (PDT)
Message-ID: <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org>
Date:   Mon, 10 Jul 2023 12:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629160132.768940-1-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230629160132.768940-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 18:01, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
> requires an interconnect provider. However, a provider is currently only
> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
> indefinitely.
> 
> Fix this by adding a dummy implementation on Tegra194. This allows nodes
> to be provided to interconnect consumers, but doesn't do any bandwidth
> accounting or frequency scaling.
> 
> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>

Applied with checkpatch warning. Please be sure you run checkpatch
before sending the patches.

Best regards,
Krzysztof

