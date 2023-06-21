Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DE739341
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFUXy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4238D171C;
        Wed, 21 Jun 2023 16:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7953616C3;
        Wed, 21 Jun 2023 23:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF0DC433C8;
        Wed, 21 Jun 2023 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687391691;
        bh=lBPO3ZhFAmH7VQLHkIL4XIsw15NEty+QUAYnGoFZeMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QozBL7Q+Lg3KDS5qP1Ehx0M4CIsfzqgkJsgaM+01CbzH5lnfRLb14u0vJOeyRjNmt
         1VDxXCVg0ANvjSB88HrSbUZKT313WkkhONXJPmUzqgdDy2w3KrSaf3C7D+SnjYB5+K
         wTFeAclrfiD+AuLd8ggg5Q3U8Ns3rVS3aiwk1O4//agNBzPLxGLauWsCVqMeikwSj/
         qyIKCyvFQnJdfByxGKtV26YTuToXntuqfCz0oZn5gw3wUtFIaq6VqHBqcslV+/wQto
         xSjiMVeNMg9LmjPxSwBV0h4YLyyybUXhIIzxhHfc82k4egclFtg9MryG3sFWPeiHdN
         lLAVbkkuPvRwg==
Date:   Wed, 21 Jun 2023 16:54:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm:
 document VDD_CH1
Message-ID: <20230621165449.2f2436a4@kernel.org>
In-Reply-To: <74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
        <20230620111456.48aae53c@kernel.org>
        <74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 08:05:50 +0200 Krzysztof Kozlowski wrote:
> On 20/06/2023 20:14, Jakub Kicinski wrote:
> > Hi Luiz, I don't see you CCed here, should we take it directly 
> > to net-next?  

Lemme take it, it's trivial enough.

> Bluetooth bindings are not part of BLUETOOTH entry, so obviously no Cc
> for bluetooth maintainers. I'll send a patch to update maintainers.

Thanks!!
