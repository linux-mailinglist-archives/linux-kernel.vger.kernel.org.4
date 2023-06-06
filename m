Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245C7244D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjFFNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFFNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA310D2;
        Tue,  6 Jun 2023 06:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7269262986;
        Tue,  6 Jun 2023 13:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76479C433EF;
        Tue,  6 Jun 2023 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686059387;
        bh=stRutyLmvZS3ZidmZrx+6DH+SkXbyrihyoYS0xtC69w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VVZidBJU0486+do3/FJQ8NyB+Y5KjPf5GBJEiRD52x50qTVkjJfwt6iMDZzCoJ423
         yIi+j5KfY4eXGj2B+dbwjZMeQ2I6lcdAurKkwM/AIXBOiif8lhMSLORaYgPrswrG16
         +KbWyEHmSs5cKPpDkSx6c4JiXVnZJE2kFKXanWScOF8H6LsSgASQy3aMVfFFsjIoLW
         1UAKV326sLzlKtUWHowJDg2r0/ngMDwGGbSIonL4ujVA+7aq6FTiV/m151elYT7PGQ
         2I5SkmXRDhdQAjrs8b03hBb4tAA1Wk07ae9mhbb1LoL8GPH1swX1Qcx9J8sqGE5vcd
         NPwxLujMFuxCA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for multipd model
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
        <20230521222852.5740-2-quic_mmanikan@quicinc.com>
        <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
        <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
        <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
        <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
Date:   Tue, 06 Jun 2023 16:49:40 +0300
In-Reply-To: <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com> (Manikanta
        Mylavarapu's message of "Tue, 6 Jun 2023 17:41:00 +0530")
Message-ID: <87edmoitu3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manikanta Mylavarapu <quic_mmanikan@quicinc.com> writes:

>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +        enum:
>>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>>
>>>> Keep rather alphabetical order (so both 5018 together).
>>>>
>>>> I also do not understand these at all. Why adding bus type to
>>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>>> soc).
>>>>
>>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>>> radio's properties, i have added bus type to compatible.
>>
>> It's the same device - WCSS - right? We do not create multiple nodes and
>> compatibles for the same devices. Bus suffixes are almost never parts of
>> compatibles.
>
>
> No it's not the same device. WCSS on inside IPQ5018 and WCSS attached
> via pcie to IPQ5018. Here QDSP6 managing both WCSS's.
>
> So for better clarity i will use attached SOC ID in compatible.
> Below are the new compatible's.
>
> - qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
> - qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
> - qcom,qcn6122-wcss-mpd //IPQ5018 attached radio

What mandates that there's just one QCN6122 device attached to PCI?
Assuming fixed PCI configurations like that makes me worried.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
