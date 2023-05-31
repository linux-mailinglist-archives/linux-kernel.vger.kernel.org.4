Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B8718120
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjEaNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjEaNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:10:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600C137
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:10:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685538647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lVaYTRM/wtAv4V9c462/KTuA8iLspzaYWPsRnVsqYs=;
        b=KnazoRb6sIWt3RcuOQWPDPs9Yf0mKXee2DTucaFVV60zVxl6d6MPpYaHQqeqqUOxOoCI4d
        uo16VxKVCiHkKd4qv8TgQWSx+GE2L3JZj/Sx3FAVdGamhnnxMnYUV9UpdIQa+njgjTDvrH
        NWZsTZQLAJKNFWj0oYDBlOedphcLSxDxGpfY7mF3kf9vkGnB3stHmcyTHOY4zA0Mj9Lmaf
        u5FXBwlvR/Z5ZDB9hMPfCdty7PjXjS8jMXdsj5Au1npdxpz2ktWZOhkKprBhgQ0+/OjFcN
        CsEeou69+nl3D2BKaf81DxCWiiEVrjfDRpoZl5Daqhq7a98w9tZ4NbiHnf9Zfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685538647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lVaYTRM/wtAv4V9c462/KTuA8iLspzaYWPsRnVsqYs=;
        b=A5gl3fLKN6jc0uHIsqNV+3UJ12mXNKH40Jgq0SXDu9mtkePjY06bBNLS+SFoZPMdoP+HMf
        l9f/Ol0OclPENNCg==
To:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 1/5] irq: Always enable parent interrupt tracking
In-Reply-To: <20230530214550.864894-2-rrendec@redhat.com>
References: <20230530214550.864894-1-rrendec@redhat.com>
 <20230530214550.864894-2-rrendec@redhat.com>
Date:   Wed, 31 May 2023 15:10:46 +0200
Message-ID: <874jnshcix.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radu!

On Tue, May 30 2023 at 17:45, Radu Rendec wrote:

Please read and follow:

    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

Especially the section about change logs.
   
Thanks,

        tglx
