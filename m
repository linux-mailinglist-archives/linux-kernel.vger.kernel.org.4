Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38861E0C3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiKFICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKFICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:02:20 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10316356;
        Sun,  6 Nov 2022 01:02:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b62so7939981pgc.0;
        Sun, 06 Nov 2022 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HVAEd9MRqq4+UEkyosACOKfYclXv6j5Rr/scR7ngsI=;
        b=J8FhOotX+JH9qRe0ClIg8UlfWcSSHM4bB5OpcJN9ldMUQEXOY38+SBkjn22YmmIQEk
         d+0bSAYG3+XaQQ8QstzC/9f2oR6gHIOwiLgylKn0Jl+R9RO0qWxWikwozGPb0Gtdwftb
         z6Am7/a1uWQbXL6RwZf2zbTBK/xJnEmW1LYDqkv8cRcPoJWy4Kygy3sV4PLOMeJ1Nsc6
         ihiOid9PJ+0/85gUV7jo67RjM5ulI/votfGsyiz87eFWMmu0yoSOsxiElOZ0isD3RO3u
         BfZPyIyPgzDltKjNDwz169RWXoghVwU+Z7mDQqppX/RkaKblO8ZYNFmEWGWS9RF7/Oe3
         UYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HVAEd9MRqq4+UEkyosACOKfYclXv6j5Rr/scR7ngsI=;
        b=BJWBX1CM024e4Sr4AYKO3QjPxHPbrvzzTWjqOW0YCqVEe0NRu+E37NFoUExiXatYxr
         tFDcvnT9YW6Jbkw2cgwA4XooO/NKwLg5vBZJ7T6Aj7lpOyjw4VkAF5DW8gJWWtpoFELk
         tBhZTmJNwrOFkXu675E+/1L1iJcck4psPCJaRaaUJsGAx/apj+pZbSm6NV4n15dAuRQw
         tM1oBxlXa+6+8WDuIVAiZH/IHcRDP73AwwhLt3EPU05aAKwaEafrZ5G8XwM1eA1PyRSC
         OxTVDTb2U7KzvKmec7MGjMpUh8vlYJvlvpqKohqH7eWUMYl8Cfod2dGOBTB6wtFE5oJh
         4ltw==
X-Gm-Message-State: ANoB5pnOeRxhYI9ESG2oTyKgmLPQi7PrKYu7onG0N8LZxQ4ZjoiDjj/b
        mrDpZoiwQkNkwjEoM8RpKbE=
X-Google-Smtp-Source: AA0mqf5npKAYgb+1Fna6B5J8t9t0/6WOt/svLNq0egbTm/M0bEBCNFe7ugsuf+37FLFfBxMKYaODGw==
X-Received: by 2002:a63:f651:0:b0:470:4f30:f724 with SMTP id u17-20020a63f651000000b004704f30f724mr5016774pgj.445.1667721719706;
        Sun, 06 Nov 2022 01:01:59 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b0056da073b2b7sm2237769pfq.210.2022.11.06.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:01:59 -0700 (PDT)
Date:   Sun, 6 Nov 2022 01:01:55 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hendrik Koerner <koerhen@web.de>
Subject: Re: [PATCH] ARM: dts: qcom: ipq8064: disable mmc-ddr-1_8v for sdcc1
Message-ID: <Y2dp8+2tfi2+nXNL@localhost>
References: <20221024233817.27410-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024233817.27410-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:38:17AM +0200, Christian Marangi wrote:
> It was reported non working mmc with this option enabled.
> Both mmc for ipq8064 are supplied by a fixed 3.3v regulator so mmc can't
> be run at 1.8v.
> Disable it to restore correct functionality of this SoC feature.
> 
> Tested-by: Hendrik Koerner <koerhen@web.de>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Perhaps there's some board where this property makes sense, but it seems
like something that should be added when needed in the leaf DTS, and not
supplied in the base DTSI. So:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

This also fixes problems I've seen on my systems, so:

Tested-by: Brian Norris <computersforpeace@gmail.com>

Thanks!
