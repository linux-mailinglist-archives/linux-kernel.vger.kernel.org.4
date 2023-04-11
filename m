Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCB6DE631
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKVJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:09:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7440E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:09:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g16so13050664iom.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681247367; x=1683839367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5Fqe2TWJg4JQvlVCDVhDYu+cpARd8OUv1aMwqepO+E=;
        b=LDT/iLh2fO4h9CGyyTzcDHHx1VMD4/yj8QpKTtPr3CpuvPjKgHmZI3buA4zSfHMD4A
         Uv5PyeIr8z0ZV81KKJza/KV96iwGhP0N4IO6/8cfUvlZyMOKUJfcnSkb3SKrcx4p3XuT
         R1M1kUAFQQLDIYJp5Fgyvu4bapJ3lmKdjzbo+LU8OjqtAoD+NgbvRiu8CNQT5SPRmbUi
         JUwi9vVVrwxkH3zC/VOQNcjzuK7EaLD6QyLBhTXL7Xr8aVeLUjVE4OdBSs5/AttrPo2v
         s31PAUJ7FTCnsOMg+0lo0hQwqhlXsdSS9z3eS0SYH3Nw3u9PYr1prKMQ1DTTRG+F0oqV
         +KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681247367; x=1683839367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5Fqe2TWJg4JQvlVCDVhDYu+cpARd8OUv1aMwqepO+E=;
        b=QUPNx0+9bKtulHmLG7f/uW7Vd6mNEOFnHlb3FKmfl9IFAmeA3g2zAh7Afst7Ul//0E
         jJ6i0ZHXR8kBvJouLwNB5mCMAdLNjV/zhkic4wgGECRmHp4fRtgRy4GsM95hHKhK5xhS
         UXZL5YDeAI44tFfjs8BUAuHQveOq2sNjs4tVUny3vYm7qnKBVLZYQLwxJEqq3dKMn3Vt
         sjeCvLAZHhscC6bYhFT4NOQA+eSNhLf+0UmODw5uBpCPhqWJgDTezTv/YGdbsWto86CS
         30YG2lX/Zy2JsZDHQVxIinUERf5rwKKNp0YXzzIFuKwP/PbV77KX7dOryae4YaHzWF2m
         m2Xw==
X-Gm-Message-State: AAQBX9clqOFv22aEZMMLhkloWkIz+pAoyyVVi3xyJ2VyAwdNIK8BmwIE
        L6Bz+KIYksK1me8Tnk+yuBoqUA==
X-Google-Smtp-Source: AKy350Y2FUSewhTp6knjCVBEbrgvEPREbj88THm4RouFUh75P4YiCm+qzi6OVVaRyPx8lnXTUGe/cw==
X-Received: by 2002:a5d:8615:0:b0:704:b905:e652 with SMTP id f21-20020a5d8615000000b00704b905e652mr2802579iol.11.1681247367540;
        Tue, 11 Apr 2023 14:09:27 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id h8-20020a022b08000000b0040639da0a02sm4133266jaa.135.2023.04.11.14.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 14:09:27 -0700 (PDT)
Message-ID: <6f6d8640-42cd-beae-a57a-50d9ff927ea5@linaro.org>
Date:   Tue, 11 Apr 2023 16:09:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v11 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-14-quic_eberman@quicinc.com>
 <fa073ce7-a9ef-9e8e-8791-71578a0834bc@linaro.org>
 <bda10c5d-4577-a21b-0c43-aa97679162a5@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <bda10c5d-4577-a21b-0c43-aa97679162a5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 4:07 PM, Elliot Berman wrote:
> 
> 
> On 3/21/2023 7:24 AM, Srinivas Kandagatla wrote:
> 
>> On 04/03/2023 01:06, Elliot Berman wrote:
>>> +
>>> +#define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> A comment here that this is going to *ONLY* start an un-authenticated 
>> VM would be useful to the users.
>>
> 
> There is only support for unauthenticated VM in the UAPI being proposed 
> and I'd like to re-use GH_VM_START ioctl for other VM types as well. Is 
> the comment really useful? I can easily see forgetting to remove the 
> comment and then being more confusing once the other VM types get added.

It's up to you.  And in general, I think your responses to my
comments have been fine--even when you just explain why you
don't plan to implement my suggestion.  Thank you.

					-Alex

> 
> Thanks,
> Elliot

