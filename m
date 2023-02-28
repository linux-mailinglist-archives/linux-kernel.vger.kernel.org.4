Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA26A5861
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjB1Lfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjB1Lfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:35:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8418165
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBF0DB80BD9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C623AC433D2;
        Tue, 28 Feb 2023 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677584127;
        bh=YQHcJnW/PI0KMNaF28Mi9Bpq0/wvAFEzUfSn8JC2PP8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=a20bCtcM693hhDfbr7p+/K6J/wewut9Wlg8UnJr1mjcjIxRFdmFOiWocevATIdqnA
         N4bl+9Y1c7tlOj73sS68tRMO4+CzfRettl72rvtvPR2Rb8Ynk7iS590ieqA0Cnrozl
         qR6E7ueo8ZObe1bgTGOrglmg5pxzWYU2B5DQKxQZS7KWmEmRhSMFNSAKsgYo3kaiGp
         G8daOLblQpbQiYtpsWKlv9YzpiwvsxCoWqIRsVjjOcZR+jY2HjZ+OoSd6A0lX8TcTD
         dHGeKZkH56NIbljHA79WigZy3LQdG93VUlts3bfdid/0NrWHhC6Z5oV+YDyg90K4Bu
         K2DdQYJdmlEsQ==
Message-ID: <5d609c84-8fef-81f8-ad90-dbca77f9b1de@kernel.org>
Date:   Tue, 28 Feb 2023 12:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] net: dsa: b53: Add support for Broadcom BCM53134
 managed Ethernet switch
Content-Language: en-US
To:     Paul Geurts <paul.geurts@prodrive-technologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-2-paul.geurts@prodrive-technologies.com>
 <AM0PR02MB5524C3FE38B82C480E2EC968BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <AM0PR02MB5524C3FE38B82C480E2EC968BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 20:44, Paul Geurts wrote:
> Add support for the BCM53134 Ethernet switch in the existing b53 dsa driver. This Ethernet switch supports MDIO and SPI interfacing.
> This implementation only implements the MDIO interface of this device.
> The device also features an SPI interface, which is not implemente in this patch.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Best regards,
Krzysztof

