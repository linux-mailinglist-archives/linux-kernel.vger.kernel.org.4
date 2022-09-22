Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD805E6DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiIVVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiIVVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A91DDDAC;
        Thu, 22 Sep 2022 14:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C359962E85;
        Thu, 22 Sep 2022 21:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083FDC433D6;
        Thu, 22 Sep 2022 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663881252;
        bh=qSDEXdzsZ4t/mAY8LLlrlB5ia5N28vCIWYCKVLNpZpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIGZuH+9Wkd5Zc5XRpAMR/c6rs5n3Yn3MR9D44C815U7/wCNcJ0Vng93S/W92r/PI
         JjcceP4c7octvyK7UXIQBdOKqgLABTUTYDpPqQ9ChvdxUHntp0+sxAe9cjmNZQ4J8e
         Y3ERLCjEdJHZvWNQkI4zHCFXueFkeZlUteSGJ91Zxmi4jgz6UtdD4J6p7fVbu0K5AD
         OwbBtOMnbiwbJyDh5oITj/La0dI6pIGWVxWPUG59nFam0FnpRHxUEXQlOkcaBo/2Zn
         oZg9Y4mV8yy++X9shAZO4skCnbYLY6gn8j93MMfjLNirUKgYVNTPYlvYhF6eCdFMYY
         yu22WwE2iDqXA==
Received: by pali.im (Postfix)
        id 15B60858; Thu, 22 Sep 2022 23:14:09 +0200 (CEST)
Date:   Thu, 22 Sep 2022 23:14:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
Message-ID: <20220922211408.56num4k6r746kzht@pali>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-3-maukka@ext.kapsi.fi>
 <YyzJe9+S83vByosb@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyzJe9+S83vByosb@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2022 22:45:47 Andrew Lunn wrote:
> > +&mdio {
> > +	status = "okay";
> > +
> > +	ethphy: ethernet-phy {
> > +		reg = <8>;
> 
> Since you have a reg value, this should be ethernet-phy@9

ethernet-phy@8 no?
