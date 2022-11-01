Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D246155FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiKAXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKAXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:15:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3C62E2;
        Tue,  1 Nov 2022 16:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B1CAB8202A;
        Tue,  1 Nov 2022 23:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB8DC433D6;
        Tue,  1 Nov 2022 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667344554;
        bh=syjGW4rXoahssQc9ukr+8qBXBn0Lhp5xJ2qK34CFsWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZZvnNsuxZGsudOTRpTbhb56G/uk/LjC2a703zBe2OofTxahXxgn/uaA3YMyXNWX9
         aiE2EvifLVVhK9h5iNtu+TS44ZwY18Mvthv2b8jaraYJcT48oev9RPMsDWGJJKdiyg
         KfWhTnUREvp5bH/q5Lhm6QDr+itnvYrBbumWNL0/Mm15RgABKrBQBSQ8xvfzaJ2xtR
         mwyGKg8G1W9ZmQTBakZwD9X0AImkTVhMbRngjXdy4e+L3fHPG3qVA9/NHjM79HZRwp
         avZpKOStO68WUk4zFSlNcVO+Wb6mKpdQstuKRwNAMe8uwET4IwLCxLhxspRYOeZCRj
         uu/6JLce1X5UA==
Received: by pali.im (Postfix)
        id 79CC77F8; Wed,  2 Nov 2022 00:15:52 +0100 (CET)
Date:   Wed, 2 Nov 2022 00:15:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Orion codenames and
 archive homepage
Message-ID: <20221101231552.jlv2pe65wbtycja2@pali>
References: <20220719080807.16729-1-pali@kernel.org>
 <20220817231208.42emdluzead2hweg@pali>
 <20220923224346.tgws4gxd5daoz2rm@pali>
 <20221101224230.wbd37f7zbaueevkn@pali>
 <871qqmxo6t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qqmxo6t.fsf@meer.lwn.net>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2022 17:14:18 Jonathan Corbet wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > On Saturday 24 September 2022 00:43:46 Pali Rohár wrote:
> >> On Thursday 18 August 2022 01:12:08 Pali Rohár wrote:
> >> > On Tuesday 19 July 2022 10:08:07 Pali Rohár wrote:
> >> > > Orion codenames are extracted from menuconfig ARCH_ORION5X and
> >> > > old Orion homepage with 88F5182/88F5281 was found in web archive.
> >> > > 
> >> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> >> > 
> >> > PING?
> >> 
> >> PING?
> >
> > PING?
> 
> Hmm...so I have no idea what happened here or why this fell through the
> cracks so badly.  I've applied it now, sorry for making you work so
> hard...
> 
> jon

Thank you very much!
