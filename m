Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320885BEA30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiITP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiITP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:27:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A26611C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:27:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p5so3393823ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8zIFK9Q1jJEQ4xwVOoH9zFIXhEFnzDoTOBCTZbUj4wQ=;
        b=W6vecheQBiXDJef24g/gY6jrzyKlfCEoqbFW+0stPdJTDL3fjrZFRs/T1tbZFdRCqo
         QbWW2oD7FN93E5H9bPWXQD8kpdNrHef9qYwx+ZWoBZw/3mq+BssIRXyCGkGg36aysJY8
         SqMqvi/ucmqaU0AZDl0drC1VlpfVBF0Ah54zrUEeiqmBnCnULimWkL44l2uKSRovIZP7
         Nx+gMZBk77N1uHH9Gz3mDFKA6J1fYEpubS8CDhF9VRp/7n0esj52ELIGo7q3enJnXLqt
         vITxzFOGyoFoOSLYhbXNrgdTa2Bhk1aNciHHvMX3EUkEeE5FfUiVxmpX/XZgnRMOU4q0
         QsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8zIFK9Q1jJEQ4xwVOoH9zFIXhEFnzDoTOBCTZbUj4wQ=;
        b=Ur7qUOr7pubmrcsgdJb54fIterw0YziH6gJMmRhlfCAIgw/50JtosRw4hEssRBJeRV
         BGa4txQ+ZeAx6g//zjXdyP2tNugxy1FWsedP7SmhRip3lUKbEyAw5BX9U6KTGQMJFuic
         Eii4IWm8n4i/l4Ja2sgeJ9OkkwIUXjyT/gb1Wh5YrSk+i4hPMSzPWUUzUvY9c8tsx7hT
         fcWXOdEtIyOTH6fugFx4/QMcrdM6OjYyezYPDM9nkILD2CXHAtrXOOpOfpGO6jlodr5s
         kL4X+yxvk8QrYqtmmf7h/UQVYhGfnGoQaXzn+6sShAVOawVxISkJ/dvbd/cJMsb/QJbz
         3P4Q==
X-Gm-Message-State: ACrzQf3K2IFvSE/vWpdg+MmErCbHLJzLA6q3hxmPn7/gU6ElRCkYIYIQ
        aRSDUq/9VOf26NNm9Rd095JQjQ==
X-Google-Smtp-Source: AMsMyM5iVKbLJLBy7lQhYAZb0NIVZgJde7kEmIUUdPuFRKx6SUN9n36NJKc/g4L+GUHFrKr5CkUCBQ==
X-Received: by 2002:a2e:8e78:0:b0:26b:fa73:914f with SMTP id t24-20020a2e8e78000000b0026bfa73914fmr7266006ljk.57.1663687644297;
        Tue, 20 Sep 2022 08:27:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d1-20020a056512368100b00494643db68bsm16351lfs.78.2022.09.20.08.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:27:23 -0700 (PDT)
Message-ID: <9ede64e5-0af4-2103-7a3f-4484d9bffb5e@linaro.org>
Date:   Tue, 20 Sep 2022 17:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
 <20220920120802.14321-4-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920120802.14321-4-quic_ppareek@quicinc.com>
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

On 20/09/2022 14:08, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.
> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.
> 
> This is quite similar to sa8295 ADP development board. Main differences
> are related to connectors, and interface cards, like USB external ports,
> ethernet-switch, and PCIe switch etc.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Reported-by: Shazad Hussain <quic_shazhuss@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
