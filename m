Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95E612C53
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3Ssv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Sss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:48:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC665D6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:48:46 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1opDMO-0004ow-Ld; Sun, 30 Oct 2022 19:48:40 +0100
Date:   Sun, 30 Oct 2022 19:48:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] staging: r8188eu: clean up action frame handlers
Message-ID: <20221030184840.2root56lrro57xo5@viti.kaiser.cx>
References: <20221030173326.1588647-1-martin@kaiser.cx>
 <e032d410-60ed-9e0b-2818-bb849adebc78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e032d410-60ed-9e0b-2818-bb849adebc78@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Philipp Hortmann (philipp.g.hortmann@gmail.com):

> On 10/30/22 18:33, Martin Kaiser wrote:
> > Clean up the handlers for action frames. Summarize common code, remove
> > unnecessary return values.

> > Please apply this on top of the "remove the last get_da calls" series.

> > Changes in v2
> > - remove on_action_public's ret variable in patch 3, not in patch 9

> > Martin Kaiser (13):
> >    staging: r8188eu: replace a GetAddr1Ptr call
> >    staging: r8188eu: remove duplicate category check
> >    staging: r8188eu: make on_action_public static void
> >    staging: r8188eu: make OnAction_back static void
> >    staging: r8188eu: make OnAction_p2p static void
> >    staging: r8188eu: remove category check in OnAction_p2p
> >    staging: r8188eu: replace switch-case with if
> >    staging: r8188eu: replace GetAddr1Ptr call in OnAction_p2p
> >    staging: r8188eu: clean up on_action_public
> >    staging: r8188eu: remove return value from on_action_public_vendor
> >    staging: r8188eu: remove return value from on_action_public_default
> >    staging: r8188eu: rtw_action_public_decache's token is a u8
> >    staging: r8188eu: check destination address in OnAction

> >   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 116 +++++-------------
> >   .../staging/r8188eu/include/rtw_mlme_ext.h    |   7 --
> >   2 files changed, 28 insertions(+), 95 deletions(-)


> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Thanks, Philipp.

I just realized that I forgot to add your Tested-by from the previous
version. The final code hasn't changed in v2, only the intermediate
steps were fixed.

Martin
