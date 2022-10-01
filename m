Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849E5F1B1E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJAJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJAJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:16:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6A1664AD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:16:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j16so10201004lfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W0EnAohfnj1QSnHddmWikcojkSGbOlP/GTWK7+JiSBs=;
        b=VCqUvvmklBIf2Dnv7hBig1IEStqAT0zZUMqRv3e4GX4SsckWYLwUv45CPzL51w6BFy
         ZyoNxEddPPGaI6jKNdRYwdI+KgnOGzMqFHbf7PrM6CrtYsH/Ty1G9skD+0FbeDi+zOQU
         Pc/0aU2IAX3kq1I+4aK5lElGqLkni7IKn4SeyZ6Vpo2pBl8944N9Wo2+6hQpzVvXb1gE
         1OKB1BqWLupwB2Kb5ZEMKkZ9v1iKRVSDTxBzj8Th/ffTzcV3qlQ8hUdKdg3HFWUtTExT
         X4uCS2LJKATpUGqnlffhGyOBxWioxUvLwCXm/vS6cbvmWuissauisxY8+HMOq9uGqAns
         gL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W0EnAohfnj1QSnHddmWikcojkSGbOlP/GTWK7+JiSBs=;
        b=frg/7gcyYaBGOiTP/EnnGlMcS6JJjbDlu9aXXO/ox/IHy6IIYgfuHPs9BLXoN9wkln
         sp4upaWHQUnneTS3/joLTGOZMeclslClS8mc7bBBPkyJdlbPQ34Dj2EqHx0NfVIQEd0p
         63+Ivp1Edl27cbRDBzHZwyejIJ20LHSiDwE3o5TQslyAnMpbdl0vDKBQ+84cB9nbh67B
         vNyx9U+kX60u2Fu7ewYetVMZh0tnWJnrjZtAF1A7lkgnNb1qXigVkTeMZgCt+W8bVl5W
         EUopZg9IMr1cZp9OZYTHNcpxDdfp8wzzJzar6y42KHyN2aueWpQs3oV65XjmxwsMgNHb
         GyCQ==
X-Gm-Message-State: ACrzQf0eVPaA9dBN9f86XfRNAxxpMv0NmtHJzGkol6XdSpx1+QYrRNYs
        UK1TZuT/lb52J438zmabBr3WbEDkfysmyw==
X-Google-Smtp-Source: AMsMyM5UN4IrBvaEt4tvcihyzYGOioRhc/bCoBcnmhaxvrlYxgvfaMsJ9drljhQzXF5IMyRxpGElLA==
X-Received: by 2002:a05:6512:10d6:b0:49a:1fc0:cc62 with SMTP id k22-20020a05651210d600b0049a1fc0cc62mr4977757lfg.138.1664615811564;
        Sat, 01 Oct 2022 02:16:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j2-20020a056512398200b0049486c66140sm699271lfu.119.2022.10.01.02.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:16:51 -0700 (PDT)
Message-ID: <70d2538b-9d6f-8443-0afc-655fe60f5dc2@linaro.org>
Date:   Sat, 1 Oct 2022 11:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 12/19] arm64: dts: qcom: qdu1000-idp: Include pmic file
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-13-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030656.29365-13-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Include the pmic file for the QDU1000 IDP platform.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 1 +

No, this must be squashed and on its own does not make any sense.

Best regards,
Krzysztof

