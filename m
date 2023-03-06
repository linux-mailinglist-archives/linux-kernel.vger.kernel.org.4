Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8564B6AB6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCFHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCFHYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:24:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA691EBD8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:24:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cw28so34500759edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 23:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678087460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3bQ4k2PvMngf9Eau2r8xaRdUgTYQ5lSW/kSlMDUom0=;
        b=RVHBz1olKRHM9CecnH51ezfBz0TAbN2v/Y+Jbn0xMyymyU8EcXQDVoHuu1VBKISYbm
         7C65P7hQabNIH7uKiPmfDiCP6zlK2FYb3RjYCjB5BXpPe84NwtcfUFicpWuqfo0o+gJL
         nmn2NXx6UotZOVZct62/2gSu54kl5w1TiF2d9uHp+9w/iZN2A2Wgr6cHExQZT3cJ9yGZ
         7SXoRX8i/MIrtAtTlGHBDU9fTXqoOusKBnlSIuRI4yh86/sD5RMpygJW5XCCr1TqdW0V
         chQzeTapnwWBxdTg5kpeZOmkOojUysr0KpoA2QobV7GvKpekWJEiEsWTPXiSuWMO93CP
         p3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678087460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3bQ4k2PvMngf9Eau2r8xaRdUgTYQ5lSW/kSlMDUom0=;
        b=MJ/MLuUUFE8NKcwAuWKE0yhanSz//KfFbG4K05oq2soh8A3GFgKWc3CxeDTGF/9gnG
         kVRN0tIqzqq6Pn+TWXzjfwBJRb/+cEZqfG4/sKWin6txWsuBmCLNaeHO/EtondVrJ3U1
         s5Qm5nfzIc7HfemyqhJ+W/NaPDxr9Vh7Wym1R4LRMDfsJVY23dU/FtsJwoeXh1iDA9wn
         6TzTFEzWKilEnFx3ZtJHAY4Go+yY3aosUVg6+AGE6BMFs0F5mQXuLnQLF10YmWcGCAdb
         6xYxAuUKOae4SYzC54oD0uu7nbeNUNTJ4TcM7ayoWuHi7U9IimCqTdunuedPoEKnCau4
         6mBg==
X-Gm-Message-State: AO0yUKVRutRkmmJp063TooupIk0hhP4Jlmwy3/OlOUpAwy4ZxADdsyNg
        M150eOdtN3jTnNWvVL5JFJTVAA==
X-Google-Smtp-Source: AK7set+IhaidXT2y96C0YWRplmrJ2nTzw3MTMT3w0/n/D0HHJ2ViWvdT+gToydQTCuXU2iPTW4/CRQ==
X-Received: by 2002:a17:906:fe41:b0:8f1:949f:37b5 with SMTP id wz1-20020a170906fe4100b008f1949f37b5mr12317038ejb.32.1678087459966;
        Sun, 05 Mar 2023 23:24:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709060f4900b008d2683e24c4sm4198751ejj.69.2023.03.05.23.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 23:24:19 -0800 (PST)
Message-ID: <eba45618-8e0f-6b7d-6ab9-329f481138b6@linaro.org>
Date:   Mon, 6 Mar 2023 08:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom: Add SDX65 SoC
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678080302-29691-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 06:24, Rohit Agarwal wrote:
> Add PCIe EP compatible string for SDX65 SoC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

