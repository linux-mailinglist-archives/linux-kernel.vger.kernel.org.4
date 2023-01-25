Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B967BFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbjAYWPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjAYWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:15:39 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6560C82;
        Wed, 25 Jan 2023 14:15:19 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j9so195489qvt.0;
        Wed, 25 Jan 2023 14:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLxtc4iFo6spjnsDH0JSjdLZbLsHkiKMcSGyTpLlCVk=;
        b=MUZnJun7Qi1CKIn1VF65pwOZvmSzp2tCa8e+Ycndto7cynav0VNfYm9hcxHoLxqFTf
         EWYGN6LzD+Firydf0QDM9ssfD9YCsJhYWnSGzCI0j3X8mhJyMiZDijbGvQ/1ewXU/xsa
         BBQBTzn9HttU8RHcq+YdMz/flP/0sd5SwNn/jyH+xAUo55JgqFJ/7+KQOtMPmmW/WJeN
         iq3S01t4tE9Yl7k8b7ViAXUdHLkMWfR3EP+Cp6NVbq68ksJ1VqvHOcui1j3S4YfQ+Ekn
         aFd0f5j9hL04SOMNr32NWJdezZmdLS3I175Qd0MNop88xPpUCPbGzWkhu6S0j7EDe2cD
         xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLxtc4iFo6spjnsDH0JSjdLZbLsHkiKMcSGyTpLlCVk=;
        b=cmo7XdApzWHd8EfuoVO01A8QQozLaPIXo7H4re8XEzwC55CZtaRPiPaT5ZsGFFUAE2
         lh5a6Xd6Ft79LiOzfLEvRSplz4gKgmDA8nZr73bOY36m/VnyVZ9uP97UMY9T+TFIECHY
         58m9ostPywUntTdPthJuI73Ilm1Bzv09gjn6MloNw1vLmD+K1qtdsDtxQ67R65Lz2fCb
         AP0fLF+Ijrk9WKPK6zrcx0J0DmUPJIxrO4JdxkWd6KPtL61dcXmIkEJxNwZEP+ArpmIK
         bzczX/R7V0QhEsQmO5lomJI0qvFLlrvpAbNVN9FBjGwDPPy4ZqKnZBK4YcZVxLj8zseH
         HWGA==
X-Gm-Message-State: AFqh2kph3MXU+ttWrumHZX1jfILbwD0TaxWZ+NRXy0z40Ow/1iOJoqin
        rC0LQ5NEFarLbhok35pnDNA=
X-Google-Smtp-Source: AMrXdXumcLU3fJNu3axW1d8MPAOUL0hFEeC/9nKUNb7AbEP3/CiFwW4i4cR4v5hOXXm+3XkFVfqXZQ==
X-Received: by 2002:a0c:90ea:0:b0:51e:268a:e78b with SMTP id p97-20020a0c90ea000000b0051e268ae78bmr56360110qvp.33.1674684918982;
        Wed, 25 Jan 2023 14:15:18 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a158a00b007023fc46b64sm4265988qkk.113.2023.01.25.14.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 14:15:18 -0800 (PST)
Message-ID: <64a01133-5a63-b950-46fb-064ffcc95623@gmail.com>
Date:   Wed, 25 Jan 2023 14:15:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: brcm,bcm7120-l2-intc:
 Fix 'brcm,int-fwd-mask' differing type
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230125221423.3058221-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230125221423.3058221-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 2:14 PM, Rob Herring wrote:
> 'brcm,int-fwd-mask' is also defined in brcm,bcm7038-l1-intc.yaml as a
> 'uint32-array', so unify the type definition.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
