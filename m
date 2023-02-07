Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB668E067
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBGSqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBGSqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:46:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78F234E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:46:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 65so6028772iou.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmZAxftyO6slzLMnbGs8o2pB/JP2fFytjbCAZ2G0Gys=;
        b=N+0VN5nXltvWKLZxJw4fFKQOY/cXtoFbsWJ2cm18+U7iRAxgWhBPGgn7SeLQlW2V71
         w4wx5sfwFvyijHomGFMr12YhY5UKChsKlZt2cTDz7egnPBhLtbZE0/yrdorwCSVhpcts
         3sq8pmIz/Zdv1bmPgO3WafpFe/K7835v74de0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmZAxftyO6slzLMnbGs8o2pB/JP2fFytjbCAZ2G0Gys=;
        b=Vj0TPuVfwQkS7QO48kvR9k5a6PhXYDY9Ahn7a8C5I+aPo1/byc4mJeBGHtmsnguuEd
         Ovft+hBQ4CZXjmkJ2Xjcg8AIiA3ePkAysOMa0TgWBfdqURZaJ6fpJsf5RagTfgp8sEhL
         SUFy8EB5+sKCes/AOt0672p7Umwr4VCDp+0ulBHivkxXlq0GDzmp6KrIq4WEex10JV0v
         kiYcNo7veQx4blXVWZw9VxkRVsi8H7Ya+FBFjLyAew00zWzW6XWQmb+ce/f5jgqZnrJv
         KSwrIvMT2UM3D9rgiB6K3KnwfE/lcVigxP1dThNF83fqMrTOlR4GFnPxzDoGhqqMqvMG
         lv5g==
X-Gm-Message-State: AO0yUKWS1OnCYnJsfwX5vwOZKEu0z6ROx3aRbrrv0eLjYNRAjFnb55/T
        MB9OEEL7dWhOS12qufHh8YLODw==
X-Google-Smtp-Source: AK7set8IYYDAys+Po0e3fJcbHqt6IBU0UizIiIRYAbmeEetgC1Kx4xHNO1xFcqAUceNSgoVGYHZhBg==
X-Received: by 2002:a6b:cf12:0:b0:6ea:6c79:d21d with SMTP id o18-20020a6bcf12000000b006ea6c79d21dmr3530115ioa.20.1675795581765;
        Tue, 07 Feb 2023 10:46:21 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id u15-20020a02b1cf000000b003a4e6b1e064sm4532144jah.90.2023.02.07.10.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:46:21 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:46:21 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] HID: i2c-hid: goodix: Add mainboard-vddio-supply
Message-ID: <Y+Kcff+9CE3IQ26I@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.6.Ic234b931025d1f920ce9e06fff294643943a65ad@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206184744.6.Ic234b931025d1f920ce9e06fff294643943a65ad@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:15PM -0800, Douglas Anderson wrote:
> As talked about in the patch ("dt-bindings: HID: i2c-hid: goodix: Add
> mainboard-vddio-supply") we may need to power up a 1.8V rail on the
> host associated with touchscreen IO. Let's add support in the driver
> for it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
