Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2B6DAF70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDGPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDGPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:11:19 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59391B9;
        Fri,  7 Apr 2023 08:11:17 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 633CD40007;
        Fri,  7 Apr 2023 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680880275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qvUklBiA+8s/G3CWyxIobe6POCuwuse5Nofrtmumdw=;
        b=iTRLBZHPnRZCtG9eUxOELSFlEcXaIC3mows84atdIyq99MWA6GyVNSQxllW5VzgAKWrvEp
        IijYO2SO29kcF9RhPNHsfQQcx3ez1+4GxdZR7OlovGVHpcF+U9WJxKZUQ1jsRzjyloi8kT
        oP6gBxFeTZIBvL2wFJ9gKzEeq4ysN2v1w7YeHg7klUyjTrm2f0+NfeUtfu1URAcY2hJ2aF
        vOoaT4mzFBuVLALm+W3XLkIRwqm0tRfKi5gzFXB+FagCZJ5hmIB7bBq1tNooUJPi0Q9opB
        qSAoq26/B1ugVYII7wzI4a2gtbMZMV5559CMonNN0FmbU6nGB5g71T0V5CvNhw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
In-Reply-To: <167880811569.329316.7671442810659168728.b4-ty@linaro.org>
References: <20230207234735.201812-1-robh@kernel.org>
 <167880811569.329316.7671442810659168728.b4-ty@linaro.org>
Date:   Fri, 07 Apr 2023 17:11:14 +0200
Message-ID: <87v8i73ey5.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On Tue, 7 Feb 2023 17:47:35 -0600, Rob Herring wrote:
>> The GICv3 ITS is an MSI controller, therefore its node name should be
>> 'msi-controller'.
>> 
>> 
>
> Applied, thanks! Let me know if anyone else wants to take it instead.
>
> [1/1] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
>       https://git.kernel.org/krzk/linux-dt/c/fce7defb8a46c31cf9384fee6e4b1e4920c46ff7

Let's hope it won't cause merge issue.

Gregory

>
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
