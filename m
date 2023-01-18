Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6392267178E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjARJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjARJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:21:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0B5D929;
        Wed, 18 Jan 2023 00:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D00CCB81BD9;
        Wed, 18 Jan 2023 08:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED2FC433EF;
        Wed, 18 Jan 2023 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674031566;
        bh=BfVz+1XSSoBmIGSKdQBPSPKSsPjEBMB8GohAlfIZU4w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CdLuO4+Dv0QA+8RJr998SMrveSx9ciXPAx3TNhJIFKKiHNxerqnVOr4nGTbMOa+Ai
         +szkBCXg+7OWDSvXfWpZ5ymTOavGOsageZjS/jWGPHCwdUS+t7Cr9uWuWmCXLJgBOk
         iXD23AEVocndO07IgsLBXjeBlYLqOdMe2Qxjqd22kE16gQ2bjhrj0BCfk+8783biD2
         ZHJk3PVNffThUgWLIvtJ4PzXzoeqGhrtyB9B4n/vNTNu9kR6RybS+NycYgTxbaOuDN
         v4lof1LHIsMqv9HdJT9Quo39uM+aOty9ffimaVCEq6iPte7ivjPXrzdZzywsYt6mBq
         D8QgqX8CmzoIQ==
Date:   Wed, 18 Jan 2023 09:46:07 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] HID: uclogic: Add support for XP-PEN Deco PRO SW
 and MW
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2301180945190.1734@cbobk.fhfr.pm>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022, José Expósito wrote:

> Hi!
> 
> This series add support for the XP-PEN Deco PRO SW and MW drawing
> tablets.
> 
> Both tablets are similar, the only difference between them is their
> size and their IDs. I own one of them and Andreas helped me test the
> other one, so thanks a lot!
> 
> Please note that this series might cause conflicts with [1], but they
> should be really easy to fix/I can rebase once it is merged.
> 
> About the patches:
> 
>  - The first patch introduces a quirks to be able to fix the frame type
>    reported by these devices.
>  - The second patch adds another quirks to know whether a tablet has
>    battery or not. I didn't find any difference in the information
>    reported by the firmware nor in the Windows driver to obtain this
>    information, so I added a manual flag.
>  - The fourth patch adds a generic mechanism to schedule jobs when an
>    event is received, in this case, to reconnect the tablet.
>  - The last two patches add support for the tablets.
> 
> Best wishes,
> José Expósito
> 
> [1] [PATCH] HID: uclogic: Add support for XP-PEN Deco 01 V2
>     https://lore.kernel.org/linux-input/20221226123456.14822-1-jose.exposito89@gmail.com/T/

I have queued this in for-6.3/uclogic branch. The conflict is a nobrainer, 
so that shouldn't be an issue at all.

Thanks,

-- 
Jiri Kosina
SUSE Labs

