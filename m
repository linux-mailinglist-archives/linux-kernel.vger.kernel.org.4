Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40E690609
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBILEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBILDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:03:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E7BB9E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:03:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r18so1139004wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9JBQ25n949SzT0aJCa+SmK4nxBdxfr7uXV4RhT7iBk=;
        b=bst5SA4qticmOdvwRLGEk4GcHbbnovNjbC4y7JMi1T7NETj309mIGUT6EPYuL4HF/q
         yG0w65mbn65/GaxxJBcSloHGsmYyG2z1C9elgvdeOW7R/0OF3zk6drFaYUwznUJWItRh
         SYAM+3MQRjhs/6UeXi0lB4+dhKI2pYnJM5T2hm/kLNuXTEZAxk+1nE2+62mOIAdGdWKq
         HsXkFhGulTWLAoF2WlFb+9ZQKkIFomaUmmkhi2wmX6Iap4QraT6U7cggDdx1YRbQR4mj
         u0xa7vug0pTrDxfGvdjSEk9D/seyq2forobXnPFTF01RetynHiMvBsNENRmXxOBlZZ7f
         B5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9JBQ25n949SzT0aJCa+SmK4nxBdxfr7uXV4RhT7iBk=;
        b=qTR/hqJh5HxSkN7KTTdcJ2PuHx5BNMV/Is7VuuSHx7kgnnDJuZfWCZHiDzOqsxrtQh
         6wkoBFTrPVtqLYqLVkE4bbFPwuRuF+AtWzZoBFEnnML+TX98jWVjKvhL04H73neSaMeO
         OgFZaslVzhQ9nhQCQwGc8O07urd/Ny7vmfJpee72tUqh7XIptolSvbqgQl+WINNxkwFK
         Ybdsb4HvHUm5ulc/bSAMJep+ekRGyDWl5QV6kOmQLN8GfgDtLVQoj3bi4mgdO3xwq3Dh
         0Ewata07nX9bOv5AsHC0lQvzUwXuER862eMpKefOZFAewdZRE7BO62R6UlAJRG4Suh6X
         QpsQ==
X-Gm-Message-State: AO0yUKWN0m/d9Co1FSEUXzYppKvLTURFbjk+fud/GaYsIuFU14hZxbBO
        Nd2JNsTxLl4CtZfxWpVEKDEXHA==
X-Google-Smtp-Source: AK7set+wrDuM7dfiMg34ZRVXU/WMO1xfv411HGqLDsbK+fxlDG3sfnsUn6oDwIykAcPRKPd5OQC64w==
X-Received: by 2002:a05:600c:45cf:b0:3df:9858:c03c with SMTP id s15-20020a05600c45cf00b003df9858c03cmr5675306wmo.17.1675940614477;
        Thu, 09 Feb 2023 03:03:34 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003de664d4c14sm1643092wmq.36.2023.02.09.03.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 03:03:34 -0800 (PST)
Message-ID: <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
Date:   Thu, 9 Feb 2023 11:03:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
 <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
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

On 09/02/2023 09:05, Amit Pundir wrote:
> Hi, So what is the verdict on this patch?
> 
> I submitted this fix to make sure UFS don't map and crash on it, which
> I have seen happening occassionaly on db845c and Caleb reported
> similar issues on his sdm845 device iirc. I should have probably put
> that in my commit message as well.
> 
> Regards,
> Amit Pundir

So the memory _is_ being used by ... continuous splash on an Android 
image, i.e. your Android ? limited to Android - image continues on with 
the splash but other blocks erroneously reuse the memory then, UFS as an 
example ?

---
bod
