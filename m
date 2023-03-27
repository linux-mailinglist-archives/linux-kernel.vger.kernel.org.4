Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7916CAEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjC0TfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC0TfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:35:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00391736
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:35:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t10so40583328edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CipNcg6XGhT+x225ozA3jqRgRsy3IVzOurOagbBJ054=;
        b=IeTokkfm6UWkOYDDbUa5a8dEtSK25HIxP3MKONEl8LYvz7+y2mO31PP6B7MD2M+80P
         8eA9viEpDVpyZaONFCKJ3VYa4LfYhMTGVn4FPKls46k0RDMS6LRFE5CIVO+33+SXAT1r
         dB0xjiPUwKXHTz3EEpThy6HPIcIWOFckY0F7wDIa2xg2pJvLKc3UFKN/R6WN7YbkpI1F
         HYg18/4cHbLLEnRI+GesvpGlQsPhUAnCMgcQl7HXCbQ6UGffvQbkyGfl/4BEzK6SmwPL
         12TtBD/LhsTFH5y88WWNlJjn3v085uU3fXQ7obGEj4vrwth+e9aOayJbNzzZ+iP6hBB/
         zJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CipNcg6XGhT+x225ozA3jqRgRsy3IVzOurOagbBJ054=;
        b=s06oqBt18qhNVxpx6vh66mqPoc62VlzcJBNhgw/RTVGICF3ks2DRiTVPYJioWFmiO4
         Urh0Nuw9t3nD6IQ4PRaiNA+BDLvos4XME6xhWUKK1JONIotC2EzbJOHSb8qO5mTxDuih
         o5D/IoE+RhpJYdBQ9hzrui+tTxjqI4dGyq0PFuTKVdbwfLEq+it219M6M4Dg2N8WMfVE
         MoCRhw+anUI1GbitS2f2h/b3iz4o9qq+o2WjSP23+jgfAVirbZP5eaC6c3iOP5lKavGF
         ahvAJypGhtZEit0Orj6kW6oxGQU0p89gPwR+kDt3RvJmJDmy36t0SAHaOe4S6VyE33Fh
         /yCA==
X-Gm-Message-State: AAQBX9fp5c90d/D9Iiyeu92hFxN3ooLAV1X/ElSCsVIbvOICk6egJ8ME
        Hnih4r7ATXAGtUImbA5Rc6mndw==
X-Google-Smtp-Source: AKy350YtrtGg8yqJ/C9YGnzqneUXRLN2+3R7BFncNFhFLbFR1CFy/RSVxt7xVrbMhYi973wLuPSvjg==
X-Received: by 2002:a17:906:3607:b0:92d:44ca:1137 with SMTP id q7-20020a170906360700b0092d44ca1137mr13605161ejb.43.1679945706240;
        Mon, 27 Mar 2023 12:35:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9314:a4b3:ce49:2c6b? ([2a02:810d:15c0:828:9314:a4b3:ce49:2c6b])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709066b0200b0092be0d267besm14577954ejr.142.2023.03.27.12.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:35:05 -0700 (PDT)
Message-ID: <8050df0c-753b-1733-962f-b4065500a090@linaro.org>
Date:   Mon, 27 Mar 2023 21:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] dt-bindings: misc: qcom,fastrpc: allow FastRPC
 node without reg entry
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230327184811.499553-1-me@dylanvanassche.be>
 <20230327184811.499553-3-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327184811.499553-3-me@dylanvanassche.be>
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

On 27/03/2023 20:48, Dylan Van Assche wrote:
> FastRPC nodes may exist without a registry property and actual

Why would they exist without unit address?

> Compute Banks  in some cases such as the SLPI on the Qualcomm SDM845 SoC.

I do not see there anything disallowing unit address yet...


> Relax the regex to allow such FastRPC nodes and remove 'reg' as a
> required property.

No, at least not without proper explanation why unit address is not
allowed for these.


Best regards,
Krzysztof

