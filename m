Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DE6DD5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDKI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjDKI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E861BD8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B4261D5E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B53FC433D2;
        Tue, 11 Apr 2023 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681203359;
        bh=/wI/i0Ukc1XMHYGM0aQJb/8JlGVBSkX/gbWaombuXaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6oIxzUJC/T1Pmrf2E+n8bW5HqikhDlOEoKVv/NxmnIm6Pn/LxExaUqbe0kVwRZaZ
         Vebn/DZvAJ5C3x0hJJPVLq8XT8LvktqakB4E1QRDTokax9k+Q6Hiak7J8E//uwANUe
         mHFyRgNswJxAS0iV2nYChXLJNX5VrGlJdcjDjJfE0rqlvmVdcCRPAJp6kJ2qEbhG1a
         YPpasRSruCT1KHO+8iseq4KmGfXSU499LEzs/0g1BQHIBYwjjyhCU+wLS3VcCau3ym
         WsHPVRPl4VY8sS6H8F6e/jj7ziW1omLuikdmPSe/Tnn15EawFK/m2uJEMQmb7LyNew
         NYPmHiOYH5WCg==
Date:   Tue, 11 Apr 2023 10:55:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZDUgnV6IB2cZojwe@lothringen>
References: <20230328063629.108510-1-victor@allwinnertech.com>
 <ZCqp02hiCell/5AR@lothringen>
 <b187d221-228a-f032-8c93-16e148ec49ca@allwinnertech.com>
 <ZCwWUyUkcC9PZlij@lothringen>
 <87857a82-99af-a941-9374-3bbe373ff74a@allwinnertech.com>
 <32b53d3c-b026-fbda-511f-9d2b4274a364@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b53d3c-b026-fbda-511f-9d2b4274a364@allwinnertech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:06:15PM +0800, Victor Hassan wrote:
> Hi Frederic,
>     If we have reached a consensus, may I add "Reviewed-by: Frederic" in the
> next patch?

Sure and perhaps add the racing scenario I proposed to clarify the changelog.

Thanks.
