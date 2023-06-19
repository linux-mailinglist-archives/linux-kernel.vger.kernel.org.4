Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2E734CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFSIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFSIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:03:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA3E73
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:03:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-970028cfb6cso531099566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161788; x=1689753788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MsnoYz0hP2V8CBehrpeQPUT+76r/6pTB7F31k/oTqQ=;
        b=R5lm2JEoN1Dap5ewRuzod70/svJW4Tpp+Jf/ugmj1Yk7OL5KSTGTc2+KLFvXEYZtts
         ByDbXZoZ7c6jDHRXmdIpI2Ml/CJ5/87e+a/DcPAG4qe/3X/dS3mR/WK4HcxKs5G54pUp
         k3US0FIJ7DwVVZDtHqibOsRlTx7HuZTzO5NocTyCsvoO0L2t+Nb4MTpHWCpzfkFAzYLW
         W8fprdmu60ugR/QdbVDPQtR5R20Jvp9cCsX76SdJ2g4o9MfkcRTPivLh64I9A68Mq1Uc
         VXKXFrmYX1ZqL+v+ALMzoK3FotlHqeR19D35Fi1kZwhwCLSy8CvBHZMSKbipZsiKSQif
         KoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161788; x=1689753788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MsnoYz0hP2V8CBehrpeQPUT+76r/6pTB7F31k/oTqQ=;
        b=K54A/j4FzgljmwgF2AN7SsaOIeGk1tSE/UAR5Nh9RXUFw/vSy3Kl1V9iMLhR+508w3
         3rAlxEHSKYkDm//HDibp4lXDl7IMLlkJcDzJIbUbCfvoQbEit23aIwbAugLXAGa2xfuo
         hcUox2XiTAn6XQcIoUEk4P2dM9q3zFLYnJBhXHg+myLIpY6XtBX4nToWLUFTXS4/Th/w
         fyXIYsqkZaVHUSnHlue8ba2kftDHCBAuXi+L2dRHAjOu2QNzUQhmAs4J+8AukV2JwZWT
         JDyBB36Zoj8nDutotefYluNNWnfjS8R9uP26KetGhqiKB+FwWhC3zlDvdBJ24BrsQKTi
         ngeg==
X-Gm-Message-State: AC+VfDxYjeGIfNqXM6eu37aoqeN3YYFLM0B2e9HFBSMGcG8sS40UQrbk
        6L+tvAQ40wpiA7pgURWWPEolQw==
X-Google-Smtp-Source: ACHHUZ4G6sKfA1qmngTmVTdImZtQIJooHKrYQsNUpw4ekWRnZ6ieoPMK8rs9BRGC1ccyE688NqDM8Q==
X-Received: by 2002:a17:907:31c2:b0:974:c32c:b484 with SMTP id xf2-20020a17090731c200b00974c32cb484mr9045597ejb.72.1687161788200;
        Mon, 19 Jun 2023 01:03:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906360200b0096a27dbb5b2sm14113007ejb.209.2023.06.19.01.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:03:07 -0700 (PDT)
Message-ID: <68262eba-c9b7-5c3c-acb1-1c651931e959@linaro.org>
Date:   Mon, 19 Jun 2023 10:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec
 starscream-bmc
Content-Language: en-US
To:     =?UTF-8?B?Q2hlbi5QSiDpmbPmn4/ku7sgVEFP?= <Chen.PJ@inventec.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Cc:     =?UTF-8?B?WWUuVmljIOiRieWuh+a4hSBUQU8=?= <ye.vic@inventec.com>,
        =?UTF-8?B?SHVhbmcuQWxhbmcg6buD6Iux6YOOIFRBTw==?= 
        <Huang.Alang@inventec.com>
References: <20230619064249.3623-1-chen.pj@inventec.com>
 <2a9e503b-7a5b-3b1e-a912-5d54a23c1ca1@linaro.org>
 <832a9af9c9024ed3b7bee0d36a482837@inventec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <832a9af9c9024ed3b7bee0d36a482837@inventec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 09:47, Chen.PJ 陳柏任 TAO wrote:
> Hi Krzysztof,
> 
> Sorry for brothering you and thanks for your patience.
> 
> I use "git imap send" and can only send two patch separately.
> After your instruction, we setup the smtp server and now send two patch together.
> 
> But it seems still not enough.
> Did you mean we need to combine two patch that modify the document and dts in "one" patch?

No, I meant the second part of my message. The long one, explaining in
details what you should do.

Best regards,
Krzysztof

