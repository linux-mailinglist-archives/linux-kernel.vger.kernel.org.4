Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83A6C343F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCUOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C027A95
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OlEhPgfyscmlDS2pCPp+bCSX5cnnqV/oLHFqrAixad0=; b=Hs4sNRo1eqEi6KGYiGzuszSmWw
        yxgglv0V7HJ7BbDV+yQWMBiy/PBUDw+XPmWnh+4aw/CiNi8p5F2/ni6FCblhOoSnodOIz3tetO4dZ
        XBb6v3v+IFqbkOkNsZmeyS/1zwxZ+a+o9DfF6C4OhJO/NMQGJgRXe+dixjvXpCdlG0l7e5LIZKhqj
        z8Y5p0ixku9JykMTlQdcC1OuBP2+n0NYYH+kBuF4ezk/qOFga8hiQTUPFkneQbCa3M80OlrzSree6
        vjXJ8L35jV/j1MbjS98eh/IK1TFyS7lCQ2oKzQSxh8Np7z4XQ7UBeRsiUiWbyK8tB1VhN/JjMI4C/
        JRBDyYoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ped09-0026uU-ET; Tue, 21 Mar 2023 14:30:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 190AA30006D;
        Tue, 21 Mar 2023 15:30:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE801240FB827; Tue, 21 Mar 2023 15:30:11 +0100 (CET)
Date:   Tue, 21 Mar 2023 15:30:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 11/18] timer: Split out "get next timer interrupt"
 functionality
Message-ID: <20230321143011.GO2234901@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-12-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-12-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:37PM +0100, Anna-Maria Behnsen wrote:
> The functionallity for getting the next timer interrupt in
> get_next_timer_interrupt() is splitted into a separate function

s/splitted/split/ -- also in other patches (8 iirc). Split is an
irregular verb and the past tense is the same as the present tense.

