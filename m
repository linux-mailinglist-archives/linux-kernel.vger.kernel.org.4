Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D767681B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAUSvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:51:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854CEB49
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:51:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so7457127wrz.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhGQcLHDiDn/MigF1AOckbdyrSZTiOwmqbX0nNR9KLs=;
        b=IIQGkHkCLrpFxR4Rjunqfs9IqSlrgPaoj1vT8MvKQZx2yd8kPlmzTAkIHyQl0GpCyH
         Gm3oTpurtmuZw752nkUgHgkADJIlqJzxRn4yon8vk5yVN4ZMpFqrw3SngAbDOKOjsZ0M
         gTmV4sqFUZcZpoP7iTL/1dyAb4i6T8Z++fUyaEWhwiCx9R4t0bgNwdx4r3X4MJjpwQGS
         AjYbotND2uSX4Ga1ar3lBwkwrIxN6JQPH58GY+MXO6KEVFSlGNIcU7Ll0/zXHzNSgm3i
         EetDKVK7vS+kwtOBIJDy+eaMocS0Ny2u4gc3igIc0Y3BGWs8LTDsd1tkQg9ScL3Wmp4e
         THtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhGQcLHDiDn/MigF1AOckbdyrSZTiOwmqbX0nNR9KLs=;
        b=hNl1cu+KuAyvE1d9Ta8Yxuj6doI9/dmELbJyTH2iEZAWVBrJUgTs6BWLag8OQtLiiF
         VRkhObD7oajy+oZy5XUBaOlpoaJ526ujoIpTdjeQvaKwgf7y4dpx+w5/0zmHiRrkuM3f
         Vi/baEP+o364MvsUHCEjjwVMcLYLY8eyXO/glgkoEdh+EWSy+lYSpZmDfQRWO36zN6Zk
         utO5bvOJswCbUChkJDl6ZIl0gQr0J1Xe5ia/lnY37/Etk/DSSFPHZH9YKymjd8eR8Tut
         oC7yZ8Ee+9wkmJ61EJymJFnzXO0rGcKhKA/PA2ARijWJJMIYT669aCr5GAmOVx0KKyt2
         0Npw==
X-Gm-Message-State: AFqh2krzHiE6RorrbXFFON9cSIcqwfcomEyib+FI+XRCp4DtUi0ZBN/K
        n6OuIl4IG3hozMQN3+og46DgYA==
X-Google-Smtp-Source: AMrXdXu6DhBISJpEkeQsz5ci0pbMH/nhWcf8KpYLYGgadMkEglLBMsThCa40/rVRc8ROyeTXFR6iyg==
X-Received: by 2002:a5d:5b0d:0:b0:2bb:62bf:f5d1 with SMTP id bx13-20020a5d5b0d000000b002bb62bff5d1mr16802949wrb.29.1674327111852;
        Sat, 21 Jan 2023 10:51:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0027cb20605e3sm15055656wrb.105.2023.01.21.10.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 10:51:51 -0800 (PST)
Message-ID: <d0bdc8f9-5ea8-5c77-3193-a2932c87156a@linaro.org>
Date:   Sat, 21 Jan 2023 19:51:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 5/9] vendor-prefixes: Add VIA Labs, Inc.
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121175639.12818-1-linux.amoon@gmail.com>
 <20230121175639.12818-6-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121175639.12818-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 18:56, Anand Moon wrote:
> Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
> of USB and USB Power Delivery controllers for multi-functional devices
> and platforms.
> 
> Website: https://www.via-labs.com/
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: - None
> V2: - drop Drop marketing, so without "leading".

Wasn't this merged? Didn't you get email?

Best regards,
Krzysztof

