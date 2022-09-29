Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC345EF035
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiI2ITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiI2ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:19:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A57B9A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:19:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l8so425784wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=5ZyPmzibvnr2TnOuyUFGjS0AhOh3YQrJGi7e/rpVMFk=;
        b=HLV2plVy84Mzb15qlCdkzm/5QLVabQ60Bld+cXtBs1nqYScki+QL5lviWcbwMtOdXm
         qA+DacmSr+qFiMEgjP7q35J1lEuAZDocOO7MZkSNeghY+vvqHHfZ9MAhI9X1viLlmSus
         x3tuNedNfAaKKAaYmJync2zuvox0rCDGefOSU0TDgCP3lisfvq8Yhf8chacoCFvRYDRE
         CTEoNbpqEInujWp/d4ztpojgfzXkT5vO86rbTh4Fg/F8xotNo5pNDh2IloOQkNcCEB69
         0I+EUU5hxpSHTCGRmCor3ijSZAem9y9HBKmWdWWS0MrtOqhcHjFsDlVwbuPX/l5SxxCr
         lFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5ZyPmzibvnr2TnOuyUFGjS0AhOh3YQrJGi7e/rpVMFk=;
        b=gm29J2caKB9nOdoinm69faC3ITJQb/hEOz9NROPcAyMvEi+/AKQ9bmgHcFg11sOk8k
         BbKEaWDR2FSl8LFDMx3BgPG7Isq0pidD7udmO1t9dECN7Xqzo+flZ8Jel1QvyL9u2Wxq
         QRG7Ru7yjGCgPWO6hK6f7q3tSc9KYz9Tbt/76Q23uABnIdSrevk6Fu8yWXsOxhd4/+oL
         WSOtTcAjPjc4Wt+vUQfRlLtjJKaFgf4tiIoJxCNjXfR1wNToXvc2eF5Qup9mA6GqtbS/
         9THO7aEHr24yinWbUWrRsEfU4byq6qmhZn9sltNipMbC9TyO6o6unSAjR6m42Fc/GwsD
         xaIw==
X-Gm-Message-State: ACrzQf3LaVUcr51svUZbOexUmU+Aa7GdlxdRR58nnJW9F3GQFGzi6mDv
        DhbQXfqsry2bWsli9P1u0sNtGA==
X-Google-Smtp-Source: AMsMyM4UxxPdeneRwUbi+UxY+d8h2/zFstCN3MPWSycAzAIsRn5dAjL0xTRzcFeKszg8rDcXqXXrwQ==
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id iv8-20020a05600c548800b003b506340731mr9241779wmb.188.1664439571180;
        Thu, 29 Sep 2022 01:19:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4b04000000b0022c96d3b6f2sm7820938wrq.54.2022.09.29.01.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:19:30 -0700 (PDT)
Message-ID: <a3dda998-77a9-e33e-b2ed-aabc2916df89@linaro.org>
Date:   Thu, 29 Sep 2022 10:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 7/7] arm: dts: qcom: mdm9615: remove useless amba
 subnode
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-7-b6e63a7df1e8@linaro.org>
 <1d859da3-89c6-d08f-bc10-e5f39c1cd2d4@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <1d859da3-89c6-d08f-bc10-e5f39c1cd2d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 20:05, Krzysztof Kozlowski wrote:
 > On 28/09/2022 11:14, Neil Armstrong wrote:
 >> Since amba node type has been deprecated, remove this subnode and
 >
 > How device node can be deprecated? simple-bus is still supported, isn't it?
The amba subnode remained after the amba compatible was changed to simple-bus, there's no need for such subnode anymore.

 >
 >
 >> move the mmc nodes in the main soc node.
 >>
 >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
 >
 > While reshuffling maybe move properties to match common style:
 > 1. compatible
 > 2. reg
 > 3. ...
 > 4. status (last)
Ack, will do.

 >
 >>
 > Best regards,
 > Krzysztof
 >
Thanks,
Neil
