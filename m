Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449D6B684F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCLQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCLQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:38:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E2093C2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:38:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn21so9423841edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678639097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAkezKPH4FZf1ldQ9Tq9wViZer8JsvhMKxU65DAB8CY=;
        b=M4YVMftyRVu2XpsQIzZw0TB0yiNMa0MkQwrw2+Dv0k3Oqon86vXwgGcNSIEh/uqHhN
         AHvIuREbbb6paUlcwUsJntWF8D7Ikl0+tV8nhzxSFZ4sV65ipyCm8McrMRoOpsFt4+vZ
         9YojraMkuUePspl5nCGncgH5CXWPyDNN65PHFUALvlwWNJcjzt6R9/dVXfuHvH9sukOM
         y5NXpgikCollhiDgoBVhvTN8KbZ60sGs0BXMfoFxxoxa291MBxB7BFJjVevQSvqos0gB
         Ssw7jkNGWBf9Cin0yWJvL4Kv5lcja5D4mHOwDXWsSkEFsZ26XCDW8naP3EcNtQaYZX5H
         EUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678639097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAkezKPH4FZf1ldQ9Tq9wViZer8JsvhMKxU65DAB8CY=;
        b=2HdyltSw4MnIAKtmc6gSQ5gmk0sZPdvJiX5FOsRLwtxEKIZ3dDYL/iisZ8WyH05aX3
         XCn+PL8Yx0xGiWQ6367WR5htSs3uQtrNZLPK0MfkRCDX+veLu3KTw+Xz1FtzoTzu/1bi
         lhEK/Co/9YSGswH8DcUAmyRD02elQtuuKQv0LRbsBgUI1SXrXNuNCcRE+xOYvg0eOBEF
         nZijHLYPxNFRmH0o4/osccvsRCGCnE38HyxFFmtWk66aN1aR2u94Mv/TVYCLFUBYWols
         0SEawDMUQ04XMP5/I01aFu9l3+BK80aygnaNXqi08Lg681at8SiESbsz5qeSsB4q7QEo
         zTZA==
X-Gm-Message-State: AO0yUKUbB/s7Uq7b14RfU7VJ7F/YYL+w+xNT65+f4Xg/9MxThUHE7XmG
        Zohwh8aoLsI3xsm4OYjb6PbLeg==
X-Google-Smtp-Source: AK7set/J/U/eNijOA4x4nTFGgcG6zFkRtuOBlsnVmgFeFIFGuxnZTkq+iKjwRwqaWIOLlgrCGRvxpA==
X-Received: by 2002:aa7:d6d0:0:b0:4ae:eb17:3afc with SMTP id x16-20020aa7d6d0000000b004aeeb173afcmr26071336edr.7.1678639097601;
        Sun, 12 Mar 2023 09:38:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g5-20020a50d0c5000000b004fbba1226d3sm689767edf.45.2023.03.12.09.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 09:38:17 -0700 (PDT)
Message-ID: <ba843f20-dce4-72d6-5291-c28dd0ad77a5@linaro.org>
Date:   Sun, 12 Mar 2023 17:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] arm64: dts: toshiba: adjust whitespace around '='
Content-Language: en-US
To:     nobuhiro1.iwamatsu@toshiba.co.jp, arnd@arndb.de, olof@lixom.net,
        arm@kernel.org, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
 <20220526204606.833054-4-krzysztof.kozlowski@linaro.org>
 <TYWPR01MB94205D3C70257E28F691D05C92D89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYWPR01MB94205D3C70257E28F691D05C92D89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 08:20, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, May 27, 2022 5:46 AM
>> To: Arnd Bergmann <arnd@arndb.de>; Olof Johansson <olof@lixom.net>;
>> arm@kernel.org; soc@kernel.org; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯Ａ
>> ＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Subject: [PATCH 4/5] arm64: dts: toshiba: adjust whitespace around '='
>>
>> Fix whitespace coding style: use single space instead of tabs or multiple
>> spaces around '=' sign in property assignment.  No functional changes (same
>> DTB).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> 
> Thank you.
> Applied on visconti/fixes.

This was supposed to be applied almost a year ago but I still cannot
find it in mainline. I assume it was lost, so I'll take it with my other
cleanups. Let me know otherwise (but then please really take it...).

Best regards,
Krzysztof

