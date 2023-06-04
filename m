Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EE721939
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFDS0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFDS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097B9F;
        Sun,  4 Jun 2023 11:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B09460D2F;
        Sun,  4 Jun 2023 18:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3954EC433EF;
        Sun,  4 Jun 2023 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685903205;
        bh=dth7Aax/mLDPwW7UkizU6eda/8h6bGF9h4Hv/a9RVPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWgGmNQdQRsqINbir0ErYfXcBEXbJICqTNpIsxPSy0qwbUUDJ4Gr0dYN3PxBaGL0t
         fn33RJpKrhRxVzEwWSWJuCuM0YJFhKbXq2QiMP4v3lq2TX7xl1LhlPRkwyUhTU2L5R
         6YfcdCmF5Y7rVzs/sFZmt0suId8dpJwPYWuugTIbJ/bu8/WN6kBkGJ3S+i169jqv3T
         /HOyYhj0d3AFhH0sehYrXZD65TBesBjbt+MoJ4aIO8HIl4RqvQN2DaXV++VKlMkPBk
         glT23a4hlVlrNanh06sNVYn5NmdAztSAleZ4l0jV6rKuo9kyB4jvcLIkawxCIlgJuh
         piH3q3LA2tosw==
Date:   Sun, 4 Jun 2023 11:26:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>, James Seo <james@equiv.tech>,
        Jonathan Corbet <corbet@lwn.net>,
        Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc'
 lists
Message-ID: <20230604112644.49ac2035@kernel.org>
In-Reply-To: <20230603160659.GA5182@1wt.eu>
References: <20230603151447.29288-1-james@equiv.tech>
        <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
        <20230603160659.GA5182@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2023 18:06:59 +0200 Willy Tarreau wrote:
> > I think that is going overboard (too far). As long as a maintainer
> > is a direct recipient of the email (patch), that should be sufficient.  
> 
> Or it could be simplified, saying that all those who are expected to
> play a role on the patchset (review, test, merge etc) should be in the
> 'To' field while those who might possibly be interested in having a
> look are in 'Cc' (lists, other people having expressed interest in the
> patchset, single-time contributors to the file being changed etc). It
> could be hinted that usually people read mails sent to them faster than
> those they're CCed. This implies that maintainers have to be in To and
> lists in Cc.

It's useful when maintainer (or group thereof) who are expected to apply
the patch are in the To:
Who applies the patch is not information a noob may know but it may be
worth writing down as best practice?
