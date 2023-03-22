Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A06C5AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCVXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCVXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:40:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A02B9E1;
        Wed, 22 Mar 2023 16:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=mQhebhj0ErIIe2B+tMJaRXg9lTK+szPIe3mCV0swbA0=; b=E5BBwMiJhWzwIOYFr//zUzlBj1
        scZXkgeH62TUicvPPjHG1IZSV6SGMuGDycbYv/uvfBHm4jLoysNQfSH+QjWT1/bgWOTEo4fmlGvLq
        qqhxtxb/jjyKogzpv7vP8Rsxs04puiSSYJz5K5bamvpvljIRvoAH7QwS+vPuNenDdhCreHBxr9bOs
        usv+wn+oWwn6J0GRx4o+1ATJbFuTvTgdQZiqdxV60V9/FZhTf7O650WeOVuHkWXv1xc2wOUkknH5T
        xuyYfrdAMLi0GG1rpu4IV+ThIvnai6MyTstUJR+onMPVLRmIyzTYQByRTSaA1k4QQisHRE0CqOrey
        T+d1OrYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pf83I-000B0W-1o;
        Wed, 22 Mar 2023 23:39:32 +0000
From:   Luis Chamberlain <mcgrof@bombadil.infradead.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        jim.cromie@gmail.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/4] cosmetic fixes to module pr_debugs
Date:   Wed, 22 Mar 2023 16:38:59 -0700
Message-Id: <167952830755.2267106.14602423112302281916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322013623.251401-1-jim.cromie@gmail.com>
References: <20230322013623.251401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

On Tue, 21 Mar 2023 19:36:19 -0600, Jim Cromie wrote:
> These 4 patches alter pr_debug() messages for more info, and less
> log-spam.
> 
> * add "for $modname:" to banners
>   helpful for finding one of many
> 
> [   40.885922] main:layout_sections: Core section allocation order for test_dynamic_debug:
>     	       ~20 lines of output
> [   40.885967] main:move_module: Final section addresses for test_dynamic_debug:
>     	       ~2 lines - .init.text/data
> 
> [...]

Applied, thanks!

[1/4] module: in layout_sections, move_module: add the modname
      commit: 4ab9c7dca82f215fa596fb61192384e4c922bf9c
[2/4] module: add symbol-name to pr_debug Absolute symbol
      commit: 9f5d69a7852db158bc9f5c5afa105ce12058afc3
[3/4] module: add section-size to move_module pr_debug
      commit: 8cf2cfac04e4b24dfc4371306e202b09ab574a80
[4/4] module: already_uses() - reduce pr_debug output volume
      commit: 6e82310365bade624ff38dd11a8467739adab6cc

  Luis
