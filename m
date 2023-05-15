Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E727036E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbjEORPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjEOROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18810E73;
        Mon, 15 May 2023 10:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E110862B93;
        Mon, 15 May 2023 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C439FC4339B;
        Mon, 15 May 2023 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684170785;
        bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Az7+9MSZshh8thj5fwryxQ/82RYk1rGAY0RvT/CERNKU0cl4pe4aq+bOXSVRRAObf
         Qk8M9r6oEh13H5Fq22aBlmCH0w+0xsNYEJWLUSzRaoRg25lGryOZAUzfNlo5bgZsEJ
         zfBRUeRJ6uQh1pjwRq20Z83iKYkSgiOfd2X9mSnJ1L14ZyxNXS1bmYef/lzne4zTnj
         GNuJ2DNz7Sp1qi+pAa9tyM4LiGuXqJP93vXJp6I6F/AmRCyG5G6rS+lhBtBxZ5lWcr
         RydbRm8KAzmhEv4tT+pbBH8QaMUvPmj/7NnlZCJARhzSbNQbbLRADzvgE7f/VVR0f5
         cG4bxE1g7SJRg==
Date:   Mon, 15 May 2023 11:13:02 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Message-ID: <ZGJoHnLalEQFD6c9@kbusch-mbp>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-6.5.
