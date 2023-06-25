Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82073D014
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFYKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:17:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67535E43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 03:17:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e0c1d5289so113476366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687688257; x=1690280257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDxSibctoUXEH8FbhaW344l8fagqf+fw0uwilWaxAWw=;
        b=tz7Kt4Yc8ENCU95r/WVdJnYhWhiuAK8cY97qf2dl2pKKH9rC2MBRBZm2ewM/MCYLuN
         e9ET4YzOaMmrH+CtFmzX8i9sg7NvdHC6WfMZBFsL+Iisom5d4BGUytjPRCzDoyA4OHiC
         Y4rzPnjoYrSmM8oreWsPXTQI/iRlbNW3Mhs2aDP7m/Lzz0+7e5y3fmC7uwgY5Ym2qrBg
         bRzJWN9YY00V/OM7HJWzDpIdLwEdjXkCvDAtByA4clCUhUy6xvvEjW7csf/jmUrlU9Z9
         s+lH7+cDX6PB0bJrAx//0QpciBa4oqyy3GvwNgfyD08jFS8G+JztwVyL/qSy+epv9LAY
         0OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687688257; x=1690280257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDxSibctoUXEH8FbhaW344l8fagqf+fw0uwilWaxAWw=;
        b=IHkJ0eKgG6hgexjX2/DlD0c+LatfBTTtvZl/+ezd577Oc6m/44efloT+C4pqqfJR5/
         TIki8PE96hfQm7jvH7rgOlKEnTRVWDdHWcPpomaE13SQMWVY9/P7AvIJeYHb6UyV75VB
         1DqfyYcx8h0gsz1m5Xju2NcCaoWAWTbF8WYtth4FZ7IbE4l9i0c9FBOnVHz2wGcJn9ZF
         VHfZ9yeKVE8QsCclYBU84A1lYdFm0nHq59OO3jVMrvOijK4iIR+j8qfIVwh4YMnLAy5M
         K3LXIfYvuWAANcuZFWQENAoHDlJxiZNxHXG/1FLH17oIohDaay06GPP0+deyng0phwJz
         XNzg==
X-Gm-Message-State: AC+VfDxedtsCu0/FO1fPYny275tainohnqA58SvHqrIdAKpXYWkIaY0N
        +/pjL72qfZ4DBA4O4SZkgtTkNw==
X-Google-Smtp-Source: ACHHUZ4LXduPHHt4DY5Lepb/cVmP4JxhlW6ONoMHpdxwOAmHFauWhKUSGJR7XfTA7B3mPHoSEflrIQ==
X-Received: by 2002:a17:906:4793:b0:974:32e:7de9 with SMTP id cw19-20020a170906479300b00974032e7de9mr23972957ejc.56.1687688256703;
        Sun, 25 Jun 2023 03:17:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b009893b06e9e3sm1922040ejb.225.2023.06.25.03.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 03:17:36 -0700 (PDT)
Message-ID: <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
Date:   Sun, 25 Jun 2023 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-5-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625094857.29644-5-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 11:48, Sherry Sun wrote:
> LPUART driver adds a new compatible string for imx8ulp, and imx93 is

What driver adds or not, is not really correct argument for
compatibility. There are plenty of compatible devices which have both
device ID entries in the driver. Why would you drop their compatibility
between each other? It does not work like that... Provide clear
rationale for this.

> much more compatible with imx8ulp than imx7ulp, so correct the
> dt-binding here.
> 

"Much more compatible" is too vague.


Best regards,
Krzysztof

