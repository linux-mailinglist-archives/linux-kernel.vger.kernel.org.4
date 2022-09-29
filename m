Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D95EF142
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiI2JFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiI2JFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:05:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B75140191
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:05:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so1254247lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=btFthdv1zNYaIydapDFqiC440lZt+Aklpvo9ijrI+3E=;
        b=CETUzoKwnJQGbM+fqxY0xo+t3Sitg4ou8G14jtk0S9sBXjm2yNZFUXjVwZa5WE6cVE
         QASgu5CsyaQwRYDaWpFSf9KG6n548mfeFqWBzJFm8unh+tvRmtMny1v3zHQCoSi+uBM2
         k6+1O+rULPQ+m0Vz40BpY0YDRKizbNR8D6n0dW1pCMypBJXpscyuydvMIqb/lKLFMbUX
         IJtSM6/IT5cIs3lyU8liZBnJGatZcNcfX2tpkuYoehpwiMX4CLx1CAoPKZkFbUmac2Yp
         VFFrLtYi5kMFUg5sOiN2oQhXeEO7Bi//xamisQyJ+ucQkN+u4H1IaXLGV/Pr1yK25XDk
         47Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=btFthdv1zNYaIydapDFqiC440lZt+Aklpvo9ijrI+3E=;
        b=ylUjylYhDX72ID1KQ8DQXPDHbmCPreItS9oPX6Elxnf0fXTeMjfdwE2SkWkqPKSPvP
         2EdkPL+sXGcL1H6KA1XlsZYoaBZgU1GVO+gbUtjO6+45YeF/V0rCeyO3wLOgbIa3yAW/
         eGA4b0lAGkXTxtOt1SS3/tHeT+OtzXahzULhvJ8FfS28EUTFILtATcxokcwqzovWIxyK
         116+esVcBcLjz0cSbU10IWJU920Dpc1xJKhRx5PwkLhnBSbZfoRCJw5Kf4NkC8Pl4G0/
         oxFLF/Zc93HWiGxAZxtj/yMeQiFzG198+LR04lHzwrtt5gTMW+WpE/EP1jcW7IoKAV5Y
         9IFg==
X-Gm-Message-State: ACrzQf3yByBs+8eG4XLHuO8WOkEXf2QhwpjF7HpNOQK4R7ELt1YK0mjs
        sYN2I/XXqWrhCONY1MNyhqzXoQ==
X-Google-Smtp-Source: AMsMyM7klAk3ViYUlzDJMUhIMtw8BmzxLiIQ5vmTfn8DY+L/oLzkQgC4s4ufaHBophp5UsSt4GQ/dA==
X-Received: by 2002:a05:6512:b96:b0:497:9dac:cc22 with SMTP id b22-20020a0565120b9600b004979daccc22mr868481lfv.687.1664442322839;
        Thu, 29 Sep 2022 02:05:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g19-20020ac25393000000b0049482adb3basm725252lfh.63.2022.09.29.02.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:05:22 -0700 (PDT)
Message-ID: <bc1f3007-b603-407a-5b9a-9bf4a70b1f75@linaro.org>
Date:   Thu, 29 Sep 2022 11:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 7/7] arm: dts: qcom: mdm9615: remove useless amba
 subnode
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-7-b6e63a7df1e8@linaro.org>
 <1d859da3-89c6-d08f-bc10-e5f39c1cd2d4@linaro.org>
 <a3dda998-77a9-e33e-b2ed-aabc2916df89@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a3dda998-77a9-e33e-b2ed-aabc2916df89@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 29/09/2022 10:19, Neil Armstrong wrote:
> On 28/09/2022 20:05, Krzysztof Kozlowski wrote:
>  > On 28/09/2022 11:14, Neil Armstrong wrote:
>  >> Since amba node type has been deprecated, remove this subnode and
>  >
>  > How device node can be deprecated? simple-bus is still supported, isn't it?
> The amba subnode remained after the amba compatible was changed to simple-bus, there's no need for such subnode anymore.

OK, but it is quite different than a node type being deprecated.

Best regards,
Krzysztof

