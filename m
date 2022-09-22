Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660915E6D19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIVUgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIVUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:36:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77101110EFC;
        Thu, 22 Sep 2022 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P/+GsHDuL4c6C3mlEkz2dVleGc/NIflGt085H79CMGE=; b=ho7l9ycIG7eFD5uGTUJqpUQY4M
        WxwVrKOoGuuwgqYtRCj+ekrp9tl285QpO+QYDEILOOMLSR8YBVQA3Ss+xRtR1zKUannCQ3uZfm4Ea
        fF6o4fBrMy/s03G/9lJNE2d3uxMhTvO32CD+rVqQF8o46UZm3Vd87hPQAGT6gatat2Sk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1obSvk-00HZPM-Nb; Thu, 22 Sep 2022 22:36:20 +0200
Date:   Thu, 22 Sep 2022 22:36:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: add DT binding for D-Link
 DNS-323
Message-ID: <YyzHRGjPJWdm/GXH@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-2-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922202458.7592-2-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:24:56PM +0300, Mauri Sandberg wrote:
> Add bindings for D-Link DNS-323. It introduces altogether four new
> compatibles: dlink,dns323, dlink,dns323a1, dlink,dns323b1 and
> dlink,dns323c1. One is for the common parts between the devices and
> then there is one for each three hardware variants.
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
