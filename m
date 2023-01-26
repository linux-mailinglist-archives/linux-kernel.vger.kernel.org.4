Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC267CA55
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjAZLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbjAZLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:55:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016772DE63
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:55:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bk16so1492422wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yP0BywDAnuuMbf+32a07Q6Ygejqs/wXSQRU+sh7FeI=;
        b=pTbd3ZJCw9QkBCVFBLLz7s12GMYqKUxPMsNWFVb0xVjETIqqg8a1SYtG7M4T4xtcYS
         EX8QJFOwqFCbF4E0kcBu3fdLUhbzHs0lYk5o1fHs+2wGBXTGxCp2pdy0MSwr3bfpOCtt
         iwwNN6tBZMLMDlXKZCOoy3whFNnGfh7ZWa0iJirmFc/FIPjpnrWEDYvBvv+OuU+LEfuw
         UFIOhyHGt4JmN3eq8hs9GR66BgK6PTw7RPxqWg0sp2hQBLBJgBvuidoojbaupcegM6Ha
         SJiLu8o8nzc+t2IC3ay3yYkX9x5EE2oy9l0eZ9hFy2QnDtBG9skdx+/M0a2JuSZ4u3u6
         GAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yP0BywDAnuuMbf+32a07Q6Ygejqs/wXSQRU+sh7FeI=;
        b=4+qQXZU8Wmo+RtI+uJyU01wWMPOslsL66G84oSUebvEcJLsDW+FByv0+deH/biGOWB
         9pbTBxTkjTzibAlgn/AgN8d09VuxMJou8wUNRvwIgCwYarXinKn/DIFhw55OTepjN/Er
         TNPR9ZiJIrR4++C1spfT422jjenK9HCEd145eHYZfZlu0iz6p1zy2BeeJ3KkX0IEAcsW
         DrZ+5iZ7QfqKSCkdfjHFcZWFqdIOdwPMjFf0xUybrJK4/tm7H7YHzKAn1ILD1ZLfmzl7
         X52q3ZH/j+HKqSSUCm+Yck3XUmuR+XqrSVF3LjpkFYI56tSAYwGIJGjM4lw58QC8nGhL
         tljA==
X-Gm-Message-State: AO0yUKXA2IB2nZX9DQR/dNvXgy58soLZcv7NNCZ+2wZsy4ooHqTtRFw/
        n5oQliykxHPc5U+otBZTdHFG8Q==
X-Google-Smtp-Source: AK7set9qt9nTQzZdQh3JcvKhICbeSSBvdsDbg5AZQS8AybL0RpuPHM+dTgnRZcLj2lVpBsg2yesVVA==
X-Received: by 2002:a5d:480b:0:b0:2bf:c748:b8bd with SMTP id l11-20020a5d480b000000b002bfc748b8bdmr1588634wrq.53.1674734126483;
        Thu, 26 Jan 2023 03:55:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h4-20020adfaa84000000b002bfbf4c3f9fsm1149608wrc.17.2023.01.26.03.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:55:26 -0800 (PST)
Message-ID: <62207c21-38f2-eb37-ea1d-2f6eef2202ff@linaro.org>
Date:   Thu, 26 Jan 2023 12:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 08/22] ASoC: dt-bindings: Add USB_RX port
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-9-quic_wcheng@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126031424.14582-9-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 04:14, Wesley Cheng wrote:
> Q6DSP supports handling of USB playback audio data if USB audio offloading
> is enabled.  Add a new definition for the USB_RX AFE port, which is
> referenced when the AFE port is started.

Subject prefix:
ASoC: dt-bindings: qcom,q6dsp-lpass-ports:

because you are not adding USB_RX port to all bindings in ASoC.

With subject fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

