Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416925B908B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiINWo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:44:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415997FE61
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:44:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so15801841pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sG4BoPjz3e0C1eNVOCbe3XTFIwC27NVv9II1vqkhBzU=;
        b=egbvshYQ7PhrCmmQJ075kMdOFDDe3HbCrbPAzU4N7wm3xIVLSn3FY2NwJllG+vOH2Y
         cfsytFveVVA76ltMYro/rPbqsT5qasiJrLGV06HXsjPbVlCelxfgW+1TeQRgLDieYUs/
         fSIHFafGEDMeum17aLYPRphQAQbAyOw5sFwWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sG4BoPjz3e0C1eNVOCbe3XTFIwC27NVv9II1vqkhBzU=;
        b=K60CbW9oLqvLsnioyYkDyllV1P90bO/tZIpmlzf9UqKhaEUvqac6GzXB2RjSvHReVC
         47n2phcedi4b5zEdHN8EpmvhB3D7ekRgJlCvqU8ENZpPycjMH8VfNIfS1dLj9nGUDCOb
         wB2LlGWtOEIpLAnVKtJMytp0XCmsH4GOFwln4xaKbBYXPvkJFGCPoFuNYatNiJSyVyWS
         Z+uBUTtHkf3oJAapJlOfnvdYs9Ekt1BaU3lTzUab2cQWgcljm855mG36QS5sM4gNcXup
         c7JdrhXXb7r8Bo0PLGYW8jW6g2bLrbzqDOTKeiwkHW848eog8jiWmmP6hk8cGux3EoDP
         fTig==
X-Gm-Message-State: ACgBeo3HyKgoHgJK0PxY52A3UvMhv3yr32Fn16pzY7lanNHpNiB3CCVP
        mvIbxJ0gjacuGAQuYz05UAG7wA==
X-Google-Smtp-Source: AA6agR6BJK39kIszlvDaPT1D98yFN2nfwJm8G/GuZYjFwhHiuy8VicYOPBae1seWlmxlUZK/eZORTQ==
X-Received: by 2002:a17:90a:d804:b0:202:f247:91b0 with SMTP id a4-20020a17090ad80400b00202f24791b0mr7319391pjv.8.1663195461789;
        Wed, 14 Sep 2022 15:44:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c963:b4c8:c1a:85f6])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017854cee6ebsm2981009plg.72.2022.09.14.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 15:44:21 -0700 (PDT)
Date:   Wed, 14 Sep 2022 15:44:18 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4}
 variants
Message-ID: <YyJZQuw5aQKbW9K/@google.com>
References: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:33:55PM -0700, Brian Norris wrote:
> The Gru-Scarlet family includes a variety of SKU identifiers, using
> parts of a 3-bit space {0..7}. SKU2 and SKU4 devices (under a few
> different manufacturer names) also use the Innolux display.
> 
> For reference, the original vendor tree source:
> 
> CHROMIUM: arm64: dts: rockchip: add sku{0,2,4} compatibility
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f6ed665c9e2eb37fb2680debbb36ec9fb0e8fb97
> 
> CHROMIUM: arm64: dts: rockchip: scarlet: add SKU0 device tree
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/9987c8776f4b087d135d761e59f7fa6cc83fc7fc
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Ping. What's happening with this? I got one non-actionable comment (that
I replied to), but I can't tell if this is just waiting on Heiko to pick
it up, or if it needs a DT reviewer.

Brian
