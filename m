Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569E73CE87
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 07:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjFYFJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 01:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFYFJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C28CE5F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18DD060B4E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3ACC433C8;
        Sun, 25 Jun 2023 05:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687669776;
        bh=9TjHg174JU3wdRRc2lXHEFu4QZLNSYyfqLS9/q0v5U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOqeEhrPai+VRft4rQv+/8qZsDxqZCeuCi6zy6MF/TMaahoppfs1wJT/tPmM5d6D0
         zSKN6bVqQvzBbT93alGKwN0B1XSdSUktjPtqt6BvaCsVgfjep7OchsyMQlNCqeYuDS
         yJtnkEePGT7ntBTjlUXkif/FZf/8EYklGaRF8VpVRc8BtiPHJoTYsjgghzaaF6AXhY
         rA/f8UqPqmh1bvxIZ/fxVnVlPd3w7De4L9Ta2JEdUU9ILtz5enUWYrnESdkKXxvUX/
         o+/bYtd3xy/FlESMBTuyaBePvVV9hgKhVbQSd7k/x7hmZrXhcjXcMO1mHobaitlDNt
         nG98OhMODfInw==
Date:   Sun, 25 Jun 2023 08:08:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Introduce memblock_reserve_node()
Message-ID: <20230625050850.GJ52412@kernel.org>
References: <20230624024622.2959376-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624024622.2959376-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 10:46:22AM +0800, Yajun Deng wrote:
> It only returns address now in memblock_find_in_range_node(), we can add a
> parameter pointing to integer for node id of the range, which can be used
> to pass the node id to the new reserve region.
> 
> Introduce memblock_reserve_node() so that the node id can be passed to
> the reserve region in memblock_alloc_range_nid().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

What problem does this patch solve?

-- 
Sincerely yours,
Mike.
