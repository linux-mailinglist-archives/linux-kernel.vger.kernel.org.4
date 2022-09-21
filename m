Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF375BFD64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIUL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIUL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:57:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5F8A1D2;
        Wed, 21 Sep 2022 04:57:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so13096377ejn.3;
        Wed, 21 Sep 2022 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=zZOjctsMopcPTCqR+GOFuJIBjyunSAlM0WaVgIg4/7c=;
        b=aSUoUeX0IHnJUQPwiAhXRaCSi8d02ZkSmFZy3K7kP89id2PLgd8uk+8XuTecVkwJHD
         ZqyiU1BRjNXun20tnInSPvrWiIFyiWcO9jx36R9F3VW1Awy4znClSme9xoEs1WzyDobz
         a/h0mlqJeIDZwcGlmc5QD8bxWRYwEqCNpNQrzFQVivSEnKRzx14OPzUx7F7VIzUXt927
         8BTY+tHI/H87eUEY8TamRt1YoUgbNX6LyqCUv14H36zTwahfPL8w6W/QNzqudCJkdkBb
         drYSy7BwqHhSijAEHEP2xCrETOli3S5VmssPhCHF0m6jqBMON6SF9OIAMiCt8DNfGkob
         ETXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=zZOjctsMopcPTCqR+GOFuJIBjyunSAlM0WaVgIg4/7c=;
        b=QM3lkzMxmQHcUflPO2ZbzOLo25F1vBpZ1lZM+Y5PXynnwRF8naSOIpn8SrHvIJ9lkK
         E3AB058A3vQVggbXTT7PeCoFRA/4k1RPpbcx2MmUMPmmI5/RlFbiNHxDXjIWEVg3rRd9
         7zWoq+EEi7tG/8dja42hjsms+bDHrwq8jrByl+EndnDeMP0fDzxOvuyvMlyoTOaSnm53
         psFUJncKYfLWCIUGWIv9xPFNcSFhvDuO5jJI991Kyk2uB/jv46CAGP3lL1OoGlSRVE3/
         ufuxHmGUKu0YEy70jNemxFRIKRDwPJSFTOJdvP87N6qXV5j5zu+fKl84MSYJNfYK7wr+
         F47g==
X-Gm-Message-State: ACrzQf0Efux7gLS/z4RLhyH2tcPUurWNVl9QivEAyr6dJFcE7XijgEno
        f9SY5WwC5zdxDovoxR3AKhcV1RkNY/s=
X-Google-Smtp-Source: AMsMyM4YwAIxh8a3m6wJMQ14CPbVq8t1NwSXDmewAdU9eeBs/bmeYfufiy4YWtgHy9ogl4X4v0QM+g==
X-Received: by 2002:a17:907:1c03:b0:77b:9d77:c5 with SMTP id nc3-20020a1709071c0300b0077b9d7700c5mr20338078ejc.225.1663761439966;
        Wed, 21 Sep 2022 04:57:19 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id dk11-20020a0564021d8b00b00454c5d9eb37sm1296313edb.30.2022.09.21.04.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 04:57:19 -0700 (PDT)
Message-ID: <b37c22a2-14e2-4d8e-e68b-bd26e4ab4072@gmail.com>
Date:   Wed, 21 Sep 2022 13:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot, env: add Broadcom's variant
 binding
To:     Rob Herring <robh@kernel.org>,
        Joel Peshkin <joel.peshkin@broadcom.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        William Zhang <william.zhang@broadcom.com>
References: <20220406152515.31316-1-zajec5@gmail.com>
 <CAN3=V2vOVLc95ZYBUDo8J7ast4UQMnZm4uYmX63LpcJdZWnmNQ@mail.gmail.com>
 <Yk8qnxqXK7WZvXrS@robh.at.kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <Yk8qnxqXK7WZvXrS@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.04.2022 20:17, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 04:55:14AM -0700, Joel Peshkin wrote:
>>     The first 32b value is a magic number (endian swapped mnemonic of "uEnv"
>> short for "u-boot environment").   Finding that magic number of a 4K
>> boundary followed by a length and then a u-boot environment with a valid
>> CRC permits a scan of the flash partition to locate the environment without
>> knowing a-priori where it is.
> 
> So it doesn't need to be described in DT? But how does one identify
> whether to scan the flash or not. You wouldn't want to do that one every
> platform. IOW, it's a sufficient discovery mechanism for a custom build,
> but not generic OS.

I can't tell if U-Boot is ever going to handle discovery based on that
binding.

I still find it very practical for operating systems (like Linux).
Consider:

&flash {
	partitions {
		partition-loader {
			compatible = "brcm,u-boot";

			partition-u-boot-env {
				compatible = "brcm,env";

				mac: ethaddr {
				};
			};
		};
	};
};

&enet {
	nvmem-cells = <&mac>;
	nvmem-cell-names = "mac-address";
};

That allows operating system to have:
1. Driver for finding env data subpartitions [1]
2. Independent driver parsing env data structured with Broadcom's format

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=27bfb201b2c03c8a033b60e5ad80cbf3aaa52b94



If you don't like it, another option could be to use "u-boot,env" and
then make U-Boot env data NVMEM driver detect actual format.



Please let me know if any of above options looks acceptable or if you
can think of another solution.
