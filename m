Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31986F28DB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjD3MRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjD3MRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3E172B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CFA6139D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 12:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC93C433EF;
        Sun, 30 Apr 2023 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682857037;
        bh=1I2GCPxIVSEIukF6RrBCL/IK9Y1gzkPx0zNlnbtcb2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qhmCxHUJ8qX2BdpOuclMSs+7nbU0omxHRuwnHtsqnSu20LuybjG2vfxtcu9RfS5yU
         LzG0/HjwsCpQOg5tKwiGrLKMHzJYwxYHaE+ZsDVy36LpiA4lHz2vVE5QIEFm/9ddHV
         V8eP+C5KDst7WEgsDWxGVLcD6wu1IpEE6qS3mmWNU+jFUWXgwsl9JEDqKtnEWUd+sg
         U0czGW927I+hVozbxrVwq9BldIKTaN7NbWL5Ec1/rgC3BrxASKzq+M5vbboVa8IgSI
         Q3ZjHaVb7UtH4nMQ7MAVkOmPFY0Mtt8HZYNli2e6+4hIJLB0JGvBA/p0oIczItZ4/W
         UByitlhGwnvpg==
Message-ID: <cb29f2c3-a5cf-64f9-317b-c728d11a305f@kernel.org>
Date:   Sun, 30 Apr 2023 14:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, achaiken@aurora.tech
References: <20230429224349.1935029-1-alison@she-devel.com>
 <20230429224349.1935029-3-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230429224349.1935029-3-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2023 00:43, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Due to missed all possible entries, this won't be even tested. You must
resend.

Best regards,
Krzysztof

