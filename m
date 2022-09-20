Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08355BE003
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiITI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiITI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:28:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64303656D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:27:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so2498693lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rkPuKjWB8t4FYJYHNtyFAmh2TFPD2Tl5mYJFMngelcQ=;
        b=dQ/DjRpyzJOPnWU9+cHPp5K1+NyJCZhOur3fr22c9+x8TZvCIw3Wcm0Ssp0uyu0tu3
         yDDjrQf/390dPv2OjCBN9ar+Yslw5Vh0fVAQX8AlXvaY25n5382qD7bJM1e0241bf31K
         t/RWa92e+NIVi73NA2XJEQ9gC5SHHY6OG3PNjNkBoaEQRWlqWeS2vfA0PLbAB5wMazJB
         fHSWi3l/1HDzrc2oNVcqu+Sm13Pe3GWuxmuoytOGa0ws99C836uILRrzbUixZuOvSv/r
         ls+HmEav2ZSNabJ8ZLCTc+r9snw3TKsTKsXXK3TDBlrt0paJ/WLA95C0Sj8dn6pC7OFx
         a2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rkPuKjWB8t4FYJYHNtyFAmh2TFPD2Tl5mYJFMngelcQ=;
        b=dejuFfVVmIUljohCOkG3H1dyUaNKhvBjhRm6xJdaskGpMSVmx2u0MY15mDrktSGmHP
         EAGhl7/ZYmesOJH0znkslJY+yaPm4FdYTxHQDSVchemdHjwqU2V5Fih5A8UOKrvdCUpW
         g+gcFyFlI9E83tvmnnq2VUedp7XkLWbqqqZmHYJvmlshqyupEAKZUmu7tfcWjBkDyAUq
         39s2a5cLFChfWyw8PYRuCIrslxpXf1KPmaPjYJI7xdc/aEWZ5guGcV3rXnc5/5yXlyMn
         Kphx2uhSoD69sJ5BiK2iriuoKsncG3b7boH2NPxTPePBaAh5S09fEpiXKhhgqBzwbi32
         +bRw==
X-Gm-Message-State: ACrzQf0uuyikpr51AQ5rT+iIMQnXIcbJfRVhfoy/9o2Ur9vIVJsLYN7i
        RzCYsVvMbev4/s3CYBSa0LBLeA==
X-Google-Smtp-Source: AMsMyM4BFghKOOucFsHQ4S+QvuMdbzcePIG13Xz2ThhzLq10ft0xMOyHNHZhr6ZzPzppj24LyC566A==
X-Received: by 2002:a05:6512:261e:b0:49e:e7dd:8912 with SMTP id bt30-20020a056512261e00b0049ee7dd8912mr7259070lfb.360.1663662436750;
        Tue, 20 Sep 2022 01:27:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b004978e51b691sm190279lfq.266.2022.09.20.01.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:27:15 -0700 (PDT)
Message-ID: <9d702646-3517-be57-dbdd-c5e5d803dd4a@linaro.org>
Date:   Tue, 20 Sep 2022 10:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: dts: aspeed: greatlakes: Add Facebook greatlakes
 (AST2600) BMC
Content-Language: en-US
To:     Bonnie Lo/WYHQ/Wiwynn <Bonnie_Lo@wiwynn.com>
Cc:     "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        "garnermic@fb.com" <garnermic@fb.com>,
        Delphine Chiu/WYHQ/Wiwynn <DELPHINE_CHIU@wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
References: <20220920023042.19244-1-Bonnie_Lo@Wiwynn.com>
 <1b03d24e-7bd3-f912-b59b-f2199770e9d8@linaro.org>
 <HK0PR04MB3105362597B1E8CBF897D0E3F84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <HK0PR04MB3105362597B1E8CBF897D0E3F84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:28, Bonnie Lo/WYHQ/Wiwynn wrote:
> Hi Krzysztof,
> 
> I am sorry.
> I have revise the DTS according to your comment and revise the subject.

You send again the same patch. If you intended to send a version 2,
please indicate it. Git format-patch can help you. Our process also
explains it.

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst

> I would like to update the patch to you, so I use "git send email" again.
> It seems like it doesn't reply the original mail but resubmit the patch.
> Could you guide me how I can reply the original mail thread and update the patch but resubmit it.

Resubmit same patch is not correct. You just did it. I expect new
versions of your patch. Each new version should be appropriately marked
with version number and changelog. Just take a look at other patches in
the list.

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst

> 
> Thanks,
> Bonnie

Do not top post.


> This email (and any attachments) contains proprietary or confidential information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited. If you are not the intended recipient, please notify the sender and delete this email immediately.

I notify you that I am going to remove the email immediately.

Best regards,
Krzysztof
