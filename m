Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6073B28B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjFWISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjFWISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE41A3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F75619A0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECACC433C0;
        Fri, 23 Jun 2023 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687508300;
        bh=JCFIGYLHdPDTxnWe0rqNvIgH7ZUiUB4HgWHe9auF49o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rR1rNCnuPhJ2OZH1ja/OSyX2834u6LlwMMxzxtxErn2vlAV4HcN6TCJ2lhlYjA/ez
         fIy8wVh27SboStti2YpZVRNnXgJ9BdeOetRCIv8GNfoJwq40IhQhjubc1xRDfIL2fT
         vtH6nRfq0SfQ3ojBmzlEl5Vx+8Es5TTaeYxbiD80=
Date:   Fri, 23 Jun 2023 10:18:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
Message-ID: <2023062306-reload-squeezing-633a@gregkh>
References: <20230621184635.25064-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621184635.25064-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:46:35PM +0200, Franziska Naepelt wrote:
> This is a series of patches to fix some trivial checkpatch issues. Not all
> issues have been fixed. I intend to submit another series to fix more stuff.

None of these apply to my staging-next branch :(
