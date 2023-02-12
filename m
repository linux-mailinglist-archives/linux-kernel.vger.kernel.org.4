Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527F6937A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 14:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBLN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 08:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 08:56:52 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B482F12860
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 05:56:48 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PF8Cc6Pvkz9sSQ;
        Sun, 12 Feb 2023 14:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676210204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FczVmXhgWDsSvXajJY85Vq5BsU6XlO1BFQUzsdrxudM=;
        b=1AW4SkDi8lc6WBa0xSKf3RFPs7jdbnOCo6BPejAmrhVgImF6nBr5AdCakeO4/QzKW1VAlk
        ZiEKmZorlqvq7efnw6+NfVwpOkbsPbtv/VbAKErI5h/sJtGzCnirxONMS+Pm/IWg7D0bdn
        nJFbx1p3/PxzNJDwdKLpGVckO2iDdozVavDp7Nl7rEIAwPxTXPGWGn9cpMViKnYkiKLgXK
        fHssQNR/be6Yb9MjRPsd6exvVegCTGApCcYcMmeNUdCNeerZtPzKukmkAgPNYrYATS74Dr
        mXEcVy8jADxzwv1E1a2E9jkDu8PGCItZvXHxCkDYhd5/zaCCGRColdWyEOgudA==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/1] drm/panel: st7703: Fix resume of XBD599 panel
Date:   Sun, 12 Feb 2023 14:15:43 +0100
References: <20230212120830.46880-1-frank@oltmanns.dev>
 <20230212120830.46880-2-frank@oltmanns.dev>
 <20230212123621.jo56yqlburd6g6ir@core>
In-reply-to: <20230212123621.jo56yqlburd6g6ir@core>
Message-ID: <875yc70yxy.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=--
