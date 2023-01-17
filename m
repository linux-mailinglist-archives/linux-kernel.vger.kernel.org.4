Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5866E7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAQUlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjAQUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:35:45 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824C2A148
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:20:56 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m7so3344415ilh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wp0QJQDzQBGT8hemYMe9M0vDzPuwdE2J+s/AVQDu9As=;
        b=sUyWoMXQn68h3GcPqqKEKdyWztOCpbn2A8Wm9ggXrnLDCQEnLF6g7PhjjUpN5jgi5d
         hrU5fvNfigr3LYsFGQWrCL+xVZEu1LIEPw14g41+GnfDCMXTZ4b5IQDxeiJWRWzxuhwN
         oXpVoZWPONN+ZPlS+OY6Lz7gBFTFPwwASkjzq3fdQR5Qk6BHRUhxWptOhWtaAZij80sD
         v7rggb0M86pSa+IdICOumogbXWQkjIGQ86NvRcgejWaIznE1BnRgGXBT0xLdHozYnweE
         koQAW+M7hUYGl7HPMExjtwaIc0P53UmgNa/gF6cHn1VDQ03UrQt6S8+PxNC6dn1eAHAG
         mjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp0QJQDzQBGT8hemYMe9M0vDzPuwdE2J+s/AVQDu9As=;
        b=OMCk9Nr83yXXGNrfFPB7x4RvnJ4BkWRMj2/Vr29ZNhQj0jH5+v5HR62D0wUjQVdp4k
         xcKKwv3M0TDQtmPostdGmgV4gzN828h5ww4bfkGR664eSzh/Tu9X7bZ4b3AqQlDsDDwX
         PKdgXuY3uaaoO7WpiZhZsOtHM44QR2CTlYk+hVtiFCk16q9COH8jAoHjGbd/tDY7KqmI
         S1P/wtudB2BBBviJZQf5oDeXUb16QO1iPOQ6TlPp2SFjXBaZkmfCdeszSbPz7G/glqbX
         NLZBJIie08IZ4EIXRnd3rcWjllJj/OamZ9TlOmKF8rVxHLk+7T55OLvGC5t+FkvCk35B
         9cPw==
X-Gm-Message-State: AFqh2kr8mbFcIsHawtymX+eqDAxgXPG88MI8NyaO56y6BAeMONmLDt4w
        Cw+fyR995lTUkH4gSMoFrnNBnw==
X-Google-Smtp-Source: AMrXdXu/lORiZp2eZqiqVnnjOPOkjH43u2TAvXtFDta2UFu0/KcmiUvJ86/Pc943zYRpsqEbtmEFEQ==
X-Received: by 2002:a92:a054:0:b0:30b:eb8a:79ba with SMTP id b20-20020a92a054000000b0030beb8a79bamr2844862ilm.27.1673983255338;
        Tue, 17 Jan 2023 11:20:55 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id g20-20020a92c7d4000000b0030c661606eesm9702252ilk.63.2023.01.17.11.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:20:54 -0800 (PST)
Message-ID: <08964d93-8118-1176-c2f8-73e14e022a89@linaro.org>
Date:   Tue, 17 Jan 2023 13:20:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-6-quic_eberman@quicinc.com>
 <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
 <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
Content-Language: en-US
In-Reply-To: <4e8a7fdf-8c91-cf2f-d369-c67b7584f580@quicinc.com>
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

On 1/10/23 11:56 AM, Elliot Berman wrote:
>> Is there any need for the endianness of these values to be specified?
>> Does Gunyah operate with a well-defined endianness?  Is there any
>> chance a VM can run with an endianness different from Gunyah?  I
>> see that the arm_smcc_* structures are defined without endianness.
>> (Sorry if these are dumb questions.)
>>
> 
> All of the data transfers for hypercalls happen via registers, so 
> endianness doesn't have impact here (there is no "low address" in a 
> register).

I don't believe that is technically true.  Practically speaking,
it's probably almost *always* little-endian.  But for example,
here:

https://developer.arm.com/documentation/102376/0100/Alignment-and-endianness
it says:

     Endianness

     In Armv8-A, instruction fetches are always treated as
     little-endian.

     For data accesses, it is IMPLEMENTATION DEFINED whether
     both little-endian and big-endian are supported. And if
     only one is supported, it is IMPLEMENTATION DEFINED
     which one is supported.

     For processors that support both big-endian and
     little-endian, endianness is configured per Exception
     level.

Perhaps that last sentence doesn't apply to HVC exceptions
but to me it *sounds* like it's at least possible for a VM
to be running with an endianness that differs from the
hypervisor (perhaps not other VMs though.)

This is not an area of expertise of mine, so I would love
for someone who knows more to correct me if I'm wrong.

It's likely to be fine as-is, but (other than the work to
do it and get it right) it doesn't hurt to specify it and
do the conversions as data is passes to/from the hypervisor.

					-Alex
