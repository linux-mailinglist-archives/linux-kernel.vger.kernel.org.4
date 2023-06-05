Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBC0723056
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjFETuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjFETuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:50:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E133C1BB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:50:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-777b4716673so38874139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994601; x=1688586601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zqUbmlyyOpVxtzSDJaeMbmrOzSyNHvJjWJRif5DapRE=;
        b=BTWbRhmXvUhVB/espD07rFre+Ia1t3SkAcewyxuS40cXxQ55tz00JRfq571J6pqYR2
         lR5hpjUrFVk/NckEWR2TeEVsLOVxrNb0LiNCBno5ZDQvmnnmnNM586TjJZmRbHTD3bs9
         rDhyal+pr1KIRHSrtffQXaIzPs07pFGuubS1AWZYmzLdrJm6bvMZb19qEPSKlQqlIWmC
         7RWalRtDd1+nphyBCedY8So2SbfYaoBWA+Idlw7/sq9MjRJKhqNLyBb3C7caBRGW/HDc
         cbaWZ8QwZGmB4kxW8I8w7R30leN+9dwjeJv38NJNRLKwqAmIuuZLnYz+vwqUXb1A17CE
         afUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994601; x=1688586601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqUbmlyyOpVxtzSDJaeMbmrOzSyNHvJjWJRif5DapRE=;
        b=FgPjWrmBERSfW6HKx9akH88R+RrP32giisoUJxuScckekAdzIJ96LfPLtoXrLprpx1
         aCk7ooUYmybHtbgad9aTqVGYj6lIsdQFEbCT46pXCwAvAL9jUn2O7N3lGclRhqlVLUgE
         QbLeRpmiGG/Wk33lxdJ1QWBeDnRrXCUXFeMJm4XekwUE3Afia9tlLL4SycPwBpJgAA1k
         0ITS+VMbyU+QoKrjZ+hbEqnbgHqR8a5T2Nrst8wvSR+VaUJsBH6cuyYOYCDgEjhCBjhU
         2/Akk9FMUEBUXm2c0W/HJ68NU3AzdTx2FF+hxnQNx/GwVZ4XgwwnaNLfT/rZmccX25EY
         fCHw==
X-Gm-Message-State: AC+VfDylaxxJSVqjFkI91/Cz5FHlP/BbPnSzT9A71F3X752Tjh+NN0pb
        0CD/28v4fNjFfcInesyM5/wZHQ==
X-Google-Smtp-Source: ACHHUZ7Mm9wiy5ptelw2AO98uw36L+kIz6u8B45c3gTGltaBfqoiSqhByCWJ3vMSfPouKBiVei/PzA==
X-Received: by 2002:a05:6602:2195:b0:777:b556:c130 with SMTP id b21-20020a056602219500b00777b556c130mr23077iob.8.1685994601248;
        Mon, 05 Jun 2023 12:50:01 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d8d05000000b0076c7a2f0f41sm2714186ioj.46.2023.06.05.12.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:50:00 -0700 (PDT)
Message-ID: <85fe3f90-12ff-cb91-73c1-0efe66dae695@linaro.org>
Date:   Mon, 5 Jun 2023 14:49:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 18/24] virt: gunyah: Add resource tickets
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-19-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-19-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Some VM functions need to acquire Gunyah resources. For instance, Gunyah
> vCPUs are exposed to the host as a resource. The Gunyah vCPU function
> will register a resource ticket and be able to interact with the
> hypervisor once the resource ticket is filled.
> 
> Resource tickets are the mechanism for functions to acquire ownership of
> Gunyah resources. Gunyah functions can be created before the VM's
> resources are created and made available to Linux. A resource ticket
> identifies a type of resource and a label of a resource which the ticket
> holder is interested in.
> 
> Resources are created by Gunyah as configured in the VM's devicetree
> configuration. Gunyah doesn't process the label and that makes it
> possible for userspace to create multiple resources with the same label.
> Resource ticket owners need to be prepared for populate to be called
> multiple times if userspace created multiple resources with the same
> label.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/virt/gunyah/vm_mgr.c  | 117 +++++++++++++++++++++++++++++++++-
>   drivers/virt/gunyah/vm_mgr.h  |   4 ++
>   include/linux/gunyah_vm_mgr.h |  14 ++++
>   3 files changed, 134 insertions(+), 1 deletion(-)

. . .

