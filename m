Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44970706332
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjEQInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEQInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41872DC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF1D643E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C38C433D2;
        Wed, 17 May 2023 08:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312991;
        bh=FrnAsONyc+Le8DGkA8Xm+odhQ87aaSFTQsnOsAprNns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcjPgRPJ9y2TMcoMBIjgPfMVCGjktyrY1r4/MabiKVb2/H5jHNS9upaRIh2oLmJqq
         NAZ1Z5mAIl05WUjG2o72TGSPJ8EcTQlv2+btFmdr8RhMZczr0bHzSPocxLKxJakae4
         vU1DJ4OJNgG1jm/xQdydjICS8KE9dx0TMpEs81KOWo/DTpUvl+ALAqBmnOm4LF1QQC
         fFC2Se6XYf0d0pKR57OPsJq4RSyIdutYY01M0dLnIGb5rClNOPAki1/BACAf9hKAtq
         xKp+v4B8legptTidynw5Ib8GlrVIGK5/EW3uK7X1gdjqDoFXINH8/fqPyd3rF05bNY
         0FyihkP1jaI5g==
Date:   Wed, 17 May 2023 10:43:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2] ntfs: Add myself as a reviewer
Message-ID: <20230517-keimen-teesieb-d606296295ba@brauner>
References: <20230517070739.6505-1-linkinjeon@kernel.org>
 <4125c148-a4f4-edd2-3009-0283246f8a95@gmail.com>
 <CAKYAXd_=kXjKnmfiSEuTLG0fd6Ezj+7_R_ZSWntbvUgQ9Hyx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKYAXd_=kXjKnmfiSEuTLG0fd6Ezj+7_R_ZSWntbvUgQ9Hyx0w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:26:59PM +0900, Namjae Jeon wrote:
> 2023-05-17 16:37 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> > On 5/17/23 14:07, Namjae Jeon wrote:
> >> I'm volunteering to help review patches for current unmaintained
> >> ntfs filesytem.
> >>
> >> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> >> ---
> >>  MAINTAINERS | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e2fd64c2ebdc..c2cecb2059d7 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
> >>
> >>  NTFS FILESYSTEM
> >>  M:	Anton Altaparmakov <anton@tuxera.com>
> >> +R:	Namjae Jeon <linkinjeon@kernel.org>
> >>  L:	linux-ntfs-dev@lists.sourceforge.net
> >>  S:	Supported
> >>  W:	http://www.tuxera.com/
> >
> > Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Thanks for your ack!
> >
> > Anyway, what about also adding linux-mm list so that akpm can
> > pick patches?
> Hm.. I think that MM folks probably don't like to see fs patches on mm list...
> And as far as I know, Christian is going to picks up the ntfs patches.
> Christian, right?

I've picked up your patch already. A notification should be sent
shortly.
