Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC06B444F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjCJOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjCJOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:22:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE7111ABAE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:21:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q16so5202495wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678458107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnRzMrvsiCN+4PreSm66b1oVlQhYcJdd5dzfTf21GJw=;
        b=FpTRpRxxdmd7NmTN1udMGEDDCfpZtnbL0H/+uDyDYPowHANrGP30ffv/oPRT4ehBfS
         0dkw4qO3WFaU2ZKdAt/MiUHAd0RqsCapGGaySGthKYE3zrRDEHtnpTEgmPgAp7xSlyW5
         95PKhIjTUxEWGJ5rQYZ8iEYWMsJFGumXatHRGaNuv08Of815RFzGe2pEuIHQfHWtJkEw
         lOYGFhBiUrO/XwtoaZkzJXFmfgKgDsvEHzFoJMiJo0cZ5LPQ2fKFYoH/54vwOxf6Rra6
         LL51xGpfxOF69IDH4bS0fcxPkR8+mNSnAYUDKmpuCUGa8LzIfWTUk/fjMMmgEEKNVar1
         JH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnRzMrvsiCN+4PreSm66b1oVlQhYcJdd5dzfTf21GJw=;
        b=uDul7FM4PLxe3tIIX3kSUIoFPFd7qWDvA6amjCsdAOFg4mWShVio4nHC9AmGNxNUE8
         Zims2VENZnpIO4MXKQekzBUfR5A69ZYD87qIjUEbnbmQIE+BWEr5sLXNvmMyPdJM4wIN
         TpN+63Nc2lN1hfW/6Bn6h5+5XGCackQzHbRQfvIVO1bBHWo/OflvE+1ImM7spD+ckC0+
         CxCgX09VvqY78N8jLnjGbmcttjzYK6UeUSi1SexksBaXHl2bbdoIuEimQB9lKY+unz63
         BnQP+8Zt5iWXW3JkrNzwFiML0U98bpFH1C5mx28Wiw69bQ7OgRP1X+pAn9QNqI9QYvVs
         +Ueg==
X-Gm-Message-State: AO0yUKU7yBrkaypF/6w/IAtvk00AWS9Z1PtYIg6+E19BPzRo7uRBDB0i
        JvdS2hn9o0DXC1D0OuiQiugbLw==
X-Google-Smtp-Source: AK7set/eNcAwO1mnLgjW8RS6PmO4LQ4XOfhdlPJVGO0ZQrpeq9Ekr0ixT8d/3DvXKJPBmNzgjDJW6Q==
X-Received: by 2002:adf:e98c:0:b0:2cc:459b:8bc8 with SMTP id h12-20020adfe98c000000b002cc459b8bc8mr16776159wrm.6.1678458107275;
        Fri, 10 Mar 2023 06:21:47 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d16-20020adffbd0000000b002c55521903bsm2297526wrs.51.2023.03.10.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:21:46 -0800 (PST)
Message-ID: <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
Date:   Fri, 10 Mar 2023 14:21:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-6-815606092fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:40, Konrad Dybcio wrote:
> Some (but not all) providers (or their specific nodes) require
> specific clocks to be turned on before they can be accessed. Failure
> to ensure that results in a seemingly random system crash (which
> would usually happen at boot with the interconnect driver built-in),
> resulting in the platform not booting up properly.

Can you give an example of which clocks on which SoC's ?

Is the intention of this patch to subsequently go through *.dts *.dtsi 
and start to remove assigned-clocks ?

Are we saying that currently there ought to be assigned-clocks for some 
of these NoC declarations ?

---
bod
