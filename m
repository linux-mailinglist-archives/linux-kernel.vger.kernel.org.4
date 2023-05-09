Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F16FBCC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjEIBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEIByY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB544A1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49EE364386
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB4C433D2;
        Tue,  9 May 2023 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683597178;
        bh=ZrT0gSNPIiNetPH2MV3BTeAcr8ZyvZCNKjDIa3x8L8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HApIz9EGUv9pnmM5TSNV1KdsvWz9ryrcO+UzR3eXqKpg/r/cMmzVbz1AVFvx2doiv
         dj+FnoZ4PlNTIs5XHjqS2pca79EmNiHViVj0y5+q5TtM/Qog4hzwATgrW2lXy2/0ZG
         NFG2hHE1QWOnhzw77ZdU+8i/7ZTuoy3MFeALJq3y7FkdGlPcR0cInqV/o58lZtw6pf
         dPt36dSEdPWZ+0PDG/HzZpeLEkD+jd8n35EZokjZmaUcgORza4VXTeO/8oYX8l3znT
         GJ8c3H9RbbNKTE3ltUio9apc088aAJYMkIggmkAb0G5qeIEZEAvf97+RnzbWPDY4pU
         GL9osRwq7+/VA==
Date:   Mon, 8 May 2023 18:52:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Taichi Nishimura <awkrail01@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] add braces to rt_type == RTN_BROADCAST case
Message-ID: <20230508185257.2e4f7434@kernel.org>
In-Reply-To: <20230509013601.2544346-1-awkrail01@gmail.com>
References: <20230509013601.2544346-1-awkrail01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 10:36:01 +0900 Taichi Nishimura wrote:
> Add braces to rt->rt_type == RTN_BROADCAST to make it easier
> to grasp the if-else-if statement.
> I think that it is ok to remove braces of rt_type == RTN_MULTICAST
> because IP_UPD_PO_STATS is oneliner.

I'm sorry but unfortunately we don't take pure coding style changes
(AKA checkpatch changes) in networking because they make backports
harder for little gain.
-- 
pw-bot: reject
