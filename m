Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5396B1567
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:44:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05F637F6;
        Wed,  8 Mar 2023 14:44:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so139836wrb.3;
        Wed, 08 Mar 2023 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678315452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsrEEEaC8AeRdb7KQgiMRTrbEFjeV3mmDKW8pToUANA=;
        b=L5k3XOLSbO+wb4L5FL1hKM+j2lV9IwZVJQ+LE6A7ZfHQE2X7YgTpbDfclFpp5WrueI
         yUdqcRH83uSOj3bp39No3oVpncovTJB/+D4wkcZaH2KlhiWMFPy8Vv1zWGUvtwVTun2l
         sCbR6mz8PIntD3RLpkqBQEt3paEeOIxNbySyNr/TfdzdAL4b2ZcCx10M3WDXpUm/6St7
         qfi1Hdet2g5zS2kpVW9ZZ5KC9zJvB8jDvMfhOJtCNfOZnAv0p1zCr9iB65pq4B0l2eqq
         4CSs5V0HRjqYNJH0IzL1khnWq6LUTJJy/VygGr9E6sTkdYO8NIEkJ8seh9fWfKPRwoyP
         FOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsrEEEaC8AeRdb7KQgiMRTrbEFjeV3mmDKW8pToUANA=;
        b=sLV99zqMsY4HwJUsXEKvbX1TBChG1Q4NfRl8LTKj2GCRCGevbcT5r9zbTLCKfl1Lwg
         4kulck/8nHfkWTQuKRm5xoXRQx/rSgWoOFjvKiTZsvfOdUgef6TMPqL8kgpIQUSQUDpB
         cSpkelr7TZBx1Ycx1+O1UhTLD0nTP67L2FyMKuHRsscmlPeTssoY4sZ47+nsZJVgT5p/
         YMScbmVu0HMOVdvKu4NUWdDK5yznfGPP7igy/sj0aIf6npFkmgL3Qv9uZPBiy5PhvJ+r
         CF/GT5vz7DKBFu+v5BYXmMABIxd1m4pVmPElSqHp6tqjvdGESL4D5K6ws6Ex20vRYDes
         KBvQ==
X-Gm-Message-State: AO0yUKWiNFeLJzILwygx//lfWSIOMTYDcnteA3pWiIg25HRMDQPuWhxU
        SZR929KvvehA2JYOvMrey58=
X-Google-Smtp-Source: AK7set/12zv05R923rnXYe6FPoJd28KNc2Y3GYMlNG5n7SFRiIyqRVzt3NDBRNKz/D834zT+2yVl/Q==
X-Received: by 2002:adf:e54b:0:b0:2ce:7b14:62fa with SMTP id z11-20020adfe54b000000b002ce7b1462famr4698320wrm.18.1678315452191;
        Wed, 08 Mar 2023 14:44:12 -0800 (PST)
Received: from [192.168.2.202] (p5487be6d.dip0.t-ipconnect.de. [84.135.190.109])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000114e00b002c57475c375sm16621500wrx.110.2023.03.08.14.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:44:11 -0800 (PST)
Message-ID: <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
Date:   Wed, 8 Mar 2023 23:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
 <20230308221657.GA3935330-robh@kernel.org>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230308221657.GA3935330-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 23:16, Rob Herring wrote:
> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>> Add bindings for the Qualcomm Secure Execution Environment interface
>> (QSEECOM).
> 
> Pretty sure I already asked, but no answer in the commit message. Why do
> we need this? You've already declared the platform supports SCM calls
> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
> is for non-discoverable h/w we are stuck with.

Yes, you've asked this before but I can only repeat what I've written in
my last response to your question: I am not aware of any way to properly
discover the interface at runtime from software.

If it makes you happy, I can put this in the commit message as well...

> Why is software made non-discoverable too?

Please direct that question at the Qualcomm guys who actually designed
that interface. I can't give you an answer to that, and I'm not all that
happy about this either.

To reiterate: I've reverse engineered this based on the Windows driver.
The Windows driver loads on an ACPI HID and it doesn't use any function
to check/verify whether the interface is actually present. Adding a DT
entry is the straight-forward adaption to having a HID in ACPI.

> Nodes with only a compatible string are usually just an abuse of DT to
> instantiate some driver.

If you or anyone here has any idea on how to discover the presence of
this, please feel free to let me know and I'd be happy to implement
that. Until then, I unfortunately don't see any other way of dealing
with this.

Regards,
Max
