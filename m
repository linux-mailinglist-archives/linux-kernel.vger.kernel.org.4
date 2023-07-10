Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636F74D304
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjGJKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjGJKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:10:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749241B1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:08:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso403860a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688983706; x=1691575706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3sqS4bojILuL92ZC495XYl2JlnTpUbFIE0CWiiAUhc=;
        b=gJbilxCDQBQvcs4/gwK8Ww9nf+9IoWoZLv1/oNh4S3ZDftLc+kXe+1wq0QlSFgkLSK
         la4F11+0aNwpYPSRtXgoBZuNMB0RUXfglpZKSCLC8Uq/WREFnP8T4KgkLSeBopOjyXPT
         T9XJNlNyRSSsYyNbic+vC56y9ZVq5k6J2nprAIxDS3osGrFtXy5a8MWkp0wiye5CxKZ4
         vb3DVrKb6b09iGTHhlzOz52JeCiK21x3YLEAYlb5raPZ3oyilNfbWkBaivzW1ak0bHRR
         ODBLb15iWEFZpaGpSOxFiszESjQPmDUzWPq6itSe+5cvVcyoSmbQ5Rh+xq28HHaM4shf
         LxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983706; x=1691575706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3sqS4bojILuL92ZC495XYl2JlnTpUbFIE0CWiiAUhc=;
        b=OwAHglk+3INiYybbMWgToGP/Ue59cbUW5z9zo8THWFEJCelFbZlQNAjHxWWIaa1Sl8
         2GKs/9XCNnA+wjwYXebOrGb7cXerk01KeyYTjxbPDQVGfoMDDdZ0Z20CYctR2do9COHH
         jfIEUFlY6lWjb0/lFtFnZqK9YDaGXp/NK4K0w7vQR3onwaT1Tvait8oYWqQYhBngvPxn
         upUpc/LZV5Ul8+PvFL9P5LpF6TH5StNa8ymzCthUX9DviJxV01DwglM6wgElUwKojBUq
         /4eiTerqwzrt4XR3aXusrjDYrcT8UlEpsL9MTDhFFPnYYO1qO9hUvs+FOUlsJcRA756p
         hycg==
X-Gm-Message-State: ABy/qLZpD+AImj4jvviHLbj6x1uR92CtmOZguICbWhJNC4QWlvIdm5Js
        2y5rHsgNWwSapQtc9ca0NX8c1aRxaHrUuBi729nCQw==
X-Google-Smtp-Source: APBJJlGRZMAzcx/sDR/CCdV+GJ20Ofgu/uXyGDE9G/URN8lOuANnybASq6RMBCtCwIgGvvFa5fSbrw==
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr2645385ejl.4.1688983706495;
        Mon, 10 Jul 2023 03:08:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b0099342c87775sm5869504ejr.20.2023.07.10.03.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:08:25 -0700 (PDT)
Message-ID: <abdff39a-5306-b431-ae28-1e1a03c0a555@linaro.org>
Date:   Mon, 10 Jul 2023 12:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch RESEND 1/4] memory: tegra: sort tegra234_mc_clients table
 as per register offsets
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     bbasu@nvidia.com, talho@nvidia.com
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-2-sumitg@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621134400.23070-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 15:43, Sumit Gupta wrote:
> Sort the MC client entries in "tegra234_mc_clients" table as per the
> override and security register offsets. This will help to avoid
> creating duplicate entries.

If person cannot search for existing symbol before adding new entry, I
doubt that sorting would solve it. OTOH, this patch makes backporting
changes trickier, so I don't think this is good approach. Are all other
Tegra files ordered in this matter?


Best regards,
Krzysztof

