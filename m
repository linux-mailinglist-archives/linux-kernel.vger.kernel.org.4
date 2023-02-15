Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549E6979A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjBOKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:17:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF9CF22A34;
        Wed, 15 Feb 2023 02:17:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0C981042;
        Wed, 15 Feb 2023 02:18:19 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CECC3F663;
        Wed, 15 Feb 2023 02:17:36 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:17:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] mailbox: Allow direct registration to a channel
Message-ID: <20230215101732.pbpom3ub3yh75n4w@bogus>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213232537.2040976-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:25:34PM -0800, Elliot Berman wrote:
> Two mailbox controllers have channel/client binding mechanisms that are
> controller-specific and not using the devicetree binding mechanisms. Mailbox
> channel/client is conceptually done in two steps: selecting the channel
> and binding the selected to channel to a client. Channel selection is sometimes
> controller specific (pcc and omap are examples). The channel/client binding
> code is all the same.
> 
> This small series de-duplicates and refactors the channel/client binding
> into a common framework function: "mbox_bind_client" which all of the
> channel selection mechanisms can use.
> 
> I found this duplicate code while working on the support for Gunyah hypervisor
> message queues [1]. I've only been able to compile-test omap-maiblox and pcc,
> however it is a straightforward conversion here.
> 
> [1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/
> 
> Elliot Berman (3):
>   mailbox: Allow direct registration to a channel

I am unable to find the above patch either in my inbox or in lore[1].
Can you please repost the same ? I would like to test/review w.r.t PCC
driver.

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230213232537.2040976-1-quic_eberman@quicinc.com/

