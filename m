Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7574A04F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjGFPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGFPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23E8F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD48360765
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F93C433C7;
        Thu,  6 Jul 2023 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688655818;
        bh=7W0Zc0obW7lVdF8yJjG8mkqdwOmhHn5kTGN3n9Oy3jA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lHXmqoE7i8vNkIDAYulkLSGN5lOOpmSFT8A6pnNGSSiNmYise8xxdlJnsVYSqh6V9
         zwQ5l1fYgI2HYdlJYzMf31Ey0rYl5Al61HcSBNyEq11dwj05AE4TRJpEA5mG7Afwhh
         /F720KUNPATt6SWoGIHX//t+P54njN3VXcwMlbqk7tKmgNcO5cdVbkYTCOsalWb5wC
         Ukc5Y+veRfvbIYd7l4rE+wgo/rk548ZTYND50qCVVfUPg+CMcRgHWq11Kp7Hofm4kB
         uB6/QJTxBZbFBOoIwzIPSSvVOjKUr4524u/VyBjb8PX2SCeRBNNIKM3dJ0UPt1kl4m
         9OXvZuRqltlvw==
Message-ID: <1a74c6c8-d921-6a43-c6ec-4e42760d1523@kernel.org>
Date:   Thu, 6 Jul 2023 10:03:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] firmware: stratix10-svc: Generic Mailbox Command
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        wen.ping.teh@intel.com
References: <20220908020350.2745506-1-kah.jing.lee@intel.com>
 <20230703034449.1334571-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230703034449.1334571-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/23 22:44, kah.jing.lee@intel.com wrote:
> Hi Dinh,
> Any feedback on this patch?
> 

What patch? I don't see anything here. Please resend.

Dinh
