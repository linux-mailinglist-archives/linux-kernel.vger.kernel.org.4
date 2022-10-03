Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681A5F313D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJCN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJCN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:29:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625324F1E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:29:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t16so11787158ljh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vrjrFsK6VtRpI2UHPnLRuHMquKG/Pwu3cpXXmdq91bE=;
        b=yzwQkK3nHvuhGjynfGxjssZTzK69/5PN7S9Ji0a7/PP5IFOak/ra0AB+VJQrA/duTK
         Psr3Ukf6Crf9wSDrXUnVe7ueyEX2yRgckL4+EjFk+05eQwMsHFwwlBBQvJ+W4Gn1dcT9
         S11kjxbSR3pa3VQfz196V3a9e3VTd+SxRtg52iggzc4s6O56eMrg6r5EjKoUbBufZPil
         Y+BN/0upH+RcoF+u/FogcAa/UcwwyGbeV+4mgVK+d6QtIqRHLmZWhELnDiGWSlkFpAPr
         9TAbjdBFJQBlTx41vdQhXP3ffKzg9EupeIxH+PN+LeixOFFvuaubm8ny2ZKXk5gupgjB
         ZWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vrjrFsK6VtRpI2UHPnLRuHMquKG/Pwu3cpXXmdq91bE=;
        b=oGdQ8HuaTW7Wf+sxcpzr0YP5R+LsiqeZ+tWurOWppO6c/Q0aLesut7KxHKf+wl9LL6
         /s97jGD7Z9fVZNTGfqAo/ma4+Wm004Q7DsodJUIMRknzyNzSPXiN1e7SBBd8QAq4VbrY
         bByA4ioNkrxDn4PV+RBsjMhqeAp+gUD29PJCn4RlWptehkRMMIY+7AHDcIWha5ecb+l7
         zW4qH2yD2KBYtf4Wiimeb9D+D9vNftm8sWZWTJkzbePrJkzDPyI6dO89Okfz7qC7KRVz
         XICixiWjCuQkNajpbumj+asIre5UjXa4DHYMqjLkSQk+11vc3wy89Q7X+NV5opYaWYTv
         YDRg==
X-Gm-Message-State: ACrzQf3IXHOpAPfYcXSJvHkYwnBVSslyXccTUQZcQ39VBkVAHe/sCfIt
        TMjeqH0eObRMmQmOATsoBaYfjw==
X-Google-Smtp-Source: AMsMyM5p3AJzIob/49islyUlukZuEqq1rWUMF/dALhuhcn93iz7oI2pcsVHta9Oq/1Gwij6EqZDOig==
X-Received: by 2002:a05:651c:b22:b0:26d:cf14:7c6c with SMTP id b34-20020a05651c0b2200b0026dcf147c6cmr2641751ljr.495.1664803740062;
        Mon, 03 Oct 2022 06:29:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 14-20020a2e154e000000b0026bfc8d4bbbsm891542ljv.125.2022.10.03.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 06:28:59 -0700 (PDT)
Message-ID: <53166a75-22b3-d936-7c70-a068993cddad@linaro.org>
Date:   Mon, 3 Oct 2022 15:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
 <20221003125444.12975-4-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003125444.12975-4-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 14:54, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes, like remoteproc, regulators etc. to sa8540p-adp.dtsi file.
> This will be base for many ADP boards to be introduced in near future.
> Common nodes are like clocks, remoteproc, regulators etc.
> 
> The differences between the sa8295 ADP board, and sa8540p ADP board
> (Qdrive-3), with respect to device/connector-interface, are as following:
> 
> PCIE: pcie nodes are not supported as of now, and will be supported
> in subsequent patches.
> 
> UFS: Devices ufs_mem_hc and ufs_card_hc, both are mounted on ADP air
> board. Whereas, only ufs_mem_hc is only mounted on Qdrive-3.
> 
> USB: Devices usb0 and usb2 are present on Qdrive-3 board. Whereas on sa8295
> ADP board, usb0, usb1, and usb2 are present. On Qdrive-3, usb2 has only one
> port supported(of the external embedded hub). Whereas on sa8295, all four
> ports of usb2 are supported.
> 
> There are different connectors for ethernet and camera, but connected
> to same interface towards soc. So, there is no need of any difference
> regarding device tree.
> 
> Artificial intelligence chip SA9000P is present only on Qdrive-3 board
> as PCIE endpoint.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 528 +++++-------------
>  .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     | 133 -----
>  2 files changed, 146 insertions(+), 515 deletions(-)
>  rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (70%)
>  copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (72%)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

