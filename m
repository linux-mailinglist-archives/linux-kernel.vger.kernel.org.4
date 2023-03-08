Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0836B166E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCHXVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHXVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:21:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A1784F49;
        Wed,  8 Mar 2023 15:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC537CE2217;
        Wed,  8 Mar 2023 23:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F2DC433D2;
        Wed,  8 Mar 2023 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678317691;
        bh=Nyd5VyYg1GAaFFeuWw+WXKla70V3r35YAr7xcRLnO/0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OqwAeriKs4BCmK2DnJQOVlDf56HU/lVYRea4ePx0PC6DQmenwVruLeOpKDIY+n/XD
         36RlbYdfVTgIcbUgR3DaqJZTRhJEhgqqdc43OlI+QX8a5S0AYpPxMBhkWLQhwgx/EP
         xxTfe6XMI+FzId3BvuSG45YsZ8Q/6zmBWgbTkx1hI0Tzs0fDw/mvad5VTmQpqMM8GP
         3v6SQdhuj4pP1e7ZNk3irNTar87/dpXcaqlndvvbNkxqpbVn6GZj3W4rrBJahGKsLi
         QvclrQRlGlbxtwvTiheZX9Jc/pLfZIxMhoxWWnvCl+l/2jGw7iVloGqWXMf6Y64PTJ
         TmxDC0QOwE+1Q==
Message-ID: <baff7de11dca4b429d2f4316775c6227d9c01576.camel@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the file-locks
 tree
From:   Jeff Layton <jlayton@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Wed, 08 Mar 2023 18:21:29 -0500
In-Reply-To: <20230309084800.58ec0343@canb.auug.org.au>
References: <20230309084800.58ec0343@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-09 at 08:48 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   4cbb75d0fdc9 ("fs/locks: Remove redundant assignment to cmd")
>=20
> is missing a Signed-off-by from its committer.
>=20

Good catch, thanks. It should be fixed now.
--=20
Jeff Layton <jlayton@kernel.org>
