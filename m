Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B05E8D54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIXOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiIXOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BDA36851;
        Sat, 24 Sep 2022 07:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D78D760C2C;
        Sat, 24 Sep 2022 14:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D81C433D6;
        Sat, 24 Sep 2022 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664029807;
        bh=PzgaZE0c42qV8niamfsc9DgtwpeEktlLhzwhIyx/b24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duRX0IKDH/2LEIYrc9e65/GOzVO5Hr1BcAMPYd1PHjEkiBepGgDtOq2HFGeNEKgss
         HyACVEppwjep18JGvXOfBGZjRlAdzZzF1PdDje8cZ56ZUqyCUn/524ocAbNkTstU5H
         pvXfy7HEz/qfA1Qjy+YqXVHAy/WKkBmdmVQ0Z0JlIieyM2y/vKVs/KJOePZ4nelig4
         n28xSnRTpQeDVSwJr6rQIZxeIACTLLxpvpmD/jLlD4HJ498H4SSPeccX+J/45hoHu+
         5Ul7Ag3IPgtbzskSSsXZwKwKvyycD4cRNUbU2/wtneUqMNk/72BHXOMzbLg2WOPvAX
         h4o/dwJCSoAzA==
Received: by pali.im (Postfix)
        id 4028B8A2; Sat, 24 Sep 2022 16:30:04 +0200 (CEST)
Date:   Sat, 24 Sep 2022 16:30:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220924143004.evsnw3xaplc57aot@pali>
References: <20220713200123.22612-1-pali@kernel.org>
 <20220808202352.iimhb2q6yawi35y6@pali>
 <3b80983d-93e9-9663-f569-7dda5b738cf1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b80983d-93e9-9663-f569-7dda5b738cf1@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 September 2022 15:50:38 Krzysztof Kozlowski wrote:
> On 08/08/2022 22:23, Pali Rohár wrote:
> > PING?
> > 
> 
> You got the ack, what are you pinging us for?
> 
> Best regards,
> Krzysztof
> 
So, who can take this patch?
