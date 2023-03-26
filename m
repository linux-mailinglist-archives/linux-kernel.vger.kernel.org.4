Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73F6C9795
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCZTTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:19:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A830DB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C836FB80D0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E69C433D2;
        Sun, 26 Mar 2023 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679858383;
        bh=0Bfogpgj5zoLD2sKtYvZhX40CxMgQ+RwGcAfyS2Czw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSSUw+BCdHObDyn1H/LAxOeAPPkOOmaMzTffZM+944jLWswrYvbj414bvPC978tu6
         YFkz6NerL9YtIuhf3kZuB138yaGexbf+rQLHCODlAuZ8O0kAjQoYsX08pZyAlECSlk
         Qy9kN+XTsnQyyXT7qIkK0a1rypXlBOs/RXPOHi3SC/GLBvAUI+si/pUroEoaWzI62k
         nsSGA1QTwDtn8/SEG4fah6GQ2a4DG2ZvK7Su8DNO3BR+5+ODg1/hhWw0q9XTOKgZdm
         iivBp2KxmkL6eXh6zjhf3mCYAO3po0ngWfO1YsLvSTu4Ze4qUjfjdJJfd7jjxCPKax
         uR1ihJVYhwfcA==
Date:   Sun, 26 Mar 2023 21:19:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 02/13] MAINTAINERS: Add Boqun to RCU entry
Message-ID: <ZCCay0bIQH1wN8mH@localhost.localdomain>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
 <20230325173316.3118674-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230325173316.3118674-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Mar 25, 2023 at 05:33:05PM +0000, Joel Fernandes (Google) a écrit :
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> Just to be clear, the "M:" tag before my name is short of "Minions" ;-)
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

