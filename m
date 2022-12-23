Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC7654EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiLWKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLWKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:08:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498B192B5;
        Fri, 23 Dec 2022 02:08:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BF1161EED;
        Fri, 23 Dec 2022 10:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70371C433D2;
        Fri, 23 Dec 2022 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671790127;
        bh=Ibkd+PwHR1HEZiuXMmKszeauVwyPlqTPO0LQKes81VY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CdG/FqC8CRH3eAsO38CVNxRJipPIJrCk+rLqSogTHHRDLC+W6NgCH8oakS+N73Uex
         cEO8mZeWMbKfKVnv6q/zkSMs8JZqFfvX6fWfw71yyDOd7HbJc9E0xR8XG3cDdXt+G0
         Ppr3Q92VB1GQ7G+FUv1xhXqd7WP3yYKWR4YuXO11qpnXMPNFZNbBDLcO7hO+W/Lcb1
         ISSSTBLfoDYWgp6GA5tVSZ+tZD9YbQc80+72he7Qt0U3VE1rpihgFbRWZe9ZavcJx7
         jIY0LKBabjYeW+ltMSrccZ+Vqb1BIidLgJFHw0JP8FeX2MyVe0MXTXVy0i7b2iXhmd
         9ezTHjPl/HQEQ==
Message-ID: <3847a67a-38f3-b8e7-749a-1a76f39b2196@kernel.org>
Date:   Fri, 23 Dec 2022 11:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v2 1/7] dt-bindings: Document common device controller
 bindings
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
 <20221222100504.68247-2-gatien.chevallier@foss.st.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221222100504.68247-2-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 11:04, Gatien Chevallier wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Introducing of the common device controller bindings for the controller
> provider and consumer devices. Those bindings are intended to allow
> divided system on chip into muliple domains, that can be used to
> configure hardware permissions.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

It seems you sent it after my feedback but I do not see my feedback
implemented here (missing SoB, this patch should not be here, not cc-ing
all maintainers, etc.). If you sent it before reading feedback, please
sent a v3 with the feedback implemented.

Best regards,
Krzysztof

