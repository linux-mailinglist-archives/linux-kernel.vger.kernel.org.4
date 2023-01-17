Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE866E7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAQUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjAQUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:36:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583122C65A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:15 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i17so11050462ila.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X6QGAdbpO4js38m8kqmMNfNj0cJL5DAjxA6pYUNKH30=;
        b=EGBN80wbBUdJj7Z/jkUWK5AFLeZOZLo5xHgOEl0PgXYrOSfBG/7dnDJbzvQhOya/ow
         +jy6ommn0FNq4Wqq83QTFAnhPeX4dDoMUIcfN2dIoY9l4OGUdsYixaaM17Ae+x1IkV8X
         xGy/1xQdE/J2mTBTSTAwy0GrYJTbaUjoANEguiNcpC5TV2IqfcMURDnsGu5H6RmCm7RY
         ZlSXTTrU34trY64Y/VT6wmqHwm+9puSKKQDZBIjr3mHpp+++7lx7kTP1g7LiYlDtyZso
         zzQmejXLekCZG+ZaIwtd1vNYDstgwiSpx9kTxioziEPC6gexAocnuxZtPD1IJrJLBlRe
         RuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6QGAdbpO4js38m8kqmMNfNj0cJL5DAjxA6pYUNKH30=;
        b=Zxn19nQdQfts76jpwsAat06GRsen2vnnPmapRl/sgsonM2lmrzpB42JwGQj+vqVqhM
         /9H/FSgRfmGbj9qPbOhaSFM3GHAB8mVZZAZ5D44ptbrxK4sdHKprkMqY3YuerpbC4SwO
         ivDVkZcqlnLucfRzjdSTa6AV3KcKlS9XPgChSHIqsOCN7rozYAL+3cln5fNPL5pAjSP3
         qe6cLVFCajH7y7LSL0NeMOmV3xxJgivSVOLLfBMIGCo1+IpW3NtbfpmRLj4l/XW/v7fB
         JjMlDZBpWCx4Snx9ok/ZIiKbzZmwlnR/BMvfcntSZCZyikmCSpL2Q9tuSKHkrJsQnY5O
         Pnuw==
X-Gm-Message-State: AFqh2krdmD5JmLDCPiaxMiRpTAHa3aGJ3cGLw0falRYJ+f5mSiKRnXzM
        8vnHdvykUoI0dacx4MEw+xtpaA==
X-Google-Smtp-Source: AMrXdXuSn9Mn8FTmXSuDHirPKGy73AMn7jIeXgtlejcuD7V+SVsgxxuOefJLK0Qin4xwXGaY2YwGSA==
X-Received: by 2002:a92:d6c6:0:b0:304:c91b:4a5c with SMTP id z6-20020a92d6c6000000b00304c91b4a5cmr3292929ilp.24.1673983274699;
        Tue, 17 Jan 2023 11:21:14 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l3-20020a056e0205c300b0030f1be2e051sm811189ils.39.2023.01.17.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:21:14 -0800 (PST)
Message-ID: <65af5abc-3719-95fe-041c-67d1d146aba1@linaro.org>
Date:   Tue, 17 Jan 2023 13:21:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 09/28] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-10-quic_eberman@quicinc.com>
 <4e064b55-22fd-5f29-620b-715a5d822a75@linaro.org>
 <f626a867-7293-fd70-00d7-706d43342f5f@quicinc.com>
Content-Language: en-US
In-Reply-To: <f626a867-7293-fd70-00d7-706d43342f5f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 12:16 PM, Elliot Berman wrote:
>>> +    ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, 
>>> msgq_data->length,
>>> +                    (uintptr_t)msgq_data->data, tx_flags, &ready);
>>> +
>>> +    /**
>>> +     * unlikely because Linux tracks state of msgq and should not 
>>> try to
>>> +     * send message when msgq is full.
>>> +     */
>>
>> Is it just unlikely, or is it impossible?
>>
> 
> This would require multiple mailbox controllers interacting with the 
> same message queue.
> 
> The only way I can think this is possible is if the Gunyah drivers are 
> unloaded when the message queue is full; drivers are then re-loaded 
> before the receiver processes the messages. The initial internal state 
> of the message queue controller assumes that there is space in the 
> message queue. We would get a Tx vIRQ once space becomes available and 
> the message would then be attempted to sent again. Since there's a safe 
> flow to recover from a inconsistent internal state and it's very 
> unlikely to start in that state, I don't think we need to add calls to 
> check if the message queue is full during initialization.

First, your explanation is appreciated but more than what I
was looking for...  I just mentioned it because if it were
impossible, then there's no point in having this code handle
something that literally can't happen.

But as far as your explanation, I *hope* if the Gunyah drivers
are unloaded, everything gets fully cleaned up before that
completes.  There should be no in-flight activity, or
any "previous generation" messages that could be processed.

In any case, I think my question is answered.  Thanks.

					-Alex
