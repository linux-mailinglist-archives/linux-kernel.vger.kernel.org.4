Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4C6C60D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWHcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjCWHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:31:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CBD1689E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:31:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so19638187edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekZUPnt2Vozh7f2sOzqBtvIcIMLGfykVhoLT/YHh2xE=;
        b=MxAap6yrlqQe+CS3DpDJfF5WuV4QamV9krsmqhN6cV++/4g87dcsgqDPv9l4+5jTSN
         fpREq+ql5ZTsrvXKij5+szUYFIjJ0KrLkBQo4LjQ1Xb8NggiUvcGJK175r4xihf79DWH
         T9KnIy/W0K7sT2bZN78BDTWH3LR1I9CbJ5kYRt9N0WwtKZTPt5K7HgBM2XmjXuODk0Fl
         eyZrEpQKsNQcqJg8O8ItsV46io0ofcKBAqE9mSXi9A/p5D9UQd6ntvzQtllz758dL0dv
         Np4e6EQf/FAiZDraFfnXffKia8k+jFmBUof/QJ6Bb3WX2KDSPFstWow9QJ3ylAscvjmg
         zAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekZUPnt2Vozh7f2sOzqBtvIcIMLGfykVhoLT/YHh2xE=;
        b=KiZvy/IuBawRCkc48rRAV4OSOaSv1KMvia/SKSfSHMEpYs6oAMwznCrgpC2kzwKEIb
         YE6klKj2tW1Y6mdJseODgf7pwm8/gszrf+VqGl8BL5tnbDgtXn9vPdoV4+g9tqTcUW1Y
         S7wJIKVnE9dt/uTEWSsTksuKMuw14jSi3Wi9vg8nJGH+yEleQEDpXaJOx9rI8KI8/LjC
         0o+RXnDUfWMOuMhDvO3bdecdlqs0u/1jDxZkOCmhmIwVdtlx6bM1v5LzJnu5xaQDvLMX
         /u0R2TmmBLzzq7OysdUhLEys0nWnPvCKX1Qmw1sjzgnKVvk6000iFbm20hxu+QgVrmVg
         duyg==
X-Gm-Message-State: AO0yUKXIdZN1GHV/2aZNb3k+pHOVYJjbjVKSbEnNBr+LCrEEx4g7Q1om
        4ZlRtfy4S674GQae/PLs2+8/EQ==
X-Google-Smtp-Source: AK7set+iWZt444eNKE55ycB9BgkADqbdT5/QwpCrCYcQJ7NbBWuq6iqdS3q/l5rzTRalH/MtURCskw==
X-Received: by 2002:a17:906:5cd:b0:8af:3b78:315d with SMTP id t13-20020a17090605cd00b008af3b78315dmr10894973ejt.23.1679556716702;
        Thu, 23 Mar 2023 00:31:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id gv27-20020a1709072bdb00b008b9b4ab6ad1sm8235164ejc.102.2023.03.23.00.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:31:56 -0700 (PDT)
Message-ID: <a767418b-1e2a-6d02-fc07-8caea8f877e2@linaro.org>
Date:   Thu, 23 Mar 2023 08:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: mfd: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
References: <20230322173519.3971434-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322173519.3971434-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 18:35, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

