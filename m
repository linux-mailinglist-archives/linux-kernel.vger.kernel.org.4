Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B026BD997
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCPTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:54:43 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D136B71B3;
        Thu, 16 Mar 2023 12:54:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D53D45FD0A;
        Thu, 16 Mar 2023 22:54:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678996476;
        bh=ZUnhBF1GKB12uouzQcwq5NkFuvf0D+yP3oyrcilkSUU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=UG6MgLmmNg+shviK0QA+u9wVj4Eq54Vz39hPzFkGG4VrEO+5CAKOAhvEXtqDejf9f
         wz1lshwMzb++n1KbEtKFvg177VKOtRCWb80ejN+aQKfCEuqyAgx/f8uKqD8kuS7hYP
         YOoYb8fYs44HTnIVFDH7y7e7i/4f1Szun4TDzrVDW/dJiChvsemDuSIxEGNjDk4rHb
         P3gZhZQsuVZYztesMHhtD4aKCrtagioNm9n19vK6+Ig83+RBUBWmdB4P26+lN3IhGR
         TDOwLSE3saggyYPkfhTr1DrYpWNdAn4+GNppROLgrEGRAcXdGiJS1SG1CDnbI6RdeB
         ElFPIaGcuZu8w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Mar 2023 22:54:35 +0300 (MSK)
Message-ID: <d0d9dbe3-ed4c-9212-e145-8fb8eee956ba@sberdevices.ru>
Date:   Thu, 16 Mar 2023 22:54:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: add binding for aw200xx
To:     Lee Jones <lee@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <devicetree@vger.kernel.org>
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-2-mmkurbanov@sberdevices.ru>
 <20230316164031.GX9667@google.com>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230316164031.GX9667@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/16 16:49:00 #20959649
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-16 19:40, Lee Jones wrote:
> On Tue, 14 Mar 2023, Martin Kurbanov wrote:
> 
>> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
>> led driver.
>>
>> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
>> ---
>>  .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
>>  1 file changed, 126 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> 
> Applied, thanks
> 
> --
> Lee Jones [李琼斯]

Hello Lee,
Thank you for quick feedback! Sorry, I don't understand one thing.
Driver implementation from the patch series must be improved, so
currently it's not applied. Does dt bindings make sense without it?
I don't think so. Please fix me if I'm wrong.

-- 
Best Regards,
Kurbanov Martin

