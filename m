Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1447089A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjERUhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjERUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8F192
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE9765201
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DD5C433EF;
        Thu, 18 May 2023 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684442253;
        bh=OzltXS/HMBEAIVHmg2Jo6AgyjxwO7geYGOlJJldR8pY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KVMYaLm7Gp4ELTBLFo6xianqSYrf0s1hcGl42cLXxQFuD4Sn7hlfqKfDOj6yQFXLO
         AK4lanCv69Ms8FFXO5IPJ3KPG9vSK65LH5awQjLriE41/eeh/6sElX/yMWRZOq0Qgo
         v7BagjMI+NsiMGbaAmDlBofuTzcermMN9sQ0+OaU=
Date:   Thu, 18 May 2023 13:37:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] auto, kbuild: flatten KBUILD_CFLAGS
Message-Id: <20230518133732.ee586408921d6f77c3a96bdf@linux-foundation.org>
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 18:46:42 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Make it slightly easier to see what compiler options are added and
> removed (and not worry about column limit too!)

I wish you'd cc'ed Linus.

Turning those four upper-cased macros into upper-cased inline functions
is just sad.  If we're going to do this we surely should go around and
make them lower-case.

