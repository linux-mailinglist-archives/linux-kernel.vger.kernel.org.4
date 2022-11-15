Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECE628EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKOBOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKOBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:14:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468C11C30;
        Mon, 14 Nov 2022 17:14:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b21so11720218plc.9;
        Mon, 14 Nov 2022 17:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvdTNo9PsZgmUgh74rxivdaIG7IRmSWUaMl5OJ/Cksg=;
        b=gg5sKE5smWo+p2ws6osNrbQqNATN2akVRGGKoHvnrd+3Jh0mPYR0zO2TOjDI2NOdNq
         7ojquPMOaXPJTsIzZq3POlYVLaMP+nV/jHDrDnblggWnpJtNaZJ8+wd20yBCgi8gvaOv
         +uAosHIY1hWeQfKOQ7u5uavAV9M8/6QReIES63QzA/WZgUsJ2pGHFS3kqvYX/e2wtdvk
         QjmKk5n5Al72TV0cQsGG8hMLewWe+Ag5hztDqOgibH7DVmrxECUWJWAIG9h8X20kWBKC
         Lvmro0a9CphCeB9JJ42oEsyl1NV0b5JkTFW9DabEyyBYScnZfphgspstL9vITbd6rfM4
         Gutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvdTNo9PsZgmUgh74rxivdaIG7IRmSWUaMl5OJ/Cksg=;
        b=n6Pyj/zBhHpRw/nLwg+yzmUpOflwfkjlMi+K+uTvyU4eUx909kmT2efq/iaPeRVbcH
         Xh5GNlwON07gtLABOq10WPp1MebgutpuVkGuRSnU3uKaT3OB5DD/mKyIuroxfS629qgY
         2HXedNoc/VlacQgvmQ/E3+vGPmkjfIyLqUz0EzzC8xPeezr2FJd0TB1+xuFvZIabUtde
         MMWe42wVYjyO6ALKQtC0qHXQPbHD7TvlzXoWy8CLFt5FobWMrJGK4S7qXdA6g2VC6Xbe
         Ebk/ZQzIqb/FwUSme1kvnGfpxxmFkRuWNCVaemqYnkfjTYIV2zaKmNNxIjCGBg6A/gOi
         0Syg==
X-Gm-Message-State: ANoB5pnam4lHS/KgzB38kbj6qUCONGXHq8uikJfz+f+3G2Kc934li2ll
        OzanHsJnoXGqIWZC1sReyts=
X-Google-Smtp-Source: AA0mqf7s0imZqXaSkBbacMXbJ9+Aud4fHOdDWh8Y/bLjTZeAMol8cJNDcuGTDsiXti1HJa9RNANwnQ==
X-Received: by 2002:a17:902:76c9:b0:187:190f:6aa7 with SMTP id j9-20020a17090276c900b00187190f6aa7mr1734102plt.131.1668474890429;
        Mon, 14 Nov 2022 17:14:50 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id z18-20020a634c12000000b00434760ee36asm6393274pga.16.2022.11.14.17.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:14:49 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:14:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/5] Input: msg2638 - Set max finger number and
 irqhandler from driver data
Message-ID: <Y3LoBcv7jaJ2Thid@google.com>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
 <20221110171952.34207-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171952.34207-2-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:19:44PM +0100, Vincent Knecht wrote:
> This will allow us to add other MStar touchscreen variants' support.
> No functional change.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
