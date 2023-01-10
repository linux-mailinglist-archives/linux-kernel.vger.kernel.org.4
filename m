Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F5663D07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjAJJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjAJJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:36:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C241A40
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:36:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z5so10009573wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rAvwdJTXS0es/sk6vKngkqRWeq8GVmHG+Ko5pAlr0o=;
        b=UuzzWu2W2WTCmPP+JqELRP1ivu18UV5HPuQg6Uhqw7iTh0gHIXi5zJh5/woC13227V
         mm8XvS2EP6QvNvBxfSQtpr/99hSEkarwOXXmdENVVOiUJNSvfm5/wDAS4i49V8oLsd4g
         c4uRf2jrzAHNp27ud17JfFr1dwuk7IgkEtdU+fA0ZhguYww7noE4YmTgJFX8ajRhzf1F
         gFSogVmfDu/xP7smUF73qUuWdi4j9+Ynx3DGDCagtoTGQu/rvEU6RTIF8py7d8QPQz5j
         Cl9fb9Iozd9pyIPBPTwipRUdJQ1x8BBqd1Qt7AgI3UEvs863szlIykFfoWDjr5H1Le7O
         pIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rAvwdJTXS0es/sk6vKngkqRWeq8GVmHG+Ko5pAlr0o=;
        b=o8L1TEVMYt9n+EvLLacXS7tTNiezXDtzXIqcYVa3eU0vlPkqBQbUR5Ec/rp4DmQO8n
         1jx20qm0k/XCwPhYunufDWCeHTSqG7anGZcJlAwIASN7h6tpk0U2WTuWn0sYrnEde5lZ
         XUI5WsYFLM4MNin4CGpFe+vjK+b6eyzkZ/34g00yn2ndakj4Au52lykrbftxKIOIpqsX
         dPvMFVeIK6c3utPaQG3GHOVq41mynQoYj0hu1j9YsqIhpT2LLz8NVjwmP+CKUhlM0bwo
         MvWnhZ5cEQTJncqItxJlCjekj7pmaulq21rcxZ3A/opcLtZMITr0JP3OOHPLzrr2gS47
         Gb/w==
X-Gm-Message-State: AFqh2koeiZ9Lo/7TB4wltBTCkAyaOR4B+/za8JHTyd/fA0tV12QHv4SQ
        ACQlfw7PqL1j3rP3g/iZtzJLew==
X-Google-Smtp-Source: AMrXdXuRU0IK09HzBVc/O86XQMYlTE8GaqgeCudczqFjzdoIAkjChdn/r2YTwcAz9kjE+ivPUUfieA==
X-Received: by 2002:a5d:5b17:0:b0:2a3:50c5:9c29 with SMTP id bx23-20020a5d5b17000000b002a350c59c29mr15882495wrb.14.1673343386093;
        Tue, 10 Jan 2023 01:36:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000104a00b002238ea5750csm12459094wrx.72.2023.01.10.01.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:36:25 -0800 (PST)
Message-ID: <21ccfc0a-df0f-66fc-58a9-f773b2cbc5b3@linaro.org>
Date:   Tue, 10 Jan 2023 10:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 04/11] dt-bindings: remoteproc: qcom,sc7280-mss-pil:
 Update memory-region
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, robin.murphy@arm.com
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-5-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109034843.23759-5-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 04:48, Sibi Sankar wrote:
> The dynamic memory region used for metadata authentication would still
> be a part of the kernel mapping and any access to this region  by the

Same problem.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

