Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551A697215
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBNXuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNXtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:49:39 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A473AAE;
        Tue, 14 Feb 2023 15:49:38 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id y8so1236777ilv.1;
        Tue, 14 Feb 2023 15:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZQ+pnrSKxKUfzFN0E4xub81x29BjpaTOIWP6xUPRvw=;
        b=uWy7TogOWnQEyeOKJhFptnQjLe6l8DIqlVkq50V2aiEOvqaYsvIwMwVj+tMEtX9NB9
         o3oJq0NLiVv1L0muemFd+u290efOir3REg0WgIe1MJxU73qhsgmhf7806KSAhlsrQwHP
         yrGbLhPRtZmt/5uHaSfI7tUoaVX/dOgp3b7Jb7OQ5D75rTRHDJ3UwjOqopW71Q9QA1I2
         Z9xEDLY8IlF5GCXdbqHD8mvHCHHwTEsTM11K5J4jr2JiER/s/u/cyIpHULuAtIPl/OTd
         b5d7eRgqVj3vGNUqzxEz6IfchpF3E+FB8H+8+rQIMEaov9YntLNJvPNiiSfIoSCBYuOH
         hvXQ==
X-Gm-Message-State: AO0yUKWoMyftmshbzCHYLDWoWH2kQiDxoPbuwHg1uf8AE8nW0EtHxdIg
        rDdFQ6P2bGHMgJ4ijO9o44BrQAU+gg==
X-Google-Smtp-Source: AK7set9rQ6DSyfJT+5iN7fP2VHxfXzd9g/+Q8EhIB6DK9njOCqwAWmisFDGz/7ZuRwpEnTugzsDS3w==
X-Received: by 2002:a92:cdab:0:b0:313:cb9e:8026 with SMTP id g11-20020a92cdab000000b00313cb9e8026mr528036ild.11.1676418577802;
        Tue, 14 Feb 2023 15:49:37 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.3])
        by smtp.gmail.com with ESMTPSA id v17-20020a02b911000000b003a60a538226sm5094064jan.112.2023.02.14.15.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:49:37 -0800 (PST)
Received: (nullmailer pid 44996 invoked by uid 1000);
        Tue, 14 Feb 2023 23:49:36 -0000
Date:   Tue, 14 Feb 2023 17:49:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add QRD8550
Message-ID: <167641857586.44942.8036773026754714432.robh@kernel.org>
References: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2023 17:38:43 +0100, Krzysztof Kozlowski wrote:
> Add board compatible for QRD8550 - a mobile-like development board with
> SM8550.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

