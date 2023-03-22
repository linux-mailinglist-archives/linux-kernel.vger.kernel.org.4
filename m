Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3276C52FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCVRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:50:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14365DC85
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:50:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so76307926edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679507425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZzncM0ecKdqEUsYhFXJ0esFYC/77XMfZpKnpzc9Pjo=;
        b=IUcv6xcY+oUqK4B4K+n84pEjRF1Psx65H0Dzjchq8r9f3+jpmE1pTENA5uA0BnowzV
         uAHKGZCR8yyg8Jit+UxQTdJxCROGAN7uq348vwc8S2H69pRtl7tUsw44O5Il6UYtsaJL
         kIMT/tK/BdJkDTFqio8I+0g8YAPmolNKM2rkS6ZjgwM4RAGgA6WhN5o4jOmnT6ttDilQ
         a3ta6K4l537tFjok0DlhZ9IE32cWpzokB25Z8h/HHOCll7WdcSeM+E6xHn8hIPWbxpUZ
         Ckdf5kTeXeg1u3DT1CiQzwqLefbWDZdlXRqhCNrxoLWtqhOhJLBBbtau0hTEpNq78HqY
         ccXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZzncM0ecKdqEUsYhFXJ0esFYC/77XMfZpKnpzc9Pjo=;
        b=HlbbdR0lmaGZnCNBdZTABBD2aUcHEth3VyYeyAkjOrIvvhK8c9wW9Vkwq4jMQJV/ie
         6IlwFxNJW7rrI04q1sT4Mxam7hIVswymiW1VcA+X+/PT4V4wtAvqzAk+YUFQ4hTACHfC
         jyTH7MMqizWA/9nvML4jfGP9VRsIafuESJnz96ffw5ZOVb6D0W1zLy4MXccTfLizKX5g
         RP2xXFxvzV6EfYMB0T5jv2b2vsRWUAT9Hgj+fDBxZiBSE/rjdzQdIQumwJ9XG8EFbsF2
         AbBkc7tyycQpEyjWnzjSIM0Rt1BIoPnU4+eyh+Sd+KQGP61aXYtN8O6byOb0kH4Y0FjH
         gYtw==
X-Gm-Message-State: AO0yUKVtRsnzR8y7iqontKiSfVLe0C0h6o37qFj2sLekOBXVdwgdtV8+
        RdjN5IwnjPPFH3S90DfIu2rnTA==
X-Google-Smtp-Source: AK7set88wcc7ojm59JKSFAtUU+gUBZdzhodrq/+Pzcm7IRcfUHbjARjZBB5XSt1Qx/Feg+Y9p4huHA==
X-Received: by 2002:a17:906:abd2:b0:918:668d:d6f9 with SMTP id kq18-20020a170906abd200b00918668dd6f9mr7468362ejb.16.1679507425316;
        Wed, 22 Mar 2023 10:50:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm7656194ejb.14.2023.03.22.10.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:50:24 -0700 (PDT)
Message-ID: <dd6257a9-1a12-23f9-e770-0809aaa7ed0e@linaro.org>
Date:   Wed, 22 Mar 2023 18:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in
 BPMP
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-11-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320182441.11904-11-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 19:24, Sumit Gupta wrote:
> If BPMP-FW doesn't support 'MRQ_BWMGR_INT', then the MC Client driver
> probe fails with 'EPROBE_DEFER' which it receives on calling the func
> 'devm_of_icc_get()'. Fix this by initializing the ICC even if the MRQ
> is missing and return 'EINVAL' from 'icc_set_bw()' instead of passing
> the request to BPMP-FW later when the BW request is made by client.
> 
> Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Tegra234")

That's not correct tag.

Anyway, send fixes separately.

Best regards,
Krzysztof

