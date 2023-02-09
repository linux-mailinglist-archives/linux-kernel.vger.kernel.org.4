Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73C690866
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBIMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBIMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:12:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60853C28
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:11:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o36so1290728wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df0R/1IsIEBizIIioRMRApD+5BCz/Cj0WUyoSJvsVgw=;
        b=rpn8yyR6+aUJwDrOJrJjq18RlJ6tXQItoSv2xO46b0Plpa2MWPZYEMNbJ0ZYaB1sjy
         Bjt1yfrymHDwmJnCR6lLArpuJV1o2xGURIlUqeOHfi+0sVqbxSeFbSu6zVt6Bm+oLhTi
         XUubJAnTcet3x6gXW5QCsoOLixrl9IcZgV+XVpzW5KMDQEQ5B3Lyz5ClpsA9lRvSGyHI
         nQWgyah3Hw023Y6HGVEDFSsEakUnIx1Cmg3pMZbl4ArhlN6lr5BQTT7ELfZqMvcB9FkI
         6JkhMwZqlOCIRnW8NR2eJej0v5U9mu9pznGRaqt8c54hdatbmca3vL+uTZVW3F1H2SNm
         73YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Df0R/1IsIEBizIIioRMRApD+5BCz/Cj0WUyoSJvsVgw=;
        b=EkKd9OOl4kYGBt8PA5vfGqrFzkaIFDtYJyTNiCOojSaanvNc5EVRJsZ6yrwnqSm7W9
         3yBCpnfn56l2I/CLdwJh4UyvLrQ40bzxcQnAAlGsomThfOUO0r9RD8E0k4INqP4/xNQA
         4PO6Ll8IXVGJvNHHRkjBqfLSf5dGZ8h6WWnD+WGGhZXnf2H+Hhsa8fqX2NvIrx4gFsVX
         gfcrziMb8YRLTeF64CBcpY3V2hnEv7UTwDZX+7/NOBH5E8xkfuZ32zqawhGcdiXuGWx/
         zqJkktOXSqdOjC8oIpnaZvCIbu/udj1UdXZG9BeRSpkr85yIC+4YpEzPAJ3dmpgPiGLY
         KvIQ==
X-Gm-Message-State: AO0yUKVVLHY3+B6nmAAekQ7UnbjQpZ+aL+jjrcMFPpN4OSMt/54mNGa7
        J6ErU6FpDB4arXUwRiLklDjyVg==
X-Google-Smtp-Source: AK7set8UCw1fqq7pOokTqqBwG55lf07NMHtWhTdB3dAiI5zggOD6rqDMVTlIW50ALOYB/+Djcvmc3g==
X-Received: by 2002:a05:600c:1e8a:b0:3df:e57d:f4ba with SMTP id be10-20020a05600c1e8a00b003dfe57df4bamr12758098wmb.7.1675944692400;
        Thu, 09 Feb 2023 04:11:32 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x2-20020a1c7c02000000b003df30c94850sm4753348wmc.25.2023.02.09.04.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 04:11:32 -0800 (PST)
Message-ID: <fa2e0db7-5b27-5a41-920b-b786dc4e521c@linaro.org>
Date:   Thu, 9 Feb 2023 12:11:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
 <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
 <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
 <ed737e67-eabc-6f29-b734-f4698767ca8e@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ed737e67-eabc-6f29-b734-f4698767ca8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 12:08, Konrad Dybcio wrote:
> If the bootloader splash is enabled then this memory is used until the
> DPU driver instructs MDP5 pipes to suck data from a newly assigned address,
> so there's a short window where it is.

It seems a shame to reserve 30 something megabytes of memory for 
continuous splash unless we are actually using it is my point.

If I'm running headless its just wasted memory.

---
bod
