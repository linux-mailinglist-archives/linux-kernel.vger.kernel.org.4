Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E620657043
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiL0WlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 17:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiL0WlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 17:41:12 -0500
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 14:41:11 PST
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:103:465::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EA25D8;
        Tue, 27 Dec 2022 14:41:11 -0800 (PST)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4NhTsP0hcVz9slg;
        Tue, 27 Dec 2022 23:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1672180297; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=3yIkxBK2GwDUmlTb+vf0D6IfPi4hxUMjEDhQ+KHTCpY=;
        b=DVd7X+832rGnDKeEtTkB4dQIcoKpUZzKvN/zZAp4/9yxkBXd7CaIpUJyZxTwr9Pj2ILZtt
        lf0VjMAqcUr/ryod7FLMGtUCDed81H9Li1oPdImYtowIUvmGMUsOwZC5weS6qS2cuKox+4
        OhCCXgTeT1+7xNa0cnpe4m0PBzxmLuSet2vZKcgdnMx+2Ut7tYrb4J9Vxuf/dbhaESA/SI
        zBMchHZBGJPrRQlFE2rEKDezlDqpmsHIOtpfYpxJVoM/zHETwiwSko5b2tDpoDiE3969mP
        01HnrHwVCABVDiBxApzU9JHrAlbWP8rxN5S1VEkqA/1QYVFqqDKzDv0DxQTg1A==
Date:   Tue, 27 Dec 2022 16:31:31 -0600
From:   jstrauss <jstrauss@mailbox.org>
To:     conor@kernel.org
Cc:     christophe.jaillet@wanadoo.fr, jansimon.moeller@gmx.de,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <20221227223131.um6muahhxbom7crg@libretux>
Reply-To: Y6slQLto568WfmfZ@spud
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-RS-META: 7nsytfipm8s4wgxwn1ec3ec3iufxfnui
X-MBO-RS-ID: c7554801159cd17ce67
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for the insight, I suspected it was some silent Proton issue. I
have switched to Mailbox.org, so all of my future emails and patches
will originate from this address.

Joe
