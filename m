Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD46FF387
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjEKODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjEKODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:03:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1D1BE3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8281664DC1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACD7C433D2;
        Thu, 11 May 2023 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683813811;
        bh=NvgptMXhoibVUzwMhVycsWLnIvK3fc/9CTGYWKNunNM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T2vpb78EXlrqTCLfdpy7FD2AruqhHuzlgr+rxt/4McJyAgp4jjUrdObAQWTHkFYN/
         ak8q1lPAjB/dZ5msC10PFGQbxFfz5zqP+w2tFkw13wnj+WrJNRYdu0FFXXnFz3C7w/
         FW5F96WWEkN+VJhqJ4yF17WdKwyjStqQ0eR0EzISDzxzMuWuUrsyg+35dCvtVSWuur
         omqEGMbhrQ+w9wURS5faW9/pzGwRpaLqTsiQOHvYhUiV4jRliO7HK4dwQUASflE/wL
         JfaU3ZyOa5WeEOwOhY5uqUIyzugJyZR/Xf19UkfPlD2TLTXU7692ZwleCUEzg3Bg5j
         1r+JAhOFsn2ng==
Message-ID: <97dd1d05-cfc4-61aa-ac3e-cc1a662c63ed@kernel.org>
Date:   Thu, 11 May 2023 16:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
        palmer@dabbelt.com
Cc:     git@amd.com, michal.simek@amd.com, harini.katakam@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230511071214.18611-1-pranavi.somisetty@amd.com>
 <20230511071214.18611-2-pranavi.somisetty@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230511071214.18611-2-pranavi.somisetty@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 09:12, Pranavi Somisetty wrote:
> watermark value is the minimum amount of packet data
> required to activate the forwarding process. The watermark
> implementation and maximum size is dependent on the device
> where Cadence MACB/GEM is used.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Best regards,
Krzysztof

