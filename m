Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670D0678DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjAXBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjAXBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2B392BB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A346361164
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABD9C433EF;
        Tue, 24 Jan 2023 01:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674524663;
        bh=PlT7W/s2TFWxg80idKxLTPtHsK3WhYehNSRHU8gs4hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djz77I+W0yJxk7OliC0+FKKI0ignKkawPpXk0MeYT0bSdQwarMHIWllSMb+dbgBYI
         8Yd8/RVp3Nb0IMt8w83hbMO/BU5varunBfE+5ytsM7ChOq4x5L3SxKudfPriuOaKgw
         7d02qSFXDpfDXKY5krpbHbCSQwJv61BWrB0XHUdAmPH56rKlUKMvG3YAhdD1XkHwV5
         I3o030wiRNRCLBMGV2zgjq+inNrIQEWH7NyUI01E9PJRc6j2n3OqGvmm0gfm2j0qRd
         mtm0DaLB8e4YCgTk+g+cVpJR18IMi9At/jQKxyns7W0GKjuktFvA0EbqduQwZHsmxZ
         9EdttqYR4BM0A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue, 24 Jan 2023 01:44:21 +0000
Message-Id: <20230124014421.112436-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

This is a reminder for the next instance of the chat series.  Next instance
will be 2023-01-23 (Tue) 09:30 PST.  You can show proposed agendas for the
chat, or propose your own using the above Google doc.  Looking forward to see
you after about 15 hours for the first time in the new lunar year :)


Thanks,
SJ
