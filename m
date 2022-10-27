Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704560F843
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiJ0NAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiJ0NAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:00:30 -0400
X-Greylist: delayed 5245 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 06:00:25 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A0F44548;
        Thu, 27 Oct 2022 06:00:24 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 405311B40;
        Thu, 27 Oct 2022 15:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666875623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bbs1eXEVQVuOzAybnzUTCaYFUXD74DOpgHPgNk+a7uk=;
        b=dLdUUfxnerVh0Yn+UpV43/yTSi7BVHeQBt09FYcH/DLPOV6zG9azJbNiUHIRvSRO31ss8T
        uR7mECbEa1whFtX3rF5/1Wok90RRZFpVUBU/In5BkZd2xIo2z0EmaaNDfE7SmiyWvvFcqJ
        5Eu+FCWzaWuDZpYs7yJU7ze6YB27wItJWOCWZUz/bpanJgoyy/6YSUphHyNO6098zdmiIH
        MlA2vxxwdYPIakqbC+raJ1MtmG836sYi2vhIfyDYj0Bbc3ZX3HirDwHmLPuhJwjKonSynp
        15tdvkRWsVue/6pu3+F2LhIbjQ/tCZjBCQUnoUTWjYB6pi1ZvDvmGimVaTMIvA==
MIME-Version: 1.0
Date:   Thu, 27 Oct 2022 15:00:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
In-Reply-To: <20221027124009.mxfcyuayfv2snqf5@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
 <20221027120519.7f3xun66l4lamcq6@skbuf>
 <20221027122727.fhs35eqtzmeen6x4@skbuf>
 <20221027124009.mxfcyuayfv2snqf5@skbuf>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <be6395ef27d47b16c3ea9a38e31b4c88@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-27 14:40, schrieb Vladimir Oltean:

> Sorry for sending so many emails. I think the problem we should fix
> first and foremost is that, if there's a user protocol specified in the
> device tree but the kernel fails to load it, it should simply stick 
> with
> the default tagging protocol, instead of failing to probe. Everything
> else can be dealt with as a future refinement.

Sounds good to me. Should I come up with a patch or will you do it?

-michael

