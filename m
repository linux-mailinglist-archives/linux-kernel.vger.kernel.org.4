Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E56A1B18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBXLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:06:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522E6A9C2;
        Fri, 24 Feb 2023 03:04:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x10so52521720edd.13;
        Fri, 24 Feb 2023 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gdwuEywNYdOYbVwrQQrjrsPur3vIHOPWD3d4XxXbKX0=;
        b=MSxzV+R1ku+iZcmavQzQwnWy2bxOkcWE8XUdsyKIODORtXEcfVCF4fOVSMRZkPxz4v
         0bz3EZvLCc1ijoG7YDtTTNdpxoQlB1L4D800QT5A5oZ+D0OLsVCZ1ub27n/XqFmMovnq
         SZprioKSlochMIlRzGmjukLD8k+x2Dlq4JOjVcBFmMy8aeya6wwmj724nxotIaGxWySO
         dsAax1prAXEmqO+a01UTHbuPs6m0sy/izKh2WGtxg4JcYdA6rF+MO7Egzn+ndCLlsXtH
         S/3K6KhM29cuMF62wxyeWl/+ZyhWKhFlaJPSNSun8OjgUNqr+JmZeBI6rxtgfbIgstXP
         nf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdwuEywNYdOYbVwrQQrjrsPur3vIHOPWD3d4XxXbKX0=;
        b=i0cjy7LLvk5EDAHLw5fVMeBraban8rfAKIegKtBV0ZY7fKmJIhUBW1wrRxt883r9Al
         ixPoczk3udTHfeWbsCd+mGr/RSF7VJBE0rFTmxhAO99SHDqHo6dvrjNUkOr4mcKvY6GF
         Uwt9BjSzCxk1yYDUqFvYZerDNiDeiF02Y6tfr12eO3xgy3Rr9Q6cG/s8k9gPofdxEaRk
         hKI9owLjAb2XWN5TacCbluHNdorM2JM29iCaegHhx0wBw05BNWjlGlG5DU2UELEYCphf
         9sT5kElmwf4+DcNOZfhZC/DnfgxHv9JxSHY5dhHQoy2HRAeU7VOTsaRQTw9LyNZciP3v
         l6Tw==
X-Gm-Message-State: AO0yUKWVvTuaWASfQzyjkBDB9SUMqFFN879iMFErTIUbOXiWUaVHrQKY
        fPyV6knymVu0h0RqHudg2LGwuVkgTMpbYfI2yPc=
X-Google-Smtp-Source: AK7set9Ir/cY7edp/BficUGznr8dJBEy/FQHiI0VNP5F0lqBK32AocTLjQxCKgd+qQmB67y0eof9R8/Ey6CMcCo7af4=
X-Received: by 2002:a17:906:2a93:b0:8e8:9fb7:5aa9 with SMTP id
 l19-20020a1709062a9300b008e89fb75aa9mr3890235eje.9.1677236657213; Fri, 24 Feb
 2023 03:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com> <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 24 Feb 2023 12:04:05 +0100
Message-ID: <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, asahi@lists.linux.dev,
        rydberg@bitmath.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 at 11:55, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

> What is the motivation for including the firmware name in the device
> tree rather than constructing it in the driver like what is done for
> the broadcom wireless?
There is no way to identify the device subtype before the firmware is
uploaded, and so i need some way of figuring out which firmware to use.
