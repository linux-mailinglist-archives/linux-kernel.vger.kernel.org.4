Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386B6E361C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDPIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDPIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:41:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18439D8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:41:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id vc20so1584960ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681634503; x=1684226503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z38YOwonjh+CuGoHVNF1HUAwyUw8JsKrwMe04nmWqWU=;
        b=XtL7I8EJa4TnDjPqg/bkL7het+eZwnY7c+vq/oR2ufKb0V0wVxGLOZPHOCrhLp/MLY
         nQac8gaM2+kSZzQMExRz5WmhDKRKEwtQDMuzGoYCzPz/ABG/m/RmWD00gis9vZyn+8fI
         QqfIJA1OfwTSEDH8Bq/9e8CvppGUejeR5PnKTUicmjUqpEph6LPByXk8FWl5s8v4s1TQ
         B7kUj9Y+8d3E5VtFUDtzmuZodOqOXYGrSPGTsqj32s0E9JYBgn77+s5Hw0bLi8Dkbr4m
         QUHb0zcNiDhtcKAHF/IUpNbEohIY694N/DlEvVye1C4+PFpvEFln0yhFvsL2wu4AoNIC
         1J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634503; x=1684226503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z38YOwonjh+CuGoHVNF1HUAwyUw8JsKrwMe04nmWqWU=;
        b=UZoewN4MazG84qqat3AfKTwR3Bjf6xRJYbEnWGzaWqUFoW19mlnin/+Fp856zLiRK4
         UJHM0wvMIgYWRApKCT+rrJF990H4lzJeu4Cg4U26+RxBmpvF5b8qbdIRS3yTp66X1ATN
         JCGoH4ZV5PI/fKofMeqElcOv92EPVku2Oiw75B4Y/bQDPTK2jDQnRXuHDqUQ1NEb0K6V
         8ZCjGqZ9DJniaw1BRM05wj485P47LDnrVGAFCATptgwqJ3y2XiByqAff0fytlnqW84tA
         DIJtc2Ly49A1QwWf5kOSINVpGstwWb1VAzyx2sttAGlBtSK0PVzkvveOjLDxPt/70suY
         ejDg==
X-Gm-Message-State: AAQBX9et6TERqZFhp3L93C6jWM3ewPfj2pwgOcBfAGYuvvQUaI+/A6TD
        PNueBqnTNV3myiq71AYIhcQw6Q==
X-Google-Smtp-Source: AKy350Zi0A5LLp8sg5agw1LU2VkgNVdoV04TQ1cymNV6El5KTnF+4ocfEanZIQeGs02EIhPW/yxFvw==
X-Received: by 2002:a17:907:9010:b0:94e:bc04:1e19 with SMTP id ay16-20020a170907901000b0094ebc041e19mr2881822ejc.71.1681634503524;
        Sun, 16 Apr 2023 01:41:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id hu14-20020a170907a08e00b0094f2d38896esm1498033ejc.65.2023.04.16.01.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:41:43 -0700 (PDT)
Message-ID: <b6f47412-591d-6b89-2096-c5e5b72d8e17@linaro.org>
Date:   Sun, 16 Apr 2023 10:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/5] Add support for Focaltech FTS Touchscreen
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 04:02, Joel Selvaraj wrote:
> Changes in v3:(Suggested by Krzysztof Kozlowski and Konrad Dybcio)
> --------------
> - dts: removed the invalid "input-enable" property
> - dts: replace interrupts with interrupts-extended
> - dts: removed redundant dma configuration
> - dts: reorder pinctrl and pinctrl-names
> - bindings: moved unevaluatedProperties after required
> - bindings: make interrupts a required property (new change from my end)
> - bindings: update example based on dts changes
> 
> I have made the interrupts a required property in the bindings as the driver
> will not function without an interrupt. Because of this new change, I have not

Driver does not really matter for the bindings. The BSD driver for
example might function without an interrupt, so why requiring it? The
reason for requiring or not is in the hardware and how it works.

Best regards,
Krzysztof

