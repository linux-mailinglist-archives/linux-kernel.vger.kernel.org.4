Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DA72FE17
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjFNMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbjFNMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E719A5;
        Wed, 14 Jun 2023 05:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF8261B59;
        Wed, 14 Jun 2023 12:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6588C433C0;
        Wed, 14 Jun 2023 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686744730;
        bh=zHcMsKnQSNQFhkeP6Yrou3QMRDYm27B+uJXLYuqzc/4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sawNrngXNPSN7u1o4+On4EaVZ7fk4mz+duEnZKMe/olvA6CkBVAa57skWjz2sQ7iN
         YY/N2QgaCTG0USIz/LIiM1YqFPhKENGO3n8fd/imtv2IwFE0OSfa9gWEmW4fsMQG6g
         yY9s9TXRwCzVavBH/oATeMMszWCYtHEHQPg4N6jxZod+vT6Bg2iMM8ffIweg5GRGfs
         vnA276Dtpe55I4bURp7BZFQBr5PBzwLfPyUoQBDcwboSSnkrdx07P01vIGfLhwdI89
         saZ8NV/uFSx04lUsiYaX5TZbQ80LwPdkom9hkT0yDTG3cT1mC0EgMrubgggOw5PO6i
         /ditZPf3ETaXA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3536DBBEB6A; Wed, 14 Jun 2023 14:11:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Closing down the wireless trees for a summer break?
In-Reply-To: <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
References: <87y1kncuh4.fsf@kernel.org> <871qifxm9b.fsf@toke.dk>
 <20230613112834.7df36e95@kernel.org>
 <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
 <20230613195136.6815df9b@kernel.org>
 <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Jun 2023 14:11:01 +0200
Message-ID: <871qiekzvu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Toke usually reviews patches for ath9k but then asks Kalle (via
> assigning in patchwork) to apply them.

As for this bit I suppose we can either agree that I do the patchwork
delegation to someone else during the break (who?), or that y'all on the
net maintainer side just apply any patches that I ACK on the list
without further action on my part. No strong preference, whatever works
best for you, Jakub :)

-Toke
