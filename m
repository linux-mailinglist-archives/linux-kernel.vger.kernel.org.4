Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564B96A5048
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB1AwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjB1AwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:52:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57525E24
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:52:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so8026696pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8s5UkFxN0XyIVbUTdsw9LuY++h2yrQIvwFytCMmrlw=;
        b=c0/r4xm3kIsQ2Jwpl2m192HxOi7kIuvxJlwpCw38u+VEwUoONxMx+2qs1uLXOCjydX
         2LbhnU8dywiojN74erI1KyXuyFYPRJdsQl1goK7DcPl5Sipb0qRBq5ulFnzZ1VzKVgYT
         8YPGredZ0oHAq6gSDQ9HKIe8bmBQEaON4yWej2GQseOoXtPfUMGDLMq73zvuQ38uFJcR
         +BwmQdvaHbPp+i4V5Uhi+fAu7EjF7hT7zMOBPxFM/t6yrAcWlgcbT5J7Et/hI7nS+BVO
         9LFuQtJersMA2qTjc4ezrLiEjKxaf2ZzBG3t3F0fnhSAnFnQ3tngo1g16dXdohdHqIq/
         fWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8s5UkFxN0XyIVbUTdsw9LuY++h2yrQIvwFytCMmrlw=;
        b=ZkfXlrMXgAdw3Hmpt5gDSyiG9UAwaEjidPAnYP4gz0RfdMoGKH2lhu40y3ZqPeTqcm
         bf+Vrbd2RO1OTr3pycDc1VBjhC4OoSqKfKDa6Zljb24Jc/7Bh4LWIirVgIo5BF+i09i8
         g2D1Qj2B9FDTGZSCfUoYivVe+mseY82kdYhnZz179Av7nilwFhfKhM7Xldxkelk9gMXI
         EwuhcU2wsoaa2Da4XgcRNDI7b7A+WnB1eZe7If9kM7i9aNODpGdCfav1R3zgEleQealA
         tCq1TaY16utWVrTTuDyVFh4ycqb6inprzwJ32VWlRAyjXWAx9wyujpqRnd51XBInSVkq
         20Iw==
X-Gm-Message-State: AO0yUKWxlhvPlqiIs9Q9Wim/TzJlKcvnTOPNrGPYODl/qcMv1csd7LsE
        6eo0VXUzPmdl1ZOg9ffMN1M2wQ==
X-Google-Smtp-Source: AK7set+TQtVs8/qCCbDkDc4YM5iQhgpDnJ+EIymGMdWMWy3GdNnv8VYRETrDicOK331w/rirpzr9GA==
X-Received: by 2002:a17:902:d4cd:b0:19c:d7a9:8bf0 with SMTP id o13-20020a170902d4cd00b0019cd7a98bf0mr1618653plg.10.1677545525332;
        Mon, 27 Feb 2023 16:52:05 -0800 (PST)
Received: from [10.211.55.3] (h112.92.137.40.static.ip.windstream.net. [40.137.92.112])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0019a8530c063sm5176304pll.102.2023.02.27.16.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:52:04 -0800 (PST)
Message-ID: <e75b8b9e-c870-6342-f7e4-32492d5f77be@linaro.org>
Date:   Mon, 27 Feb 2023 18:52:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
 <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
 <44a59ea4-da6e-e96a-5e89-dfd41db72823@linaro.org>
 <cd61963d-eb4c-9a4f-d48f-7a633bfd4be3@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <cd61963d-eb4c-9a4f-d48f-7a633bfd4be3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 5:13 PM, Elliot Berman wrote:
>> TBH, gunyah.c should be merged as part of resource manager, and check 
>> if uuids and features in probe before proceeding further.
>>
> 
> 
> Ah -- gunyah_rsc_mgr.ko has symbol dependency on gunyah-msgq.ko. 
> gunyah-msgq.ko has symbol dependency on gunyah.ko. gunyah.ko doesn't 
> have any probe and does all its work on module_init.
> 
> In order to merge gunyah.c with resource manager, I would need to 
> incorporate message queue mailbox into resource manager. IMO, this 
> rapidly moves towards a mega-module which was discouraged previously.

I missed this discussion; why was it discouraged?

I can think of some reasons why I guess.  But I don't see what
problem comes from linking together a "mega module" that's made
up of well-isolated source files that expose minimal APIs to
one another.  All inter-dependent modules will required at once
anyway; I don't understand the benefit of implementing them
separately.  Can you explain, or provide some context?  Thanks.

					-Alex

