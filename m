Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AC7296B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjFIKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjFIKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:20:45 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AAE7A83
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:12:11 -0700 (PDT)
Date:   Fri, 09 Jun 2023 10:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1686305526; x=1686564726;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Z8KAJyXpaTjqlrocmyKy6x9aI9Hp2RmjG+2bALz/4DRXehj7XFrjW/yRDU3Dp+qfO
         DqoO/Pm8C11yi1akcmKC3tfSNrHiLjZrCpsLKkQry/WnA2uem4gLUbncQ5lAynXA3J
         AGcRpH3VpZcVSmaY23/BtD7eq5T9GU2iHwXA8lO2pxCnpTGnzBqUhRexAhCEvvTfl9
         z3tHWcugCBoIJp4l1+Ok4Fdg4PB0gm2dfcQ0Ew3Btdf4l/ARtDrbpPg23IjkO+2cO9
         GlnAkbXpmDLcULBxsLW9r1wmFi+eZ3osJvJabskWIlkqBjUnKL153TYBzHSuHJQl+n
         H30tTIIcIEM0w==
To:     Colin Ian King <colin.i.king@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/connector: Fix spelling mistake "provded" -> "provided"
Message-ID: <tUFXNKt-8oZgTGwGtUnsKtf6pxPDd7KpJWwmrFDemhWU5ZrxXrY210L7paHIPrQot5IEZuX5X57vkDIANUyz56RsHLZpQJeILmX-6h4GG3c=@emersion.fr>
In-Reply-To: <20230609081213.1222580-1-colin.i.king@gmail.com>
References: <20230609081213.1222580-1-colin.i.king@gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
