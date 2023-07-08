Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584E774BED4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGHTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:06:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485931BE;
        Sat,  8 Jul 2023 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=w7h+S2cLgTjh16VlaZ5qoXFp6Lq6SvFpHp5l/5QTa9E=; b=dKqxm6fci1aX7/gYARS6Mna8ZG
        Zr0aSElWDP6L4TSAE6MIA8ntF2Hvr0Q03Iwx/CAdR1YRlZR6GmQl7OSDtb/BjOiH0tVn8WTJUJbWl
        jC7J0Clj6GDtWkeVJzMiu0eO460EBEDIWovMH+QWo902dPl0bk8O0auNwjoXGQO3173c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qIDGO-000pQm-6m; Sat, 08 Jul 2023 21:06:36 +0200
Date:   Sat, 8 Jul 2023 21:06:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: marvell: add missing space before {
Message-ID: <7e458907-1961-4596-ad8e-0a20a745b501@lunn.ch>
References: <20230705150018.293752-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705150018.293752-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:00:17PM +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
