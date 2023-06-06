Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3D723F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjFFKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjFFKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:15:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC6BE5E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:15:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso24897835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686046505; x=1688638505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNkliQDOX5/DehjdcQjHrvfLhUKbrTQj51iuKhg8zgQ=;
        b=PeTPaH5ibJCAkBRiyVus6ZSYfqU8v5zhbB1pCsTbPy/BzRdPgzKA4Na0VRu2XdyKav
         JSm0XHG57qT7+kLkY73VFINxtuFRnMruq75OTD75iU9vt2ODFzjCJcnOG8yD0mohc4DT
         61dWdJdQJhKIaltHJQfbELKuvqrgdwOHcwYNwnMHXLhFz7w5VCBGnRnufuCmIlcfJAsI
         wP0/k8CLAB11/Rfj+yHdr6Csp9efQgxULzpxSqCxHSVgp42cC3QZQoDCQhCewqfrMWT0
         GgijQkB/moacltprbDhn2JYX19tIBBpb2DlizG9k3JI675+bUPEtOeoLn/YlpO+SgykV
         StXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046505; x=1688638505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNkliQDOX5/DehjdcQjHrvfLhUKbrTQj51iuKhg8zgQ=;
        b=M8rwbW4Mvgm+D8iSuL/NBBH1fKv5uY/WB4RQriuZVf4Fl9Z1addYibXSPAMAggWuVm
         z8dLCSP3YZy3ML7O+YiTAXjavLsQUNY/BspJeE1cDbiGhoc08lbVnjZma0rrYsaO4Zw4
         c+TkcLjH3sSNqGJkjHuC927Wno/DDWu4KdViQK2xXxk2eujAjRR3I8cgh8DQ433vRZb/
         mUDGLguxnM3HMdGCchhXT1Dp3LzLD+Bgx7iNJq0fDE/ZOYE87U5+go2XXASqo3BnTJzl
         oqkU23iQilRH6a6qu50Vw9KBz/8GsH2o/3cIsX8q6lOAEF41ZN0l505Nt3SpxI6Z1orn
         PrgA==
X-Gm-Message-State: AC+VfDxJDTG3DFhLeeTPdl7ZYTDvay/onUxqp5mrknZNLrkhHI4rFRvu
        wfb2nRlQ+67tARhNf/qmAMi7fg==
X-Google-Smtp-Source: ACHHUZ7UXzN3sjrmWHqnF6qF45MerD7fGvSmOZEJhXivlS7r1ZQTZXAdh6hooFfVKS3RP5fx9S7ekw==
X-Received: by 2002:a05:6000:4c8:b0:30a:eeee:2fba with SMTP id h8-20020a05600004c800b0030aeeee2fbamr1481125wri.34.1686046504842;
        Tue, 06 Jun 2023 03:15:04 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d504e000000b00300aee6c9cesm12229550wrt.20.2023.06.06.03.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:15:04 -0700 (PDT)
Message-ID: <4742a6b6-f647-34a8-682a-af5ed181608c@linaro.org>
Date:   Tue, 6 Jun 2023 11:15:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless
 support
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230605094710.2037879-1-amit.pundir@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230605094710.2037879-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 10:47, Amit Pundir wrote:
> This is a follow-up of the upstream discussion,
> https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
> around adding a reserved memory region in sdm845-db845c
> for the framebuffer memory (the splash region set up by
> the bootloader) but the general opinion was to avoid
> adding that reserved memory for the headless DB845c
> usecase.
> 
> So this patch splits the sdm845-db845c into a common dtsi,
> a new sdm845-db845-headless DT, which disables the mdss
> display subsystem, and a new sdm845-db845c DT with an
> additional reserved-memory region for the framebuffer.
> 
> The default sdm845-db845c.dtb remains pretty much the same
> (with an exception of additional reserved-memory region),
> while others can use sdm845-db845c-headless.dtb for their
> headless systems.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Walk me through this one again.

We only need this reserved memory for as long as the splash screen 
persists - correct ?

If there is no HDMI or DSI connected then XBL will never allocate this 
memory.

If the MDPSS? driver runs, the display hardware gets pointed at 
different memory and the splashscreen memory is either marked as 
reserved - and never usable again or its not marked as reserved and we 
have system race but in the racy case, the memory is usable.

Is the solution then not to make the MDSS driver always liberate this 
memory - irrespective of whether or not a display is connected ?

It seems wrong to sacrifice ~ 37 megabytes of memory permanently. If I 
were building an embedded system based on db845 I would want to have 
that memory available to me either way.

---
bod
