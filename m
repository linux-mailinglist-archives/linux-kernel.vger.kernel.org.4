Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FBE60FBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiJ0PZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiJ0PZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:25:51 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750953A4E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:25:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e15so1601972qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOO+F95U9O4jk/n65hYZseHyMe71X6liRCwk6TGsdSk=;
        b=V/wCu44bsoPCylEk+SGnhNZdWPaiUGmmHtNEouJbCab3WAO33aOTmvlhKsNjxxeEz4
         Yn9ORCdjtyxGEOxD5TO+5UNQE18MNN4ayd0ccl2I3RCfeLQINlKxBRuIVn1miSJWhu1s
         b9TmzfUQ0A9szxHYd5ZSfaeaHSZBd+o+gUL2FyG2kKWWo0QSUiRJMK8TPI7GFIbIYcTL
         voVfzsOw67O6ssYLmkpxwUPjXwd0/5tLisUxd3Rd0oALQZHOoZpXYpRlHZI1TRkj6k6h
         6cWm7jjpe3tCCjJ1RMKGDKmxNMgMDs3xzdvGNvCqFkzP1SBI5m8N2QyaRDAAH50Z+8Ic
         0Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOO+F95U9O4jk/n65hYZseHyMe71X6liRCwk6TGsdSk=;
        b=n+CzOwwLXbJ46NzbPkejifva9gG2H1dyt7pMUl87SXWXSgVxa+jhVmnYDsTUOSOJGh
         YZ3TX597fl+8flClsP60GwcR26X7byv9dumfAXvOW0a+iwc0QIW268nj8x/JM5ugmTKj
         UWQmwOsnrc16MSxIqHJbAYVbj4KiF5DbG+tllGKMQ1ltQWepa4QghFb5YiECX5aZ+6Pf
         i3kqemeP7cA+aDCo5gf+YguX1SbBvDB4pNkw9wsFDwyi+9b2hsBzXpifLlOdOfk3M0EW
         sMcCGNkOem6CQRhfdXWKaRXXdrMJgzLeUwjmQWAVbBmkLtVrXjcVrskZsMTZeRAMjmbq
         IvlA==
X-Gm-Message-State: ACrzQf3T9Aeb7yTblhOJLqKOy+fnKvP+/NWYEBESpQ4AHQo+8qw8nJvf
        pShRguiBIAu0h1NeLAkcs8mnbg==
X-Google-Smtp-Source: AMsMyM4MfDxgroQTsa8xDUFc/TeISESdJgNK6yixrrxj4TWJ4BgeBTO6V8QG/SAS2ggAd0lAqR3mHg==
X-Received: by 2002:a05:6214:194a:b0:4b8:d7dc:292a with SMTP id q10-20020a056214194a00b004b8d7dc292amr31523057qvk.54.1666884344498;
        Thu, 27 Oct 2022 08:25:44 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l13-20020a37f90d000000b006ea7f9d8644sm1150571qkj.96.2022.10.27.08.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:25:43 -0700 (PDT)
Message-ID: <23e8a609-345f-a8ce-b0cb-2926fd86a315@linaro.org>
Date:   Thu, 27 Oct 2022 11:25:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to
 rpmpd binding
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190549.4005703-3-quic_molvera@quicinc.com>
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

On 26/10/2022 15:05, Melody Olvera wrote:
> Add compatible and constants for the power domains exposed by the RPMH
> in the Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

Looks good, but you did not Cc maintainers and  they must see this patch.

Who do you think will review and pick up this patch?


Best regards,
Krzysztof

