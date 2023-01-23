Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C906779BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjAWLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjAWLAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:00:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB067DBD5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:00:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o17-20020a05600c511100b003db021ef437so8220080wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoMxQi6P6gQALr5fTqcoF2RvllvoHm9Uewgoh0CLFsA=;
        b=pwIMCbFRMKCmOjJcqheAFoPiAg7Q5iUg2JDpaNpvjm7HUxkkfKXWsOFsrOWReOgPao
         veauXSfsuTnMrNlzPDB+gt8VJj/koWEUGwio80nbFYzkt3XqkKP3/G51oZYIu/vu9Ei6
         OzX2stfhjfCCofefCPj78Wg6gPr/9CGTtN8uf6dnVaSdd0NZqN+2itD4bOdaGC/uNhyX
         UF5lbUqUYpE3GhW53oybvG+ndyw49obdLsBjymEvAidfZhInqRQaTmdSpIldPE0zNRjM
         0cE7uCJyhf2EQhQVZYY1ulRtraVHWs79q4+1UVpyiJnM0eh+/9UguQIwX34cFa1lZZvu
         X8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoMxQi6P6gQALr5fTqcoF2RvllvoHm9Uewgoh0CLFsA=;
        b=W/IL7dvMnVEpfEmTQi6fqGsWGeeRoDIPfU1XJzkL2hHzKMFqUi6/0y4BrUK8gDxvap
         ok3Y+x1CMEwVvMRFYM+hR8a329/fkPHHnQmX5pHwyOD+AaYRFPKwlpSw610+QR5iEEWC
         RI8OLU1zphpVP34TXGObO7AwmktxUxzCNjF1nHUsmOoypwDxD9MAJgNhoGtsWZY/INWC
         8dWWrhHiOQgLjIR3sWlMC4L9zggv/lkpmk81A+w22ZwpEla62M5Uqd7rOaaeUWLwsqNa
         lSg60cfwenSTPyjMPWXzbc/RSV5F1YlqVhH1DCdVLa4ZJFQjNDEuZkRfZ7awVSwlPndr
         t1iQ==
X-Gm-Message-State: AFqh2kphJO2C3pdsen5wetj8Yff3plQublibGGHYcGRyJi02PxJrM+V7
        zfNojTl5lSfRcwKgvNExrW/8tg==
X-Google-Smtp-Source: AMrXdXthSh18y/Pfpnbd+I5ax9kyThEk8u+bddSZOEtILQqapgx6Py6YLXUkOY/iCgi6Nf1Z+Yy6XA==
X-Received: by 2002:a05:600c:a13:b0:3db:1de2:af31 with SMTP id z19-20020a05600c0a1300b003db1de2af31mr15779613wmp.37.1674471609483;
        Mon, 23 Jan 2023 03:00:09 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003db03725e86sm10126826wmc.8.2023.01.23.03.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:00:08 -0800 (PST)
Message-ID: <0aa544f8-0d23-5345-b9b2-61d6e765c784@linaro.org>
Date:   Mon, 23 Jan 2023 11:00:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
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

On 23/01/2023 02:31, Bryan O'Donoghue wrote:
> - Leaves dummy power-domain reference in cpu defintion as this
is required by the yaml


