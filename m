Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1D65B3E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjABPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbjABPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:09:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53695B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:09:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bq39so34103708lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQ5TlvQcWjRRm6b2OTD1D6ae2UGkXzupmyvdapRYCLI=;
        b=ijVl+/UPlJ6pf1b87q/freCsy7IHzlCFndaBzu87+p2xc2iEr4yX7yfcI7OCVKb8Yw
         hNyK9iHWQ1/zjIQfVerHkA7cX9tfGZcELkBpfvqymnPeGbZ+E78eORd3QseucFmAFTUd
         oreQYFdIthklrx+dmmBBrIkNNIC1UDP+K5B5h8Thix66wL3sW2ew+PyMwtAO5oYujWes
         ZtX4dxQgatPbkpycv0gRUDe52QvSi7caRBposaHf01anA8VUbAkNRABGwSQrKICn5O1X
         x3tjRsdS6OSkhK+vXk+WHMHGYUXoVTr4WVjU8yl9W01nRZ70RdEZhSMG82jR4f1wZZYI
         se9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ5TlvQcWjRRm6b2OTD1D6ae2UGkXzupmyvdapRYCLI=;
        b=Y/uvTcSueQogW8QZcxflArDGYbBQqGNP/wy9ZFX+TP6qqSLwpvm6GJR0FfFhuBV7FM
         yw9A/OnH1SFEBy2J2xKGNq/vMD1et2P3BW8NcXgKmGbu4TvOZwWRPWBC8ATs0B4ccwHL
         r3eNHaI1CpFNaWzn3Ofg8GY6DZ4xPepQa8wCWWhcYrf4KYrnsiwfYsOVqbpJonS+brNZ
         WBn50Bsnqql8ssd5tAeeQvgVqYqPwn+A5fRufBf+tREV2lvPragw5FZhQd78fLg8lkE/
         SAbw0EuDGWVL6B+/7++5m9yfvBr4oRwD8jXho7GNSWoY5XWfJuuL6WzMoZ9flqZsE8gL
         TrMA==
X-Gm-Message-State: AFqh2kpBH6LxHyS2SQV+AGR/oWGlJLb5ZbQ4HE19JYFYwkZ5WtMJ7RUG
        HBDOUvjk5tJBAUtC5fmiEB3FLw==
X-Google-Smtp-Source: AMrXdXtYL9jE//L+XB8b8VhGGV8iVUa61wddthB4WIzGYN/WjTmcVkAavLSt3Cc7u2uPOnBxvcJJdQ==
X-Received: by 2002:ac2:58e1:0:b0:4b5:4606:7ad9 with SMTP id v1-20020ac258e1000000b004b546067ad9mr12233478lfo.39.1672672156703;
        Mon, 02 Jan 2023 07:09:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b0027fdb26e4b1sm1084700ljb.91.2023.01.02.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:09:16 -0800 (PST)
Message-ID: <ae0499ce-f4a2-22a8-840a-6d7640079b93@linaro.org>
Date:   Mon, 2 Jan 2023 16:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
 <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:03, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 01:20:03PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 11:50, Johan Hovold wrote:
>>> The wcd938x codec is not a memory-mapped device and does not belong
>>> under the soc node.
>>>
>>> Move the node to the root node to avoid DT validation failures.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
>>>  1 file changed, 19 insertions(+), 21 deletions(-)
>>
>> Don't you base on some older tree? It was alreadt moved. Maybe other
>> changes were also implemented...
> 
> If you've moved this node is hasn't made it into linux-next (or the qcom
> tree) yet.

So you need to update your tree/rebase as this is already in Qualcomm
tree. There was no linux-next release since a week, so that's not a
solution.

Best regards,
Krzysztof

