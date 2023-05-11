Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7316FE984
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbjEKBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjEKBeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2D6A4C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E29064157
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9AC433D2;
        Thu, 11 May 2023 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683768839;
        bh=ehqsTiJeXFoWkUX5m5q0zk18w02eaYb37H/12j3Sn0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IAhOu6LrMht7xbTJep54i6CMeulj3I6IaiVMsI/5MkwveegjGXHRYDTJX+0+mFQHv
         zpi00o+jL4R/ExIKZ4pX96puTIutUnwczhPtBpsMilapsVzs1cUFBYluTXZMK6Innp
         toc4yivNoAXKNC5RaBbS76xqCPAfJ8nyvTlKWnbSjNnBX1WgQQgH1D0avorewZOX4s
         6sEAlYIduBkv3esrsb62oKZFan4AWeT6PD0tbTUcPagclZuikmOuF/IDIzMvFbzBsD
         8Owff3bWC8iKsyHFCULBd/InX9Qjcxp19ty4naH8jDTAwBC193pISEU4M0H43J2wgc
         vDL95Ri8C3eiQ==
Date:   Wed, 10 May 2023 18:33:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Remove low_thresh in ip defrag
Message-ID: <20230510183357.1b8501fd@kernel.org>
In-Reply-To: <20230509071243.1572-1-angus.chen@jaguarmicro.com>
References: <20230509071243.1572-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 15:12:43 +0800 Angus Chen wrote:
> As low_thresh has no work in fragment reassembles,del it.

You're not really deleting it. 
Please use spellcheck.
You also misspelled "unused" in the code.
-- 
pw-bot: cr
