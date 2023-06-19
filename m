Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF4734E09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjFSIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjFSIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4011990
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B40615D2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77257C433C9;
        Mon, 19 Jun 2023 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687163617;
        bh=vCiGNFmway1xT8+5HeboDaHKKj7jfcsjDO8MygM7DHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFliDPQHKPU78L2i5PEnlMjzcJKnjOQlcKipokhnjTQQAC+aJvUC7uCtSL8Zejm9g
         Tpo8yPkXesBzFBF5sY4s+Dz+HFEiok2UrEn0iaiFCM9BgP+/19Df392U+TR7vpqOSV
         yuYlGEi0QApa3PFhap3tkD8XbsTMkQACvezjHf135y3CQxlLrWg8dztxV3TdSs9fw8
         vMCQ8HE0reQPpM1XRv8itZkFoPjpAyiwLjMh5Fx78a3H6+3y6PdXPMgmAB81/EtUt1
         sP9WyXpMtwGSqf5pSZv6vuG+JCZ/JX28SXEcIpySO2GlI+GkfzTk8GjOCRpz9yJWhr
         1LYVLvn9cdxGQ==
Date:   Mon, 19 Jun 2023 09:33:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: rsmu: turn rsmu-{core,i2c,spi} into
 single-object modules
Message-ID: <20230619083333.GQ3635807@google.com>
References: <20230604042557.900590-1-masahiroy@kernel.org>
 <20230604042557.900590-2-masahiroy@kernel.org>
 <20230615140010.GE3635807@google.com>
 <CAK7LNAQjYQSMjNb4Cn_8NVxGhsJ96-JBeNChVzLjefQZ82aKVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQjYQSMjNb4Cn_8NVxGhsJ96-JBeNChVzLjefQZ82aKVg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023, Masahiro Yamada wrote:

> On Thu, Jun 15, 2023 at 11:00 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Sun, 04 Jun 2023, Masahiro Yamada wrote:
> >
> > > With the previous fix, these modules are built from a single C file.
> > >
> > > Rename the source files so they match the module names.
> >
> > Should this be part of the previous patch?
> 
> 
> I do not know. It is up to the maintainer's preference (you).
> 
> If you want me to send a squashed patch, I will be
> happy to do so.

I think it makes sense in this case.

-- 
Lee Jones [李琼斯]
