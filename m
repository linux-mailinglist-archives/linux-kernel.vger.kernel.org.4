Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1015265DD25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbjADTxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjADTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:52:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462817881;
        Wed,  4 Jan 2023 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ByKoxMq+7lwWsQwwtMR38lubpFnmTYGQuFwbs0Lq/Hc=; b=YMRT3QmCM3DHlF782l6j2yyvaO
        5vzgENshoi/xzDBa5wd23Ve2yxC7AU8+3qW3PeJ+VrjP+tPu9eJHuJ7NyCm5MGEiYZdC8SywTywqv
        I23Ueokxp42hu9RkpIrsIX6hTmvNef7W3nXclW1vv3rLzJe/l4DOKfvG7uL+nbgtpbZHX7UmFlfQD
        /wRAYtBQouyRJ0GuGj6uor0c7iQBKNqYyf9++IbqBiue8s7JIO/uAZGD8P54c9uRCrbX5/5c/oXqD
        dmNlbUcpzjNQOrCEiLjsctD6vWRKYO5dUul6hvM+0SqdzegiOdx/qe+jcvR6ZknLIwNbtMnK8Dnfd
        DQJ4cT0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD9oj-00Bbse-JW; Wed, 04 Jan 2023 19:52:56 +0000
Date:   Wed, 4 Jan 2023 11:52:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] test_kmod: stop kernel-doc warnings
Message-ID: <Y7XZFSJr3hM3tbNQ@bombadil.infradead.org>
References: <20230102211605.26058-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102211605.26058-1-rdunlap@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:16:05PM -0800, Randy Dunlap wrote:
> Use kernel-doc notation to prevent warnings:
> 
> lib/test_kmod.c:58: warning: contents before sections
> lib/test_kmod.c:94: warning: cannot understand function prototype: 'struct kmod_test_device_info '
> lib/test_kmod.c:119: warning: cannot understand function prototype: 'struct kmod_test_device '
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org

Applied onto modules-next, thanks!

  Luis
