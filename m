Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333F682858
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAaJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAaJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:11:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD874A236;
        Tue, 31 Jan 2023 01:08:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA4B1CE1BD9;
        Tue, 31 Jan 2023 09:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0495FC433D2;
        Tue, 31 Jan 2023 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675156038;
        bh=6rC+V1tP3Op9yvH3e0zv8TeU0J8vzIaUym1qAHheRn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEP3ZEwtHYeQxqP23cdr/ZNtCEafLkvFGwisohYTyM85F84b/g7gMLbI4sE2eK2zH
         SWSttbGJNAh+INknGyyox/whfCkyhljAPyIbiWGDte228l4aZVUO+hNkFsxgy3tCL3
         /ValNB5ZpwOvO/sCHWDSIWHSqWeaH1aCBHYG1aX7mSkLZrl8VK/mKzPCEwQj1B/Nfy
         suNtqQqhoWJqidjK403AcPiNS6PeBJmWt7GCVYJeUMhmxKAy4O4MXgkGLrJgFBgOHq
         FnQc822WtxLPX8j/AhRC0qpAPGzMSvyTg+xTuRC9hMt6uogwXgOMSpTKrswf2rSIe2
         3Fg7+2q6VdilA==
Date:   Tue, 31 Jan 2023 09:07:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the leds-lj tree
Message-ID: <Y9jaQNFZGJTMWQxi@google.com>
References: <20230131144626.13019b79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131144626.13019b79@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023, Stephen Rothwell wrote:

> Hi all,
> 
> The following commits are also in other trees as different commits
> (but the same patches):
> 
>   0ca222c81977 ("leds: Remove asic3 driver")
>   227e9611cd74 ("dt-bindings: leds: Document Bluetooth and WLAN triggers")
> 
> They are commit
> 
>   fe24d8a40292 ("leds: remove asic3 driver")
> 
> from the arm-soc tree, and commit
> 
>   ef017002b93b ("dt-bindings: leds: Document Bluetooth and WLAN triggers")
> 
> from the bluetooth tree.

Luiz, please could you remove these from your tree.

-- 
Lee Jones [李琼斯]
