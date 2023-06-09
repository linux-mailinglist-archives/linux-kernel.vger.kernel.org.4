Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE172A197
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFIRqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:46:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3935DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:46:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77acb944bdfso90333739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686332790; x=1688924790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORN9WVquc1eDa/NSYBsODEMAyXT/sC/8w6SXWS7Qzgo=;
        b=fzsnU9EoqafeV7Cn73ofchOoBCacaYnZUnIOw7tL8zNyqaxJs4nTNt0evUic6C65tq
         qE6DW7IgcvWLEivIP6r42+q3oN77yHyRpK5Mj6Cy3c8hZ7HA/sm43fuRoSJ5+H9PJjzu
         50HWDhOJy7qrVxtNvrjuuWsaO/EOfdFzpXgnqaAHTZvz2+RwI5iaroHa8Hwt9ol3QoWs
         jBD5q/6FQIHxrrcegz3/vuEARZdmu2uu5YFkKD5CCVou8U+O9FvAyBwRc5dUTHKg3RtF
         U9AvH1RKRcXrz7Zq8B7TidkYyvB1rp0prVXkXmJl0IW4iBYwuQvHiM081/3u5XUAyq2O
         HkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332790; x=1688924790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORN9WVquc1eDa/NSYBsODEMAyXT/sC/8w6SXWS7Qzgo=;
        b=NKNoLm9NLQoKKOhPn+MbEfjVITeOFRBSISF7QShqSgj2NvHfKB6qa3uTf/bHs+j2/o
         bzYcDaHhFJOj8b8icT8xWpq0BN/aOuT0o1G82JAdrLsUvemYYhho5340YK8BhUCV/FkM
         Ez3qsLeAXLLlqAGQm4WxVHfq/NcbrB+PVJdYwMaAUs3DL8CtlKa/0NqEbcDhmaaTkrRe
         PeXFVtfiQAf9TO0u0fKh3g3+VvZ79nHHpCFLPv/9KCwkBuBlEXrv5QSjj60B53655C9o
         PbX35mYdSwIDXkmmhJyX8AOVidxxmJJ4oYM4EoLxH/vSkTytUVuospotOyfffDwragCp
         A0Mg==
X-Gm-Message-State: AC+VfDybriag+TdZUliSJ4yxq6LTIZRXghlAJtKA9ieyQF7PmeQ9pOP+
        nCNthfBS8bX+9k7k6s6c3BgzYw==
X-Google-Smtp-Source: ACHHUZ47AG3wAglH5Pw0GaXvZRnB3BfoAgvmfvevkXVlgMtgzr6hM2rkymQ7qMD3eChz4oaVWxieBg==
X-Received: by 2002:a05:6602:2747:b0:774:8786:1b59 with SMTP id b7-20020a056602274700b0077487861b59mr2513455ioe.11.1686332790231;
        Fri, 09 Jun 2023 10:46:30 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a22-20020a5d89d6000000b007747a6d875csm1190529iot.9.2023.06.09.10.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 10:46:29 -0700 (PDT)
Message-ID: <ab5013da-51fe-8bd4-e4ff-e16f9d81bd48@linaro.org>
Date:   Fri, 9 Jun 2023 12:46:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 23/24] virt: gunyah: Add ioeventfd
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-24-quic_eberman@quicinc.com>
 <85e7c3ae-0991-0ca9-909c-f38773f63894@linaro.org>
 <2f60fc9f-a8b2-fe8c-183a-5ee9b276b02d@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <2f60fc9f-a8b2-fe8c-183a-5ee9b276b02d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 12:33 PM, Elliot Berman wrote:
>>> +static int gh_write_ioeventfd(struct gh_vm_io_handler *io_dev, u64 
>>> addr, u32 len, u64 data)
>>> +{
>>> +    struct gh_ioeventfd *iofd = container_of(io_dev, struct 
>>> gh_ioeventfd, io_handler);
>>
>> Does a write of 0 bytes still signal an event?
>>
> 
>  From gunyah_ioeventfd perspective, yes. I don't think a write of 0 
> bytes is possible, but maybe you are thinking of scenario I'm not?
> 
>>> +
>>> +    eventfd_signal(iofd->ctx, 1);
>>> +    return 0;
>>> +} 

No, I was just observing that eventfd_signal() is called regardless
of the value of len.

					-Alex
