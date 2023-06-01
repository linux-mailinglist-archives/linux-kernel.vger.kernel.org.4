Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6A719099
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFACnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFACnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FE98E;
        Wed, 31 May 2023 19:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A95B764047;
        Thu,  1 Jun 2023 02:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE283C433EF;
        Thu,  1 Jun 2023 02:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685587413;
        bh=oY+xHQYhmKKcwx/KFgT6bDL0acZ4b8k6V5/PXp21OD0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=B6eTO2IhPq4sxJWdqy1PlR5e96YguoOBStRC4KnUmyaHo8FTUHFkUPbcePIoDMukC
         rJ53eJPk9ICrj7MLdRlIxlAz6LC0ixyPJeMVWqM8ZLxRvVhPy9L7oT1N8B3iZKhK1B
         WdH+uxFnvDNvCYcLND97mcEuZkF+76lKdxvzJuJc44yfP9gXN7n8gv8OiQA1zIJ/3v
         HsoZROJ58XSR02ECJacOa2LMsgb2wYzeXb3Vkw8quzh4tQe/jdP0AjaQRVi0l6MAxx
         syOaU+a2zgSr5ZAwwrmILugxkzJj7W1kkZTIY7mfDBjAKXAtQAhOB0iume13cLIZZM
         sOvTwiSSctf1A==
Date:   Wed, 31 May 2023 19:43:32 -0700
From:   Kees Cook <kees@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20230601123056.59b281c8@canb.auug.org.au>
References: <20230601123056.59b281c8@canb.auug.org.au>
Message-ID: <81BE1A87-DED7-4A7C-AFB8-A5AA54D19150@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2023 7:30:56 PM PDT, Stephen Rothwell <sfr@canb=2Eauug=2Eorg=2Ea=
u> wrote:
>Hi all,
>
>The following commit is also in the mm-hotfixes tree as a different commi=
t
>(but the same patch):
>
>  f7223ccc138b ("string: use __builtin_memcpy() in strlcpy/strlcat")
>
>This is commit
>
>  0af9b29c6efd ("string: use __builtin_memcpy() in strlcpy/strlcat")
>
>in the mm-hotfixes tree=2E

Andrew, should I drop this from my tree?



--=20
Kees Cook
