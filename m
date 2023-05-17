Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD62706C35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjEQPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEQPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50419028;
        Wed, 17 May 2023 08:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483FE64879;
        Wed, 17 May 2023 15:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D895C433D2;
        Wed, 17 May 2023 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684335985;
        bh=uj3yY1AQxYZ5vT1NpUTbFozGPyly3ykjZNUb52/KP+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TB0P7qc7sqyKrutmMUYIP9Aryjc6+VsVHC5s/C8RCzKNIma73U9n6kIJX6vn8Q/+D
         13wWhU9FrBZBi/uq/FNfUJP5NKdDCp/a/YhyDCS39U8VVEFxOeird1HkAqAKfnnnv/
         wKEmyocF4G19gelpmZAeSIrfdJAKKzXgmkJbtPiYjebeH1NH1guklKHoaj/XEhytet
         v2xao5IngygO7BCpJqhDUDIe7TgCu0bf+9/wFbuPXPChWUf4RrQBftA96Z1mQSQDyV
         yZU1ud73567zxvHRXP++zc9lU0BvkaQqw6sX6HxCHPF/4BJmedLoZnmPquDCMs5p54
         uiop1DizSRCzQ==
Date:   Wed, 17 May 2023 08:06:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5] dt-bindings: net: nxp,sja1105: document
 spi-cpol/cpha
Message-ID: <20230517080624.672d52a2@kernel.org>
In-Reply-To: <50cc1727-999f-9b7a-ef09-14461fa4ddfb@linaro.org>
References: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
        <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
        <20230515105035.kzmygf2ru2jhusek@skbuf>
        <20230516201000.49216ca0@kernel.org>
        <50cc1727-999f-9b7a-ef09-14461fa4ddfb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 10:26:38 +0200 Krzysztof Kozlowski wrote:
> On 17/05/2023 05:10, Jakub Kicinski wrote:
> > On Mon, 15 May 2023 13:50:35 +0300 Vladimir Oltean wrote:  
> >> On Mon, May 15, 2023 at 09:45:25AM +0200, Krzysztof Kozlowski wrote:  
>  [...]  
> >>
> >> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>  
> > 
> > Is my instinct that this should go to net-next correct?  
> 
> It would be great missing net-next was pointed out by checkpatch.pl.

FWIW, I'd have taken the patch as is. There isn't much the current
build tester can do for dt-bindings, anyway. But thanks for the resend
:)

I was wondering about checkpatch, too, but haven't come up with any
great solution. The problem is kind of at an intersection of checkpatch
and get_maintainer.
