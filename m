Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553160F1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ0H4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiJ0Hz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:55:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C28D220;
        Thu, 27 Oct 2022 00:55:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w189so743220pfw.4;
        Thu, 27 Oct 2022 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJAEKndr3m6wkfHwUrnC0w/oTWY26XXJ7PxMYSqorLA=;
        b=F0KKv+ad3qoKlO1BO7vEexO8niWP4K3suGfjq2soz7HeZjjCp+RCqX69vAAE4H0l3G
         JjRa2lEKbrZ87cgPlqasGGxBPQOV1Sb8CRg9wJZh4wtTWP7jZXV1ogOeNLWzVibP7s/O
         8TdEh2sP0bsFR/CyDsJD8HrOnHaVsRFRtTCC5nnaaT9e7CJChFvkkoTr9i1lZbImstoP
         w0F8fNhT6nkeLNW9cHUP7qt7bPkGjWc6p9Jtq+twr0JcBEZA0Cw5H86toRxrWoYjt3za
         Mpyme/IvITrGdk2wRYtxyTI5B3S3ayYvYMnimGqEQX/8wJT43/6Jkq5hh2MvMOHuhwTU
         pf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJAEKndr3m6wkfHwUrnC0w/oTWY26XXJ7PxMYSqorLA=;
        b=dBvRN1/AJeuG8esA3uWSPZCmix8na1RNrTpbFxHQYJHCjwTEoACG3Ft8QHc7LwQWul
         R49DbnYcZlgmpvZNdyJUxCWDuzbM2uy/eRfPUfsqLhueIMcJrh4BHmgzoocu0L8lFX0K
         iuOohWZxdt/ASS/y1/a0rLJfQeHO54576dfDmqMp49af3dxM1c0OXtY9yT79XH7OsCQq
         Jg4Jmp+IRyadsTHqBq2CLwjfJh/RW/Q3DhGBd0Wg6HngoUr4mCeUcvVTvE3WWoHJYuFR
         wUaywvjZ/SoG8NVLTQ+OKy2OljD5rVcbp3TQzE+mGqS32wFCHRqs1hHnV4cQRxrRUnX2
         dS1w==
X-Gm-Message-State: ACrzQf3Xt1LKrS9Lhezy68yqsUdW4/72cF8kkReSrAw2Fkt+kPjv8LI4
        b2V9G3VGGrI2LirB2A37RUA=
X-Google-Smtp-Source: AMsMyM4RuXf3SFWGHbEF/qs8moP9zk6bojXHDwIAw0jrPBotzHFLCqlixCAZlEmHMoAsFj6N/fwnpw==
X-Received: by 2002:a63:4307:0:b0:464:a24d:8201 with SMTP id q7-20020a634307000000b00464a24d8201mr41524700pga.116.1666857353905;
        Thu, 27 Oct 2022 00:55:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b0017b264a2d4asm588191plr.44.2022.10.27.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:55:53 -0700 (PDT)
Date:   Thu, 27 Oct 2022 00:55:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Message-ID: <Y1o5hYAnBuf1akJ9@google.com>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-6-dac2dfaac703@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v4-6-dac2dfaac703@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:06:42AM +0200, Neil Armstrong wrote:
> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Should I merge this through my tree or you want all these changes to go
together through some particular tree?

Thanks.

-- 
Dmitry
