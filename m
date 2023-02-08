Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B268F42D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBHRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBHRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:17:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C98E04F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hSDAmbV7WRqaU/9YALDqWuwC1DCZ4TQHSeySO2UO0k0=; b=Nr0KhKBIgy+vmFvl/JgScxx2HS
        PC6n+jsggHqRvR8pK1Db1AMvhfNAI7zEtSLAVyRPagzgWAdzBSPZi+ekz2lmKE9GioStc0fZJ33eA
        jsQuw78dUxyRiirDX2A3VZ1pGW6BLqGtb/kPOhRzdyQv3bVfpJvHbyFpHdvMqMZ+oj00lQpUjJQ6p
        ls50l1WXOLhoR6iFsHJoDazUE+jDBTQeylitkYxhIcNrXbhUosRSTwEMoUnRVSrlOPD643Znxtl6d
        vQD+M4mu0tUfXaVmwJXuLn1Qfwf5g217x2wUnJLZfZg3Dwc9WlIVS7cI43fP7tIQO+DtQMrp265qm
        LHLnAqNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPo4R-001OV5-RL; Wed, 08 Feb 2023 17:17:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E6C13001CB;
        Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FB8F203C285D; Wed,  8 Feb 2023 18:17:22 +0100 (CET)
Message-ID: <20230208171050.490809180@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:10:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, kirill.shutemov@linux.intel.com,
        Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH v3 0/4] x86: Fully relocatable alternatives and some NOPs
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This version is fully tested and includes a few NOP twiddles inspired by the
objtool patches I'll post separately.

Also available at:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/core


