Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F56BA0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCNUcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCNUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:32:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FE51F9B;
        Tue, 14 Mar 2023 13:32:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so67140590edb.9;
        Tue, 14 Mar 2023 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLFoyfLfdyO7ocn4I91ehlSCtw1QfcrPgCtbPrlB1lQ=;
        b=OZQCXhqLqja/dOED9oYnGh5ZzK1T5CXLPiHRfTPuPsgIqlJxZBwyhxIkcjHXYESffT
         GUzc7tofvBNLC2CG39cmcbO4RpIZFP1pyLyqMmR2vw4arkGWkE+a55fMpvZuTsyxQgPv
         Ic9Urgqyvcp3g+JfyMq0u2Y2D1YCN6+tMAksRo4OcxUO7aYQ4knVnSP4hsIen78KfaGF
         Pu6tc4goaQUKA09AMqN2pAgXHwS+y9a8WDxJ6wdoOpVwLzfLC4K+5OL8HKa08JWI/SzJ
         SL+R938Dks+Y4QJktoWX9ze9f/ky/l39GkFrhPRFAFB/R31io1wmuPAAb/jWf66CbFDA
         5a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLFoyfLfdyO7ocn4I91ehlSCtw1QfcrPgCtbPrlB1lQ=;
        b=our/r7frfstvge2In5HMW0gy8qzJOOLSHWalQjOEAqNin3BnjoiUB9qehW+DM23AVK
         nZ068Qb0psdH9/ncMXHvaY66b1OIh8jH66+vttx9u55QtNuannS/f7uHlzNrECyTTpXd
         YUBlK7B/qF7fTQJnwdfuJzpNIuUzxCHvSi500Tv/pssTYGp/sdk478GoGIgznPxqQddN
         7SOh4hLHirRhxGGsTi6OYq/G3C/d8pyhY5IUxNcsdQIinKMWJ5ZEDwAiivz/RCuXi74b
         rYxjWNHucugHUQ8u8Uc2NLJxqRHFsZZHUIb6p5iyU4UbbjaHR/i7HswVVSVZFHEY5CRU
         CSLA==
X-Gm-Message-State: AO0yUKXfhtjTNk+D01eFfnbP6xbteo7ytevNNOe+aTanK/af5Kp+Z3W2
        pgucD8Rh0C3K2hBLb2l8uWFTfbJcECWC9i3d
X-Google-Smtp-Source: AK7set++sOxBoil2fV/AYd0vkfsoNi2NQY+Xq66eS0oKEFztdyuIRLgcGbiy+VyJFSjbI5WVnmFEng==
X-Received: by 2002:a17:907:2166:b0:8b1:7ae9:647 with SMTP id rl6-20020a170907216600b008b17ae90647mr4833331ejb.76.1678825970910;
        Tue, 14 Mar 2023 13:32:50 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170907989300b008cf8c6f5c43sm1557535ejc.83.2023.03.14.13.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:32:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: Use of_property_present() for testing DT property
 presence
Date:   Tue, 14 Mar 2023 21:32:49 +0100
Message-ID: <4252460.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20230310144724.1545223-1-robh@kernel.org>
References: <20230310144724.1545223-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 10. marec 2023 ob 15:47:24 CET je Rob Herring napisal(a):
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!

Best regards,
Jernej


