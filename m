Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F46F40E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEBKQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjEBKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:15:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21D55B6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:15:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso3832061a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683022532; x=1685614532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrpxqbKEzamc5RG0FnnS0fxPW9rAuEu+YqpkL0lepMc=;
        b=C54XOXZDaUskwznqU0zAZlzDkAkltYduWzHXMpZpBh2zIZNLFJZ6H48SR0j7u9L9h9
         RpM8OTOBbz6+Kloc92rmImOHY5RZglfJTqnVrt3oIBYaeft/wgyqQIX43nRjymOqxCrb
         E0iF4d0lf0TxC/XwcBvzlWI6PiS2buvlQUXJfMrWKgzfY6DpxXMmKfRsEcEmnC3zC9BL
         4x/Z/MEy+siIRghQzue8PxIyXRr7k+Tb4B2UiWZW1ZeffklDqfcUJW1uhxVPNDvAs6QN
         Zmf55sZj0FQJrz/aHAGpEF/A0c74iwRTqwMbuseFOkNoIdrRnt33rUa90OKn3rkBBfQ/
         4U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683022532; x=1685614532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrpxqbKEzamc5RG0FnnS0fxPW9rAuEu+YqpkL0lepMc=;
        b=Fe7kAEHw7uttfiVwIXgNmO8Tm40EGKhhvx9mMU1OGuzZ4VBtic0NPPk2lFbAIWYsyi
         tRkG/59qbZ4TEW47PnvrELgz3lwFT1Um+R+L7vsZoXGvk8LfBvmtLxAInBTfcvMco1Z+
         fEswB4uXvC7fIiqbvEWW06iUCUT9/izysBwLvYOKLcrgvwVruShnuoPjPmjNSYywxOYj
         UxYMr4y2bkITKU2mMZTrO0+aQMFEPcl4FUTV/0WOavmZMcdR1iaxEIgONZ/ic4SRu7Vp
         EgHedSh1oauu194gWvYCkzn8e10KTAeiV8wPgbtrZmM/hURJodQI6NmscGEcYKa9ji9w
         Uj+Q==
X-Gm-Message-State: AC+VfDxYTFbtxzUJHgfUt9ugc+YnzNBok805VmHs8+UzmSMNyQCI1xRA
        DtF/Siiq78Op26VmQMkxjKnQrA==
X-Google-Smtp-Source: ACHHUZ4uY4Ep+mspEXhMJeXZP+sFc7XAIzlJdXhPCxEsdPCTOdSnD1ndWScze17CMcPb5JXXt4So/A==
X-Received: by 2002:a17:906:ef0d:b0:953:8c0b:32d with SMTP id f13-20020a170906ef0d00b009538c0b032dmr16391748ejs.52.1683022531752;
        Tue, 02 May 2023 03:15:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id sb10-20020a1709076d8a00b00958079b676asm13249281ejc.122.2023.05.02.03.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:15:31 -0700 (PDT)
Message-ID: <f6193f9d-796e-66aa-12cb-e2c331015f04@linaro.org>
Date:   Tue, 2 May 2023 12:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-2-quic_kriskura@quicinc.com>
 <df24efb2-8279-ef15-a118-2a24885288c8@linaro.org>
 <a001c9c0-f186-f125-daab-e646790badfe@quicinc.com>
 <0f2dea5a-b6f7-b659-f41e-55d1777b4dd1@linaro.org>
 <aab0ee5c-4573-759a-ebda-401b041a65cb@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aab0ee5c-4573-759a-ebda-401b041a65cb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 10:52, Krishna Kurapati PSSNV wrote:
>> Best regards,
>> Krzysztof
>>
> 
> Thanks Krzysztof. One query:
> 
> Clocks are same for both single/multiport controllers. Would the 
> following be fine ?
> 

Yes, thanks.

Best regards,
Krzysztof

