Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF845B3AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiIIOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiIIOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:44:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E3125B1D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:44:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so2094440ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QRbJ2ooLdimMcCfJ9oyWLU6O612w08VbsijCYMzYCY4=;
        b=K8lxF0W6occELPfMaX72DS47qyq9RcaoR6MzPntGsL4CBOOwZuuSbdUq01bJhoW2Tr
         bCzl8eaBl8oHe5nY3tfpcf6SommdKR2CzjbW47w136RJKjC8NckR1fsagIz2afNQD5AI
         TreraNJze4MdxXTOP4Ua+x2xv3HoZ+6b7XBzPE/NJ5vU2wiCNAOkkMMH6rErcGIa9TxH
         v8ZLgeeYhsWAmkGQ7Yfwaw9pLnyLD/xaoZZkhKRz4wtvOaDZNDd3Jekmk4KdpGiLcW4y
         gCP5FhWLZBRuDhrkmd8czvhsc6myMnMiZpnTxz3Pq/qfZNYOGKCuXedt4YpICCKLQs6s
         HGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QRbJ2ooLdimMcCfJ9oyWLU6O612w08VbsijCYMzYCY4=;
        b=1feptv/q9wPqz9UykuNFoMDkgr5VzukgKQNGkxxmAvhacDgfzDqdTZXU3b44aoDGAG
         rjuQdf+rd5f9Qj3Ldp6I8CcjPKEkqIK3nwVz+EEH6AO47g5sNTXvMhQfNjn/OsM6Ngo0
         TSAjnMyB1QnDZVSrGOjrl1KhL+4/U04kOmB3Qp04+YBRIADRZwuB8UJ8v946wI3PSOG0
         TC8uA7jR+/KTnKqY5+gR1kbZ2K/NDriv1mrma2oYOH9vDVoCmg3A46blIPnDU+3XXURw
         xEV3dMdSSK1vEXEg0MgGQbW4gIYZQ8IWSKziKjkjMk8PZtpixgI5N1G+6iPwYHCzDjPz
         UFFA==
X-Gm-Message-State: ACgBeo28AYGe6FhjiLkxWeSwj4S8f99Htq8Ihojvg6yTVFpcrGZ0Kv8e
        PS+ffWOhBbomNE27W/k1eMmmvg==
X-Google-Smtp-Source: AA6agR7rt6NoM3HYa1SElcUM6vShvP82xGgOkPHH1v8eQ/6KkjSJf/qcew+8kTF5ZhbE6gxoqRPTYA==
X-Received: by 2002:a05:651c:12cb:b0:25e:44ef:8bfa with SMTP id 11-20020a05651c12cb00b0025e44ef8bfamr4169995lje.324.1662734654792;
        Fri, 09 Sep 2022 07:44:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o28-20020ac25e3c000000b0048cc076a03dsm101021lfg.237.2022.09.09.07.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:44:14 -0700 (PDT)
Message-ID: <ac64332d-e095-f8df-688b-e757874c6137@linaro.org>
Date:   Fri, 9 Sep 2022 16:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 03/10] dt-bindings: misc: fastrpc: Document
 memory-region property
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
 <20220909133938.3518520-4-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909133938.3518520-4-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:39, Abel Vesa wrote:
> Add memory-region property to the list of optional properties, specify
> the value type and a definition. This property is used to specify the
> memory region which should be used for remote heap CMA.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
