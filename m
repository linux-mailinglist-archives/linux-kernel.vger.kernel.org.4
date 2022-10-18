Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DA60304D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiJRPzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiJRPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:55:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0CC2870C;
        Tue, 18 Oct 2022 08:55:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so33418597ejd.0;
        Tue, 18 Oct 2022 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze2iQW7Ubk1DBaTyzAEIIUKAqNn2VA5sWTsaUEmBUpM=;
        b=Dl4L5xbF7jd0OVQQ3rs5MnpwKOcbg52KbtO6WWw0M1SksG1GWj0kxDC1HXekzP8OV0
         /y2NLJS94MGFVVhejp0ts7xB0gLn4ZI4fNvuMM2xph3I448b1AG9kmAzhZe0piEnSM86
         CFG+HYUVAANgyeKQpimlX3Wq7osNHrpOxG+RCPc+zP5qWxgPkJFEiwfqD8Mu4lUtqdyR
         ZU5ldU9oy7/xGf8o1J3k3jX+ZZdM85JbF9GQSY+brcHLVdNN518tWyS5Tj7EJ8sUik1C
         dZtT7LpwOWjg0DBXBQivCly/NCZCxnwW8bmfJtpUQVQA8C7/AwqCucdpajrDtbxEvLpm
         Aq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ze2iQW7Ubk1DBaTyzAEIIUKAqNn2VA5sWTsaUEmBUpM=;
        b=sZxBY5DjLd/S1LAuIx7/EjLqFXcjaytYPlT/4UCmhrewDs09ulcBCqmZYyJncQQMnE
         xzGXMB/PFb1IenEzJvtefNYxbKmsKSjo+qpYY95SvTKxHw82YbfAuAbZJxAY0tSzp7UQ
         U/+8XFYhyqKmR/ioRapqR1VrR467o5RUZ7lms3vhXOvVVds6XzgLl6BZoUcb82jt2Dg2
         Q5pWEPZwf9+7LD1APMG2vVuCIFa04vWMyLUGTaq40ok3YNETs+L9zssXkiUG+3DC+ilY
         u0qB6+decgy+pMFCnyqhK0un/LDPet8rpd0Pz2v9PAYCx9fpD+1W5bd6hvb6wUEZlaO3
         VpSQ==
X-Gm-Message-State: ACrzQf3zupAR1ZAoy1PE9o5CPD9F6hIjCkbi/KgQw/m97tgGHQZhhHGY
        dwozT6n5ScjRLMkWmQH1Az0=
X-Google-Smtp-Source: AMsMyM7NKaPdktFPck4SbtkHlX5uYLlpxukySouUq+wlEPXTXynkWtkbFsAbfrE18sqR7TkD6NmkxA==
X-Received: by 2002:a17:907:1ded:b0:78d:4606:268 with SMTP id og45-20020a1709071ded00b0078d46060268mr3046776ejc.163.1666108516509;
        Tue, 18 Oct 2022 08:55:16 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056402149a00b0043bbb3535d6sm9067327edv.66.2022.10.18.08.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:55:15 -0700 (PDT)
Message-ID: <bd2bcbeb-c800-4f14-c801-c6b5489dbf49@gmail.com>
Date:   Tue, 18 Oct 2022 17:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: u-boot: allow
 dynamic subpartitions
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20221018154202.4634-1-zajec5@gmail.com> <Y07LYoq6Dh+k0uJm@spud>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <Y07LYoq6Dh+k0uJm@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2022 17:50, Conor Dooley wrote:
> On Tue, Oct 18, 2022 at 05:42:01PM +0200, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot partition may contain subpartitions. For example Broadcom
>> includes environment data block in the middle of its U-Boot partition.
>>
>> This allows describing Broadcom's U-Boot env data and will allow
>> referencing its NVMEM cell in the future.
>>
>> Reg: 118f3fbe517f4 ("dt-bindings: mtd: partitions: support label/name only partition")
> 
> Pardon my ignorance here, but what is the significance of a "Reg" tag?

That was meant to be "Ref:" and was meant to show commit that introduced
concept of dynamic partitions. I thought it's a new feature not everyone
may be familiar with yet. I thought it may help to review this patch.

If that is pointless though could you Rob just drop those tags while
applying, please? I guess I'll just let you decide.


>> Ref: dd638202dfb65 ("dt-bindings: mtd: partitions: add additional example for qcom,smem-part")
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

