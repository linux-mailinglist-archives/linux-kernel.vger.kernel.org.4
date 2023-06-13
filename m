Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8356572DCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjFMIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjFMIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D8C0;
        Tue, 13 Jun 2023 01:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B74062C28;
        Tue, 13 Jun 2023 08:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203EFC433EF;
        Tue, 13 Jun 2023 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646012;
        bh=JT9Jvu1dX40hUZ1jaMh9qthY+SgE+t3hITpy125/yTg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OueWfr2MdVmYIbbMeKGZu1jPOJ+2k2BhLb3nP6XkbiWhT1MzKTMmbw9CFX/DnMhyC
         Dzjk8CxkiQIx8xz01XQBZ2GOJaHAPRaB+nsHXpkjjs7OVFakncS+9527KKHaW79Blz
         qCCtEPXe8yI/iINoOzJCrk971Z5f4pZgx0MOTAdb9XVcpZezaNBtBoG4wKdJKuk72C
         jcsYl5YSH0aq+1hKR/SmpHj//XZ4jNL7zJ7DW3qUhbPwcZFwH26DFErMWSOLgZQ9l/
         XIHCNelIbibugJaZOgSwP7gMUg3vs/SX7E1QCIbVKTM9kDk4xN68GiYFPQJ6oUFOtH
         AWPHukintqf1w==
Message-ID: <78b104cd-15a2-63d8-bbce-0a5593e6a151@kernel.org>
Date:   Tue, 13 Jun 2023 10:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
Content-Language: en-US
To:     Srinivas Goud <srinivas.goud@amd.com>, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com
Cc:     git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 13:42, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
> Part of this feature configuration and counter registers
> added in IP for 1bit/2bit ECC errors.
> Please find more details in PG096 v5.1 document.
> 
> xlnx,has-ecc is optional property and added to Xilinx CAN
> Controller node if ECC block enabled in the HW.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

