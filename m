Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415296C9097
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCYTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCYTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:54:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D119D335
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 455A4B80A07
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 19:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0642C433EF;
        Sat, 25 Mar 2023 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679774060;
        bh=neA+GAu1SuoqAJ4hA63uXVKhnlRrCEtBMr4N5TfeES8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SWt1Ro5/U43qxeQn6JDT55QpNrktHqBid9ZggK7kWGgE0XffvMi6ih4ajbYaSFlwT
         TTDRhyKVRarMtUhCb0GgbNpA50E58JURDCmNLoSTz68E4v1puKUmkb2wgJW5wB68zm
         bHVMNkXjFWBtTS64ktRJ/EdshHFoNWYaAUZltOmQ=
Date:   Sat, 25 Mar 2023 12:54:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] zsmalloc: minor documentation updates
Message-Id: <20230325125419.1b86c2331d94f86bad30d2aa@linux-foundation.org>
In-Reply-To: <20230325024631.2817153-1-senozhatsky@chromium.org>
References: <20230325024631.2817153-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 11:46:29 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> 	Two minor patches that bring zsmalloc documentation up to date.
> 

It would be best to keep the in-kernel documentation accurate
for the kernel version with which it is shipped.  So can you
please suggest a Fixes: for these two?
