Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3D65F10C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjAEQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjAEQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:23:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3078B4E42F;
        Thu,  5 Jan 2023 08:23:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u9so91377582ejo.0;
        Thu, 05 Jan 2023 08:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgX3Uq5RN2gSxMD0FpAihmi52pqkCtembnImF2lZd1A=;
        b=XFAeuZZdm8oGXFYrt5K0AoexBXXG2KNww0ztHS62JWbcYMzvrdcqh9P7MNMkmwpSXe
         e1Yc2oL9WFlKdi5wtL9ykg8RMH4kmfoGMXKu72j8Q+qHM0eegIIGDkHIzP0v7sYrxG8o
         vjvO6GTte4j/hbWJTqoPwNEF3ozWP7RGVmRiyFDTIDwljpOuzFINcD0Z8vZNWP73NA+P
         RGdO5qPeChj1sEMPKsFHBksQxZQ1mq/Mdw9rQNN2gFOr2BYhp7u0QgScLQSYxqeenecd
         96IzbF8onkkIRmBIOyrNkY9caesvf+7yD6U/OLyjkoNEo160doio/yrlxo6aGDkH55K3
         bp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgX3Uq5RN2gSxMD0FpAihmi52pqkCtembnImF2lZd1A=;
        b=FE549qb+j7HAACJvR+6sbwD5loEAq0kbPZw8qUwwkTTolcseuSXhHDvHIRWv5/X9sA
         oGE4lxsG5ojgXaOuzBPq+HsWRjVd1uSbyKLRpmUvlaW3hsXBMmufDgO3xxhrhGfaOGOZ
         SHuXcEPd0bG9x6GBUEAzGd5cHmejJqwyB+w+NpPnUPv9G2yFuBJ05CUOOoHoyqAPVqmN
         +F5BeLu2OqiKoxv7nLZz8k33wUmadSB1oVwQSFKOWFxeq4/ZHFnIe+ejMOeT0FA6HQmC
         zk5hBUPPSMIT4suqdzQYRuBaoUmcsusfDwIXHzx0bZDmpexz8prtE82QV0GVHd3H1ekc
         K1EQ==
X-Gm-Message-State: AFqh2kpnDtdkw5h8b/ZP3ZQLCg3odJHLKUYPAfbzJ9kWx6LBgjtNsJTX
        W5z493OyGgDlhfNBrHPuZqpV0vZkafTRHxAP
X-Google-Smtp-Source: AMrXdXs6L27C/xjKuud7Vz8JTA95Nlc31IiajcsXqJwmfmirq1LtYT1Mbix+2eKxiqVBCANKMzF8mA==
X-Received: by 2002:a17:906:1c59:b0:7bb:af66:f38c with SMTP id l25-20020a1709061c5900b007bbaf66f38cmr45192698ejg.10.1672935804845;
        Thu, 05 Jan 2023 08:23:24 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0084c70c27407sm11121630ejh.84.2023.01.05.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:23:23 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] ARM: dts: sunxi: Fix GPIO LED node names
Date:   Thu, 05 Jan 2023 17:23:22 +0100
Message-ID: <2126880.irdbgypaU6@jernej-laptop>
In-Reply-To: <20221231225854.16320-1-samuel@sholland.org>
References: <20221231225854.16320-1-samuel@sholland.org>
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

Dne sobota, 31. december 2022 ob 23:58:53 CET je Samuel Holland napisal(a):
> These board devicetrees fail to validate because the gpio-leds schema
> requires its child nodes to have "led" in the node name.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


