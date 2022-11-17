Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66B62D5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiKQI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiKQI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:58:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C75133C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:58:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so1527954edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYZlkht9cjMAUGoNTf3GOMX0dDwCun9IlRoqXLzGEOI=;
        b=fAdoTHJOKxKzmfxO0EnU+WR0qCfsr/huIjdlnNlWNLJNBVcDngovLdOUAZC2uagCPu
         tVumLNvNwgpgSIDjx0EDsGI6Qj03/MmupUJiFUYPLHDf+yQIZn4HReLriERwbQDLnspZ
         1MKNpkDYe0QMFO56uoD+lAxR57yLSToQm2n+4PlyxWhruCpfLi5ceyMifVq1SkAihCcM
         CZlVW+aHgLr8SxSLBKtmvpoKIz15U1ERF6NCDOqH5I5YxYR2la5einX+KhuK0MD/wXgR
         21rxP5OTeeZPZeb5ITOxvFgFQK8UeyufXWEwcbJgqew7K6rf17Di2vkUl0nanbP/Ws+t
         ekqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYZlkht9cjMAUGoNTf3GOMX0dDwCun9IlRoqXLzGEOI=;
        b=uVJBMMM4r8GETQ1aT9gd8NEat71O2RQQGd1NXUi6Dwa50BEVo3XYci49pbL25cO7tm
         M0Al8pEMHsUrENQ2k9xetjOUoV3bcq8Zg5xQQZ0EXjnyuOmUV2o9xr5yhfMOpHFIFoQC
         HkUiyfki0kbcBMD8ncsOE09cb/8LOWEIq3owaHhnHeYhy023PLOMLkukiyF2BcAZ0a9V
         pB93kpvOBIsr3UZ1PiZKVmFBqdoB6Y5Z9WW5QJu25E+mekqYPr/gw9pU3cFwRnHMQdPH
         H0U0j+TQemW/PXTG1yf22Wy8HMgu/gbxQbOtTBpX8+0WmPguNrimtfkAFRUc6M1+O4ca
         0Q8g==
X-Gm-Message-State: ANoB5pkv5WTvdMjm+Cgb7R6zLjdemCuW3U6jCRcytC7ELr1cgnrP0ad9
        GiupPlOfXiQ47ae5+FvDVAA7Nkar596uJssDfSWQHw==
X-Google-Smtp-Source: AA0mqf7CqLi6uOxXHGGceCqjCKxwYf2fbaD3a6EWZA2RCLx11Qq2CKova+ttchtlp/INUa/mOdlHQkqD+atRqwUwYQQ=
X-Received: by 2002:a05:6402:2948:b0:463:bc31:2604 with SMTP id
 ed8-20020a056402294800b00463bc312604mr256367edb.32.1668675532087; Thu, 17 Nov
 2022 00:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
In-Reply-To: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 09:58:41 +0100
Message-ID: <CACRpkdaqfaa5B-tRebw7M-Ldj6+pVntAN32UzJ_PGGTXV1ufsQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: pinctrl: convert semtech,sx150xq bindings
 to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:06 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

> This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
> bindings documentation to cover all differences between HW variants
> and current bindings usage.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
