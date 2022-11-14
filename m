Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3B628958
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiKNTai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiKNTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:30:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41BA29C99
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60B3DB81200
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A398C433D7;
        Mon, 14 Nov 2022 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454232;
        bh=maHMH+bLq35OjAq+PvxpUNIQADX1wrSuQglWGswHg2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx9Yw7yg+j9s5tN12gCjhIO8zV19K7CQr22WcmyLvyg0T3SlR7pSaGmd66WgjvRFX
         S/wv4QUnO+Ol/Z0B2Z8Ol2rQQ/fAqrvzsER8H/WZNcqd2js/x0e0PhslDwzh6jNQIb
         yK4L6g3mcixdFVNAzOLv0jiQu91fqgRhpP6/XtgoT+GAvFQBwU+LhyHtFkXfMo26pw
         opUZ0/elTAVyomglsxJ/t4667bnQe/3sbBcSBzrHKPG7CNJIz68oFBbd1+5HFkb39q
         lMheYYXrgB02iKX4BuejLK/HiH13sWGqJ5VB8PjnZk3tqJvUK7s5UBKWmn6fOzMwg4
         lFcFhXMONvSrQ==
Date:   Mon, 14 Nov 2022 11:30:29 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] scripts/faddr2line: Fix regression in name resolution on
 ppc64le
Message-ID: <20221114193029.aybkzubzxynqcms6@treble>
References: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
 <YzLcPZYTWXfrU+K4@quatroqueijos.cascardo.eti.br>
 <1664532445.32klbp0ljq.naveen@linux.ibm.com>
 <0f4decac-1349-3ceb-246c-e648364d797f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f4decac-1349-3ceb-246c-e648364d797f@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:21:33PM +0000, Christophe Leroy wrote:
> Gentle ping ... Can this fix be merged ?

Thanks for the reminder.  Looks good, I'll go ahead and take it.

-- 
Josh
