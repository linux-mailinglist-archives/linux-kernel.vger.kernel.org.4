Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF76E1992
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDNBWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDNBWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:22:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A646AE;
        Thu, 13 Apr 2023 18:22:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so20161030pja.2;
        Thu, 13 Apr 2023 18:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681435363; x=1684027363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6SErP6/nSb8h46D/pJI3HygBoTceGl0I9VAkeiwOzw=;
        b=K8o3SfEWbdfBFkVqhGtHPDHcgYzZhYEg0DbhcXQbYxXlR2JLZ9G4F+AtoYx0/y8u/L
         s0XA5725aoOGUHQ0+aZBktmotkrHrtWso4rd+Nx/us9VUjOsfQWsWjSIr5D+H1qyQra/
         /HYC49upR4wxYoblcXGVqG8cezg/8aMN6DtGLJtoOBAWjswzVneJawFCFUohKq9KUdCl
         rX6slF9CCsRoiXtbc6yajEKt91axCPmthTYH2dfrsqlgh7+rqsIS6nLiq3QxFyzCRIiW
         adi6J99rZ78MdWiWHEzBzFp4tsNC/OBXimDbJLT/XaqrjnNSbUPw47Fnsl8gy50nSQ0i
         Sb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681435363; x=1684027363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6SErP6/nSb8h46D/pJI3HygBoTceGl0I9VAkeiwOzw=;
        b=OVfBmI8Zkls8ScSsTn9eA/3in66GelSmT9MvM76doBWUriwJ71CRjmcrUwH0oF20Vo
         rigGHovWmSAv8S6FqUINGB9hYzfT/++IEfn/b0drobdW7OHle9RRzGHyE5Kvkm7rCcKy
         Q6kP6MSDB5RRzM2GxJ0Ue1wUND1M2qdXgCo38LBoapXvO4iykRIVkVMjunxeJm4OtkMh
         NJEPvHFpU0CDFJKHCaSzugtuKDn42AuoPQOXcbfswRHpZfe2tOLOahj2AGmZ1r6SdCTi
         SAKN7ioWpm4EM/F6Aj1kUeyns01yU1vyOPkCJXTTKS0cUoZi47/s0nkHC3H9jWADEube
         p8Zw==
X-Gm-Message-State: AAQBX9ez6czf/Up+AYUT9d8k69ruwB7fjYTy5F9kD8D0Ce4SRQnnyq8a
        glvEvX7zkRcnoOlOoaO5n+Y=
X-Google-Smtp-Source: AKy350b7RSEL1JMKOaI1GbzPm/+iBiW/c1gFzLXeG43IrcIg5rdyVJx1256GZCBBDCRBjW2KxjXbwA==
X-Received: by 2002:a17:902:c641:b0:1a6:77b7:8ff9 with SMTP id s1-20020a170902c64100b001a677b78ff9mr800441pls.9.1681435362727;
        Thu, 13 Apr 2023 18:22:42 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b001a2b79db755sm2039883pls.140.2023.04.13.18.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 18:22:42 -0700 (PDT)
Message-ID: <91861072-dc2d-46d3-dc0d-26d17a3693c7@gmail.com>
Date:   Fri, 14 Apr 2023 09:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-13-ychuang570808@gmail.com>
 <241f6cb1-193f-d372-0eda-157946b15780@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <241f6cb1-193f-d372-0eda-157946b15780@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/4/14 上午 01:01, Krzysztof Kozlowski wrote:
> On 12/04/2023 07:38, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add entry for Nuvoton ma35d1 maintainer and files.
>> In addition, update board binding paths of NUVOTON NPCM.
>
>>   ARM/NUVOTON NPCM ARCHITECTURE
>>   M:	Avi Fishman <avifishman70@gmail.com>
>>   M:	Tomer Maimon <tmaimon77@gmail.com>
>> @@ -2512,7 +2522,8 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>>   S:	Supported
>>   F:	Documentation/devicetree/bindings/*/*/*npcm*
>>   F:	Documentation/devicetree/bindings/*/*npcm*
>> -F:	Documentation/devicetree/bindings/arm/npcm/*
> It is not a bisectable change.
>
> Best regards,
> Krzysztof
>

F:    Documentation/devicetree/bindings/*/*/*npcm*
F:    Documentation/devicetree/bindings/*/*npcm*
F:    Documentation/devicetree/bindings/arm/nuvoton/*npcm*    <-- remove 
this
F:    Documentation/devicetree/bindings/soc/nuvoton/*npcm* <-- remove this

Yes, the two statements at the bottom seem redundant. I will remove them.

Best regards,
Jacky Huang


