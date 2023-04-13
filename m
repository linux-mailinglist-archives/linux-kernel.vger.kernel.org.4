Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F36E0FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDMONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjDMONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:13:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BC448B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:13:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f26so31676991ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681395197; x=1683987197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUg/Vhl4ma9csERVssXScNUtMrmvSNZoznhCnpPJffE=;
        b=o3pqnoQR4q+ECIpxDAjZaH/4ZWbbQfmxWI6mJm3FRP3DH1F5T10tUc8vA+LQkAPG4U
         IvrPmcpwx1owZ8nbuwzp309bofZsDRqgVggAMO3fC8hOfX0Rkj9v31IOD83GO/yNikat
         n7X4vEP4prszZMluVSt81aL4wqkHgbJUq/eNKBqB59fmqjxEJwnChR7FfFvURf+nzBMH
         TUXCZfE/EU9F4C52w5qHtJCetUCRleFf+IMG+aZIlkM2DmXtGdpNKnjqMR8xR/hVgb1C
         9Z2iYsiutkweUPzWyxpxe3Ob9tyL5vmr+ffXHYpu8ZWbZWf9JrO4kd1I/xOXvgNLTGns
         4hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681395197; x=1683987197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUg/Vhl4ma9csERVssXScNUtMrmvSNZoznhCnpPJffE=;
        b=L4VQFseBsgLScpwQHnnlKc+ve1sN1xXfNSsq4qupUBklyvhRjSgj8cd7Rdf9jHWcSU
         Sdn2lQydacsntipNU+e1h+QVYmVlhRnBLVKpKr6ppTvK3muwK0Jpmpi6JEuEk5+knO+W
         01SZGqueHPmTiXoI8kZccUfdoZLvXyyHLok9L0M9ldEwRSJEejHEIVnXJmFcow6a122C
         n7g9RMocW8yE3bxpFpCMkaogs1YTVuiSYwKL6MNBpAw6YW4OJxXiLRvgmkPSFKvZ/6f0
         oC9woKWDAf0IKIEbt+cNjx1FIRSMd/ppX8/QvWKmJgaKmUP4+2zM5VsrIU5z9FY/FuZQ
         sWBQ==
X-Gm-Message-State: AAQBX9fct4WMlkImEnaaI0Jc9S+zcKVFtkn0/Z6QHfwyQVK+wSW38ZgC
        LTo7fsdkWS/gGq6MwfXuaxom7g==
X-Google-Smtp-Source: AKy350bqaGf9G9UynCwnECkBk51iC6Y9ZmFekAq/MvRpTO/3kxt99/nMVf+P8TxZ4KgLopGpGReGLQ==
X-Received: by 2002:a17:906:e25a:b0:94a:96c4:2361 with SMTP id gq26-20020a170906e25a00b0094a96c42361mr2684805ejb.73.1681395197078;
        Thu, 13 Apr 2023 07:13:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id bi24-20020a170906a25800b0092f38a6d082sm999572ejb.209.2023.04.13.07.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 07:13:16 -0700 (PDT)
Message-ID: <5953bc83-9609-6d12-7e9b-ca5202151fb3@linaro.org>
Date:   Thu, 13 Apr 2023 16:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 0/7] Add JH7110 USB and USB PHY driver support
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230406015216.27034-1-minda.chen@starfivetech.com>
 <517670ca-ba2e-811e-3eb2-7f38011c9690@linaro.org>
 <985d0a57-1fc8-5725-4d3a-33dcc5d49d67@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <985d0a57-1fc8-5725-4d3a-33dcc5d49d67@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 12:44, Minda Chen wrote:
> 
> 
> On 2023/4/12 16:26, Krzysztof Kozlowski wrote:
>> On 06/04/2023 03:52, Minda Chen wrote:
>>> This patchset adds USB driver and USB PHY for the StarFive JH7110 SoC.
>>> USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
>>> The patch has been tested on the VisionFive 2 board.
>>>
>>> This patchset should be applied after the patchset [1], [2] and[3]:
>>> [1] https://patchwork.kernel.org/project/linux-riscv/cover/20230314124404.117592-1-xingyu.wu@starfivetech.com/
>>> [2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@starfivetech.com/
>>> [3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421.133428-1-changhuang.liang@starfivetech.com/
>>>
>>> This patchset is base on v6.3-rc4
>>>
>>> patch 1 is usb phy dt-binding document.
>>> patch 2 is Pcie PHY dt-binding document.
>>> patch 3 is USB 2.0 PHY driver.
>>> patch 4 is PCIe PHY driver.
>>> patch 5 is usb dt-binding document.
>>> patch 6 is the wrapper module driver of Cadence USB3. USB controller IP is Cadence USB3.
>>> patch 7 is USB device tree configuration.
>>>
>>> previous version
>>> ---
>>> v1: https://patchwork.kernel.org/project/linux-usb/cover/20230306095212.25840-1-minda.chen@starfivetech.com/
>>> v2: https://patchwork.kernel.org/project/linux-usb/cover/20230308082800.3008-1-minda.chen@starfivetech.com/
>>
>> This is v2.
>>
>>> v3: https://patchwork.kernel.org/project/linux-usb/cover/20230315104411.73614-1-minda.chen@starfivetech.com/
>>>
>>> changes
>>> v4:
>>>   1. (patch 1) split PCIe PHY dt-binding doc to patch 2.
>>>   2. (patch 2) PCIe PHY add stg and sys con configuration to dt-binding doc.
>>>   3. (patch 3)
>>>      - split PCIe PHY driver to patch 4.
>>>      - replace dr_mode to phy mode in jh7110_usb2_phy.
>>>   4. (patch 4) 
>>>      - Makefile and Kconfig sorted by alphabet sequence.
>>>      - Add PCIe PHY stg and syscon PHY connection configuration
>>>        for USB 3.0.
>>>   5. (patch 5)
>>>      - commit message changed.
>>>      - merge wrapper dts node and cdns3 node in example.
>>>      - Add interrupts, reg, phy and dr_mode in property.
>>>      - Add reset-name in property example.
>>>   6. (patch 6)
>>>      - For dts node is merged, Using platform_device_alloc and
>>>        platform_device_add to generate cadence sub device.
>>>      - IOMEM and IRQ resource are passed to Cadence sub device.
>>>      - Add PHY ops process for PHY dts setting can not be passed to
>>>        Cadence USB driver.
>>>      - remove the stg and sys USB 3.0 PHY configuration.
>>>      - Change the suspend clock reset and clock enable sequence.
>>>      - Get all reset and clock resources before enable them in 
>>>        cdns_clk_rst_init.
>>>      - commit message changed.
>>>   7. (patch 7)
>>>      - merge wrapper dts node and cdns3 node in usb dts.
>>>      - move the stg and sys USB 3.0 PHY confiuration to
>>>        PCIe PHY dts node.
>>>      - commit message changed.
>>>      - Add reset-names dts.
>>>
>>> v3:
>>>   1. Add patch 1 - 4. Add USB PHY driver and dt-binding doc. 
>>>      USB PHY codes are moved to patch 3 and patch 4.
>>>   2. (patch 5)
>>>      - USB wrapper module dts document is moved to usb directory.
>>>      - Remove the 'dr_mode' and 'starfive,usb2-only' setting.
>>>      - Some dts format changes. dts binding check pass.
>>>   3. (patch 6)
>>>      - Remove the PHY codes. 
>>>      - Search 'dr_mode' and phy setting from Cadence subnode.
>>>   4. (patch 7)
>>>      - Add USB PHY dts configurion. 
>>>      - 'dr_mode' is moved to Cadence controller submode.
>>>
>>> v2:
>>>   1. (patch 5) dt-binding changes. The document example is the same as dts config.
>>>   2. (patch 6) using dev_err_probe and syscon_regmap_lookup_by_phandle_args function. Some formats changes
>>>   3. (patch 7) dts nodes sorted by the address after @
>>>
>>>
>>> Minda Chen (7):
>>>   dt-bindings: phy: Add StarFive JH7110 USB document
>>>   dt-bindings: phy: Add StarFive JH7110 PCIe document
>>>   phy: starfive: add JH7110 USB 2.0 PHY driver.
>>>   phy: starfive: add JH7110 PCIE 2.0 PHY driver.
>>>   dt-bindings: usb: Add StarFive JH7110 USB Bindings YAML schemas
>>>   usb: cdns3: add StarFive JH7110 USB driver.
>>>   riscv: dts: starfive: add USB dts configuration for JH7110
>>>
>>>  .../phy/starfive,jh7110-pcie-phy.yaml         |  58 +++
>>>  .../bindings/phy/starfive,jh7110-usb-phy.yaml |  50 +++
>>>  .../bindings/usb/starfive,jh7110-usb.yaml     | 136 +++++++
>>>  MAINTAINERS                                   |  16 +
>>>  .../jh7110-starfive-visionfive-2.dtsi         |   7 +
>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  44 ++
>>>  drivers/phy/starfive/Kconfig                  |  22 +
>>>  drivers/phy/starfive/Makefile                 |   2 +
>>>  drivers/phy/starfive/phy-jh7110-pcie.c        | 197 +++++++++
>>>  drivers/phy/starfive/phy-jh7110-usb.c         | 161 ++++++++
>>>  drivers/usb/cdns3/Kconfig                     |  11 +
>>>  drivers/usb/cdns3/Makefile                    |   1 +
>>>  drivers/usb/cdns3/cdns3-starfive.c            | 378 ++++++++++++++++++
>>>  drivers/usb/cdns3/core.h                      |   3 +
>>>  14 files changed, 1086 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>>>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>>>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
>>>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>>>
>>>
>>> base-commit: 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
>>> prerequisite-patch-id: 24a6e3442ed1f5454ffb4a514cfd768436a87090
>>> prerequisite-patch-id: 55390537360f25c8b9cbfdc30b73ade004f436f7
>>
>> fatal: bad object 55390537360f25c8b9cbfdc30b73ade004f436f7
>>
>> What commits do you reference? How are they helpful?
>>
> I use "git format-patch --base=(commit) to generate patchset.
> Maybe I set the wrong base commit.

How are they helpful if these are private commits?

Best regards,
Krzysztof

