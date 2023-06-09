Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73A729ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbjFIPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbjFIPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:40:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA030FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:40:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so21419251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686325223; x=1688917223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQRG02G+Dbe1B0+6KJo9SLXQ+0hXudANBMUpTqfI594=;
        b=I/MnDNi6hc7i16YsigbS2TngJdyE6/1hQ9/2Kwd477U/yZweXOzxXY481vZ/DbVURy
         I0faW+RY9qo5oPK6dzHE5uYjqgp+TLN1vqsGR7C5YYqsVUq+PnGAz9Y+z97NZtS9U0Bh
         lU56mGvfG04d1zMvMRLVL4lE65AGddoyPmbx9qu2HJNu87SyrAslfMB/t2q+NlDj3k2C
         wW3XmAK/ivP2qj0+uVNEoNwrNiboNZiHfMxOPxxeoktyrLRBZKQdShF/PfVD16N3fuI0
         CIMkwnfQ3DSH0QKnj7MR/H9qFzDoVJu2Go5TTnX3B6DX47C1shIZcDFjh1Q+fLVYwVf6
         gvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325223; x=1688917223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQRG02G+Dbe1B0+6KJo9SLXQ+0hXudANBMUpTqfI594=;
        b=OVZSCgnRLUMmfP0WV5CNua8N3abFDNZT2vSuU6hS/tTqbtF+9fA8u7QVtZDmiyGlk7
         qrOMgdr86GX0AEcqhujuk5Z1dQWur8g/NC4KYy9r2YIr1O+4hDkKpk//qQxmzHm/Y7zR
         KJSHIXrGclFXbzB+Cv9zSoCvz8ry5iowD3uFIGFiJ0be2usdNyBK+nzL5y6a8TOCjaFz
         1CPj88S9ek2E/O+mg0jSgxJySVwHApbnxqwAIkBjPQwECITgnNt3uJUw72PrQAiVBWXn
         qrUzSxtA6hWAOhPTx7TTya4JLvAGzE/7Y//9D5D6kTagiEhnQjIrAucc2lbuV1psfrls
         OOZA==
X-Gm-Message-State: AC+VfDzb7tYQiknAg/5MbGhhD8OhGGK/fkqLGZhbJArOpdh2w7ey6a0R
        DvodiwYu234biqJBpEC9xhiepYPyTHsHIcQYVu4=
X-Google-Smtp-Source: ACHHUZ6UuT10SINr+AclWPtzmR8uSUSk8xgIMXeY2yatS06wlFryDLE9BlVdvfnBdFjUr2wBphKw4Q==
X-Received: by 2002:a2e:964b:0:b0:2b1:edfe:8171 with SMTP id z11-20020a2e964b000000b002b1edfe8171mr1125092ljh.36.1686325223004;
        Fri, 09 Jun 2023 08:40:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s13-20020aa7cb0d000000b005163a6c9f18sm1868430edt.53.2023.06.09.08.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:40:22 -0700 (PDT)
Message-ID: <37f17a76-4568-f780-1397-ebc767cd2973@linaro.org>
Date:   Fri, 9 Jun 2023 17:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, siva.durga.prasad.paladugu@amd.com,
        git@amd.com
References: <20230609110447.151235-1-piyush.mehta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609110447.151235-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 13:04, Piyush Mehta wrote:
> Convert the binding to DT schema format. It also updates the
> reset-controller description.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> - Addressed the Krzysztof review comment:
>  - Update DT binding to fix the dt_binding_check warning.
> 
> Link: https://lore.kernel.org/lkml/168612336438.2153757.6000360498539992409.robh@kernel.org/T/#m4abfe6287177d5fd09f781d298dd19d56aae5e27 
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ----------------
>  .../bindings/reset/xlnx,zynqmp-reset.yaml     | 64 +++++++++++++++++++

You forgot to update xlnx,zynqmp-firmware.yaml. It was wrong from the
beginning, but now you can fix it in this commit.

Best regards,
Krzysztof

